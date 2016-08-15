module myModule_tb(); 
    `timescale 1ns/1ps
    wire signed[37:0] output_tdata;    //Filter output
    reg signed[15:0] out;              //Bit shifted output
    reg rst;                           //Reset - active high
    reg signed[15:0] input_tdata;      //16-bit conversion of generated wave
    reg input_tvalid;                  //Valid signal - active high
    wire output_tvalid;
    reg output_tready;
    reg [3:0] rate;
    reg clk;                           //Standard clock
    wire [31:0] wave;                  //32 bit output from DDS
    wire [15:0] debug;
    
    always begin
 #4 clk =!clk;                         //125MHz clock
    input_tdata<=wave[15:0];           //Take top 8 of lower 16 bits of wave (only these should be populated)
    input_tvalid = 1;                  //Begin recording data
    output_tready = 1;
    rate = 2048;
    out<=output_tdata[15:0];
    $display (input_tdata,"   ",out);  //Prints given value to console
    end
     
    initial begin
 //Initialize clock and reset
 clk = 0;
 rst = 1;
 input_tvalid = 0;
 output_tready = 0;
 //End simulation
 #10
 rst = 0;
 #80000
 $finish;
    end
     
cic_decimator cic_decimator(clk,rst,input_tdata,input_tvalid,input_tready,output_tdata,output_tvalid,output_tready,rate,debug);
    
wave_generator wave_generator(
    .aclk(clk),
    .m_axis_data_tdata(wave)
);    

endmodule



/*
Copyright (c) 2015 Alex Forencich
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * Cascaded integrator-comb (CIC) Decimator
 */
module cic_decimator #(
    parameter WIDTH = 16,
    parameter RMAX = 2048,
    parameter M = 1,
    parameter N = 2,
    parameter REG_WIDTH = WIDTH+$clog2((RMAX*M)**N)
)
(
    input  wire                      clk,
    input  wire                      rst,

    /*
     * AXI stream input
     */
    input  wire [WIDTH-1:0]          input_tdata,
    input  wire                      input_tvalid,
    output wire                      input_tready,

    /*
     * AXI stream output
     */
    output wire [REG_WIDTH-1:0]      output_tdata,
    output wire                      output_tvalid,
    input  wire                      output_tready,

    /*
     * Configuration
     */
    input  wire [$clog2(RMAX+1)-1:0] rate,
    output wire [REG_WIDTH-1:0] debug
);

/*
 * CIC decimator architecture
 *
 *                       ,---.
 * IN -->(+)--------+--->| V |----+------->(-)--- OUT
 *        ^         |    `---'    |         ^
 *        |         |             |         |
 *        +-- z-1 --+             +-- z-M --+
 *
 *       \___________/           \___________/
 *             N                       N
 *
 *         Integrate    Decimate     Comb
 *
 */

reg [$clog2(RMAX+1)-1:0] cycle_reg = 0;

reg [REG_WIDTH-1:0] int_reg[N-1:0];

wire [REG_WIDTH-1:0] int_reg_0 = int_reg[0];
wire [REG_WIDTH-1:0] int_reg_1 = int_reg[1];

reg [REG_WIDTH-1:0] comb_reg[N-1:0];

wire [REG_WIDTH-1:0] comb_reg_0 = comb_reg[0];
wire [REG_WIDTH-1:0] comb_reg_1 = comb_reg[1];

assign input_tready = output_tready | (cycle_reg != 0);

assign output_tdata = comb_reg[N-1];
assign output_tvalid = input_tvalid & cycle_reg == 0;
assign debug = int_reg[0];

genvar k;
integer i;

initial begin
    for (i = 0; i < N; i = i + 1) begin
        int_reg[i] <= 0;
        comb_reg[i] <= 0;
    end
end

// integrator stages
generate

for (k = 0; k < N; k = k + 1) begin : integrator
    always @(posedge clk) begin
        if (rst) begin
            int_reg[k] <= 0;
        end else begin
            if (input_tready & input_tvalid) begin
                if (k == 0) begin
                    int_reg[k] <= $signed(int_reg[k]) + $signed(input_tdata);
                end else begin
                    int_reg[k] <= $signed(int_reg[k]) + $signed(int_reg[k-1]);
                end
            end
        end
    end
end

endgenerate

// comb stages
generate

for (k = 0; k < N; k = k + 1) begin : comb
    reg [REG_WIDTH-1:0] delay_reg[M-1:0];

    initial begin
        for (i = 0; i < M; i = i + 1) begin
            delay_reg[i] <= 0;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < M; i = i + 1) begin
                delay_reg[i] <= 0;
            end
            comb_reg[k] <= 0;
        end else begin
            if (output_tready & output_tvalid) begin
                if (k == 0) begin
                    delay_reg[0] <= $signed(int_reg[N-1]);
                    comb_reg[k] <= $signed(int_reg[N-1]) - $signed(delay_reg[M-1]);
                end else begin
                    delay_reg[0] <= $signed(comb_reg[k-1]);
                    comb_reg[k] <= $signed(comb_reg[k-1]) - $signed(delay_reg[M-1]);
                end

                for (i = 0; i < M-1; i = i + 1) begin
                    delay_reg[i+1] <= delay_reg[i];
                end
            end
        end
    end
end

endgenerate

always @(posedge clk) begin
    if (rst) begin
        cycle_reg <= 0;
    end else begin
        if (input_tready & input_tvalid) begin
            if (cycle_reg < RMAX - 1 && cycle_reg < rate - 1) begin
                cycle_reg <= cycle_reg + 1;
            end else begin
                cycle_reg <= 0;
            end
        end
    end
end

endmodule
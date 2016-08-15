module myModule_tb(); 
    `timescale 1ns/1ns
    wire signed[15:0] d_out; //Final output
    reg reset;               //Reset - active high
    reg signed[15:0] x;      //16-bit conversion of generated wave
    reg valid;               //Valid signal - active high
    reg clk;                 //Standard clock
    wire [31:0] wave;        //32 bit output from DDS
    
    always begin
 #8 clk =!clk;               //125MHz clock
    reset = 0;
    x<=wave[15:0];           //Take lower 16 bits of wave (only these should be populated)
    valid = 1;               //Begin recording data
    $display (x,"   ",d_out);            //Prints given value to console
    end
     
    initial begin
 //Initialize clock and reset
 clk = 0;
 reset = 1;
     
 //End simulation
 #80000
 $finish;
    end
     
fir_filter fir_filter(d_out, x, clk, reset, valid);
    
wave_generator wave_generator(
    .aclk(clk),
    .m_axis_data_tdata(wave)
);    

endmodule



module fir_filter(d_out,x,clk,reset,valid); 
//output filtered signal
output signed[15:0] d_out;

//input signals
input signed [15:0] x;
input clk,reset,valid;

//Define 195 16-bit coefficients for FIR filter
wire signed[15:0] b[0:20];

//Coefficient to record number of stored values.
reg[7:0] coeff_add;

//Storage for coefficient multiplication results
reg signed [31:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,
temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,
temp19,temp20;

//Store for sum
reg signed [15:0] y;

//Input buffer
reg signed [15:0] z0,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,
z16,z17,z18,z19,z20;

//Set up FIR coefficients generated with SciPy
assign b[	0	]=16'h	00F1	;
assign b[	1	]=16'h	0135	;
assign b[	2	]=16'h	01FA	;
assign b[	3	]=16'h	032C	;
assign b[	4	]=16'h	04AE	;
assign b[	5	]=16'h	065A	;
assign b[	6	]=16'h	0806	;
assign b[	7	]=16'h	0989	;
assign b[	8	]=16'h	0ABB	;
assign b[	9	]=16'h	0B80	;
assign b[	10	]=16'h	0BC4	;
assign b[	11	]=16'h	0B80	;
assign b[	12	]=16'h	0ABB	;
assign b[	13	]=16'h	0989	;
assign b[	14	]=16'h	0806	;
assign b[	15	]=16'h	065A	;
assign b[	16	]=16'h	04AE	;
assign b[	17	]=16'h	032C	;
assign b[	18	]=16'h	01FA	;
assign b[	19	]=16'h	0135	;
assign b[	20	]=16'h	00F1	;


//Resets anbd runs counter
always @ (posedge clk)	
begin
if(reset)	
coeff_add<=8'd0; 
else if(coeff_add==8'd194)	
coeff_add<=8'd1;	
else if(valid)	
coeff_add<=coeff_add + 1'd1; 
end

//Reset and record data
always @ (posedge clk)	
begin	
if(reset)	
begin
temp0<=16'd0;temp1<=16'd0;temp2<=16'd0;temp3<=16'd0;temp4<=16'd0;
temp5<=16'd0;temp6<=16'd0;temp7<=16'd0;temp8<=16'd0;temp9<=16'd0;
temp10<=16'd0;temp11<=16'd0;temp12<=16'd0;temp13<=16'd0;temp14<=16'd0;
temp15<=16'd0;temp16<=16'd0;temp17<=16'd0;temp18<=16'd0;temp19<=16'd0;
temp20<=16'd0;

y<=16'd0;	//reset y

//reset stored values
z0<=16'd0;z1<=16'd0;z2<=16'd0;z3<=16'd0;z4<=16'd0;z5<=16'd0;
z6<=16'd0;z7<=16'd0;z8<=16'd0;z9<=16'd0;z10<=16'd0;z11<=16'd0;
z12<=16'd0;z13<=16'd0;z14<=16'd0;z15<=16'd0;z16<=16'd0;z17<=16'd0;
z18<=16'd0;z19<=16'd0;z20<=16'd0;
end

//Move data through buffer on each cycle
else if(valid)	
begin	
z0<=x;z1<=z0;z2<=z1;z3<=z2;z4<=z3;z5<=z4;z6<=z5;
z7<=z6;z8<=z7;z9<=z8;z10<=z9;z11<=z10;z12<=z11;
z13<=z12;z14<=z13;z15<=z14;z16<=z15;z17<=z16;
z18<=z17;z19<=z18;z20<=z19;

//Do multiplications
temp0<=z0 * b[0]; 
temp1<=z1 * b[1]; 
temp2<=z2 * b[2]; 
temp3<=z3 * b[3]; 
temp4<=z4 * b[4]; 
temp5<=z5 * b[5]; 
temp6<=z6 * b[6];
temp7<=z7 * b[7]; 
temp8<=z8 * b[8];
temp9<=z9 * b[9];	
temp10<=z10 * b[10]; 
temp11<=z11 * b[11]; 
temp12<=z12 * b[12]; 
temp13<=z13 * b[13]; 
temp14<=z14 * b[14]; 
temp15<=z15 * b[15]; 
temp16<=z16 * b[16]; 
temp17<=z17 * b[17]; 
temp18<=z18 * b[18]; 
temp19<=z19 * b[19]; 
temp20<=z20 * b[20]; 


//Do sum
y<= temp0[30:15] + temp1[30:15] + temp2[30:15] +temp3[30:15] + temp4[30:15] + temp5 [30:15] + temp6[30:15] + temp7[30:15] + 
temp8[30:15] + temp9[30:15] + temp10 [30:15] + temp11[30:15] + temp12[30:15] + temp13[30:15] + temp14[30:15] + temp15 [30:15] +
temp16[30:15] + temp17[30:15] + temp18[30:15] + temp19[30:15] + temp20 [30:15]; 
end	
end	

assign d_out=y;	//Set output to sum
endmodule
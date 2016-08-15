`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2016 13:54:50
// Design Name: 
// Module Name: Mixer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mixer(

// Mixer

input wire signed [13:0] adc_input,         //Modulated signal into mixer
input wire signed [13:0] dds_in,      //LO into mixer
input wire mix_clk,                     //clock signal from adc
input wire mix_rstn,                       //reset signal from adc
output reg signed [13:0] signal_out        //signal out of mixer
);
//reg [13:0] dds_scale;                   //define reg to scale the Local Oscillator amplitude
//reg [13:0] adc_scale;                   //define reg to scale the ADC input amplitude
reg signed [27:0] signal_int;                  //interim signal before assigned first 14 bits of the reg
reg [27:0] signal_int2;                 //second interim signal for fine tuning bitshift

always @(posedge mix_clk) begin
if (mix_rstn == 1'b0) begin //reset     //if reset is low, don't mix
end else begin
    //dds_scale <= dds_in >>> 4;          //bitshift Local Oscil by 4 bits to right, i.e divide by 16
    //adc_scale <= adc_input >>> 4;       //bitshift input signal by 4 bits ^^
	signal_int <= adc_input*dds_in; //Mixing
	signal_int2 <= signal_int >>> 16;  //fine tune bitshift to ensure 16384 is max, i.e 14 bit
	signal_out <= signal_int[27:14];   //take the last 14 bits of signal_int (Important bits)
end
end

endmodule

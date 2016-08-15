`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2016 13:16:54
// Design Name: 
// Module Name: Locking
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

module LockIn(

    input  wire										adc_clk,  //define inputs
	input  wire										adc_rst,
	input  wire			[23:0]					    pinc_in,        //incoming phase
	input  wire signed	[23:0]						poff_in,        //phase offset
	
	input  wire signed	[15:0]						adc_a,          //mod signal in
	output reg  signed	[31:0]						signal_out,     //mixed signal out
	output wire signed	[23:0]						LO_out          //Local Oscil out
);

// DDSs
wire		   [23:0] dds_phase1;
reg			[23:0] dds_phase2;
wire signed [15:0] dds_out2;

dds_PG_pw24 PG_inst(                //defines 300Khz (alter IP to change this) sine wave, has PHASE OUTPUT
	.clk(adc_clk),
	.pinc_in(pinc_in),
	.phase_out(dds_phase1)            //sets phase for LO and SMA output
);

always @(posedge adc_clk) begin              //Phase adjuster
	dds_phase2 <= dds_phase1 + poff_in;     //Wire poff_in to a variable dial?
end

dds_LUT_pw24_ow24 LUT_inst1(
	.clk(adc_clk),
	.phase_in(dds_phase1),     //phase input
	.sine(LO_out)              //output sine wave
);

dds_LUT_pw24_ow16 LUT_inst2(
	.clk(adc_clk),
	.phase_in(dds_phase2),         //phase input
	.sine(dds_out2)                //output sine wave
);

assign LO_out = dac_a;

endmodule

module Mixer(adc_a, dds_out2, signal_out, adc_clk, adc_rst);

// Mixer

input wire signed [15:0] adc_a;         //Modulated signal into mixer
input wire signed [23:0] dds_out2;      //LO into mixer
input wire adc_clk;
input wire adc_rst;
output reg signed [31:0] signal_out;    //Signal out of mixer

always @(posedge adc_clk) begin
if (adc_rst == 1'b0) begin //reset
end else begin
	signal_out <= adc_a*dds_out2; //Mixing
end
end

endmodule

// Low pass filters - are located in the parent module


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2016 13:32:40
// Design Name: 
// Module Name: red_pitaya_locking
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

//TBI = To be Implemented

module red_pitaya_locking(

    input  wire										lck_clk,          //define inputs
	input  wire										lck_rstn,         //reset
	//input  wire			[23:0]					    pinc_in,  //increment phase (would change initial phase of dds_out2 and LO_out) (TBI)
	       wire                                     connector,  //connecting tvalid ports
	//input  wire signed	[23:0]						poff_in,  //phase offset (TBI) (Changing relative phase of LO_out and dds_out2)

	output wire signed	[13:0]						LO_out,          //Local Oscil out
	output wire signed  [13:0]                      dds_out2         //Output to Mixer

);

//reg LO_scale;

// DDSs
wire   [15:0] dds_phase1; //Phase of LO_out
reg   [15:0] dds_phase2;  //Phase of dds_out2

dds_PG_pw24 PG_inst(                //defines phase of sine wave, has PHASE OUTPUT
	.aclk(lck_clk),                    //clock input from adc
	.m_axis_phase_tvalid(connector),           //Tells other modules it is outputting data
	.m_axis_phase_tdata(dds_phase1)            //sets phase for LO and SMA output
);

always @(posedge lck_clk) begin              //Phase adjuster
	dds_phase2 <= dds_phase1; //+ poff_in;     //Wire poff_in to a variable dial?
end

dds_LUT_pw24_ow24 LUT_inst1(            //defines 377Khz wave, re-customise IP to change this
	.aclk(lck_clk),                    //clock input from adc
	.s_axis_phase_tdata(dds_phase1),     //phase input
	.s_axis_phase_tvalid(connector),       //receives "handshake" from dds_PG_pw24
	.m_axis_data_tdata(LO_out)              //output sine wave
);

dds_LUT_pw24_ow16 LUT_inst2(            //Secondary 377Khz wave
	.aclk(lck_clk),                        //clock input from adc
	.s_axis_phase_tdata(dds_phase2),         //phase input
	.s_axis_phase_tvalid(connector),       //receives "handshake" from dds_PG_pw24
	.m_axis_data_tdata(dds_out2)                //output sine wave
);

endmodule

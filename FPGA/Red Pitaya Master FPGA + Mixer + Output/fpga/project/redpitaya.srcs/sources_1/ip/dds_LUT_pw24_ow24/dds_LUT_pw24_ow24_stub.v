// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Fri Aug 12 14:00:15 2016
// Host        : DESKTOP-UNM7EP2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/RazBB/Documents/GitHub/RedPitayaMaster/fpga/project/redpitaya.srcs/sources_1/ip/dds_LUT_pw24_ow24/dds_LUT_pw24_ow24_stub.v
// Design      : dds_LUT_pw24_ow24
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_12,Vivado 2016.2" *)
module dds_LUT_pw24_ow24(aclk, s_axis_phase_tvalid, s_axis_phase_tdata, m_axis_data_tvalid, m_axis_data_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_phase_tvalid,s_axis_phase_tdata[15:0],m_axis_data_tvalid,m_axis_data_tdata[15:0]" */;
  input aclk;
  input s_axis_phase_tvalid;
  input [15:0]s_axis_phase_tdata;
  output m_axis_data_tvalid;
  output [15:0]m_axis_data_tdata;
endmodule

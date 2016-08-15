// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Aug 11 11:10:58 2016
// Host        : DESKTOP-UNM7EP2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/RazBB/Documents/GitHub/RedPitayaMaster/fpga/project/redpitaya.srcs/sources_1/ip/dds_PG_pw24/dds_PG_pw24_sim_netlist.v
// Design      : dds_PG_pw24
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dds_PG_pw24,dds_compiler_v6_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dds_compiler_v6_0_12,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module dds_PG_pw24
   (aclk,
    m_axis_phase_tvalid,
    m_axis_phase_tdata);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) input aclk;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TVALID" *) output m_axis_phase_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TDATA" *) output [15:0]m_axis_phase_tdata;

  wire aclk;
  wire [15:0]m_axis_phase_tdata;
  wire m_axis_phase_tvalid;
  wire NLW_U0_debug_axi_resync_in_UNCONNECTED;
  wire NLW_U0_debug_core_nd_UNCONNECTED;
  wire NLW_U0_debug_phase_nd_UNCONNECTED;
  wire NLW_U0_event_phase_in_invalid_UNCONNECTED;
  wire NLW_U0_event_pinc_invalid_UNCONNECTED;
  wire NLW_U0_event_poff_invalid_UNCONNECTED;
  wire NLW_U0_event_s_config_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_config_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_m_axis_data_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_data_tvalid_UNCONNECTED;
  wire NLW_U0_m_axis_phase_tlast_UNCONNECTED;
  wire NLW_U0_s_axis_config_tready_UNCONNECTED;
  wire NLW_U0_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_U0_debug_axi_chan_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_pinc_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_poff_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_phase_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_data_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_phase_tuser_UNCONNECTED;

  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "1" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_M_DATA = "0" *) 
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "0" *) 
  (* C_HAS_S_CONFIG = "0" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "1" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "16" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "0" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "3" *) 
  (* C_PHASE_ANGLE_WIDTH = "3" *) 
  (* C_PHASE_INCREMENT = "2" *) 
  (* C_PHASE_INCREMENT_VALUE = "11000110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "0" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  dds_PG_pw24_dds_compiler_v6_0_12 U0
       (.aclk(aclk),
        .aclken(1'b1),
        .aresetn(1'b1),
        .debug_axi_chan_in(NLW_U0_debug_axi_chan_in_UNCONNECTED[0]),
        .debug_axi_pinc_in(NLW_U0_debug_axi_pinc_in_UNCONNECTED[15:0]),
        .debug_axi_poff_in(NLW_U0_debug_axi_poff_in_UNCONNECTED[15:0]),
        .debug_axi_resync_in(NLW_U0_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(NLW_U0_debug_core_nd_UNCONNECTED),
        .debug_phase(NLW_U0_debug_phase_UNCONNECTED[15:0]),
        .debug_phase_nd(NLW_U0_debug_phase_nd_UNCONNECTED),
        .event_phase_in_invalid(NLW_U0_event_phase_in_invalid_UNCONNECTED),
        .event_pinc_invalid(NLW_U0_event_pinc_invalid_UNCONNECTED),
        .event_poff_invalid(NLW_U0_event_poff_invalid_UNCONNECTED),
        .event_s_config_tlast_missing(NLW_U0_event_s_config_tlast_missing_UNCONNECTED),
        .event_s_config_tlast_unexpected(NLW_U0_event_s_config_tlast_unexpected_UNCONNECTED),
        .event_s_phase_chanid_incorrect(NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED),
        .event_s_phase_tlast_missing(NLW_U0_event_s_phase_tlast_missing_UNCONNECTED),
        .event_s_phase_tlast_unexpected(NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED),
        .m_axis_data_tdata(NLW_U0_m_axis_data_tdata_UNCONNECTED[0]),
        .m_axis_data_tlast(NLW_U0_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(1'b0),
        .m_axis_data_tuser(NLW_U0_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(NLW_U0_m_axis_data_tvalid_UNCONNECTED),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tlast(NLW_U0_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(1'b0),
        .m_axis_phase_tuser(NLW_U0_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .s_axis_config_tdata(1'b0),
        .s_axis_config_tlast(1'b0),
        .s_axis_config_tready(NLW_U0_s_axis_config_tready_UNCONNECTED),
        .s_axis_config_tvalid(1'b0),
        .s_axis_phase_tdata(1'b0),
        .s_axis_phase_tlast(1'b0),
        .s_axis_phase_tready(NLW_U0_s_axis_phase_tready_UNCONNECTED),
        .s_axis_phase_tuser(1'b0),
        .s_axis_phase_tvalid(1'b0));
endmodule

(* C_ACCUMULATOR_WIDTH = "16" *) (* C_AMPLITUDE = "0" *) (* C_CHANNELS = "1" *) 
(* C_CHAN_WIDTH = "1" *) (* C_DEBUG_INTERFACE = "0" *) (* C_HAS_ACLKEN = "0" *) 
(* C_HAS_ARESETN = "0" *) (* C_HAS_M_DATA = "0" *) (* C_HAS_M_PHASE = "1" *) 
(* C_HAS_PHASEGEN = "1" *) (* C_HAS_PHASE_OUT = "1" *) (* C_HAS_SINCOS = "0" *) 
(* C_HAS_S_CONFIG = "0" *) (* C_HAS_S_PHASE = "0" *) (* C_HAS_TLAST = "0" *) 
(* C_HAS_TREADY = "0" *) (* C_LATENCY = "1" *) (* C_MEM_TYPE = "2" *) 
(* C_MODE_OF_OPERATION = "0" *) (* C_MODULUS = "9" *) (* C_M_DATA_HAS_TUSER = "0" *) 
(* C_M_DATA_TDATA_WIDTH = "1" *) (* C_M_DATA_TUSER_WIDTH = "1" *) (* C_M_PHASE_HAS_TUSER = "0" *) 
(* C_M_PHASE_TDATA_WIDTH = "16" *) (* C_M_PHASE_TUSER_WIDTH = "1" *) (* C_NEGATIVE_COSINE = "0" *) 
(* C_NEGATIVE_SINE = "0" *) (* C_NOISE_SHAPING = "0" *) (* C_OPTIMISE_GOAL = "0" *) 
(* C_OUTPUTS_REQUIRED = "0" *) (* C_OUTPUT_FORM = "0" *) (* C_OUTPUT_WIDTH = "3" *) 
(* C_PHASE_ANGLE_WIDTH = "3" *) (* C_PHASE_INCREMENT = "2" *) (* C_PHASE_INCREMENT_VALUE = "11000110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
(* C_PHASE_OFFSET = "0" *) (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) (* C_POR_MODE = "0" *) 
(* C_RESYNC = "0" *) (* C_S_CONFIG_SYNC_MODE = "0" *) (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
(* C_S_PHASE_HAS_TUSER = "0" *) (* C_S_PHASE_TDATA_WIDTH = "1" *) (* C_S_PHASE_TUSER_WIDTH = "1" *) 
(* C_USE_DSP48 = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "dds_compiler_v6_0_12" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module dds_PG_pw24_dds_compiler_v6_0_12
   (aclk,
    aclken,
    aresetn,
    s_axis_phase_tvalid,
    s_axis_phase_tready,
    s_axis_phase_tdata,
    s_axis_phase_tlast,
    s_axis_phase_tuser,
    s_axis_config_tvalid,
    s_axis_config_tready,
    s_axis_config_tdata,
    s_axis_config_tlast,
    m_axis_data_tvalid,
    m_axis_data_tready,
    m_axis_data_tdata,
    m_axis_data_tlast,
    m_axis_data_tuser,
    m_axis_phase_tvalid,
    m_axis_phase_tready,
    m_axis_phase_tdata,
    m_axis_phase_tlast,
    m_axis_phase_tuser,
    event_pinc_invalid,
    event_poff_invalid,
    event_phase_in_invalid,
    event_s_phase_tlast_missing,
    event_s_phase_tlast_unexpected,
    event_s_phase_chanid_incorrect,
    event_s_config_tlast_missing,
    event_s_config_tlast_unexpected,
    debug_axi_pinc_in,
    debug_axi_poff_in,
    debug_axi_resync_in,
    debug_axi_chan_in,
    debug_core_nd,
    debug_phase,
    debug_phase_nd);
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_phase_tvalid;
  output s_axis_phase_tready;
  input [0:0]s_axis_phase_tdata;
  input s_axis_phase_tlast;
  input [0:0]s_axis_phase_tuser;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [0:0]s_axis_config_tdata;
  input s_axis_config_tlast;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [0:0]m_axis_data_tdata;
  output m_axis_data_tlast;
  output [0:0]m_axis_data_tuser;
  output m_axis_phase_tvalid;
  input m_axis_phase_tready;
  output [15:0]m_axis_phase_tdata;
  output m_axis_phase_tlast;
  output [0:0]m_axis_phase_tuser;
  output event_pinc_invalid;
  output event_poff_invalid;
  output event_phase_in_invalid;
  output event_s_phase_tlast_missing;
  output event_s_phase_tlast_unexpected;
  output event_s_phase_chanid_incorrect;
  output event_s_config_tlast_missing;
  output event_s_config_tlast_unexpected;
  output [15:0]debug_axi_pinc_in;
  output [15:0]debug_axi_poff_in;
  output debug_axi_resync_in;
  output [0:0]debug_axi_chan_in;
  output debug_core_nd;
  output [15:0]debug_phase;
  output debug_phase_nd;

  wire \<const0> ;
  wire aclk;
  wire aclken;
  wire aresetn;
  wire [0:0]debug_axi_chan_in;
  wire [15:0]debug_axi_pinc_in;
  wire [15:0]debug_axi_poff_in;
  wire debug_core_nd;
  wire [15:0]debug_phase;
  wire debug_phase_nd;
  wire event_phase_in_invalid;
  wire event_pinc_invalid;
  wire event_poff_invalid;
  wire event_s_config_tlast_missing;
  wire event_s_config_tlast_unexpected;
  wire event_s_phase_chanid_incorrect;
  wire event_s_phase_tlast_missing;
  wire event_s_phase_tlast_unexpected;
  wire [0:0]m_axis_data_tdata;
  wire m_axis_data_tlast;
  wire m_axis_data_tready;
  wire [0:0]m_axis_data_tuser;
  wire m_axis_data_tvalid;
  wire [15:0]m_axis_phase_tdata;
  wire m_axis_phase_tlast;
  wire m_axis_phase_tready;
  wire [0:0]m_axis_phase_tuser;
  wire m_axis_phase_tvalid;
  wire [0:0]s_axis_config_tdata;
  wire s_axis_config_tlast;
  wire s_axis_config_tready;
  wire s_axis_config_tvalid;
  wire [0:0]s_axis_phase_tdata;
  wire s_axis_phase_tlast;
  wire s_axis_phase_tready;
  wire [0:0]s_axis_phase_tuser;
  wire s_axis_phase_tvalid;
  wire NLW_i_synth_debug_axi_resync_in_UNCONNECTED;

  assign debug_axi_resync_in = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "1" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_M_DATA = "0" *) 
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "0" *) 
  (* C_HAS_S_CONFIG = "0" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "1" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "16" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "0" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "3" *) 
  (* C_PHASE_ANGLE_WIDTH = "3" *) 
  (* C_PHASE_INCREMENT = "2" *) 
  (* C_PHASE_INCREMENT_VALUE = "11000110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "0" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  dds_PG_pw24_dds_compiler_v6_0_12_viv i_synth
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(aresetn),
        .debug_axi_chan_in(debug_axi_chan_in),
        .debug_axi_pinc_in(debug_axi_pinc_in),
        .debug_axi_poff_in(debug_axi_poff_in),
        .debug_axi_resync_in(NLW_i_synth_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(debug_core_nd),
        .debug_phase(debug_phase),
        .debug_phase_nd(debug_phase_nd),
        .event_phase_in_invalid(event_phase_in_invalid),
        .event_pinc_invalid(event_pinc_invalid),
        .event_poff_invalid(event_poff_invalid),
        .event_s_config_tlast_missing(event_s_config_tlast_missing),
        .event_s_config_tlast_unexpected(event_s_config_tlast_unexpected),
        .event_s_phase_chanid_incorrect(event_s_phase_chanid_incorrect),
        .event_s_phase_tlast_missing(event_s_phase_tlast_missing),
        .event_s_phase_tlast_unexpected(event_s_phase_tlast_unexpected),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tlast(m_axis_data_tlast),
        .m_axis_data_tready(m_axis_data_tready),
        .m_axis_data_tuser(m_axis_data_tuser),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tlast(m_axis_phase_tlast),
        .m_axis_phase_tready(m_axis_phase_tready),
        .m_axis_phase_tuser(m_axis_phase_tuser),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .s_axis_config_tdata(s_axis_config_tdata),
        .s_axis_config_tlast(s_axis_config_tlast),
        .s_axis_config_tready(s_axis_config_tready),
        .s_axis_config_tvalid(s_axis_config_tvalid),
        .s_axis_phase_tdata(s_axis_phase_tdata),
        .s_axis_phase_tlast(s_axis_phase_tlast),
        .s_axis_phase_tready(s_axis_phase_tready),
        .s_axis_phase_tuser(s_axis_phase_tuser),
        .s_axis_phase_tvalid(s_axis_phase_tvalid));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
BeDk6slWwyJ7dkKWyaZdmI5S1xnQWnB2oiiYkvyYe3ILPohOGwb55RsmeeSbX1QjJu01hxqQuKng
/gQKr+nekw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ASzYKVAZmSO0SmC0FWgRspy8UM6oxvcf3jSUzSQ5aTbQcdQEmkCnyOPWPw5rhfBxgGmpUIes9+yb
Y1HX9gskfNW1iUc9hvj0/7i23Dl3Awuv9PwzU2qkFTur1xa+VTaDhjRdBkmelm1XEmzy0fVWfN3E
JrqrAgqGTQHZ2JkK6Bo=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oJBoHreUf2ZGu1uujJJM+r+7FZbqExapJJyyvy1o9iddxQis4QmRw6/bE0DAY0iOm9OEPedgUYiN
HJiQO008872laIEmtmT/BZsMbhdVL80RK/NlqxNSooHOOtA7Q2ooOW5Qroi6pqh15Of2uGz4EX8r
QzKai9gyZ1nNfMdTAvc=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
gXcd8sTNtxVLLLKC4rAjsRNsfX1NVlxv5NlbcoCN3RLErB2fm8TB5dri0TbIQGAb+HGHGVOVAHgx
uVooaR3J4n0jcKalCdHupCpw5tdmXAARWsN3+yNMWjktBvDZlREeBk2BplNU4DXuIjpyRlcW28oq
fXURF5uCQelaIUMgDwAyoK4ndypdafocPYsPsbB7ZcLdDX4H5Le9tBCnXO/3QcalHHXgUWKcLkyn
o62h+Ts9twP03kQwoK/zsw/Mj8ubV//CFoyYXoAsGg33zvV6pCpWjHcIR6qmaj3YFStAb9Gwjq47
yV9Y3uGyv5WU5KKhj3xqBA2tQXCqQY863nIZnQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZCOLBlM+DOBMBQ8zvcBqrtqtygwYjI0iydlVEAyokc0UPDasfRQj4taurJsghnxG4bETs5xI8oYV
0HnNJr9QlLNdd6mcJgJqN/c90+zI7I0/hnO/qlv0Pup/OiWbYiiAzYaGPmKRDqi7WYyqSO7I4TS2
AG2Q/zR6LKL+UR1LQcmMcJ4RgLFqPmMasX9iUCz5I9lsv9KntADfsOLwcJl5QoT1i4VZKbohe5Qm
MESQHJetAMfbworTVW5vJr8gNUaDSSpP+4845B0JGNCebeUUC8/1KVkOL2aPgIiLRFtWjAGp0OdP
Hgc1IPHx2d0B9ihxkm+YRP31ignQS302EQYvBw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NrFXeDUSk0IEdKSAJNgkeyX3IOnuNIcPQAo5W4y9LavsF2f6Nt+rduqEQbagw39p3ash8XtbR/w2
nbOm3koCj/8C0OoRET7PqvN4QJy3y4VTXAZe0/S0IrLxQsNhhv6J/qZfD8QvZ356rQBjqyRt3tes
FKIyW/uL9wD45Iy27+yn385eZ31TEAWa3qUWjlZ4QirRNAT1OkORBDIQDHOOlrRwhcFvBqpmP+bt
dB3NdDgt5niwoonBSPDFf2StNdLHNsQCxz9zmE4Hap77op41g4Avc9CdLgPyKBKRlvYKlsU5dB+X
7VzJf8Jl3UhqXRVBX0i7dzEKJTZE1Bhvb5jelg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
JZ96dHizR8iVyksCi3G9hD6UgrdJQy6lFRVQ9HfW4xM0BAQJmb7d+H7EN5bEUOKYXr7L1b2msUNG
Gi2WUAHbVXxfT1nINhzrHpokXqa9OVVvuOJKAn6nSbZDOdHqwVHdQ1Wqg5QMbUgvQYDlfyOKlhiz
q5LezhvRDQP2nMX5FS6IjGPgJA7rBCaxlhzPVjVEUh1gHcwioPpI1cX/jUP/m/W1REnZdkdEUufx
wot4ODOoBhGj5Flvsp8hctm31QyzPmorLFKSyGdRn/h57vIdtf76sTYYjoENxGZGjYNxwL2C0feG
/74pr6pkEEnbiyQ/ZXEpkoVYabU3ivtvy+0E8w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
yAcroUVP7QLqy2pzfbghAjFl+IEfyS+oxdLLgx+Ja5Vk5A77SXPgB8eaPW99tvQhFb2xno+v9vpv
E/DXhoHl1F/HpugV0G9bBKsAMFwVMBEnCiFOXGft4T1fPcZV3EIs+Dy3UtIEwqiVgNqFalKxUwe6
yllrWupKcUQe6o5Ci+ikVUDKLK2gzKj3093R+vn2NdRXkPEzyKz8M/HxaaiWvAPv8nKjTUaq9ayH
e+cyagi1dShzidT1rZytU7FDruD2pW6WWK0q3gYiki81ib0dPw4j/xfbsAaPH6Lcc+Xwze0Buko8
vc3bj9Isx8GudZUOhKS19dBHrwetcBJrcfRusg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 18352)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif

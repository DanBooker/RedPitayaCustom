// -----------------------------------------------------------------------------
// (c) Copyright 2013 Xilinx, Inc. All rights reserved.                
//                                                                              
// This file contains confidential and proprietary information                  
// of Xilinx, Inc. and is protected under U.S. and                              
// international copyright and other intellectual property                      
// laws.                                                                        
//                                                                              
// DISCLAIMER                                                                   
// This disclaimer is not a license and does not grant any                      
// rights to the materials distributed herewith. Except as                      
// otherwise provided in a valid license issued to you by                       
// Xilinx, and to the maximum extent permitted by applicable                    
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND                    
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES                  
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING                    
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-                       
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and                     
// (2) Xilinx shall not be liable (whether in contract or tort,                 
// including negligence, or under any other theory of                           
// liability) for any loss or damage of any kind or nature                      
// related to, arising under or in connection with these                        
// materials, including for any direct, or any indirect,                        
// special, incidental, or consequential loss or damage                         
// (including loss of data, profits, goodwill, or any type of                   
// loss or damage suffered as a result of any action brought                    
// by a third party) even if such damage or loss was                            
// reasonably foreseeable or Xilinx had been advised of the                     
// possibility of the same.                                                     
//                                                                              
// CRITICAL APPLICATIONS                                                        
// Xilinx products are not designed or intended to be fail-                     
// safe, or for use in any application requiring fail-safe                      
// performance, such as life-support or safety devices or                       
// systems, Class III medical devices, nuclear facilities,                      
// applications related to the deployment of airbags, or any                    
// other applications that could lead to death, personal                        
// injury, or severe property or environmental damage                           
// (individually and collectively, "Critical                                   
// Applications"). Customer assumes the sole risk and                          
// liability of any use of Xilinx products in Critical                          
// Applications, subject only to applicable laws and                            
// regulations governing limitations on product liability.                      
//                                                                              
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS                     
// PART OF THIS FILE AT ALL TIMES.                                              
// -----------------------------------------------------------------------------

`timescale 1ps / 1ps

`default_nettype none

module axi_protocol_converter_0_example_design
  (
    /**************** Other Signals ****************/
    output wire                            done,
    /**************** System Signals ****************/
    input  wire                            clk_p,
    input  wire                            clk_n,
    input  wire                            sys_rst
  );

  //**********************************************
  // Signals
  //**********************************************
  (* MARK_DEBUG *) wire                            aclk;
  (* MARK_DEBUG *) wire                            aresetn;
  (* MARK_DEBUG *) wire                            locked;

  /**************** Write Address Channel Signals ****************/
  (* MARK_DEBUG *) wire [32-1:0]      m_axi_awaddr;
  (* MARK_DEBUG *) wire [3-1:0]                    m_axi_awprot;
  (* MARK_DEBUG *) wire                            m_axi_awvalid;
  (* MARK_DEBUG *) wire                            m_axi_awready;
  (* MARK_DEBUG *) wire [32-1:0]      s_axi_awaddr;
  (* MARK_DEBUG *) wire [3-1:0]                    s_axi_awprot;
  (* MARK_DEBUG *) wire                            s_axi_awvalid;
  (* MARK_DEBUG *) wire                            s_axi_awready;
  (* MARK_DEBUG *) wire [3-1:0]                    s_axi_awsize;
  (* MARK_DEBUG *) wire [2-1:0]                    s_axi_awburst;
  (* MARK_DEBUG *) wire [4-1:0]                    s_axi_awcache;
  (* MARK_DEBUG *) wire [4-1:0]       s_axi_awlen;
  (* MARK_DEBUG *) wire [2-1:0]      s_axi_awlock;
  (* MARK_DEBUG *) wire [4-1:0]                    s_axi_awqos;
  (* MARK_DEBUG *) wire [12-1:0]        s_axi_awid;
  /**************** Write Data Channel Signals ****************/
  (* MARK_DEBUG *) wire [32-1:0]      m_axi_wdata;
  (* MARK_DEBUG *) wire [32/8-1:0]    m_axi_wstrb;
  (* MARK_DEBUG *) wire                            m_axi_wvalid;
  (* MARK_DEBUG *) wire                            m_axi_wready;
  (* MARK_DEBUG *) wire [32-1:0]      s_axi_wdata;
  (* MARK_DEBUG *) wire [32/8-1:0]    s_axi_wstrb;
  (* MARK_DEBUG *) wire                            s_axi_wvalid;
  (* MARK_DEBUG *) wire                            s_axi_wready;
  (* MARK_DEBUG *) wire                            s_axi_wlast;
  (* MARK_DEBUG *) wire [12-1:0]        s_axi_wid;
  /**************** Write Response Channel Signals ****************/
  (* MARK_DEBUG *) wire [2-1:0]                    m_axi_bresp;
  (* MARK_DEBUG *) wire                            m_axi_bvalid;
  (* MARK_DEBUG *) wire                            m_axi_bready;
  (* MARK_DEBUG *) wire [2-1:0]                    s_axi_bresp;
  (* MARK_DEBUG *) wire                            s_axi_bvalid;
  (* MARK_DEBUG *) wire                            s_axi_bready;
  (* MARK_DEBUG *) wire [12-1:0]        s_axi_bid;
  /**************** Read Address Channel Signals ****************/
  (* MARK_DEBUG *) wire [32-1:0]      m_axi_araddr;
  (* MARK_DEBUG *) wire [3-1:0]                    m_axi_arprot;
  (* MARK_DEBUG *) wire                            m_axi_arvalid;
  (* MARK_DEBUG *) wire                            m_axi_arready;
  (* MARK_DEBUG *) wire [32-1:0]      s_axi_araddr;
  (* MARK_DEBUG *) wire [3-1:0]                    s_axi_arprot;
  (* MARK_DEBUG *) wire                            s_axi_arvalid;
  (* MARK_DEBUG *) wire                            s_axi_arready;
  (* MARK_DEBUG *) wire [3-1:0]                    s_axi_arsize;
  (* MARK_DEBUG *) wire [2-1:0]                    s_axi_arburst;
  (* MARK_DEBUG *) wire [4-1:0]                    s_axi_arcache;
  (* MARK_DEBUG *) wire [2-1:0]      s_axi_arlock;
  (* MARK_DEBUG *) wire [4-1:0]       s_axi_arlen;
  (* MARK_DEBUG *) wire [4-1:0]                    s_axi_arqos;
  (* MARK_DEBUG *) wire [12-1:0]        s_axi_arid;
  /**************** Read Data Channel Signals ****************/
  (* MARK_DEBUG *) wire [32-1:0]      m_axi_rdata;
  (* MARK_DEBUG *) wire [2-1:0]                    m_axi_rresp;
  (* MARK_DEBUG *) wire                            m_axi_rvalid;
  (* MARK_DEBUG *) wire                            m_axi_rready;
  (* MARK_DEBUG *) wire [32-1:0]      s_axi_rdata;
  (* MARK_DEBUG *) wire [2-1:0]                    s_axi_rresp;
  (* MARK_DEBUG *) wire                            s_axi_rvalid;
  (* MARK_DEBUG *) wire                            s_axi_rready;
  (* MARK_DEBUG *) wire                            s_axi_rlast;
  (* MARK_DEBUG *) wire [12-1:0]        s_axi_rid;

  //**********************************************
  // Instantiate MASTER
  //**********************************************
  axi_protocol_converter_0_example_master
  axi_master_m00 (
  /**************** Write Address Channel Signals ****************/
  .m_axi_awaddr(s_axi_awaddr),
  .m_axi_awprot(s_axi_awprot),
  .m_axi_awvalid(s_axi_awvalid),
  .m_axi_awready(s_axi_awready),
  .m_axi_awsize(s_axi_awsize),
  .m_axi_awburst(s_axi_awburst),
  .m_axi_awcache(s_axi_awcache),
  .m_axi_awlen(s_axi_awlen),
  .m_axi_awlock(s_axi_awlock),
  .m_axi_awqos(s_axi_awqos),
  .m_axi_awid(s_axi_awid),
  /**************** Write Data Channel Signals ****************/
  .m_axi_wdata(s_axi_wdata),
  .m_axi_wstrb(s_axi_wstrb),
  .m_axi_wvalid(s_axi_wvalid),
  .m_axi_wready(s_axi_wready),
  .m_axi_wlast(s_axi_wlast),
  .m_axi_wid(s_axi_wid),
  /**************** Write Response Channel Signals ****************/
  .m_axi_bresp(s_axi_bresp),
  .m_axi_bvalid(s_axi_bvalid),
  .m_axi_bready(s_axi_bready),
  .m_axi_bid(s_axi_bid),
  /**************** Read Address Channel Signals ****************/
  .m_axi_araddr(s_axi_araddr),
  .m_axi_arprot(s_axi_arprot),
  .m_axi_arvalid(s_axi_arvalid),
  .m_axi_arready(s_axi_arready),
  .m_axi_arsize(s_axi_arsize),
  .m_axi_arburst(s_axi_arburst),
  .m_axi_arcache(s_axi_arcache),
  .m_axi_arlock(s_axi_arlock),
  .m_axi_arlen(s_axi_arlen),
  .m_axi_arqos(s_axi_arqos),
  .m_axi_arid(s_axi_arid),
  /**************** Read Data Channel Signals ****************/
  .m_axi_rdata(s_axi_rdata),
  .m_axi_rresp(s_axi_rresp),
  .m_axi_rvalid(s_axi_rvalid),
  .m_axi_rready(s_axi_rready),
  .m_axi_rlast(s_axi_rlast),
  .m_axi_rid(s_axi_rid),
  /**************** Other Signals ****************/
  .done(done),
  /**************** System Signals ****************/
  .aclk(aclk),
  .aresetn(aresetn)
  );

  //**********************************************
  // Instantiate SLAVE
  //**********************************************
  axi_protocol_converter_0_example_slave
  axi_slave_s00 (
  /**************** Write Address Channel Signals ****************/
  .s_axi_awaddr(m_axi_awaddr),
  .s_axi_awprot(m_axi_awprot),
  .s_axi_awvalid(m_axi_awvalid),
  .s_axi_awready(m_axi_awready),
  /**************** Write Data Channel Signals ****************/
  .s_axi_wdata(m_axi_wdata),
  .s_axi_wstrb(m_axi_wstrb),
  .s_axi_wvalid(m_axi_wvalid),
  .s_axi_wready(m_axi_wready),
  /**************** Write Response Channel Signals ****************/
  .s_axi_bresp(m_axi_bresp),
  .s_axi_bvalid(m_axi_bvalid),
  .s_axi_bready(m_axi_bready),
  /**************** Read Address Channel Signals ****************/
  .s_axi_araddr(m_axi_araddr),
  .s_axi_arprot(m_axi_arprot),
  .s_axi_arvalid(m_axi_arvalid),
  .s_axi_arready(m_axi_arready),
  /**************** Read Data Channel Signals ****************/
  .s_axi_rdata(m_axi_rdata),
  .s_axi_rresp(m_axi_rresp),
  .s_axi_rvalid(m_axi_rvalid),
  .s_axi_rready(m_axi_rready),
  /**************** System Signals ****************/
  .aclk(aclk),
  .aresetn(aresetn)
  );

  //**********************************************
  // Instantiate DUT
  //**********************************************
  axi_protocol_converter_0
  dut
  (
  //**********************************************
  // DUT SLAVE INTERFACE
  //**********************************************
  /**************** Write Address Channel Signals ****************/
  .s_axi_awaddr(s_axi_awaddr),
  .s_axi_awprot(s_axi_awprot),
  .s_axi_awvalid(s_axi_awvalid),
  .s_axi_awready(s_axi_awready),
  .s_axi_awsize(s_axi_awsize),
  .s_axi_awburst(s_axi_awburst),
  .s_axi_awcache(s_axi_awcache),
  .s_axi_awlen(s_axi_awlen),
  .s_axi_awlock(s_axi_awlock),
  .s_axi_awqos(s_axi_awqos),
  .s_axi_awid(s_axi_awid),
  /**************** Write Data Channel Signals ****************/
  .s_axi_wdata(s_axi_wdata),
  .s_axi_wstrb(s_axi_wstrb),
  .s_axi_wvalid(s_axi_wvalid),
  .s_axi_wready(s_axi_wready),
  .s_axi_wlast(s_axi_wlast),
  .s_axi_wid(s_axi_wid),
  /**************** Write Response Channel Signals ****************/
  .s_axi_bresp(s_axi_bresp),
  .s_axi_bvalid(s_axi_bvalid),
  .s_axi_bready(s_axi_bready),
  .s_axi_bid(s_axi_bid),
  /**************** Read Address Channel Signals ****************/
  .s_axi_araddr(s_axi_araddr),
  .s_axi_arprot(s_axi_arprot),
  .s_axi_arvalid(s_axi_arvalid),
  .s_axi_arready(s_axi_arready),
  .s_axi_arsize(s_axi_arsize),
  .s_axi_arburst(s_axi_arburst),
  .s_axi_arcache(s_axi_arcache),
  .s_axi_arlock(s_axi_arlock),
  .s_axi_arlen(s_axi_arlen),
  .s_axi_arqos(s_axi_arqos),
  .s_axi_arid(s_axi_arid),
  /**************** Read Data Channel Signals ****************/
  .s_axi_rdata(s_axi_rdata),
  .s_axi_rresp(s_axi_rresp),
  .s_axi_rvalid(s_axi_rvalid),
  .s_axi_rready(s_axi_rready),
  .s_axi_rlast(s_axi_rlast),
  .s_axi_rid(s_axi_rid),

  //**********************************************
  // DUT MASTER INTERFACE
  //**********************************************
  /**************** Write Address Channel Signals ****************/
  .m_axi_awaddr(m_axi_awaddr),
  .m_axi_awprot(m_axi_awprot),
  .m_axi_awvalid(m_axi_awvalid),
  .m_axi_awready(m_axi_awready),
  /**************** Write Data Channel Signals ****************/
  .m_axi_wdata(m_axi_wdata),
  .m_axi_wstrb(m_axi_wstrb),
  .m_axi_wvalid(m_axi_wvalid),
  .m_axi_wready(m_axi_wready),
  /**************** Write Response Channel Signals ****************/
  .m_axi_bresp(m_axi_bresp),
  .m_axi_bvalid(m_axi_bvalid),
  .m_axi_bready(m_axi_bready),
  /**************** Read Address Channel Signals ****************/
  .m_axi_araddr(m_axi_araddr),
  .m_axi_arprot(m_axi_arprot),
  .m_axi_arvalid(m_axi_arvalid),
  .m_axi_arready(m_axi_arready),
  /**************** Read Data Channel Signals ****************/
  .m_axi_rdata(m_axi_rdata),
  .m_axi_rresp(m_axi_rresp),
  .m_axi_rvalid(m_axi_rvalid),
  .m_axi_rready(m_axi_rready),

  /**************** System Signals ****************/
  .aclk(aclk),
  .aresetn(aresetn)
  );

  //**********************************************
  // Instantiate Clock Generator module
  //**********************************************
  axi_protocol_converter_0_example_clk_wiz_0
  clk_wiz_0
  (
    .clk_in1_p( clk_p ),
    .clk_in1_n( clk_n ),
    .clk_out1(aclk),
    .locked(locked)
  );

  //**********************************************
  // Instantiate Reset Generator module
  //**********************************************
  axi_protocol_converter_0_example_proc_sys_reset_0
  proc_sys_reset_0
  (
    .slowest_sync_clk(aclk),
    .ext_reset_in(sys_rst),
    .interconnect_aresetn(aresetn),
    .aux_reset_in(1'b0),
    .mb_debug_sys_rst(1'b0),
    .dcm_locked(locked),
    .mb_reset(),
    .bus_struct_reset(),
    .peripheral_reset(),
    .peripheral_aresetn()
  );


endmodule

`default_nettype wire


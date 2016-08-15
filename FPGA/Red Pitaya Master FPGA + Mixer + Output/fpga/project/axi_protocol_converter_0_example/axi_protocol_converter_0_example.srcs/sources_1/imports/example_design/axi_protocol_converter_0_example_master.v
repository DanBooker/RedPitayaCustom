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

`timescale 1ps/1ps

`default_nettype none

module axi_protocol_converter_0_example_master
(
  /**************** Write Address Channel Signals ****************/
  output reg [32-1:0]       m_axi_awaddr = {32{1'b0}},
  output reg [3-1:0]                     m_axi_awprot = 3'b0,
  output reg                             m_axi_awvalid = 1'b0,
  input  wire                            m_axi_awready,
  output reg [3-1:0]                     m_axi_awsize = 3'b0,
  output reg [2-1:0]                     m_axi_awburst = 2'b0,
  output reg [4-1:0]                     m_axi_awcache = 4'b0,
  output reg [4-1:0]        m_axi_awlen = {4{1'b0}},
  output reg [2-1:0]       m_axi_awlock = {2{1'b0}},
  output reg [4-1:0]                     m_axi_awqos = 4'b0,
  output reg [12-1:0]         m_axi_awid = {12{1'b0}},
  /**************** Write Data Channel Signals ****************/
  output wire [32-1:0]      m_axi_wdata,
  output reg [32/8-1:0]     m_axi_wstrb = {(32/8){1'b1}},
  output reg                             m_axi_wvalid = 1'b0,
  input  wire                            m_axi_wready,
  output reg                             m_axi_wlast = 1'b0,
  output reg [12-1:0]         m_axi_wid = {12{1'b0}},
  /**************** Write Response Channel Signals ****************/
  input  wire [2-1:0]                    m_axi_bresp,
  input  wire                            m_axi_bvalid,
  output reg                             m_axi_bready = 1'b0,
  input  wire [12-1:0]        m_axi_bid,
  /**************** Read Address Channel Signals ****************/
  output reg [32-1:0]       m_axi_araddr = {32{1'b0}},
  output reg [3-1:0]                     m_axi_arprot = 3'b0,
  output reg                             m_axi_arvalid = 1'b0,
  input  wire                            m_axi_arready,
  output reg [3-1:0]                     m_axi_arsize = 3'b0,
  output reg [2-1:0]                     m_axi_arburst = 2'b0,
  output reg [4-1:0]                     m_axi_arcache = 4'b0,
  output reg [4-1:0]        m_axi_arlen = {4{1'b0}},
  output reg [2-1:0]       m_axi_arlock = {2{1'b0}},
  output reg [4-1:0]                     m_axi_arqos = 4'b0,
  output reg [12-1:0]         m_axi_arid = {12{1'b0}},
  /**************** Read Data Channel Signals ****************/
  input  wire [32-1:0]      m_axi_rdata,
  input  wire [2-1:0]                    m_axi_rresp,
  input  wire                            m_axi_rvalid,
  output reg                             m_axi_rready = 1'b0,
  input  wire                            m_axi_rlast,
  input  wire [12-1:0]        m_axi_rid,
  /**************** Other Signals ****************/
  output wire                            done,
  /**************** System Signals ****************/
  input  wire                            aclk,
  input  wire                            aresetn
  );

  /**************** Local Parameters ****************/
  localparam [16-1:0]              P_M_AXI_XACTIONS = 10;
  localparam integer               P_M_AXI_DATA_BYTES = (32 / 8);
  localparam [16-1:0]              P_M_AXI_DONE = 20;
  localparam [8-1:0]               P_M_AXI_DONE_WIDTH = 5;
  localparam integer               P_M_AXI_SIZE = 2;
  localparam [4-1:0]  P_M_AXI_BURST_LEN = 15;

  genvar i;
  /**************** Internal Wires/Regs - Read Channels ****************/
  reg [P_M_AXI_DONE_WIDTH-1:0] arcnt_i = {P_M_AXI_DONE_WIDTH{1'b0}}, rcnt_i = {P_M_AXI_DONE_WIDTH{1'b0}};
  wire                         read_xaction_done_i;
  reg [32:0]      araddr_i = {(32+1){1'b0}};
  reg [3-1:0]                  arprot_i = 3'b0;
  reg [3-1:0]                  arsize_i = 3'b0;
  reg [2-1:0]                  arburst_i = 2'b0;
  reg [4-1:0]                  arcache_i = 4'b0;
  reg [2-1:0]                  arlock_i = 2'b0;
  reg [4-1:0]     arlen_i = {4{1'b0}};
  reg [4-1:0]                  arqos_i = 4'b0;
  reg [12:0]        arid_i = {(12+1){1'b0}};
  reg [32-1:0]    rdata_i = {32{1'b0}};
  reg [2-1:0]                  rresp_i = 2'b00;
  reg [12-1:0]      rid_i = {12{1'b0}};
  reg [3:0]                    acc_r_i = 4'b0;

  /**************** Internal Wires/Regs - Write Channels ****************/
  reg [32-1:0]    wdata_i = {32{1'b0}};
  reg [P_M_AXI_DONE_WIDTH-1:0] awcnt_i = {P_M_AXI_DONE_WIDTH{1'b0}}, wcnt_i = {P_M_AXI_DONE_WIDTH{1'b0}}, bcnt_i = {P_M_AXI_DONE_WIDTH{1'b0}};
  reg [8-1:0]                  xfer_w_i = 8'h00;
  wire                         write_burst_done_i;
  reg [32:0]      awaddr_i = {(32+1){1'b0}};
  reg [3-1:0]                  awprot_i = 3'b0;
  reg [3-1:0]                  awsize_i = 3'b0;
  reg [2-1:0]                  awburst_i = 2'b0;
  reg [4-1:0]                  awcache_i = 4'b0;
  reg [2-1:0]                  awlock_i = 2'b0;
  reg [4-1:0]     awlen_i = {4{1'b0}};
  reg [4-1:0]                  awqos_i = 4'b0;
  reg [12:0]        awid_i = {(12+1){1'b0}};
  reg [P_M_AXI_DATA_BYTES-1:0] wstrb_i = {P_M_AXI_DATA_BYTES{1'b1}};
  reg [12:0]        wid_i = {(12+1){1'b0}};
  reg [2-1:0]                  bresp_i = 2'b00;
  reg [12-1:0]      bid_i = {12{1'b0}};
  reg [2:0]                    acc_b_i = 3'b0;

  /**************** Internal Wires/Regs - Other ****************/
  wire                         done_i;
  wire                         done_sel;
  reg                          done_cycle;
  reg                          done_d1;
  wire                         areset = ~aresetn;
  reg [2-1:0]                  areset_i = 2'b00;

  /**************** Assign Read Channel Outputs ****************/
  assign read_xaction_done_i = m_axi_rvalid && m_axi_rready && m_axi_rlast;
  always @(posedge aclk) begin
    m_axi_araddr <= done_cycle ? araddr_i[32-1:0] : 32'h0;
    m_axi_arprot <= done_cycle ? arprot_i : 3'b000;
    m_axi_arsize <= done_cycle ? arsize_i : P_M_AXI_SIZE;
    m_axi_arburst <= done_cycle ? arburst_i : 2'b01;
    m_axi_arlock <= done_cycle ? arlock_i[2-1:0] : {2{1'b0}};
    m_axi_arcache <= done_cycle ? arcache_i : 4'h3;
    m_axi_arqos <= done_cycle ? arqos_i : 4'h0;
    m_axi_arid <= done_cycle ? arid_i[12-1:0] : {12{1'b0}};
  end

  /**************** Assign Write Channel Outputs ****************/
  assign m_axi_wdata = wdata_i;
  assign write_burst_done_i = (m_axi_wready && m_axi_wvalid && m_axi_wlast);
  always @(posedge aclk) begin
    m_axi_awaddr <= done_cycle ? awaddr_i[32-1:0] : 32'h0;
    m_axi_awprot <= done_cycle ? awprot_i : 3'b000;
    m_axi_awsize <= done_cycle ? awsize_i : P_M_AXI_SIZE;
    m_axi_awburst <= done_cycle ? awburst_i : 2'b01;
    m_axi_awlock <= done_cycle ? awlock_i[2-1:0] : {2{1'b0}};
    m_axi_awcache <= done_cycle ? awcache_i : 4'h3;
    m_axi_awqos <= done_cycle ? awqos_i : 4'h0;
    m_axi_awid <= done_cycle ? awid_i[12-1:0] : {12{1'b0}};
    m_axi_wid <= done_cycle ? wid_i[12-1:0] : {12{1'b0}};
    m_axi_wstrb <= done_cycle ? wstrb_i : {P_M_AXI_DATA_BYTES{1'b1}};
  end

  // Register Reset
  always @(posedge aclk) begin
    areset_i <= {areset_i[0], areset};
  end

  //**********************************************
  // Read Channel: ARVALID, ARADDR, ARLEN, RREADY
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      m_axi_arvalid <= 1'b0;
      m_axi_rready <= 1'b0;
      rcnt_i <= {P_M_AXI_DONE_WIDTH{1'b0}};
      arcnt_i <= {P_M_AXI_DONE_WIDTH{1'b0}};
      m_axi_arlen <= {4{1'b0}};
    end else begin
      /**************** Read Address Channel ****************/
      // Increment counters
      arcnt_i <= (m_axi_arvalid && m_axi_arready) ? (arcnt_i + 1'b1) : (arcnt_i);

      // Select between burst length
      m_axi_arlen <= done_cycle ? arlen_i : ((arcnt_i == P_M_AXI_XACTIONS-1) && (m_axi_arlen != P_M_AXI_BURST_LEN) && m_axi_arready && m_axi_arvalid) ? P_M_AXI_BURST_LEN : m_axi_arlen;

      // arvalid
      if(areset_i == 2'b10) begin
        m_axi_arvalid <= 1'b1;
      end else if(m_axi_arready && m_axi_arvalid && (arcnt_i == P_M_AXI_DONE-1'b1)) begin
        m_axi_arvalid <= 1'b0;
      end else begin
        m_axi_arvalid <= m_axi_arvalid;
      end

      /**************** Read Data Channel ****************/
      // Toggle rready to demonstrate backpressure from master
      m_axi_rready <= ~m_axi_rready;

      // Increment counters
      rcnt_i <= (read_xaction_done_i) ? (rcnt_i + 1'b1) : (rcnt_i);
    end
  end


  //**********************************************
  // Read Channel: Random outputs
  //**********************************************
  always @(posedge aclk) begin
    araddr_i <= {araddr_i[32-1:0], ~araddr_i[32]};
    arprot_i <= {arprot_i[3-2:0], ~arprot_i[3-1]};
    arlen_i <= {arlen_i[4-2:0], ~arlen_i[4-1]};
    arsize_i <= {arsize_i[3-2:0], ~arsize_i[3-1]};
    arburst_i <= {arburst_i[2-2:0], ~arburst_i[2-1]};
    arlock_i <= {arlock_i[2-2:0], ~arlock_i[2-1]};
    arcache_i <= {arcache_i[4-2:0], ~arcache_i[4-1]};
    arqos_i <= {arqos_i[4-2:0], ~arqos_i[4-1]};
    arid_i <= {arid_i[12-1:0], ~arid_i[12]};
  end

  //**********************************************
  // Read Channel: PROCESS INPUTS
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      rdata_i <= {32{1'b0}};
      rresp_i <= {2{1'b0}};
      rid_i <= {12{1'b0}};
      acc_r_i <= 4'b0;
    end else if (m_axi_rvalid) begin
      // Register Inputs
      rdata_i <= m_axi_rdata;
        acc_r_i[0] <= rdata_i[0];
      rresp_i <= m_axi_rresp;
        acc_r_i[1] <= rresp_i[0];
      rid_i <= m_axi_rid;
        acc_r_i[3] <= rid_i[0];
    end else begin
      rdata_i <= rdata_i>>1;
      rresp_i <= rresp_i>>1;
      rid_i <= rid_i>>1;
      acc_r_i <= acc_r_i>>1;
    end
  end

  //**********************************************
  // Write Channel: AWVALID, AWADDR, AWLEN, WVALID, WLAST, BREADY
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      m_axi_awvalid <= 1'b0;
      m_axi_wvalid <= 1'b0;
      m_axi_bready <= 1'b0;
      awcnt_i <= {P_M_AXI_DONE_WIDTH{1'b0}};
      wcnt_i <= {P_M_AXI_DONE_WIDTH{1'b0}};
      bcnt_i <= {P_M_AXI_DONE_WIDTH{1'b0}};
      xfer_w_i <= 8'h00;
      m_axi_awlen <= {4{1'b0}};
      m_axi_wlast <= 1'b0;
    end
    else begin
      /**************** Write Address Channel ****************/
      // Increment counters
      awcnt_i <= (m_axi_awready && m_axi_awvalid) ? (awcnt_i + 1'b1) : (awcnt_i);

      // Select between burst length
      m_axi_awlen <= done_cycle ? awlen_i : ((awcnt_i == P_M_AXI_XACTIONS-1) && (m_axi_awlen != P_M_AXI_BURST_LEN) && m_axi_awready && m_axi_awvalid) ? P_M_AXI_BURST_LEN : m_axi_awlen;

      // awvalid
      if(areset_i == 2'b10) begin
        m_axi_awvalid <= 1'b1;
      end else if(m_axi_awready && m_axi_awvalid && (awcnt_i == P_M_AXI_DONE-1'b1)) begin
        m_axi_awvalid <= 1'b0;
      end else begin
        m_axi_awvalid = m_axi_awvalid;
      end

      /**************** Write Data Channel ****************/
      m_axi_wlast <= (awcnt_i < P_M_AXI_XACTIONS) ? 1'b1 : ((xfer_w_i == P_M_AXI_BURST_LEN - 1) ? 1'b1 : 1'b0);

      // Increment counters
      if(m_axi_wready && m_axi_wvalid) begin
        if(m_axi_wlast) begin
          xfer_w_i <= 8'h00;
          wcnt_i <= wcnt_i + 1'b1;
        end else begin
          xfer_w_i <= xfer_w_i + 1'b1;
        end
      end else begin
        xfer_w_i <= xfer_w_i;
        wcnt_i <= wcnt_i;
      end

      // wvalid
      if(areset_i == 2'b10) begin
        m_axi_wvalid <= 1'b1;
      end else if(write_burst_done_i && (wcnt_i == P_M_AXI_DONE-1)) begin
        m_axi_wvalid <= 1'b0;
      end else begin
        m_axi_wvalid <= m_axi_wvalid;
      end

      /**************** Write Response Channel ****************/
      // Toggle bready to demonstrate backpressure from master
      m_axi_bready <= ~m_axi_bready;

      // Increment counters
      bcnt_i <= (m_axi_bready && m_axi_bvalid) ? (bcnt_i + 1'b1) : (bcnt_i);
    end
  end



  //**********************************************
  // Write Channel: WDATA
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      wdata_i <= {32{1'b0}};
    end else begin
      wdata_i <= (m_axi_wvalid && m_axi_wready) ? {wdata_i[32-2 : 0], ~wdata_i[32-1]} : wdata_i;
    end
  end

  //**********************************************
  // Write Channel: Random outputs
  //**********************************************
  always @(posedge aclk) begin
    awaddr_i <= {awaddr_i[32-1:0], ~awaddr_i[32]};
    awprot_i <= {awprot_i[3-2:0], ~awprot_i[3-1]};
    wstrb_i <= {wstrb_i[32/8-2:0], ~wstrb_i[32/8-1]};
    awlen_i <= {awlen_i[4-2:0], ~awlen_i[4-1]};
    awsize_i <= {awsize_i[3-2:0], ~awsize_i[3-1]};
    awburst_i <= {awburst_i[2-2:0], ~awburst_i[2-1]};
    awlock_i <= {awlock_i[2-2:0], ~awlock_i[2-1]};
    awcache_i <= {awcache_i[4-2:0], ~awcache_i[4-1]};
    awqos_i <= {awqos_i[4-2:0], ~awqos_i[4-1]};
    awid_i <= {awid_i[12-1:0], ~awid_i[12]};
    wid_i <= {wid_i[12-1:0], ~wid_i[12]};
  end

  //**********************************************
  // Write Channel: PROCESS INPUTS
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      bresp_i <= {2{1'b0}};
      bid_i <= {12{1'b0}};
      acc_b_i <= 3'b0;
    end else if (m_axi_bvalid) begin
      // Register Inputs
      bresp_i <= m_axi_bresp;
        acc_b_i[0] <= bresp_i[0];
      bid_i <= m_axi_bid;
        acc_b_i[2] <= bid_i[0];
    end else begin
      bresp_i <= bresp_i>>1;
      bid_i <= bid_i>>1;
      acc_b_i <= acc_b_i>>1;
    end
  end

  //**********************************************
  // Assert Done
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      done_d1 <= 1'b0;
      done_cycle <= 1'b0;
    end else begin
      done_d1 <= done_i;
      done_cycle <= done_i & ~done_d1;
    end
  end

  assign done_i = (rcnt_i==P_M_AXI_DONE) && (bcnt_i==P_M_AXI_DONE);
  assign done_sel = acc_r_i[0] & acc_b_i[0];
  assign done = done_sel ? done_i : done_d1;

endmodule

`default_nettype wire


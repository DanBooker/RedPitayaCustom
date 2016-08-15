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

module
axi_protocol_converter_0_example_slave
(
  /**************** Write Address Channel Signals ****************/
  input  wire [32-1:0]     s_axi_awaddr,
  input  wire [3-1:0]                   s_axi_awprot,
  input  wire                           s_axi_awvalid,
  output reg                            s_axi_awready = 1'b0,
  /**************** Write Data Channel Signals ****************/
  input  wire [32-1:0]     s_axi_wdata,
  input  wire [32/8-1:0]   s_axi_wstrb,
  input  wire                           s_axi_wvalid,
  output reg                            s_axi_wready = 1'b0,
  /**************** Write Response Channel Signals ****************/
  output reg [2-1:0]                    s_axi_bresp = 2'b0,
  output reg                            s_axi_bvalid = 1'b0,
  input  wire                           s_axi_bready,
  /**************** Read Address Channel Signals ****************/
  input  wire [32-1:0]     s_axi_araddr,
  input  wire [3-1:0]                   s_axi_arprot,
  input  wire                           s_axi_arvalid,
  output reg                            s_axi_arready = 1'b0,
  /**************** Read Data Channel Signals ****************/
  output wire [32-1:0]     s_axi_rdata,
  output reg [2-1:0]                    s_axi_rresp = 2'b0,
  output reg                            s_axi_rvalid = 1'b0,
  input  wire                           s_axi_rready,
  /**************** System Signals ****************/
  input  wire                           aclk,
  input  wire                           aresetn
  );

  /**************** Local Parameters ****************/
  localparam integer P_S_AXI_DATA_BYTES = 32/8;

  genvar i;
  /**************** Internal Wires/Regs - Read Channels ****************/
  reg [8-1:0]                   xfer_r_cnt = 8'h00;
  reg [16-1:0]                  arcnt_i = 16'h0000;
  wire                          read_xaction_done_i;
  reg [32-1:0]     rdata_i = {32{1'b0}};
  reg                           arvalid_i = 1'b0;
  reg [32-1:0]     araddr_i = {32{1'b0}};
  reg [3-1:0]                   arprot_i = 3'b000;
  reg [8:0]                     acc_ar_i = 9'b0;

  /**************** Internal Wires/Regs - Write Channels ****************/
  wire                          write_burst_done_i;
  reg [16-1:0]                  awcnt_i = 16'h0000;
  reg                           awvalid_i = 1'b0;
  reg [32-1:0]     awaddr_i = {32{1'b0}};
  reg [3-1:0]                   awprot_i = 3'b000;
  reg                           wvalid_i = 1'b0;
  reg [32-1:0]     wdata_i = {32{1'b0}};
  reg [32/8-1:0]   wstrb_i = {(32/8){1'b0}};
  reg [8:0]                     acc_aw_i = 9'b0;
  reg [3:0]                     acc_w_i = 4'b0;
  /**************** Internal Wires/Regs - Other ****************/
  wire                          areset = ~aresetn;
  reg [2-1:0]                   areset_i = 2'b00;

  /**************** Assign Read Channel Outputs ****************/
  assign s_axi_rdata = rdata_i;
  assign read_xaction_done_i = (s_axi_rready && s_axi_rvalid);
  /**************** Assign Write Channel Outputs ****************/
  assign write_burst_done_i =(s_axi_wready && s_axi_wvalid);

  // Register Reset
  always @(posedge aclk) begin
    areset_i <= {areset_i[0], areset};
  end

  //**********************************************
  // Read Channel: ARREADY, RVALID, RLAST, RID
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      s_axi_arready <= 1'b0;
      s_axi_rvalid <= 1'b0;
      xfer_r_cnt <= 8'h00;
      arcnt_i <= 16'h0000;
    end else begin
      /**************** Read Address Channel ****************/
      // arready
      if(areset_i == 2'b10) begin
        s_axi_arready <= 1'b1;
      end else if(s_axi_arready && s_axi_arvalid) begin
        s_axi_arready <= 1'b0;
        arcnt_i <= arcnt_i + 1'b1;
      end else if(read_xaction_done_i) begin
        s_axi_arready <= 1'b1;
      end else begin
        s_axi_arready <= s_axi_arready;
      end

      /**************** Read Data Channel ****************/
      // Increment counters

      // rvalid
      if(s_axi_arready && s_axi_arvalid) begin
        s_axi_rvalid <= 1'b1;
      end else if(read_xaction_done_i) begin
        s_axi_rvalid <= 1'b0;
      end else begin
        s_axi_rvalid <= s_axi_rvalid;
      end

    end
  end


  //**********************************************
  // Read Channel: RDATA
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      rdata_i <= {32{1'b0}};
    end else begin
      rdata_i <= (s_axi_rready && s_axi_rvalid) ? {rdata_i[32-2 : 0], ~rdata_i[32-1]} : rdata_i;
    end
  end

  //**********************************************
  // Read Channel: RRESP
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      s_axi_rresp <= {2{1'b0}};
    end else if (read_xaction_done_i) begin
      s_axi_rresp <= 2'b11;
    end else if (~s_axi_rvalid) begin
      s_axi_rresp <= {acc_ar_i[0], 1'b0};
    end
  end

  //**********************************************
  // Read Channel: PROCESS INPUTS
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      araddr_i <= {32{1'b0}};
      arprot_i <= {3{1'b0}};
      acc_ar_i <= 9'b0;
    end else if (s_axi_arvalid) begin
      // Register Inputs
      araddr_i <= s_axi_araddr;
        acc_ar_i[0] <= araddr_i[0];
      arprot_i <= s_axi_arprot;
        acc_ar_i[1] <= arprot_i[0];
    end else begin
      araddr_i <= araddr_i>>1;
      arprot_i <= arprot_i>>1;
      acc_ar_i <= acc_ar_i>>1;
    end
  end

  //**********************************************
  // Write Channel: AWREADY, WREADY, BVALID, BID
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      awcnt_i <= 16'h0000;
      s_axi_awready <= 1'b0;
      s_axi_wready <= 1'b0;
      s_axi_bvalid <= 1'b0;
    end else begin
      /**************** Write Address Channel ****************/
      // awready
      if(areset_i == 2'b10) begin
        s_axi_awready <= 1'b1;
      end else if(s_axi_awready && s_axi_awvalid) begin
        s_axi_awready <= 1'b0;
        awcnt_i <= awcnt_i + 1'b1;
      end else if(s_axi_bready && s_axi_bvalid) begin
        s_axi_awready <= 1'b1;
      end else begin
        s_axi_awready <= s_axi_awready;
      end

      /**************** Write Data Channel ****************/
      // wready
      if(write_burst_done_i) begin
        s_axi_wready <= 1'b0;
      end else if(s_axi_awready && s_axi_awvalid) begin
        s_axi_wready <= 1'b1;
      end else begin
        s_axi_wready <= s_axi_wready;
      end

      /**************** Write Response Channel ****************/
      // bvalid
      if(write_burst_done_i) begin
        s_axi_bvalid <= 1'b1;
      end else if(s_axi_bready && s_axi_bvalid) begin
        s_axi_bvalid <= 1'b0;
      end else begin
        s_axi_bvalid <= s_axi_bvalid;
      end
    end
  end


  //**********************************************
  // Write Channel: BRESP
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      s_axi_bresp <= {2{1'b0}};
    end else if (s_axi_bready && s_axi_bvalid) begin
      s_axi_bresp <= 2'b11;
    end else if (~s_axi_bvalid) begin
      s_axi_bresp <= {(acc_aw_i[0] & acc_w_i[0]), 1'b0};
    end
  end

  //**********************************************
  // Write Address Channel: PROCESS INPUTS
  //**********************************************
  always @(posedge aclk) begin
    if (areset) begin
      awaddr_i <= {32{1'b0}};
      awprot_i <= {3{1'b0}};
      acc_aw_i <= 9'b0;
    end else if (s_axi_awvalid) begin
      // Register Inputs
      awaddr_i <= s_axi_awaddr;
        acc_aw_i[0] <= awaddr_i[0];
      awprot_i <= s_axi_awprot;
        acc_aw_i[1] <= awprot_i[0];
    end else begin
      awaddr_i <= awaddr_i>>1;
      awprot_i <= awprot_i>>1;
      acc_aw_i <= acc_aw_i>>1;
    end
  end

  //**********************************************
  // Write Data Channel: PROCESS INPUTS
  //**********************************************
  always @(posedge aclk) begin
    if(areset) begin
      wdata_i <= {32{1'b0}};
      wstrb_i <= {32{1'b0}};
      acc_w_i <= 4'b0;
    end else if (s_axi_wvalid) begin
      // Register Inputs
      wdata_i <= s_axi_wdata;
        acc_w_i[0] <= wdata_i[0];
      wstrb_i <= s_axi_wstrb;
        acc_w_i[1] <= wstrb_i[0];
    end else begin
      wdata_i <= wdata_i>>1;
      wstrb_i <= wstrb_i>>1;
      acc_w_i <= acc_w_i>>1;
    end
  end

endmodule

`default_nettype wire


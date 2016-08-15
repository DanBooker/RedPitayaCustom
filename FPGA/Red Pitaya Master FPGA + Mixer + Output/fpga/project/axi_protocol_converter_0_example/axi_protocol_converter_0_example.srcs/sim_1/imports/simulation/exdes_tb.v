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

module exdes_tb;

  /**************** Local Parameters ****************/
  localparam CLK_PERIOD = 5000; //ps
  localparam RESET_PULSE = 500; // cycles
  localparam TIMEOUT = 20000; // cycles

  //**********************************************
  // Signals
  //**********************************************
  reg                             clk_p;
  reg                             clk_n;
  reg                             sys_rst;
  wire                            done;

  /**************** Simulation Variables ****************/
  // Generate clock
  initial begin
    clk_p = 1'b1;
    clk_n = 1'b0;
    forever #(CLK_PERIOD / 2) begin
      clk_p = ~clk_p;
      clk_n = ~clk_n;
    end
  end

  // Generate reset
  initial begin
    $display("%t: %m: Starting testbench", $time);
    $monitor("%t: %m: System reset detected: %0d", $time, sys_rst);
    sys_rst = 1'b1;
    #(CLK_PERIOD * RESET_PULSE) sys_rst = 1'b0;
  end

  //**********************************************
  // Instantiate Example Design
  //**********************************************
  axi_protocol_converter_0_example_design
  exdes_top
  (
  .clk_p(clk_p),
  .clk_n(clk_n),
  .sys_rst(sys_rst),
  .done(done)
  );

  // Monitor end of simulation
  always @(posedge clk_p) begin
    if (done) begin
      $display("%t: %m: SIMULATION PASSED", $time);
      $display("%t: %m: Test Completed Successfully", $time);
      $stop;
    end
  end

  // Generate simulation error
  initial begin
    #(CLK_PERIOD * TIMEOUT) $display("%t: %m: ERROR - Test timed out.", $time);
    $stop;
  end

endmodule

`default_nettype wire


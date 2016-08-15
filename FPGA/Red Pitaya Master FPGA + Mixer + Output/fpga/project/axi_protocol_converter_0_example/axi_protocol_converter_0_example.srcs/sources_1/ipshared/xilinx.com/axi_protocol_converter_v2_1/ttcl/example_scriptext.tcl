set core [ipx::get_cores -from project]
set CompName [get_property NAME $core]
set board [get_property BOARD [current_project]]

# Configure cores to set board constraints if board is set.
if {![string equal $board {}]} {
  set list_board_param_pcr    [list CONFIG.USE_BOARD_FLOW {true} CONFIG.RESET_BOARD_INTERFACE {reset}]
  set list_board_param_clkwiz [list CONFIG.USE_BOARD_FLOW {true} CONFIG.DIFF_CLK_IN1_BOARD_INTERFACE {sys_diff_clock} ]
} else { 
  set list_board_param_pcr    [list CONFIG.USE_BOARD_FLOW {false}]
  set list_board_param_clkwiz [list CONFIG.PRIM_IN_FREQ {200.000}]
}

# Determine IP clock requirements
set aclk_async_handle [ipx::get_user_parameters -quiet -of_objects $core ACLK_ASYNC]
if {[llength $aclk_async_handle] > 0} {
  set aclk_async [get_property VALUE $aclk_async_handle]
} else { 
  set aclk_async 0
}

set aclk_ratio_handle [ipx::get_user_parameters -quiet -of_objects $core ACLK_RATIO]
if {[llength $aclk_ratio_handle] > 0} { 
  set aclk_ratio [get_property VALUE $aclk_ratio_handle]
} else { 
  set aclk_ratio {1:1}
}

if {$aclk_async == 1} { 
  # Configure asynchronous frequencies
  set clk_freq_list [list CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {10.000} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {16.000}]
  set num_psr 2
} elseif {![string equal {1:1} $aclk_ratio]} { 
  # Configure synchronous clock ratios
  set clk0_ratio [lindex [split $aclk_ratio :] 0]
  set clk1_ratio [lindex [split $aclk_ratio :] 1]
  set clk_freq_list [list CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ [expr {$clk0_ratio*5}] CONFIG.CLKOUT2_REQUESTED_OUT_FREQ [expr {$clk1_ratio*5}]]
  set num_psr 2
} else { 
  # Default clock.
  set clk_freq_list [list CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {10.000}]
  set num_psr 1
}

# Create Clocking module
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 5.3 -module_name ${CompName}_example_clk_wiz_0
set_property -dict [concat CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} CONFIG.USE_RESET {false} $list_board_param_clkwiz $clk_freq_list] [get_ips ${CompName}_example_clk_wiz_0]
#set_property generate_synth_checkpoint false [get_files ${CompName}_example_clk_wiz_0.xci]
generate_target all [get_files  ${CompName}_example_clk_wiz_0.xci]
# Create Reset module
create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version 5.0 -module_name ${CompName}_example_proc_sys_reset_0
set_property -dict $list_board_param_pcr [get_ips ${CompName}_example_proc_sys_reset_0]
#set_property generate_synth_checkpoint false [get_files ${CompName}_example_proc_sys_reset_0.xci]
generate_target all [get_files ${CompName}_example_proc_sys_reset_0.xci]

# Creat extra reset module if two clocks.
if {$num_psr > 1} { 
  create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version 5.0 -module_name ${CompName}_example_proc_sys_reset_1
#set_property generate_synth_checkpoint false [get_files ${CompName}_example_proc_sys_reset_1.xci]
generate_target all [get_files ${CompName}_example_proc_sys_reset_1.xci]
}

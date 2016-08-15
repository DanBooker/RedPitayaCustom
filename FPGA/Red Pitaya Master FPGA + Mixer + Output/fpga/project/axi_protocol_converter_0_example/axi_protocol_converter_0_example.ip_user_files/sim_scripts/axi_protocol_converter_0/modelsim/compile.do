vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/generic_baseblocks_v2_1_0
vlib msim/fifo_generator_v13_1_1
vlib msim/axi_data_fifo_v2_1_8
vlib msim/axi_infrastructure_v1_1_0
vlib msim/axi_register_slice_v2_1_9
vlib msim/axi_protocol_converter_v2_1_9

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap generic_baseblocks_v2_1_0 msim/generic_baseblocks_v2_1_0
vmap fifo_generator_v13_1_1 msim/fifo_generator_v13_1_1
vmap axi_data_fifo_v2_1_8 msim/axi_data_fifo_v2_1_8
vmap axi_infrastructure_v1_1_0 msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_9 msim/axi_register_slice_v2_1_9
vmap axi_protocol_converter_v2_1_9 msim/axi_protocol_converter_v2_1_9

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
"../../../ipstatic/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \

vlog -work fifo_generator_v13_1_1 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/fifo_generator_v13_1/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_1 -64 -93 \
"../../../ipstatic/ipshared/xilinx.com/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_1 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work axi_data_fifo_v2_1_8 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \

vlog -work axi_register_slice_v2_1_9 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \

vlog -work axi_protocol_converter_v2_1_9 -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
"../../../ipstatic/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
"c:/Users/RazBB/Documents/GitHub/RedPitayaMaster/fpga/project/axi_protocol_converter_0_example/axi_protocol_converter_0_example.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog" \
"../../../../axi_protocol_converter_0_example.srcs/sources_1/ip/axi_protocol_converter_0/sim/axi_protocol_converter_0.v" \

vlog -work xil_defaultlib "glbl.v"


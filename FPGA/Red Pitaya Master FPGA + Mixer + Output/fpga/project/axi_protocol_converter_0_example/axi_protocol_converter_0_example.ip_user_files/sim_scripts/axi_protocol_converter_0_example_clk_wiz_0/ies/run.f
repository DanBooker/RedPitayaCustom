-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../axi_protocol_converter_0_example.srcs/sources_1/ip/axi_protocol_converter_0_example_clk_wiz_0/axi_protocol_converter_0_example_clk_wiz_0_clk_wiz.v" \
  "../../../../axi_protocol_converter_0_example.srcs/sources_1/ip/axi_protocol_converter_0_example_clk_wiz_0/axi_protocol_converter_0_example_clk_wiz_0.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib


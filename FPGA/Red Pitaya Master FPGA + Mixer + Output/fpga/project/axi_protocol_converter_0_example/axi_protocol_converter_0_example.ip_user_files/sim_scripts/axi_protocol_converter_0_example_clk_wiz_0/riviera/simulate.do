onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+axi_protocol_converter_0_example_clk_wiz_0 -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -O5 xil_defaultlib.axi_protocol_converter_0_example_clk_wiz_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {axi_protocol_converter_0_example_clk_wiz_0.udo}

run -all

endsim

quit -force

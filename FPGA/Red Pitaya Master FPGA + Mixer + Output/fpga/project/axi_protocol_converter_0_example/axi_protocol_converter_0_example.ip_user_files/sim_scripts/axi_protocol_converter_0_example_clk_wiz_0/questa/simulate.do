onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib axi_protocol_converter_0_example_clk_wiz_0_opt

do {wave.do}

view wave
view structure
view signals

do {axi_protocol_converter_0_example_clk_wiz_0.udo}

run -all

quit -force

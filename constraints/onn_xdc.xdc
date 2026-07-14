## CLOCK
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 8.000 [get_ports clk]

## RESET
set_property PACKAGE_PIN K18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## SWITCHES
set_property PACKAGE_PIN G15 [get_ports {sw[0]}]
set_property PACKAGE_PIN P15 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]

## LEDs
set_property PACKAGE_PIN M14 [get_ports {led[0]}]
set_property PACKAGE_PIN M15 [get_ports {led[1]}]
set_property PACKAGE_PIN G14 [get_ports {led[2]}]
set_property PACKAGE_PIN D18 [get_ports {led[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]


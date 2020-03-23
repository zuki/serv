#
# Clock / Reset
#
set_location_assignment PIN_H6 -to i_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk
set_location_assignment PIN_E6 -to i_rst
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to i_rst

#UART/GPIO
set_location_assignment PIN_A8 -to q
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q

set_location_assignment PIN_B4 -to uart_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart*

set_global_assignment -name INTERNAL_FLASH_UPDATE_MODE "SINGLE IMAGE WITH ERAM"

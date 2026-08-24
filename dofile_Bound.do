#Set the context to DFT
 set_context dft -rtl -design_identifier pass1_rtl

#Create & set the TSDB directory
 set_tsdb_output_directory TSDB

#Read the cell library files
 read_cell_library ../libs/adk.tcelllib

#Read the design source codes
 read_verilog [glob ../rtl/*.v]

#Elaborate the design top
 set_current_design msrv32_top

#Set the design level to chip level 
 set_design_level chip

#Specify the DFT requirements
 set_dft_specification_requirements -boundary_scan on -logic_test on 
 
#Set attributes for the TAP controller pins
 set_attribute_value tck_p -name function -value tck
 set_attribute_value tdi_p -name function -value tdi
 set_attribute_value tms_p -name function -value tms
 set_attribute_value trst_p -name function -value trst
 set_attribute_value tdo_p -name function -value tdo

# output port : ms_riscv32_mp_imaddr_out; 
set_boundary_scan_port_options {ms_riscv32_mp_imaddr_out edt_channel_out1_p scan_en shift_clock_src_p shift_capture_clock } -cell_options dont_touch

add_clocks [get_ports ms_riscv32_mp_clk_in] -period 6ns -label clk

add_dft_signals scan_en -source_nodes scan_en

#Run the DRC
 check_design_rules 

 #Create & report the DFT specification
 set spec [create_dft_specification -replace]
 report_config_data $spec

 #Insert the DFT instruments
 process_dft_specification

 extract_icl

 set pattern [create_pattern_specification -replace]
 report_config_data $pattern

 #Insert the DFT instruments
 process_pattern_specification
 

 open_visualizer

 #Display the visualizer
 display_specification 

 
 #Set system mode to SETUP
 set_system_mode SETUP


 


####### LBIST / EDT / OCC #################


set_context dft -rtl -design_identifier pass2_rtl

set_tsdb_output_directory TSDB

read_cell_library ../libs/adk.tcelllib

open_tsdb ./TSDB

read_design msrv32_top -design_identifier pass1_rtl 

set_current_design msrv32_top -show_elaboration_warnings

set_design_level chip

set_dft_specification_requirements -logic_test on 

#check_design_rules

#report_drc_rules DFT_C6-1

#analyze_drc_violation DFT_C6-1

#add_clocks [get_ports ms_riscv32_mp_clk_in] -period 6ns -label clk

add_dft_signals x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en

check_design_rules

#########################################
#read the spec file of occ & LBIST & EDT 
#########################################

set spec [create_dft_specification -sri_sib_list {edt occ lbist} -replace]
report_config_data $spec

read_config_data ../logic_instruments_main.dfpspec -in_wrapper $spec -replace

report_config_data $spec 

display_specification 

process_dft_specification 


extract_icl


set Pattern [create_pattern_specification]

report_config_data $Pattern

process_pattern_specification

###################################
#simulations
####################################

set_simulation_library_sources -v ../libs/adk.v

run_testbench_simulations

check_testbench_simulations -report_status 


###################################
#SYNTHESIS
###################################

set_quick_synthesis_options -complete_synthesis on

#set_system_mode analysis

write_design -output_file msrv32_top_netlist.v 


#exit





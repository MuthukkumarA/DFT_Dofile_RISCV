set_context dft -scan

#read_cell_library ../libs/adk.tcelllib 

read_cell_library ../libs/adk.tcelllib ../libs/dft_sim.tcelllib

read_verilog ./msrv32_top_netlist.v 

set_current_design msrv32_top -show_elaboration_warnings 

analyze_control_signals -auto

set_design_level chip

set_test_logic -set on -clock on -reset on

check_design_rules

set_scan_insertion_options -port_index_start_value 1 -si_timing any_edge -so_timing any_edge -chain_count 7

analyze_scan_chains

//add_scan_mode unwrapped -chain_count 7
// Scan mode 'unwrapped' already exists.


insert_test_logic

report_scan_cells

report_test_logic


write_design -output_file ./pass3_outputs/scan_inserted_netlist.v -replace

write_atpg_setup ./pass3_outputs/msrv32_atpg -replace





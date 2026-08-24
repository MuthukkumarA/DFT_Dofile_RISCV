set_context pattern -scan

read_cell_library ../libs/adk.tcelllib ../libs/dft_sim.tcelllib

read_verilog ./pass3_outputs/scan_inserted_netlist.v 

set_current_design msrv32_top -show_elaboration_warnings

analyze_control_signals
 
dofile ./pass3_outputs/msrv32_atpg.dofile 

tessent_scan_setup

check_design_rules

report_clocks

add_faults -all

create_patterns

report_statistics

report_faults -all

report_faults -class DS

report_scan_volume

write_patterns pass3_outputs/msrv32_top_patterns.ascii -ascii -replace


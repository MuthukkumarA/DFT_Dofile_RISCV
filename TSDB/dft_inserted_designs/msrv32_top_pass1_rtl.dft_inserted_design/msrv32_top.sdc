#--------------------------------------------------------------------------
#
#  Unpublished work. Copyright 2021 Siemens
#
#  This material contains trade secrets or otherwise confidential 
#  information owned by Siemens Industry Software Inc. or its affiliates 
#  (collectively, SISW), or its licensors. Access to and use of this 
#  information is strictly limited as set forth in the Customer's 
#  applicable agreements with SISW.
#
#--------------------------------------------------------------------------
#  File created by: Tessent Shell
#          Version: 2022.2
#       Created on: Tue Apr  7 17:30:47 IST 2026
#--------------------------------------------------------------------------

#
#  Procs table of content:
#
#    tessent_set_default_variables
#    tessent_set_ijtag_non_modal
#    tessent_set_non_modal
#    set_ijtag_retargeting_options
#    tessent_set_jtag_bscan_non_modal
#    tessent_msrv32_top_set_dft_signals
#    tessent_get_cells
#    tessent_get_flops
#    tessent_get_pins
#    tessent_get_ports
#    tessent_map_to_verilog
#    tessent_remap_vhdl_path_list
#    tessent_remove_clock_groups
#    tessent_get_clock_source
#    tessent_set_clock_sense_stop_propagation
#    tessent_get_mem_cells
#    tessent_get_clocks
#    tessent_get_preserve_instances
#    tessent_get_size_only_instances
#    tessent_get_optimize_instances
#
proc tessent_set_default_variables {} {
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_clock_mapping tessent_input_delay_percentage tessent_output_delay_percentage tessent_tck_clocks_group_created tessent_hierarchy_separator tessent_path_cache tessent_timing_tool
  #
  # This proc defines the default value of the variables used in instrument timing constraints
  #

  # Time units assumed ns
  set time_unit_multiplier 1.0

  set tessent_tck_period 100.0

  set tessent_tck_clocks_list [list tessent_tck]

  array set tessent_clock_mapping {
    tessent_tck tessent_tck
  }

  set tessent_input_delay_percentage 0.25

  set tessent_output_delay_percentage 0.0

  set tessent_tck_clocks_group_created 0

  set tessent_hierarchy_separator /

  array set tessent_path_cache {
  }

  switch -glob [file tail [info nameofexecutable]] {
    common_shell_exec {set tessent_timing_tool dc_shell}
    oasys*            {set tessent_timing_tool oasys}
    rc                {set tessent_timing_tool encounter}
    genus             {set tessent_timing_tool genus}
    default           {set tessent_timing_tool pt_shell}
  }
  

}
proc tessent_set_ijtag_non_modal {} {  
  
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_tck_clocks_group_created
  global tessent_clock_mapping tessent_input_delay tessent_input_delay_percentage tessent_output_delay tessent_output_delay_percentage
  
  if {[info exists tessent_input_delay]} {
    set local_input_delay $tessent_input_delay
  } else {
    set local_input_delay [expr {$tessent_input_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
  }
  if {[info exists tessent_output_delay]} {
    set local_output_delay $tessent_output_delay
  } else {
    set local_output_delay [expr {$tessent_output_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
  }
    
  if {[sizeof_collection [tessent_get_clocks $tessent_clock_mapping(tessent_tck) -quiet]] == 0} {
    create_clock [tessent_get_ports [list {tck_p}]]  \
      -period [expr $tessent_tck_period*$time_unit_multiplier] \
      -name $tessent_clock_mapping(tessent_tck) -add
  
  }
  set mapped_tck_clock_list [list]
  foreach tck_clock $tessent_tck_clocks_list {
    lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
  }
  if {[sizeof_collection [tessent_get_clocks $mapped_tck_clock_list -quiet]] > 0} {
    tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
    set_clock_groups -asynchronous -group [tessent_get_clocks $mapped_tck_clock_list] -name tessent_tck_clock_group
    set tessent_tck_clocks_group_created 1
  }
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) -clock_fall [tessent_get_ports {tdi_p}]
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) -clock_fall [tessent_get_ports {tms_p}]
  set_output_delay $local_output_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {tdo_p}]
  set_false_path -from [tessent_get_ports {trst_p}]
  # Reset release timing check is only needed inside TAP, false path reset to network
  set_false_path -through [tessent_get_pins [list {msrv32_top_pass1_rtl_tessent_tap_main_inst/tessent_persistent_cell_tlr_buf/A}]] 
  # Select from the TAP is toggled in Update-IR state
  # and won't be used until three TCK cycles later, in Capture-DR
  set_multicycle_path -setup 3 \
      -through [tessent_get_pins [list {msrv32_top_pass1_rtl_tessent_tap_main_inst/tessent_persistent_cell_host_1_to_sel_buf/A}]] 
  set_false_path -hold -through [tessent_get_pins [list {msrv32_top_pass1_rtl_tessent_tap_main_inst/tessent_persistent_cell_host_1_to_sel_buf/A}]] 
  
  set scan_resource_sib_list {
    msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst/to_enable_int*
    msrv32_top_pass1_rtl_tessent_sib_sri_inst/to_enable_int*
  }
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $scan_resource_sib_list] 
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells $scan_resource_sib_list] 
  
}
proc tessent_set_non_modal {} {
  tessent_set_ijtag_non_modal
  tessent_set_jtag_bscan_non_modal
}
proc set_ijtag_retargeting_options {args} {  
  
    # Issue the set_ijtag_retargeting_options command from within your master timing 
    # script in order establish the settings requirements for pattern generation.
    # Tessent Shell supports the same command with the same syntax, allowing you
    # to consistently specify these settings across your simulations, synthesis 
    # and STA runs. You may want to place the calls to this command into a file
    # and source it from Tessent Shell and your synthesis/timing tools.
    array set tessent_timing_option2var_mapping {
      -tck_period tessent_tck_period
    }
    foreach key [array names tessent_timing_option2var_mapping] {
      global [subst $tessent_timing_option2var_mapping($key)]
    }
    # Parse options, assuming default value from tessent_set_default_variables.
    foreach {key value} $args {
      if {![info exists tessent_timing_option2var_mapping($key)]} {
        set warning_list [list]
        lappend warning_list "Tessent SDC Warning: The option '$key' is not supported by the SDC version of set_ijtag_retargeting_options."
        lappend warning_list "                     Supported arguments are: [join [lsort [array get tessent_timing_option2var_mapping]]{, }]."
        puts [join $warning_list "\n"]
        continue
      }
      if {$key eq "-tck_period"} {
        #get only the number from -tck_period
        set value [regexp -inline {^[0-9]+(?:.[0-9]+)?} $value]
      }
      set [subst $tessent_timing_option2var_mapping($key)] $value
    }
  
}
proc tessent_set_jtag_bscan_non_modal {} {
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_clock_mapping tessent_input_delay_percentage tessent_output_delay_percentage tessent_tck_clocks_group_created tessent_hierarchy_separator tessent_path_cache tessent_timing_tool  
  create_generated_clock [tessent_get_pins [list {msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_capture_shift_clock_gater_inst/GCK}]]  \
    -name bscan_capture_shift_clock \
    -source [tessent_get_ports [list {tck_p}]]  \
    -add -master_clock $tessent_clock_mapping(tessent_tck) \
    -divide_by 1
  create_generated_clock [tessent_get_pins [list {msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_update_clock_gater_inst/GCK}]]  \
    -name bscan_update_clock \
    -source [tessent_get_ports [list {tck_p}]]  \
    -invert \
    -add -master_clock $tessent_clock_mapping(tessent_tck) \
    -divide_by 1
  
  set_multicycle_path 2 -setup -start -from [tessent_get_clocks [list bscan_capture_shift_clock]] -to [tessent_get_clocks [list bscan_update_clock]]
  set_multicycle_path 3 -hold -start -from [tessent_get_clocks [list bscan_capture_shift_clock]] -to [tessent_get_clocks [list bscan_update_clock]]
  set_multicycle_path 2 -setup -end -from [tessent_get_clocks [list bscan_update_clock]] -to [tessent_get_clocks [list bscan_capture_shift_clock]]
  set_multicycle_path 3 -hold -end -from [tessent_get_clocks [list bscan_update_clock]] -to [tessent_get_clocks [list bscan_capture_shift_clock]]
  
  set_multicycle_path 2 -setup -start -from $tessent_clock_mapping(tessent_tck) -through [tessent_get_pins [list msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_select_jtag_input_buf/Y]]
  set_multicycle_path 3 -hold -start -from $tessent_clock_mapping(tessent_tck) -through [tessent_get_pins [list msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_select_jtag_input_buf/Y]]
  
  set_multicycle_path 2 -setup -start -from $tessent_clock_mapping(tessent_tck) -through [tessent_get_pins [list msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_select_jtag_output_buf/Y]]
  set_multicycle_path 3 -hold -start -from $tessent_clock_mapping(tessent_tck) -through [tessent_get_pins [list msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_select_jtag_output_buf/Y]]
  
  set_multicycle_path 2 -setup -start -from $tessent_clock_mapping(tessent_tck) -through [tessent_get_pins [list msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_force_disable_buf/Y]]
  set_multicycle_path 3 -hold -start -from $tessent_clock_mapping(tessent_tck) -through [tessent_get_pins [list msrv32_top_pass1_rtl_tessent_bscan_interface_I/tessent_persistent_cell_force_disable_buf/Y]]
  
  set mapped_tck_clock_list [list]
  foreach tck_clock $tessent_tck_clocks_list {
    lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
  }
  foreach bscan_clock [list bscan_capture_shift_clock bscan_update_clock] {
    lappend mapped_tck_clock_list $bscan_clock
    if {[lsearch -exact $tessent_tck_clocks_list $bscan_clock] < 0} {
      lappend tessent_tck_clocks_list $bscan_clock
      set tessent_clock_mapping($bscan_clock) $bscan_clock
    }
  }
  tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
  set_clock_groups -asynchronous -name tessent_tck_clock_group -group [tessent_get_clocks $mapped_tck_clock_list]
  set tessent_tck_clocks_group_created 1
  
}
proc tessent_msrv32_top_set_dft_signals {{mode reset}} {
#
# Force all dft_signal sources to either their reset or all_test value when applicable.
#   argument mode :== reset | all_test_on | all_test_x
#
  set_case_analysis 0 [tessent_get_ports scan_en]
  set_case_analysis 0 [tessent_get_pins msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_async_set_reset_static_disable/Y]

}
proc tessent_get_cells {path_list args} {
  set actualArgs [list]
  set silent 0
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    lappend actualArgs $argValue
  }
  # Quietly try verilog syntax first. If not found, try VHDL remapping
  set cell_col {}
  foreach path $path_list {
    set cell_col_tmp [get_cells [list [tessent_map_to_verilog $path]] {*}$actualArgs -quiet]
    if { [sizeof_collection $cell_col_tmp] == 0 && [regexp {%TSSEP%} $path]} {
      # try a partially ungrouped path with known markers
      set cell_col_tmp [get_cells [list [tessent_map_to_verilog $path -mappings [list {%TSSEP%} {?}]]] {*}$actualArgs -quiet]
    } 
    if { [sizeof_collection $cell_col_tmp] == 0 } {
      set cell_col_tmp [get_cells [tessent_map_to_verilog [tessent_remap_vhdl_path_list [list $path]]] {*}$actualArgs -quiet]
    } 
    if {[sizeof_collection $cell_col_tmp] > 0} {
      append_to_collection cell_col $cell_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC warning: Cell was not found with pattern '${path}'"
    }
  }
  if {[sizeof_collection $cell_col] > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    return $cell_col
  } elseif {!$silent} {
    puts "Tessent SDC error: No cell found with pattern(s) '${path_list}'"
  }
  return
 
}
proc tessent_get_flops {path_list args} {
  global tessent_timing_tool
  set cell_col [tessent_get_cells $path_list {*}$args]
  
  if {[sizeof_collection $cell_col] == 0} {return {}}

  switch -- $tessent_timing_tool {
    encounter {set flop_col [filter sequential true $cell_col]}
    default   {set flop_col [filter_collection $cell_col "is_sequential == true"]}
  }

  return $flop_col
 
}
proc tessent_get_pins {path_list args} {
  global tessent_timing_tool
  set pin_col {}
  set actualArgs [list]
  set silent 0
  set hierarchical ""
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    if { [regexp {^-hier(archical)?$} $argValue] } { set hierarchical "-hierarchical"; continue }
    lappend actualArgs $argValue
  }
  switch -- $tessent_timing_tool {
    pt_shell {set pin_name_attribute "lib_pin_name"}
    default  {set pin_name_attribute "name"}
  }
  foreach path $path_list {
    set pin_sep_index [string last / $path]
    set mapped_cells [tessent_get_cells [list [string range $path 0 [expr $pin_sep_index - 1]]] -silent {*}$hierarchical]
    if {[sizeof_collection $mapped_cells] > 0} {
      set pin_col_tmp [get_pins -of_objects $mapped_cells -filter "$pin_name_attribute =~ [string range $path [expr $pin_sep_index + 1] end]" {*}$actualArgs -quiet]
    } else {
      set pin_col_tmp {}
    }
    if {[sizeof_collection $pin_col_tmp] > 0} {
      append_to_collection pin_col $pin_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC warning: Pin was not found with pattern '${path}'"
    }
  }
  if {[sizeof_collection $pin_col] > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    return $pin_col
  } elseif {!$silent} {
    puts "Tessent SDC error: No pin found with pattern(s) '${path_list}'"
  }
  return
   
}
proc tessent_get_ports {port_patterns args} {
  global tessent_timing_tool
  set actualArgs [list]
  set silent 0
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    lappend actualArgs $argValue
  }
  # Quietly try verilog syntax first. If not found, try advanced remapping
  set port_col {}
  foreach port_pattern $port_patterns {
    set port_col_tmp [get_ports [list [tessent_map_to_verilog $port_pattern]] {*}$actualArgs -quiet]
    if { [sizeof_collection $port_col_tmp] == 0 } {
      set port_col_tmp [get_ports [tessent_map_to_verilog [tessent_remap_vhdl_path_list [list $port_pattern] -type ports]] {*}$actualArgs -quiet]
    } 
    if {[sizeof_collection $port_col_tmp] > 0} {
      append_to_collection port_col $port_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC warning: Port was not found with pattern '${port_pattern}'"
    }
  }
  set sc [sizeof_collection $port_col]
  if {$sc > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    if {$sc == 1 && $tessent_timing_tool eq "oasys"} {
      return [index_collection $port_col 0]
    } else {
      return $port_col
    }
  } elseif {!$silent} {
    puts "Tessent SDC error: No port found with pattern(s) '${port_patterns}'"
  }
  return
  
}
proc tessent_map_to_verilog {path_list args} {
  global tessent_hierarchy_separator tessent_custom_mapping_regsub

  set ARGS(-mappings) [list]
  array set ARGS $args

  set mapped_paths $path_list
  if {[array size tessent_custom_mapping_regsub] > 0} {
    foreach custom_re [array names tessent_custom_mapping_regsub] {
      set mapped_paths [regsub -all $custom_re $mapped_paths $tessent_custom_mapping_regsub($custom_re)]
    }
  }
  array set map_array {
    [ ?
    ] ?
    ) ?
    ( ?
    . ?
    - ?
  }
  set map_array(%TSSEP%) $tessent_hierarchy_separator
  if {$tessent_hierarchy_separator ne "/"} {
    set map_array(/) $tessent_hierarchy_separator
  }
  if {[string is list $ARGS(-mappings)]} {
    array set map_array $ARGS(-mappings)
  }
  set mapped_paths [string map [array get map_array] $mapped_paths]
  return $mapped_paths
  
}
proc tessent_remap_vhdl_path_list {path_list args} {
  global tessent_path_cache
  set remapped_path_list [list]
  array set ARGS {
    -type cells
  }
  array set ARGS $args
  set type $ARGS(-type)
  set get_cmd "get_${type}"
  foreach path $path_list {
    # Check if we have that full path cached
    if {[info exists tessent_path_cache($path)]} {
      set pathMapped $tessent_path_cache($path)
    } else {
      set pathMapped ""
      set pathUnmapped ""
      foreach sub_path [split $path "/"] {
        if {$pathUnmapped eq ""} {
          set slash ""
        } else {
          set slash "/"
        }
        append pathUnmapped $slash $sub_path
        # Problematic paths are the following:
        #   - Paths with unrolled VHDL generate loops
        #   - non-standard change names that would trim the trailing underscore of multi-bit register names
        #   - Complex ports in some timing tools

        # Check if we have that hiercarchy cached
        if {[info exists tessent_path_cache($pathUnmapped)]} {
          set pathMapped $tessent_path_cache($pathUnmapped)
          continue
        }
        append pathMapped $slash $sub_path
        # If for port, go straight into Complex ports mapping
        if {$type eq "ports"} {
          # Some timing tools address complex identifiers like Tessent Shell: <id>.<id> 
          # Some other timing tools address those same complex construct like this <id>[<id>]
          # Try to exclude indexes from identifier as is bus was intact
          #     i.s. <id>.<id>[n] -> <id>[id][n]
          set pathMappedTemp [regsub -all {\.([^\.\[]+)} $pathMapped {[\1]}]
          if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
            set pathMapped $pathMappedTemp
            set tessent_path_cache($pathUnmapped) $pathMapped
            continue
          }
          # Try to include indexes as part of a full "escaped" identifier 
          #     i.e. <id>.<id>[n] -> <id>[<id>[n]]
          set pathMappedTemp [regsub -all {\.([^\.]+)} $pathMapped {[\1]}]
          if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
            set pathMapped $pathMappedTemp
            set tessent_path_cache($pathUnmapped) $pathMapped
            continue
          }
          # rest of the mappings are for cells
          continue
        }
        # Try verilog first on this hierarchy
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMapped]]] > 0} {
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
        # Unrolled VHDL loop from HDLE - closing bracket of a generate loop identifier was removed
        set pathMappedTemp [regsub {[\])]\.} $pathMapped {.}]
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
          set pathMapped $pathMappedTemp
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
        # Identifier that would simply have had its last character trimmed
        #   This would be an underscore, adding '?' to support some pre-mapped paths in constraints
        set pathMappedTemp [regsub {[\]\?]$} $pathMapped {}]
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
          set pathMapped $pathMappedTemp
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
      }
    }
    lappend remapped_path_list $pathMapped 
  }
  return $remapped_path_list

}
proc tessent_remove_clock_groups {group_type group_name_list} {
  global tessent_timing_tool tessent_tck_clocks_group_created
  if {!$tessent_tck_clocks_group_created} {return}
  switch -- $tessent_timing_tool {
    dc_shell  {remove_clock_groups $group_type $group_name_list; set tessent_tck_clocks_group_created 0}
    pt_shell  {remove_clock_groups $group_type -name $group_name_list; set tessent_tck_clocks_group_created 0}
    encounter {#remove_clock_groups command does not exist}
    genus     {#remove_clock_groups command does not exist}
    default   {#do not assume remove_clock_groups exists}
  }
 
}
proc tessent_get_clock_source {clk} {
  global tessent_timing_tool
  set clockSource0 ""
  switch -- $tessent_timing_tool {
    encounter {set clockSource0 [lindex [get_attribute sources [tessent_get_clocks $clk]] 0]}
    genus     {set clockSource0 [lindex [get_db [tessent_get_clocks $clk] .sources] 0]}
    default   {set clockSource0 [index_collection [get_attribute [tessent_get_clocks $clk] sources] 0]}
  }
  return $clockSource0
 
}
proc tessent_set_clock_sense_stop_propagation {clk pin cell} {
  global tessent_timing_tool
  if {$tessent_timing_tool in {genus encounter} || ![get_attribute $cell is_hierarchical]} {
    set target $pin
  } else {
    set target ""
    foreach_in_collection ipin [tessent_get_pins [get_attribute $cell full_name]/*/*] {
      if {[get_attribute $ipin direction] eq "in" && [get_attribute [all_connected $ipin] full_name] eq [get_attribute $pin full_name]} {
        append_to_collection target $ipin
      }
    }
    if {[sizeof_collection $target] > 0} {
      puts "Tessent SDC note: Hierarchical pin '[get_attribute $pin full_name]' maps to libcell pin(s) [join [get_attribute $target full_name] ,]."
    } else {
      puts "Tessent SDC error: Failed to map hierarchical pin '[get_attribute $pin full_name]' to libcell pin."
      return
    }
  }
  if {$tessent_timing_tool eq "pt_shell"} {
    set_sense -type clock -clocks $clk -stop_propagation $target
  } else {
    set_clock_sense -clocks $clk -stop_propagation $target
  }
 
}
proc tessent_get_mem_cells {inpath} {
  set out_cells [tessent_get_cells $inpath]
  foreach_in_collection cell $out_cells {
    if {[get_attribute $cell is_hierarchical] eq "true"} {
      set cell_path [get_attribute $cell full_name]
      if {[sizeof_collection [get_cells -quiet "$cell_path/*"]]>0} {
        set out_cells [add_to_collection $out_cells [tessent_get_mem_cells "$cell_path/*"]]
      }
    }
  }
  return [filter_collection $out_cells "is_sequential==true"]
  
}
proc tessent_get_clocks {patternList args} {
  # Genus does not support more than one <pattern> for 'get_clocks <pattern>'
  set C {}
  foreach p $patternList {
    append_to_collection C [get_clocks $p {*}$args] -unique
  }
  return $C
 
}
proc tessent_get_preserve_instances {select} {
  # The 'select' argument identifies a list of instances to be returned.
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list

  set persistent_design_instance_glob_list {
    tessent_persistent_cell_*
  }

  set scan_instrument_instance_list {
  }

  set scan_related_instance_list {
    msrv32_top_pass1_rtl_tessent_bscan_interface_I
  }

  set tcd_scan_instance_list {
  }

  set non_scan_instance_list {
    msrv32_top_pass1_rtl_tessent_bscan_logical_group_DEF_inst
    msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst
    msrv32_top_pass1_rtl_tessent_sib_sri_inst
    msrv32_top_pass1_rtl_tessent_tap_main_inst
    msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst
  }

  set icl_design_instance_list {
  }

  set keyList [list add_core_instances scan_insertion icl_extract]
  set concatDict {
    add_core_instances { persistent_design_instance_glob_list scan_instrument_instance_list scan_related_instance_list }
    scan_insertion     { tcd_scan_instance_list non_scan_instance_list }
    icl_extract        { icl_design_instance_list }
  }
  set instanceColl {}
  # Nothing to return when 'select' is unknown
  if { [lsearch -exact $keyList $select] < 0 } {
    return $instanceColl
  }
  # Assemble a superset list depending on the 'select' value
  # based on the list of list of variables names to concatenate
  # for each 'select' value.
  foreach {validSelect concatVarnameList} $concatDict {
    foreach concatVarname $concatVarnameList {
      set getCellsArg [expr {[string match *_glob_list $concatVarname] ? "-hierarchical" : ""}]
      foreach instancePattern [set $concatVarname] {
        append_to_collection instanceColl [tessent_get_cells $instancePattern -filter {is_hierarchical==true} $getCellsArg -silent] -unique
      }
    }
    if { $select eq $validSelect } {
      break
    }
  }
  return $instanceColl

}
proc tessent_get_size_only_instances {} {
  set persistent_cell_instance_glob_list {
    tessent_persistent_cell_*
  }

  set instanceColl {}
  foreach instancePattern $persistent_cell_instance_glob_list {
    append_to_collection instanceColl [get_cells $instancePattern -filter {is_hierarchical==false} -hierarchical -quiet] -unique
  }

  return $instanceColl
}
proc tessent_get_optimize_instances {} {
  set optimize_instance_list {
    msrv32_top_pass1_rtl_tessent_tap_main_inst/fsm
  }

  set instanceColl {}
  foreach instancePattern $optimize_instance_list {
    append_to_collection instanceColl [tessent_get_cells $instancePattern -silent]
  }
  return $instanceColl

}

# Provide pre-2021.2 tessent-shell plugin proc mapping to 2021.3 convention, 
# so as to maintain backward-compatibility with older customer scripts.
set tessent_old_2_new_proc_name_mapping {
  {tessent_constrain_msrv32_top_mentor_ijtag_non_modal tessent_set_ijtag_non_modal no}
  {tessent_constrain_msrv32_top_mentor_jtag_bscan_non_modal tessent_set_jtag_bscan_non_modal no}
  {tessent_constrain_msrv32_top_non_modal tessent_set_non_modal no}
}
foreach line $tessent_old_2_new_proc_name_mapping {
  lassign $line old_proc_name new_proc_name arguments
  if {$arguments eq "yes"} {
    proc $old_proc_name args "$new_proc_name {*}\$args"
  } else {
    proc $old_proc_name {} $new_proc_name
  }
}
    

//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.2
//       Created on: Tue Apr  7 17:30:47 IST 2026
//-------------------------------------------------


Module msrv32_top {
   // Created by ICL extraction
   ClockPort ms_riscv32_mp_clk_in {
      Attribute tessent_clock_domain_labels = "clk ms_riscv32_mp_clk_in";
      Attribute tessent_clock_periods = "all 6.00ns";
   }
   TCKPort tck_p;
   ScanInPort tdi_p {
      Attribute tessent_use_in_dft_specification = "false";
   }
   ScanOutPort tdo_p {
      Source msrv32_top_pass1_rtl_tessent_tap_main_inst.tdo;
      Attribute forced_low_dft_signal_list = "tms_disable";
   }
   TMSPort tms_p {
      Attribute forced_low_dft_signal_list = "tms_disable";
   }
   TRSTPort trst_p {
      Attribute connection_rule_option = "allowed_tied_high";
   }
   ScanInterface tap {
      Port tck_p;
      Port tdi_p;
      Port tdo_p;
      Port tms_p;
      Port trst_p;
   }
   Attribute tessent_design_format = "verilog_2001";
   Attribute test_setup_procfile = "";
   Attribute forced_low_internal_input_port_list = "{scan_en_pad/C}";
   Attribute icl_extraction_date = "Tue Apr  7 17:30:47 IST 2026";
   Attribute created_by_tessent_icl_extract = "true";
   Attribute tessent_design_id = "pass1_rtl";
   Attribute tessent_design_level = "chip";
   Attribute tessent_is_physical_module = "true";
   Instance msrv32_top_pass1_rtl_tessent_bscan_interface_I Of 
       msrv32_top_pass1_rtl_tessent_bscan_interface {
      InputPort scan_in = tdi_p;
      InputPort from_bscan_scan_out = 'bx;
      InputPort ijtag_capture_en = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_shift_en = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_update_en = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort bscan_select = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.host_bscan_to_sel;
      InputPort ijtag_tck = tck_p;
      InputPort force_disable = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.force_disable;
      InputPort select_jtag_input = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.select_jtag_input;
      InputPort select_jtag_output = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.select_jtag_output;
      Attribute tessent_design_instance = 
          "msrv32_top_pass1_rtl_tessent_bscan_interface_I";
   }
   Instance msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst Of 
       msrv32_top_pass1_rtl_tessent_sib_2 {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = tdi_p;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_from_so = 
          msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst";
   }
   Instance msrv32_top_pass1_rtl_tessent_sib_sri_inst Of 
       msrv32_top_pass1_rtl_tessent_sib_1 {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.host_1_to_sel;
      InputPort ijtag_si = tdi_p;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_from_so = 
          msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv32_top_pass1_rtl_tessent_sib_sri_inst";
   }
   Instance msrv32_top_pass1_rtl_tessent_tap_main_inst Of 
       msrv32_top_pass1_rtl_tessent_tap_main {
      InputPort tck = tck_p;
      InputPort tdi = tdi_p;
      InputPort tms = tms_p;
      InputPort trst = trst_p;
      InputPort host_1_from_so = 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst.ijtag_so;
      InputPort host_bscan_from_so = 
          msrv32_top_pass1_rtl_tessent_bscan_interface_I.scan_out;
      Attribute tessent_design_instance = 
          "msrv32_top_pass1_rtl_tessent_tap_main_inst";
   }
   Instance msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst Of 
       msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.ijtag_to_sel;
      InputPort ijtag_si = tdi_p;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      Attribute tessent_design_instance = 
          "msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst";
   }
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_bscan_interface_I
Module msrv32_top_pass1_rtl_tessent_bscan_interface {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass1_rtl_bscan.instrument/msrv32_top_pass1_rtl_tessent_bscan_interface.icl'
   ScanOutPort scan_out {
      Source BScanReg[0];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_use_in_dft_specification = "false";
   }
   ScanInPort scan_in {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
   }
   ScanInPort from_bscan_scan_out {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
   }
   CaptureEnPort ijtag_capture_en {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
   }
   ShiftEnPort ijtag_shift_en {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
   }
   UpdateEnPort ijtag_update_en {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
   }
   SelectPort bscan_select {
      Attribute tessent_use_in_dft_specification = "false";
   }
   TCKPort ijtag_tck;
   DataInPort force_disable {
      Attribute connection_rule_option = "allowed_tied_low";
      Attribute tessent_bscan_function = "force_disable";
      Attribute tessent_use_in_dft_specification = "false";
   }
   DataInPort select_jtag_input {
      Attribute connection_rule_option = "allowed_tied_low";
      Attribute tessent_bscan_function = "select_jtag_input";
      Attribute tessent_use_in_dft_specification = "false";
   }
   DataInPort select_jtag_output {
      Attribute connection_rule_option = "allowed_tied_low";
      Attribute tessent_bscan_function = "select_jtag_output";
      Attribute tessent_use_in_dft_specification = "false";
   }
   ScanInterface tessent_bscan {
      Attribute tessent_disable_constraints_if_unused = "on";
      Port scan_out;
      Port scan_in;
      Port ijtag_capture_en;
      Port ijtag_shift_en;
      Port ijtag_update_en;
      Port ijtag_tck;
      Port bscan_select;
   }
   Attribute tessent_instrument_container = 
       "msrv32_top_pass1_rtl_bscan.instrument";
   Attribute tessent_instrument_type = "mentor::jtag_bscan";
   Attribute tessent_instrument_subtype = "bscan_interface";
   Attribute tessent_design_name = "msrv32_top";
   Attribute tessent_design_id = "pass1_rtl";
   Attribute tessent_signature = "4a9304fd0a67e9ea43e13139ea7b679b";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_boundary_scan_reg = "BScanReg";
   Attribute forced_low_output_port_list = 
       "{to_bscan_force_disable} {to_bscan_select_jtag_input} ",
       "{to_bscan_select_jtag_output}";
   Attribute tessent_bscan_clock_persistent_buffer_output_list = 
       "{tessent_persistent_cell_ijtag_tck_buf/Y} {tessent_persistent_cell_capture_shift_clock_gater_inst/GCK} {tessent_persistent_cell_update_clock_gater_inst/GCK}"
       ;
   Attribute tessent_bscan_control_persistent_buffer_output_list = 
       "{tessent_persistent_cell_ijtag_shift_en_buf/Y} {tessent_persistent_cell_ijtag_update_en_buf/Y} {tessent_persistent_cell_ijtag_capture_en_buf/Y} {tessent_persistent_cell_force_disable_buf/Y}"
       ;
   Attribute tessent_bscan_force_high_persistent_buffer_output_list = 
       "{tessent_persistent_cell_bscan_select_buf/Y} {tessent_persistent_cell_select_jtag_output_buf/Y}"
       ;
   Attribute tessent_bscan_force_low_persistent_buffer_output_list = 
       "{tessent_persistent_cell_select_jtag_input_buf/Y}";
   ScanRegister BScanReg[219:0] {
      ScanInSource scan_in;
      Attribute tessent_ignore_during_icl_verification = "on";
      Attribute tessent_use_icl_override_wrapper = "false";
   }
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst
Module msrv32_top_pass1_rtl_tessent_sib_2 {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass1_rtl_ijtag.instrument/msrv32_top_pass1_rtl_tessent_sib_2.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ToSelectPort ijtag_to_sel {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort ijtag_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "5940cf84121a34952a851e0077cfd042";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_sib_sri_inst
Module msrv32_top_pass1_rtl_tessent_sib_1 {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass1_rtl_ijtag.instrument/msrv32_top_pass1_rtl_tessent_sib_1.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ToSelectPort ijtag_to_sel {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort ijtag_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_resource_instrument_host";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "e9aa32e9d76f99ad1ae52f8e2a3695a9";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_tap_main_inst
Module msrv32_top_pass1_rtl_tessent_tap_main {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass1_rtl_ijtag.instrument/msrv32_top_pass1_rtl_tessent_tap_main.icl'
   TCKPort tck;
   ScanInPort tdi;
   ScanOutPort tdo {
      Source IRMux;
      Attribute forced_high_output_port_list = "tdo_en";
      Attribute forced_low_dft_signal_list = "tms_disable";
   }
   DataOutPort tdo_en {
      Attribute associated_scan_port_list = "tdo";
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute function_modifier = "tdo_enable_active_high";
   }
   TMSPort tms {
      Attribute forced_low_dft_signal_list = "tms_disable";
   }
   TRSTPort trst {
      Attribute connection_rule_option = "allowed_tied_high";
   }
   ToCaptureEnPort capture_dr_en;
   ToShiftEnPort shift_dr_en;
   ToUpdateEnPort update_dr_en;
   ToResetPort test_logic_reset {
      ActivePolarity 0;
   }
   ToSelectPort host_1_to_sel {
      Source host_1_to_sel_int;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort host_1_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInPort host_bscan_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ToSelectPort host_bscan_to_sel {
      Source bscan_select_int;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_bscan_function = "select";
   }
   DataOutPort force_disable {
      Source force_disable_int;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_bscan_function = "force_disable";
   }
   DataOutPort select_jtag_input {
      Source select_jtag_input_int;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_bscan_function = "select_jtag_input";
   }
   DataOutPort select_jtag_output {
      Source select_jtag_output_int;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_bscan_function = "select_jtag_output";
   }
   DataOutPort extest_pulse {
      Source ext_test_pulse_int;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_bscan_function = "extest_pulse";
   }
   DataOutPort extest_train {
      Source ext_test_train_int;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_bscan_function = "extest_train";
   }
   DataOutPort fsm_state[3:0] {
      RefEnum state_encoding;
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute function_modifier = "tap_fsm_state";
   }
   ScanInterface tap_client {
      Port tdi;
      Port tdo;
      Port tms;
   }
   ScanInterface host_ijtag_1 {
      Port host_1_from_so;
      Port host_1_to_sel;
   }
   ScanInterface host_bscan {
      Attribute tessent_is_bscan_host = "on";
      Port host_bscan_to_sel;
      Port host_bscan_from_so;
      Port capture_dr_en;
      Port shift_dr_en;
      Port update_dr_en;
      Port test_logic_reset;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instruction_reg = "instruction";
   Attribute tessent_bypass_reg = "bypass";
   Attribute tessent_instrument_container = "msrv32_top_pass1_rtl_ijtag";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_instrument_subtype = "tap_controller";
   Attribute tessent_signature = "3a30752784406bc1d08a13ae35e9e539";
   Enum state_encoding {
      test_logic_reset = 4'b1111;
      run_test_idle = 4'b1100;
      select_dr = 4'b0111;
      capture_dr = 4'b0110;
      shift_dr = 4'b0010;
      exit1_dr = 4'b0001;
      pause_dr = 4'b0011;
      exit2_dr = 4'b0000;
      update_dr = 4'b0101;
      select_ir = 4'b0100;
      capture_ir = 4'b1110;
      shift_ir = 4'b1010;
      exit1_ir = 4'b1001;
      pause_ir = 4'b1011;
      exit2_ir = 4'b1000;
      update_ir = 4'b1101;
   }
   Enum instruction_opcodes {
      BYPASS = 4'b1111;
      CLAMP = 4'b0000;
      EXTEST = 4'b0001;
      EXTEST_PULSE = 4'b0010;
      EXTEST_TRAIN = 4'b0011;
      INTEST = 4'b0100;
      SAMPLE = 4'b0101;
      PRELOAD = 4'b0101;
      HIGHZ = 4'b0110;
      HOSTIJTAG_1 = 4'b0111;
   }
   ScanRegister instruction[3:0] {
      ScanInSource tdi;
      CaptureSource 4'b0001;
      ResetValue 4'b1111;
      RefEnum instruction_opcodes;
   }
   ScanRegister bypass {
      ScanInSource tdi;
      CaptureSource 1'b0;
   }
   ScanMux IRMux SelectedBy fsm.irSel {
      1'b0 : DRMux;
      1'b1 : instruction[0];
   }
   ScanMux DRMux SelectedBy instruction {
      4'b1111 : bypass;
      4'b0000 : bypass;
      4'b0001 : host_bscan_from_so;
      4'b0010 : host_bscan_from_so;
      4'b0011 : host_bscan_from_so;
      4'b0100 : host_bscan_from_so;
      4'b0101 : host_bscan_from_so;
      4'b0110 : bypass;
      4'b0111 : host_1_from_so;
      'bx : bypass;
   }
   LogicSignal host_1_to_sel_int {
      instruction == HOSTIJTAG_1;
   }
   LogicSignal bscan_select_int {
      (((((instruction == EXTEST) || (instruction == INTEST)) || (instruction == 
      EXTEST_PULSE)) || (instruction == EXTEST_TRAIN)) || (instruction == 
          SAMPLE)) || (instruction == PRELOAD);
   }
   LogicSignal force_disable_int {
      instruction == HIGHZ;
   }
   LogicSignal select_jtag_input_int {
      instruction == INTEST;
   }
   LogicSignal select_jtag_output_int {
      ((((instruction == EXTEST) || (instruction == EXTEST_PULSE)) || 
          (instruction == EXTEST_TRAIN)) || (instruction == CLAMP)) || 
          (instruction == HIGHZ);
   }
   LogicSignal ext_test_pulse_int {
      instruction == EXTEST_PULSE;
   }
   LogicSignal ext_test_train_int {
      instruction == EXTEST_TRAIN;
   }
   Instance fsm Of msrv32_top_pass1_rtl_tessent_tap_main_fsm {
      InputPort tck = tck;
      InputPort tms = tms;
      InputPort trst = trst;
   }
}

// instanced as msrv32_top_pass1_rtl_tessent_tap_main.fsm
Module msrv32_top_pass1_rtl_tessent_tap_main_fsm {
   // ICL module read from source on or near line 189 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass1_rtl_ijtag.instrument/msrv32_top_pass1_rtl_tessent_tap_main.icl'
   TCKPort tck;
   TMSPort tms;
   TRSTPort trst;
   ToIRSelectPort irSel;
   ToResetPort tlr;
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst
Module msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass1_rtl_ijtag.instrument/msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source tdr[0];
   }
   DataOutPort async_set_reset_static_disable {
      Source tdr[0];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "async_set_reset_static_disable";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "0";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_async_set_reset_static_disable/Y}";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_resource_instrument_dft_control";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "9bbfe1b4a702a176d4b2f5652d73940a";
   ScanRegister tdr[0:0] {
      ScanInSource ijtag_si;
      CaptureSource 1'b0;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
}

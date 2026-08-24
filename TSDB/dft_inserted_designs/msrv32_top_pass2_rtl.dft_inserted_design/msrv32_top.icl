//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.2
//       Created on: Tue Apr  7 17:43:31 IST 2026
//-------------------------------------------------


Module msrv32_top {
   // Created by ICL extraction
   DataInPort control_chain_enable {
      Attribute tessent_timing = "scan_reconfiguration";
      Attribute connection_rule_option = "allowed_tied_low";
   }
   ClockPort edt_clock {
      Attribute function_modifier = "sync_tester_clock";
      Attribute forced_high_dft_signal_list = "ltest_en";
      Attribute connection_rule_option = "allowed_no_source";
   }
   ClockPort ms_riscv32_mp_clk_in {
      Attribute tessent_clock_domain_labels = "clk ms_riscv32_mp_clk_in";
      Attribute tessent_clock_periods = "all 6.00ns";
   }
   ClockPort shift_clock_src_p;
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
   Attribute forced_low_internal_input_port_list = 
       "{msrv32_top_pass2_rtl_tessent_lbist_inst/scan_en_out}";
   Attribute icl_extraction_date = "Tue Apr  7 17:43:31 IST 2026";
   Attribute created_by_tessent_icl_extract = "true";
   Attribute tessent_design_id = "pass2_rtl";
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
          msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.ijtag_so;
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
   Instance msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst Of 
       msrv32_top_pass2_rtl_tessent_edt_lbist_c0 {
      InputPort lbist_en = msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_en;
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_lbist_inst.to_edt_scan_in;
      InputPort edt_bypass = 
          msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.edt_bypass;
      InputPort edt_single_bypass_chain = 
          msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.edt_single_bypass_chain_out;

      InputPort edt_low_power_shift_en = 
          msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.edt_low_power_shift_en;

      InputPort ccm_en = control_chain_enable;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = msrv32_top_pass2_rtl_tessent_lbist_inst.edt_sib_en;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst Of 
       msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass2_rtl_tessent_sib_edt_inst.ijtag_to_sel;
      InputPort ijtag_si = msrv32_top_pass2_rtl_tessent_sib_occ_inst.ijtag_so;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_lbist_inst Of 
       msrv32_top_pass2_rtl_tessent_lbist {
      InputPort ijtag_tck = tck_p;
      InputPort test_clock = edt_clock;
      InputPort shift_clock_src = shift_clock_src_p;
      InputPort from_edt_scan_out = 
          msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.ijtag_so;
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.ijtag_so;
      InputPort ccm_en = control_chain_enable;
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass2_rtl_tessent_sib_lbist_inst.ijtag_to_sel;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_lbist_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst Of 
       msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder {
      InputPort ncp_index[1] = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp[1];
      InputPort ncp_index[0] = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp[0];
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst Of 
       msrv32_top_pass2_rtl_tessent_occ {
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_si = msrv32_top_pass2_rtl_tessent_sib_lbist_inst.ijtag_so;
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_sel = 
          msrv32_top_pass2_rtl_tessent_sib_occ_inst.ijtag_to_sel;
      InputPort static_clock_control_mode = 
          msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_en;
      InputPort clock_sequence[2] = 
          msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst.occ1_clock_sequence[2];

      InputPort clock_sequence[1] = 
          msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst.occ1_clock_sequence[1];

      InputPort clock_sequence[0] = 
          msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst.occ1_clock_sequence[0];

      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst Of 
       msrv32_top_pass2_rtl_tessent_occ {
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.ijtag_so;
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_sel = 
          msrv32_top_pass2_rtl_tessent_sib_occ_inst.ijtag_to_sel;
      InputPort static_clock_control_mode = 
          msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_en;
      InputPort clock_sequence[2] = 
          msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst.occ2_clock_sequence[2];

      InputPort clock_sequence[1] = 
          msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst.occ2_clock_sequence[1];

      InputPort clock_sequence[0] = 
          msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst.occ2_clock_sequence[0];

      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_sib_edt_inst Of 
       msrv32_top_pass2_rtl_tessent_sib_1 {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = msrv32_top_pass2_rtl_tessent_sib_occ_inst.ijtag_so;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_from_so = 
          msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_sib_edt_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_sib_lbist_inst Of 
       msrv32_top_pass2_rtl_tessent_sib_1 {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = 
          msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.ijtag_so;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_from_so = msrv32_top_pass2_rtl_tessent_lbist_inst.ijtag_so;

      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_sib_lbist_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_sib_occ_inst Of 
       msrv32_top_pass2_rtl_tessent_sib_1 {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = msrv32_top_pass2_rtl_tessent_sib_lbist_inst.ijtag_so;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_from_so = 
          msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_sib_occ_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst Of 
       msrv32_top_pass2_rtl_tessent_sib_1 {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = msrv32_top_pass2_rtl_tessent_sib_edt_inst.ijtag_so;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_from_so = 
          msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst Of 
       msrv32_top_pass2_rtl_tessent_single_chain_mode_logic {
      InputPort ijtag_si = 
          msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.ijtag_so;
      InputPort ijtag_tck = tck_p;
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass2_rtl_tessent_sib_lbist_inst.ijtag_to_sel;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort edt_single_bypass_chain_in = 'b0;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst";
   }
   Instance msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst Of 
       msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl {
      InputPort ijtag_reset = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.test_logic_reset;
      InputPort ijtag_sel = 
          msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.ijtag_to_sel;
      InputPort ijtag_si = msrv32_top_pass2_rtl_tessent_sib_edt_inst.ijtag_so;
      InputPort ijtag_ce = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.capture_dr_en;
      InputPort ijtag_se = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.shift_dr_en;
      InputPort ijtag_ue = 
          msrv32_top_pass1_rtl_tessent_tap_main_inst.update_dr_en;
      InputPort ijtag_tck = tck_p;
      Attribute tessent_design_instance = 
          "msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst";
   }
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_bscan_interface_I
Module msrv32_top_pass1_rtl_tessent_bscan_interface {
   // ICL module read from source on or near line 136 of file './TSDB/dft_inserted_designs/msrv32_top_pass1_rtl.dft_inserted_design/msrv32_top.icl'
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
   // ICL module read from source on or near line 223 of file './TSDB/dft_inserted_designs/msrv32_top_pass1_rtl.dft_inserted_design/msrv32_top.icl'
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
   // ICL module read from source on or near line 268 of file './TSDB/dft_inserted_designs/msrv32_top_pass1_rtl.dft_inserted_design/msrv32_top.icl'
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
   // ICL module read from source on or near line 314 of file './TSDB/dft_inserted_designs/msrv32_top_pass1_rtl.dft_inserted_design/msrv32_top.icl'
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
   // ICL module read from source on or near line 500 of file './TSDB/dft_inserted_designs/msrv32_top_pass1_rtl.dft_inserted_design/msrv32_top.icl'
   TCKPort tck;
   TMSPort tms;
   TRSTPort trst;
   ToIRSelectPort irSel;
   ToResetPort tlr;
}

// instanced as msrv32_top.msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst
Module msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl {
   // ICL module read from source on or near line 510 of file './TSDB/dft_inserted_designs/msrv32_top_pass1_rtl.dft_inserted_design/msrv32_top.icl'
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

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst
Module msrv32_top_pass2_rtl_tessent_edt_lbist_c0 {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_edt_lbist.instrument/msrv32_top_pass2_rtl_tessent_edt_lbist_c0.icl'
   DataInPort lbist_en;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i.ijtag_so;
   }
   DataInPort edt_bypass {
      RefEnum OnOffTable;
      Attribute tessent_no_input_constraints = "on";
   }
   DataInPort edt_single_bypass_chain {
      RefEnum OnOffTable;
      Attribute tessent_no_input_constraints = "on";
   }
   DataInPort edt_low_power_shift_en {
      RefEnum OnOffTable;
      Attribute tessent_no_input_constraints = "on";
   }
   DataInPort ccm_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_container = 
       "msrv32_top_pass2_rtl_edt_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::edt";
   Attribute tessent_signature = "564f555e493c63b1a6be0b6faef77933";
   Enum OnOffTable {
      off = 1'b0;
      on = 1'b1;
   }
   ScanRegister lfsm_vec[30:0] {
      ScanInSource lfsm_vec_scan_in_mux;
   }
   ScanRegister lbist_lp_hold_reg[3:0] {
      ScanInSource 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.ijtag_so;
   }
   ScanRegister lbist_lp_toggle_reg[3:0] {
      ScanInSource lbist_lp_hold_reg[0];
   }
   ScanRegister lbist_lp_switching_reg[3:0] {
      ScanInSource lbist_lp_toggle_reg[0];
   }
   ScanRegister lbist_lp_mask_shift_reg[30:0] {
      ScanInSource 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.ijtag_so;

   }
   ScanRegister bist_chain_mask[9:0] {
      ScanInSource 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.ijtag_so;

   }
   ScanRegister bist_chain_mask_load_en {
      ScanInSource bist_chain_mask[0];
   }
   ScanRegister misr[23:0] {
      ScanInSource msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.ijtag_so;

   }
   ScanMux lbist_scan_in_mux SelectedBy ccm_en {
      1'b0 : ijtag_si;
   }
   ScanMux lfsm_vec_scan_in_mux SelectedBy lbist_en {
      1'b1 : lbist_scan_in_mux;
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i Of 
       msrv32_top_pass2_rtl_tessent_edt_c0_sib {
      InputPort ijtag_si = lbist_scan_in_mux;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lfsm_vec[0];
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i Of 
   msrv32_top_pass2_rtl_tessent_edt_c0_sib {
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lbist_lp_switching_reg[0];
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i Of 
   msrv32_top_pass2_rtl_tessent_edt_c0_sib {
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.ijtag_so;

      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lbist_lp_mask_shift_reg[0];
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i Of 
       msrv32_top_pass2_rtl_tessent_edt_c0_sib {
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.ijtag_so;

      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = bist_chain_mask_load_en;
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i Of 
       msrv32_top_pass2_rtl_tessent_edt_c0_sib {
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = misr[0];
   }
}

// instanced as msrv32_top_pass2_rtl_tessent_edt_lbist_c0.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i
// instanced as msrv32_top_pass2_rtl_tessent_edt_lbist_c0.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i
// instanced as msrv32_top_pass2_rtl_tessent_edt_lbist_c0.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i
// instanced as msrv32_top_pass2_rtl_tessent_edt_lbist_c0.msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i
// instanced as msrv32_top_pass2_rtl_tessent_edt_lbist_c0.msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i
Module msrv32_top_pass2_rtl_tessent_edt_c0_sib {
   // ICL module read from source on or near line 148 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_edt_lbist.instrument/msrv32_top_pass2_rtl_tessent_edt_lbist_c0.icl'
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source sib;
   }
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   ToSelectPort ijtag_to_sel {
      Source to_sel_and;
   }
   ScanInPort ijtag_from_so;
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
   Attribute tessent_signature = "e53cdf797eb092002858538b3da6e70c";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
   LogicSignal to_sel_and {
      ijtag_sel, sib == 2'b11;
   }
}

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst
Module msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_edt_lbist.instrument/msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr.icl'
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
   DataOutPort edt_bypass {
      Source tdr[0];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_edt_bypass/Y}";
   }
   DataOutPort edt_low_power_shift_en {
      Source tdr[1];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_edt_low_power_shift_en/Y}";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "a7970d7bd468ee3ab89fd5129cffbd31";
   ScanRegister tdr[1:0] {
      ScanInSource ijtag_si;
      CaptureSource tdr[1:0];
      DefaultLoadValue 2'b00;
      ResetValue 2'b00;
   }
}

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_lbist_inst
Module msrv32_top_pass2_rtl_tessent_lbist {
   // ICL module read from source on or near line 18 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_lbist.instrument/msrv32_top_pass2_rtl_tessent_lbist.icl'
   TCKPort ijtag_tck;
   ClockPort test_clock {
      Attribute forced_high_dft_signal_list = "ltest_en";
      Attribute connection_rule_option = "allowed_no_source";
      Attribute function_modifier = "sync_tester_clock";
      Attribute persistent_pin = 
          "msrv32_top_pass2_rtl_tessent_lbist_fsm_i/tessent_persistent_cell_edt_clock_tck_m"
          ,"ux/A1";
   }
   ClockPort shift_clock_src {
      Attribute persistent_pin = 
          "msrv32_top_pass2_rtl_tessent_lbist_fsm_i/tessent_persistent_cell_shift_clock_int"
          ,"_mux/A0";
   }
   ScanInPort from_edt_scan_out;
   ScanOutPort to_edt_scan_in {
      Source msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.ijtag_so;

   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source ijtag_so_mux;
   }
   DataOutPort lbist_en {
      Source bist_en;
   }
   DataInPort ccm_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort ncp[1:0] {
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_use_in_dft_specification = "false";
      Attribute function_modifier = "tessent_ncp_index";
   }
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   ToSelectPort edt_sib_en {
      Source msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.ijtag_to_sel;
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port from_edt_scan_out;
      Port edt_sib_en;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_container = 
       "msrv32_top_pass2_rtl_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::logic_bist";
   Attribute tessent_signature = "4ec3cea58e70c659167317bab5538354";
   Alias bist_done = bist_en {
      RefEnum YesNo;
   }
   Enum YesNo {
      Yes = 1'b1;
      No = 1'b0;
   }
   Enum BistSetupValues {
      Idle = 3'b000;
      LongSetup = 3'b001;
      DefaultLogicBist = 3'b010;
      NormalLogicBist = 3'b011;
      SingleChainMode = 3'b11x;
   }
   ScanRegister capture_phase_size[2:0] {
      ScanInSource from_lbist_register_path_mux;
   }
   ScanRegister warmup_pattern_cnt[9:0] {
      ScanInSource capture_phase_size[0];
   }
   ScanRegister bit_cnt_max[5:0] {
      ScanInSource warmup_pattern_cnt[0];
   }
   ScanRegister vector_cnt[13:0] {
      ScanInSource bit_cnt_max[0];
   }
   ScanRegister ncp_cnt[7:0] {
      ScanInSource vector_cnt[0];
   }
   ScanRegister ncp_3_limit[7:0] {
      ScanInSource from_ncp_limits_path_mux;
      Attribute ncp_name = "ncp4";
   }
   ScanRegister ncp_2_limit[7:0] {
      ScanInSource ncp_3_limit[0];
      Attribute ncp_name = "ncp3";
   }
   ScanRegister ncp_1_limit[7:0] {
      ScanInSource ncp_2_limit[0];
      Attribute ncp_name = "ncp2";
   }
   ScanRegister ncp_0_limit[7:0] {
      ScanInSource ncp_1_limit[0];
      Attribute ncp_name = "ncp1";
   }
   ScanRegister lbist_low_power_shift_en_reg {
      ScanInSource 
          msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.ijtag_so;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister lbist_burn_in_reg {
      ScanInSource lbist_low_power_shift_en_reg;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister shift_clock_select[1:0] {
      ScanInSource lbist_burn_in_reg;
      CaptureSource 2'b00;
      ResetValue 2'b00;
   }
   ScanRegister bist_sync_reset {
      ScanInSource shift_clock_select[0];
      CaptureSource 1'b0;
      ResetValue 1'b0;
      Attribute explicit_iwrite_only = 1'b1;
   }
   ScanRegister bist_clock_disable {
      ScanInSource bist_sync_reset;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister bist_setup[2:0] {
      ScanInSource bist_clock_disable;
      CaptureSource 3'b0;
      ResetValue 3'b0;
      Attribute explicit_iwrite_only = 3'b110;
      RefEnum BistSetupValues;
   }
   ScanRegister bist_en {
      ScanInSource bist_setup[0];
      ResetValue 1'b0;
      RefEnum YesNo;
   }
   ScanRegister ijtag_so_ff {
      ScanInSource msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.ijtag_so;
      CaptureSource 1'b0;
   }
   ScanMux ijtag_so_mux SelectedBy ccm_en {
      1'b0 : ijtag_so_ff;
   }
   ScanMux from_lbist_register_path_mux SelectedBy lbist_register_path_en {
      1'b1 : ijtag_si;
   }
   ScanMux from_ncp_limits_path_mux SelectedBy lbist_register_path_en {
      1'b1 : msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so;
   }
   ScanMux from_edt_scan_out_mux SelectedBy edt_scan_path_en {
      1'b1 : from_edt_scan_out;
   }
   LogicSignal lbist_register_path_en {
      ((bist_setup[2:0] == LongSetup) && (bist_clock_disable == 1'b0)) && 
          (bist_en == 1'b1);
   }
   LogicSignal edt_scan_path_en {
      (bist_setup[2:0] == LongSetup) && (bist_clock_disable == 1'b0);
   }
   Instance msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i Of 
       msrv32_top_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = ncp_cnt[0];
   }
   Instance msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i Of 
       msrv32_top_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = ncp_0_limit[0];
   }
   Instance msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i Of 
       msrv32_top_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = bist_en;
   }
   Instance msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i Of 
       msrv32_top_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = 
          msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = from_edt_scan_out_mux;
   }
}

// instanced as msrv32_top_pass2_rtl_tessent_lbist.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i
// instanced as msrv32_top_pass2_rtl_tessent_lbist.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i
// instanced as msrv32_top_pass2_rtl_tessent_lbist.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i
// instanced as msrv32_top_pass2_rtl_tessent_lbist.msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i
Module msrv32_top_pass2_rtl_tessent_lbist_sib {
   // ICL module read from source on or near line 223 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_lbist.instrument/msrv32_top_pass2_rtl_tessent_lbist.icl'
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ShiftEnPort ijtag_se;
   CaptureEnPort ijtag_ce;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   ToSelectPort ijtag_to_sel {
      Source to_enable_and;
   }
   ScanInPort ijtag_from_so;
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
   Attribute tessent_signature = "61af80b3e6c09dafce522d7e41c7f3d2";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
   LogicSignal to_enable_and {
      ijtag_sel, sib == 2'b11;
   }
}

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder_inst
Module msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_lbist_ncp_index_decoder.instrument/msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder.icl'
   DataInPort ncp_index[1:0] {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute function_modifier = "tessent_ncp_index";
   }
   DataOutPort occ1_clock_sequence[2:0] {
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute function_modifier = "tessent_clock_sequence";
   }
   DataOutPort occ2_clock_sequence[2:0] {
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute function_modifier = "tessent_clock_sequence";
   }
   Attribute tessent_instrument_container = 
       "msrv32_top_pass2_rtl_lbist_ncp_index_decoder.instrument";
   Attribute tessent_instrument_type = "mentor::lbist_ncp_index_decoder";
   Attribute tessent_signature = "d0a27309a6d10fd60461650215f6c808";
}

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst
// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst
Module msrv32_top_pass2_rtl_tessent_occ {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_occ.instrument/msrv32_top_pass2_rtl_tessent_occ.icl'
   ClockPort fast_clock {
      Attribute icl_extraction_port_trigger_list = "clock_out";
   }
   ToClockPort clock_out {
      Source tck_mux;
      Attribute exclude_from_sdc = "on";
   }
   TCKPort ijtag_tck;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source tdr_sib.scan_out;
   }
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   DataInPort static_clock_control_mode {
      Attribute connection_rule_option = "allowed_tied";
      Attribute tessent_use_in_dft_specification = "false";
   }
   DataInPort clock_sequence[2:0] {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
      Attribute function_modifier = "tessent_clock_sequence";
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_type = "mentor::occ";
   Attribute tessent_instrument_subtype = "standard";
   Attribute tessent_instrument_container = 
       "msrv32_top_pass2_rtl_occ.instrument";
   Attribute tessent_signature = "c396d091d1d725e4992bc8247288d065";
   Alias test_mode = tdr[0] {
   }
   Alias fast_capture_mode = tdr[1] {
   }
   Alias active_upstream_parent_occ = tdr[2] {
   }
   Alias capture_cycle_width[1:0] = tdr[4:3] {
   }
   Alias inject_tck = tdr[5] {
   }
   Alias ijtag_static_clock_control_mode = tdr[6] {
   }
   Alias ijtag_clock_sequence[2:0] = tdr[9:7] {
   }
   ScanRegister tdr[9:0] {
      ScanInSource ijtag_si;
      CaptureSource 10'b0000000000;
      ResetValue 10'b0000000000;
   }
   ClockMux tck_mux SelectedBy inject_tck {
      1'b1 : ijtag_tck;
      1'b0 : fast_clock;
   }
   Instance tdr_sib Of msrv32_top_pass2_rtl_tessent_occ_sib_int {
      InputPort clock = ijtag_tck;
      InputPort reset = ijtag_reset;
      InputPort scan_in = ijtag_si;
      InputPort capture_en = ijtag_ce;
      InputPort shift_en = ijtag_se;
      InputPort update_en = ijtag_ue;
      InputPort enable = ijtag_sel;
      InputPort from_scan_out = tdr[0];
   }
}

// instanced as msrv32_top_pass2_rtl_tessent_occ.tdr_sib
Module msrv32_top_pass2_rtl_tessent_occ_sib_int {
   // ICL module read from source on or near line 82 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_occ.instrument/msrv32_top_pass2_rtl_tessent_occ.icl'
   TCKPort clock;
   ResetPort reset {
      ActivePolarity 0;
   }
   ScanInPort scan_in;
   ScanOutPort scan_out {
      Source sib;
   }
   CaptureEnPort capture_en;
   ShiftEnPort shift_en;
   UpdateEnPort update_en;
   SelectPort enable;
   ToSelectPort to_scan_en {
      Source to_scan_en_and;
   }
   ScanInPort from_scan_out;
   ScanInterface client {
      Port scan_in;
      Port scan_out;
      Port enable;
   }
   ScanInterface host {
      Port from_scan_out;
      Port to_scan_en;
   }
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : scan_in;
      1'b1 : from_scan_out;
   }
   LogicSignal to_scan_en_and {
      enable, sib == 2'b11;
   }
}

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_sib_edt_inst
// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_sib_lbist_inst
// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_sib_occ_inst
// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst
Module msrv32_top_pass2_rtl_tessent_sib_1 {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_ijtag.instrument/msrv32_top_pass2_rtl_tessent_sib_1.icl'
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
   Attribute tessent_signature = "2fe5180c090b0b29cbe8cf5bfb4f15e7";
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

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst
Module msrv32_top_pass2_rtl_tessent_single_chain_mode_logic {
   // ICL module read from source on or near line 18 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_lbist.instrument/msrv32_top_pass2_rtl_tessent_single_chain_mode_logic.icl'
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source single_chain_sib_i.ijtag_so;
   }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   DataInPort edt_single_bypass_chain_in {
      Attribute tessent_no_input_constraints = "on";
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort edt_single_bypass_chain_out {
      Source edt_single_bypass_chain_ctrl;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_container = 
       "msrv32_top_pass2_rtl_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::logic_bist";
   Attribute tessent_instrument_subtype = "single_chain_mode_logic";
   Attribute tessent_signature = "4430e4ac49016410a3c0c7444f0a3d6e";
   ScanRegister tdr_single_bypass {
      ScanInSource ijtag_si;
      ResetValue 1'b0;
   }
   LogicSignal edt_single_bypass_chain_ctrl {
      edt_single_bypass_chain_in || tdr_single_bypass;
   }
   Instance tdr_sib_i Of 
       msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = tdr_single_bypass;
   }
   Instance msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i Of 
       msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers {
      InputPort ijtag_si = tdr_sib_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = single_chain_sib_i.ijtag_to_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort edt_single_bypass_chain = tdr_single_bypass;
   }
   Instance single_chain_sib_i Of 
       msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_si = tdr_sib_i.ijtag_so;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = 
          msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i.ijtag_so;
   }
}

// instanced as msrv32_top_pass2_rtl_tessent_single_chain_mode_logic.tdr_sib_i
// instanced as msrv32_top_pass2_rtl_tessent_single_chain_mode_logic.single_chain_sib_i
// instanced as msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers.blk1_sib_i
Module msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_sib {
   // ICL module read from source on or near line 79 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_lbist.instrument/msrv32_top_pass2_rtl_tessent_single_chain_mode_logic.icl'
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source sib;
   }
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   ToSelectPort ijtag_to_sel {
      Source to_sel_and;
   }
   ScanInPort ijtag_from_so;
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
   Attribute tessent_signature = "fb0f11524ef196c143387b3f7e463165";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
   LogicSignal to_sel_and {
      ijtag_sel, sib == 2'b11;
   }
}

// instanced as msrv32_top_pass2_rtl_tessent_single_chain_mode_logic.msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i
Module msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers {
   // ICL module read from source on or near line 118 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_lbist.instrument/msrv32_top_pass2_rtl_tessent_single_chain_mode_logic.icl'
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source blk1_sib_i.ijtag_so;
   }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   DataInPort edt_single_bypass_chain {
      Attribute tessent_no_input_constraints = "on";
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_type = "mentor::edt";
   Attribute tessent_instrument_subtype = "edt_internal_scan_registers";
   Attribute tessent_signature = "e4c799486801e1adf1213b1d859863c3";
   ScanRegister edt_lbist_chain1[1:0] {
      ScanInSource edt_lbist_chain1_single_chain_mode_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain2[1:0] {
      ScanInSource edt_lbist_chain2_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain3[1:0] {
      ScanInSource edt_lbist_chain3_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain4[1:0] {
      ScanInSource edt_lbist_chain4_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain5[1:0] {
      ScanInSource edt_lbist_chain5_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain6[1:0] {
      ScanInSource edt_lbist_chain6_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain7[1:0] {
      ScanInSource edt_lbist_chain7_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain8[1:0] {
      ScanInSource edt_lbist_chain8_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain9[1:0] {
      ScanInSource edt_lbist_chain9_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain10[1:0] {
      ScanInSource edt_lbist_chain10_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanMux edt_lbist_chain1_single_chain_mode_mux SelectedBy 
       edt_single_bypass_chain {
      1'b1 : ijtag_si;
   }
   ScanMux edt_lbist_chain2_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain1[0];
   }
   ScanMux edt_lbist_chain3_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain2[0];
   }
   ScanMux edt_lbist_chain4_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain3[0];
   }
   ScanMux edt_lbist_chain5_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain4[0];
   }
   ScanMux edt_lbist_chain6_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain5[0];
   }
   ScanMux edt_lbist_chain7_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain6[0];
   }
   ScanMux edt_lbist_chain8_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain7[0];
   }
   ScanMux edt_lbist_chain9_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain8[0];
   }
   ScanMux edt_lbist_chain10_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain9[0];
   }
   Instance blk1_sib_i Of 
       msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_from_so = edt_lbist_chain10[0];
   }
}

// instanced as msrv32_top.msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst
Module msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl {
   // ICL module read from source on or near line 17 of file '/home1/PD07/AMuthuKKumar/DFT_RISCV_PROJECT/Project/TSDB/instruments/msrv32_top_pass2_rtl_ijtag.instrument/msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl.icl'
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
   DataOutPort mcp_bounding_en {
      Source tdr[3];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "mcp_bounding_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_mcp_bounding_en/Y}";
   }
   DataOutPort control_test_point_en {
      Source tdr[2];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "control_test_point_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_control_test_point_en/Y}";
   }
   DataOutPort observe_test_point_en {
      Source tdr[1];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "observe_test_point_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_observe_test_point_en/Y}";
   }
   DataOutPort x_bounding_en {
      Source tdr[0];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "x_bounding_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_x_bounding_en/Y}";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_resource_instrument_dft_control";
   Attribute forced_low_output_port_list = 
       "x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en"
       ;
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "c922dbe18e174a87593069ee9603d48c";
   ScanRegister tdr[3:0] {
      ScanInSource ijtag_si;
      CaptureSource 4'b0000;
      DefaultLoadValue 4'b0000;
      ResetValue 4'b0000;
   }
}

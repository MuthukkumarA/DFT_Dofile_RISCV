//--------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2021 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.2
//       Created on: Tue Apr  7 17:43:10 IST 2026
//--------------------------------------------------------------------------

Module msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl {
 
  ResetPort     ijtag_reset             { ActivePolarity 0;      }
  SelectPort    ijtag_sel;
  ScanInPort    ijtag_si;
  CaptureEnPort ijtag_ce;
  ShiftEnPort   ijtag_se;
  UpdateEnPort  ijtag_ue;
  TCKPort       ijtag_tck;
  ScanOutPort   ijtag_so                { Source tdr[0];         }
  DataOutPort   mcp_bounding_en         {
    Source tdr[3];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "mcp_bounding_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_mcp_bounding_en/Y";
  }
  DataOutPort   control_test_point_en   {
    Source tdr[2];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "control_test_point_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_control_test_point_en/Y";
  }
  DataOutPort   observe_test_point_en   {
    Source tdr[1];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "observe_test_point_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_observe_test_point_en/Y";
  }
  DataOutPort   x_bounding_en           {
    Source tdr[0];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "x_bounding_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_x_bounding_en/Y";
  }
 
  ScanInterface client { 
    Port ijtag_si; 
    Port ijtag_so; 
    Port ijtag_sel;
  }
 
  Attribute keep_active_during_scan_test = "true";
  Attribute tessent_dft_function = "scan_resource_instrument_dft_control";
  Attribute forced_low_output_port_list = "x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en";
 
  ScanRegister tdr[3:0] {
    ScanInSource     ijtag_si;
    CaptureSource    4'b0000;
    ResetValue       4'b0000;
    DefaultLoadValue 4'b0000;
  }
 
 
  Attribute tessent_use_in_dft_specification = "false";
  Attribute tessent_instrument_type          = "mentor::ijtag_node";
  Attribute tessent_signature                = "c922dbe18e174a87593069ee9603d48c";
}

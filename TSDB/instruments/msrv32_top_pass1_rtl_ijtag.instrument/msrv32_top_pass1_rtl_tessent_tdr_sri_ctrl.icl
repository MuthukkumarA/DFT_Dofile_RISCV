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
//       Created on: Tue Apr  7 17:29:57 IST 2026
//--------------------------------------------------------------------------

Module msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl {
 
  ResetPort     ijtag_reset             { ActivePolarity 0;      }
  SelectPort    ijtag_sel;
  ScanInPort    ijtag_si;
  CaptureEnPort ijtag_ce;
  ShiftEnPort   ijtag_se;
  UpdateEnPort  ijtag_ue;
  TCKPort       ijtag_tck;
  ScanOutPort   ijtag_so                { Source tdr[0];         }
  DataOutPort   async_set_reset_static_disable                   {
    Source tdr[0];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "async_set_reset_static_disable";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "0";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_async_set_reset_static_disable/Y";
  }
 
  ScanInterface client { 
    Port ijtag_si; 
    Port ijtag_so; 
    Port ijtag_sel;
  }
 
  Attribute keep_active_during_scan_test = "true";
  Attribute tessent_dft_function = "scan_resource_instrument_dft_control";
 
  ScanRegister tdr[0:0] {
    ScanInSource     ijtag_si;
    CaptureSource    1'b0;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
 
 
  Attribute tessent_use_in_dft_specification = "false";
  Attribute tessent_instrument_type          = "mentor::ijtag_node";
  Attribute tessent_signature                = "9bbfe1b4a702a176d4b2f5652d73940a";
}

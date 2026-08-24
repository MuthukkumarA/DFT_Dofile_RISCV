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

Module msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr {
 
  ResetPort     ijtag_reset             { ActivePolarity 0;      }
  SelectPort    ijtag_sel;
  ScanInPort    ijtag_si;
  CaptureEnPort ijtag_ce;
  ShiftEnPort   ijtag_se;
  UpdateEnPort  ijtag_ue;
  TCKPort       ijtag_tck;
  ScanOutPort   ijtag_so                { Source tdr[0];         }
  DataOutPort   edt_bypass              {
    Source tdr[0];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_edt_bypass/Y";
  }
  DataOutPort   edt_low_power_shift_en  {
    Source tdr[1];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_edt_low_power_shift_en/Y";
  }
 
  ScanInterface client { 
    Port ijtag_si; 
    Port ijtag_so; 
    Port ijtag_sel;
  }
 
  Attribute keep_active_during_scan_test = "true";
  ScanRegister tdr[1:0] {
    ScanInSource     ijtag_si;
    CaptureSource    tdr[1:0];
    ResetValue       2'b00;
    DefaultLoadValue 2'b00;
  }
 
 
  Attribute tessent_use_in_dft_specification = "false";
  Attribute tessent_instrument_type          = "mentor::ijtag_node";
  Attribute tessent_signature                = "a7970d7bd468ee3ab89fd5129cffbd31";
}

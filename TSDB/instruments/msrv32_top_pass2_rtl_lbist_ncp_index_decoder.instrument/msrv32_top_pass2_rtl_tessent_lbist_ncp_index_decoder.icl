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
//       Created on: Tue Apr  7 17:43:15 IST 2026
//--------------------------------------------------------------------------

Module msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder {
  DataInPort                            ncp_index[1:0] {
    Attribute connection_rule_option = "allowed_no_source";
    Attribute function_modifier = "tessent_ncp_index";
  }
  DataOutPort                           occ1_clock_sequence[2:0]{
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute function_modifier = "tessent_clock_sequence";
  }
  DataOutPort                           occ2_clock_sequence[2:0]{
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute function_modifier = "tessent_clock_sequence";
  }
  
  Attribute tessent_instrument_container = "msrv32_top_pass2_rtl_lbist_ncp_index_decoder.instrument";
  Attribute tessent_instrument_type      = "mentor::lbist_ncp_index_decoder";
  Attribute tessent_signature            = "d0a27309a6d10fd60461650215f6c808";
}

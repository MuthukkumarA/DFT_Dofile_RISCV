//--------------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2021 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.2
//       Created on: Tue Apr  7 17:43:14 IST 2026
//--------------------------------------------------------------------------------


Module msrv32_top_pass2_rtl_tessent_lbist { // {{{
    TCKPort             ijtag_tck;
    ClockPort           test_clock {
        Attribute forced_high_dft_signal_list = "ltest_en";
        Attribute connection_rule_option      = "allowed_no_source";
        Attribute function_modifier           = "sync_tester_clock";
        Attribute persistent_pin              = "msrv32_top_pass2_rtl_tessent_lbist_fsm_i/tessent_persistent_cell_edt_clock_tck_mux/A1";
    }
    ClockPort           shift_clock_src {
        Attribute persistent_pin = "msrv32_top_pass2_rtl_tessent_lbist_fsm_i/tessent_persistent_cell_shift_clock_int_mux/A0";
    }
    ScanInPort          from_edt_scan_out;
    ScanOutPort         to_edt_scan_in      { Source msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.ijtag_so; }
    ScanInPort          ijtag_si;
    ScanOutPort         ijtag_so            { Source ijtag_so_mux; }
    DataOutPort         lbist_en            { Source bist_en; }
    DataInPort          ccm_en              {
        Attribute connection_rule_option           = "allowed_tied_low";
    }
    DataOutPort         ncp[1:0] {
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_use_in_dft_specification = "false";
      Attribute function_modifier = "tessent_ncp_index";
    }
    ResetPort           ijtag_reset         { ActivePolarity 0; }
    SelectPort          ijtag_sel;
    CaptureEnPort       ijtag_ce;
    ShiftEnPort         ijtag_se;
    UpdateEnPort        ijtag_ue;
    ToSelectPort        edt_sib_en          { Source msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.ijtag_to_sel; }
 
    ScanInterface client {
       Port ijtag_si;
       Port ijtag_so;
       Port ijtag_sel;
    }
    ScanInterface host {
       Port from_edt_scan_out;
       Port edt_sib_en;
    }
 
    ScanMux ijtag_so_mux SelectedBy ccm_en {
        1'b0 : ijtag_so_ff;
    }
 
    Alias bist_done    = bist_en { RefEnum YesNo;}
 
    //
    // Bist registers
    //
    LogicSignal lbist_register_path_en  {
        ( bist_setup[2:0] == LongSetup ) && ( bist_clock_disable == 1'b0 ) && ( bist_en == 1'b1 );
    }
    ScanMux from_lbist_register_path_mux SelectedBy lbist_register_path_en {
        1'b1 : ijtag_si;
    }
    ScanRegister capture_phase_size[2:0] {
        ScanInSource    from_lbist_register_path_mux;
    }
    ScanRegister warmup_pattern_cnt[9:0] {
        ScanInSource    capture_phase_size[0];
    }
    ScanRegister bit_cnt_max[5:0] {
        ScanInSource    warmup_pattern_cnt[0];
    }
    ScanRegister vector_cnt[13:0] {
        ScanInSource    bit_cnt_max[0];
    }
    ScanRegister ncp_cnt[7:0] {
        ScanInSource    vector_cnt[0];
    }
 
    Instance msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i Of msrv32_top_pass2_rtl_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = ijtag_si;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = ncp_cnt[0];
    }
 
    ScanMux from_ncp_limits_path_mux SelectedBy lbist_register_path_en {
        1'b1 : msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so;
    }
    ScanRegister ncp_3_limit[7:0] {
        Attribute ncp_name = "ncp4";
        ScanInSource    from_ncp_limits_path_mux ;
    }
    ScanRegister ncp_2_limit[7:0] {
        Attribute ncp_name = "ncp3";
        ScanInSource    ncp_3_limit[0];
    }
    ScanRegister ncp_1_limit[7:0] {
        Attribute ncp_name = "ncp2";
        ScanInSource    ncp_2_limit[0];
    }
    ScanRegister ncp_0_limit[7:0] {
        Attribute ncp_name = "ncp1";
        ScanInSource    ncp_1_limit[0];
    }
    Instance msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i Of msrv32_top_pass2_rtl_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = ncp_0_limit[0];
    }
 
    //
    // Control registers
    //
    ScanRegister lbist_low_power_shift_en_reg {
        ScanInSource    msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.ijtag_so;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanRegister lbist_burn_in_reg {
        ScanInSource    lbist_low_power_shift_en_reg;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanRegister shift_clock_select[1:0] {
        ScanInSource    lbist_burn_in_reg;
        CaptureSource   2'b00;
        ResetValue      2'b00;
    }
    ScanRegister bist_sync_reset {
        ScanInSource    shift_clock_select[0];
        CaptureSource   1'b0;
        ResetValue      1'b0;
        Attribute explicit_iwrite_only = 1'b1;
    }
    ScanRegister bist_clock_disable {
        ScanInSource    bist_sync_reset;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanRegister bist_setup[2:0] {
        ScanInSource    bist_clock_disable;
        CaptureSource   3'b0;
        ResetValue      3'b0;
        RefEnum         BistSetupValues; 
        Attribute explicit_iwrite_only = 3'b110;
    }
    ScanRegister bist_en {
        ScanInSource    bist_setup[0];
        ResetValue      1'b0;
        RefEnum         YesNo;
    }
    Instance msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i Of msrv32_top_pass2_rtl_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.ijtag_so;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = bist_en;
    }
 
    LogicSignal edt_scan_path_en  {
        ( bist_setup[2:0] == LongSetup ) && ( bist_clock_disable == 1'b0 );
    }
    ScanMux from_edt_scan_out_mux SelectedBy edt_scan_path_en {
        1'b1 : from_edt_scan_out;
    }
 
    Instance msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i Of msrv32_top_pass2_rtl_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.ijtag_so;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = from_edt_scan_out_mux;
    }
 
    ScanRegister ijtag_so_ff {
        ScanInSource    msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.ijtag_so;
        CaptureSource   1'b0;
    }
 
    Enum YesNo {
        Yes                 = 1'b1;
        No                  = 1'b0;
    }
    Enum BistSetupValues {
        Idle                = 3'b000;
        LongSetup           = 3'b001;
        DefaultLogicBist    = 3'b010;
        NormalLogicBist     = 3'b011;
        SingleChainMode     = 3'b11x;
    }
    Attribute keep_active_during_scan_test = "true";
    Attribute tessent_instrument_container = "msrv32_top_pass2_rtl_lbist.instrument";
    Attribute tessent_instrument_type = "mentor::logic_bist";
    Attribute tessent_signature       = "4ec3cea58e70c659167317bab5538354";
} // }}}
 
Module msrv32_top_pass2_rtl_tessent_lbist_sib { // {{{
    TCKPort             ijtag_tck;
    ResetPort           ijtag_reset         { ActivePolarity 0; }
    ScanInPort          ijtag_si;
    ScanOutPort         ijtag_so            { Source sib; }
    ShiftEnPort         ijtag_se;
    CaptureEnPort       ijtag_ce;
    UpdateEnPort        ijtag_ue;
    SelectPort          ijtag_sel;
    ToSelectPort        ijtag_to_sel        { Source to_enable_and; }
    ScanInPort          ijtag_from_so;
 
    ScanRegister sib {
        ScanInSource    scan_in_mux;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanMux scan_in_mux SelectedBy sib {
        1'b0 : ijtag_si;
        1'b1 : ijtag_from_so;
    }
    LogicSignal to_enable_and  {
        ijtag_sel,sib == 2'b11;
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
    Attribute keep_active_during_scan_test     = "true";
    Attribute tessent_use_in_dft_specification = "false";
    Attribute tessent_instrument_type          = "mentor::ijtag_node";
    Attribute tessent_signature                = "61af80b3e6c09dafce522d7e41c7f3d2";
} // }}}
 

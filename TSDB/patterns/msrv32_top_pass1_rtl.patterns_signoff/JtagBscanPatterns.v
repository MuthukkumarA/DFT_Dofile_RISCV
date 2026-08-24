//
// Verilog format test patterns produced by Tessent Shell 2022.2
// Filename       : ./TSDB/patterns/msrv32_top_pass1_rtl.patterns_signoff/JtagBscanPatterns.v
// Idstamp        : 2022.2:ec94:6099:0:0000
// Date           : Tue Apr  7 17:30:59 2026
//
// Begin_Verify_Section 
//   format            = Verilog 
//   top_module_name   = TB 
//   serial_flag       = OFF 
//   test_set_type     = IJTAG_TEST 
//   pad_value         = X 
//   one_setup         = ON 
//   no_initialization = ON 
// End_Verify_Section 
// Parameter File Keyword Settings 
//   SIM_CHANGE_PATH           true ; 
//   SIM_TOP_NAME              TB ; 
//   SIM_INSTANCE_NAME         DUT_inst ; 
//   SIM_CLOCK_MONITOR         true ; 
// End Parameter File Keyword Settings 


`define SIM_INSTANCE_NAME DUT_inst


`timescale 1ns / 1ns

module TB;

integer     _write_DIAG_file;
integer     _DIAG_file_header;
integer     _diag_file;
integer     _diag_chain_header;
integer     _diag_scan_header;
integer     _last_fail_pattern;
integer     _fail_pattern_cnt;
integer     _write_MASK_file;
integer     _MASK_file_header;
integer     _mask_file;
integer     _par_shift_cnt;
integer     _chain_test_;
integer     _compare_fail;
integer     _compare_fail_count;
integer     _compare_count;
integer     _compare_z_count;
integer     _bit_count;
integer     _report_bit_cnt;
integer     _miscompare_limit;
integer     _found_fail;
integer     _found_fail_per_cycle;
reg[72:0]    _found_fail_obus;
integer     _end_vec_file_ok;
integer     _cycle_count, _save_cycle_count;
integer     _pattern_count, _repeat_count_nest[0:8], _repeat_count, _message_index;
integer     _index, _scan_index, _file_cnt, _max_index, _vec_pat_count, _save_index[0:8];
integer     _repeat_depth;
integer     _file_check;
integer     _run_testsetup;
integer     _in_testsetup;
integer     _start_pat;
integer     _end_pat;
integer     _end_after_setup;
integer     _no_setup;
integer     _save_state;
integer     _restart_state;
integer     _in_restart;
integer     _override_cfg;
integer     _in_range;
integer     _do_compare;
integer     _in_chaintest;
integer     _pat_num;
integer     _skipped_patterns;
integer     _end_simulation;
integer     _config_file;
integer     _fstat;
integer     _max_file_cnt;
reg[256*8:1] _vec_file_name;
reg[256*8:1] _cfg_file_name;
integer     _scan_shift_count;
reg[147:0]    _ibus;
reg[72:0]    _exp_obus, _msk_obus;
wire[72:0]   _sim_obus;
reg[2:0]    _pat_type;
reg         _tp_num;
reg         mgcdft_save_signal, mgcdft_restart_signal;
reg[302:0]   vect;

wire ms_riscv32_mp_clk_in, ms_riscv32_mp_rst_in, \ms_riscv32_mp_rc_in[63] , 
     \ms_riscv32_mp_rc_in[62] , \ms_riscv32_mp_rc_in[61] , \ms_riscv32_mp_rc_in[60] , 
     \ms_riscv32_mp_rc_in[59] , \ms_riscv32_mp_rc_in[58] , \ms_riscv32_mp_rc_in[57] , 
     \ms_riscv32_mp_rc_in[56] , \ms_riscv32_mp_rc_in[55] , \ms_riscv32_mp_rc_in[54] , 
     \ms_riscv32_mp_rc_in[53] , \ms_riscv32_mp_rc_in[52] , \ms_riscv32_mp_rc_in[51] , 
     \ms_riscv32_mp_rc_in[50] , \ms_riscv32_mp_rc_in[49] , \ms_riscv32_mp_rc_in[48] , 
     \ms_riscv32_mp_rc_in[47] , \ms_riscv32_mp_rc_in[46] , \ms_riscv32_mp_rc_in[45] , 
     \ms_riscv32_mp_rc_in[44] , \ms_riscv32_mp_rc_in[43] , \ms_riscv32_mp_rc_in[42] , 
     \ms_riscv32_mp_rc_in[41] , \ms_riscv32_mp_rc_in[40] , \ms_riscv32_mp_rc_in[39] , 
     \ms_riscv32_mp_rc_in[38] , \ms_riscv32_mp_rc_in[37] , \ms_riscv32_mp_rc_in[36] , 
     \ms_riscv32_mp_rc_in[35] , \ms_riscv32_mp_rc_in[34] , \ms_riscv32_mp_rc_in[33] , 
     \ms_riscv32_mp_rc_in[32] , \ms_riscv32_mp_rc_in[31] , \ms_riscv32_mp_rc_in[30] , 
     \ms_riscv32_mp_rc_in[29] , \ms_riscv32_mp_rc_in[28] , \ms_riscv32_mp_rc_in[27] , 
     \ms_riscv32_mp_rc_in[26] , \ms_riscv32_mp_rc_in[25] , \ms_riscv32_mp_rc_in[24] , 
     \ms_riscv32_mp_rc_in[23] , \ms_riscv32_mp_rc_in[22] , \ms_riscv32_mp_rc_in[21] , 
     \ms_riscv32_mp_rc_in[20] , \ms_riscv32_mp_rc_in[19] , \ms_riscv32_mp_rc_in[18] , 
     \ms_riscv32_mp_rc_in[17] , \ms_riscv32_mp_rc_in[16] , \ms_riscv32_mp_rc_in[15] , 
     \ms_riscv32_mp_rc_in[14] , \ms_riscv32_mp_rc_in[13] , \ms_riscv32_mp_rc_in[12] , 
     \ms_riscv32_mp_rc_in[11] , \ms_riscv32_mp_rc_in[10] , \ms_riscv32_mp_rc_in[9] , 
     \ms_riscv32_mp_rc_in[8] , \ms_riscv32_mp_rc_in[7] , \ms_riscv32_mp_rc_in[6] , 
     \ms_riscv32_mp_rc_in[5] , \ms_riscv32_mp_rc_in[4] , \ms_riscv32_mp_rc_in[3] , 
     \ms_riscv32_mp_rc_in[2] , \ms_riscv32_mp_rc_in[1] , \ms_riscv32_mp_rc_in[0] , 
     \ms_riscv32_mp_instr_in[31] , \ms_riscv32_mp_instr_in[30] , \ms_riscv32_mp_instr_in[29] , 
     \ms_riscv32_mp_instr_in[28] , \ms_riscv32_mp_instr_in[27] , \ms_riscv32_mp_instr_in[26] , 
     \ms_riscv32_mp_instr_in[25] , \ms_riscv32_mp_instr_in[24] , \ms_riscv32_mp_instr_in[23] , 
     \ms_riscv32_mp_instr_in[22] , \ms_riscv32_mp_instr_in[21] , \ms_riscv32_mp_instr_in[20] , 
     \ms_riscv32_mp_instr_in[19] , \ms_riscv32_mp_instr_in[18] , \ms_riscv32_mp_instr_in[17] , 
     \ms_riscv32_mp_instr_in[16] , \ms_riscv32_mp_instr_in[15] , \ms_riscv32_mp_instr_in[14] , 
     \ms_riscv32_mp_instr_in[13] , \ms_riscv32_mp_instr_in[12] , \ms_riscv32_mp_instr_in[11] , 
     \ms_riscv32_mp_instr_in[10] , \ms_riscv32_mp_instr_in[9] , \ms_riscv32_mp_instr_in[8] , 
     \ms_riscv32_mp_instr_in[7] , \ms_riscv32_mp_instr_in[6] , \ms_riscv32_mp_instr_in[5] , 
     \ms_riscv32_mp_instr_in[4] , \ms_riscv32_mp_instr_in[3] , \ms_riscv32_mp_instr_in[2] , 
     \ms_riscv32_mp_instr_in[1] , \ms_riscv32_mp_instr_in[0] , ms_riscv32_mp_instr_hready_in, 
     \ms_riscv32_mp_data_in[31] , \ms_riscv32_mp_data_in[30] , \ms_riscv32_mp_data_in[29] , 
     \ms_riscv32_mp_data_in[28] , \ms_riscv32_mp_data_in[27] , \ms_riscv32_mp_data_in[26] , 
     \ms_riscv32_mp_data_in[25] , \ms_riscv32_mp_data_in[24] , \ms_riscv32_mp_data_in[23] , 
     \ms_riscv32_mp_data_in[22] , \ms_riscv32_mp_data_in[21] , \ms_riscv32_mp_data_in[20] , 
     \ms_riscv32_mp_data_in[19] , \ms_riscv32_mp_data_in[18] , \ms_riscv32_mp_data_in[17] , 
     \ms_riscv32_mp_data_in[16] , \ms_riscv32_mp_data_in[15] , \ms_riscv32_mp_data_in[14] , 
     \ms_riscv32_mp_data_in[13] , \ms_riscv32_mp_data_in[12] , \ms_riscv32_mp_data_in[11] , 
     \ms_riscv32_mp_data_in[10] , \ms_riscv32_mp_data_in[9] , \ms_riscv32_mp_data_in[8] , 
     \ms_riscv32_mp_data_in[7] , \ms_riscv32_mp_data_in[6] , \ms_riscv32_mp_data_in[5] , 
     \ms_riscv32_mp_data_in[4] , \ms_riscv32_mp_data_in[3] , \ms_riscv32_mp_data_in[2] , 
     \ms_riscv32_mp_data_in[1] , \ms_riscv32_mp_data_in[0] , ms_riscv32_mp_data_hready_in, 
     ms_riscv32_mp_hresp_in, ms_riscv32_mp_eirq_in, ms_riscv32_mp_tirq_in, 
     ms_riscv32_mp_sirq_in, tms_p, trst_p, tdi_p, tck_p, ms_riscv32_mp_clk_in_p, 
     scan_en, ramclk_p, control_chain_enable, control_chain_scan_in, 
     edt_clock, edt_update, edt_channel_in1_p, \ms_riscv32_mp_dmaddr_out[31] , 
     \ms_riscv32_mp_dmaddr_out[30] , \ms_riscv32_mp_dmaddr_out[29] , 
     \ms_riscv32_mp_dmaddr_out[28] , \ms_riscv32_mp_dmaddr_out[27] , 
     \ms_riscv32_mp_dmaddr_out[26] , \ms_riscv32_mp_dmaddr_out[25] , 
     \ms_riscv32_mp_dmaddr_out[24] , \ms_riscv32_mp_dmaddr_out[23] , 
     \ms_riscv32_mp_dmaddr_out[22] , \ms_riscv32_mp_dmaddr_out[21] , 
     \ms_riscv32_mp_dmaddr_out[20] , \ms_riscv32_mp_dmaddr_out[19] , 
     \ms_riscv32_mp_dmaddr_out[18] , \ms_riscv32_mp_dmaddr_out[17] , 
     \ms_riscv32_mp_dmaddr_out[16] , \ms_riscv32_mp_dmaddr_out[15] , 
     \ms_riscv32_mp_dmaddr_out[14] , \ms_riscv32_mp_dmaddr_out[13] , 
     \ms_riscv32_mp_dmaddr_out[12] , \ms_riscv32_mp_dmaddr_out[11] , 
     \ms_riscv32_mp_dmaddr_out[10] , \ms_riscv32_mp_dmaddr_out[9] , 
     \ms_riscv32_mp_dmaddr_out[8] , \ms_riscv32_mp_dmaddr_out[7] , 
     \ms_riscv32_mp_dmaddr_out[6] , \ms_riscv32_mp_dmaddr_out[5] , 
     \ms_riscv32_mp_dmaddr_out[4] , \ms_riscv32_mp_dmaddr_out[3] , 
     \ms_riscv32_mp_dmaddr_out[2] , \ms_riscv32_mp_dmaddr_out[1] , 
     \ms_riscv32_mp_dmaddr_out[0] , \ms_riscv32_mp_dmdata_out[31] , 
     \ms_riscv32_mp_dmdata_out[30] , \ms_riscv32_mp_dmdata_out[29] , 
     \ms_riscv32_mp_dmdata_out[28] , \ms_riscv32_mp_dmdata_out[27] , 
     \ms_riscv32_mp_dmdata_out[26] , \ms_riscv32_mp_dmdata_out[25] , 
     \ms_riscv32_mp_dmdata_out[24] , \ms_riscv32_mp_dmdata_out[23] , 
     \ms_riscv32_mp_dmdata_out[22] , \ms_riscv32_mp_dmdata_out[21] , 
     \ms_riscv32_mp_dmdata_out[20] , \ms_riscv32_mp_dmdata_out[19] , 
     \ms_riscv32_mp_dmdata_out[18] , \ms_riscv32_mp_dmdata_out[17] , 
     \ms_riscv32_mp_dmdata_out[16] , \ms_riscv32_mp_dmdata_out[15] , 
     \ms_riscv32_mp_dmdata_out[14] , \ms_riscv32_mp_dmdata_out[13] , 
     \ms_riscv32_mp_dmdata_out[12] , \ms_riscv32_mp_dmdata_out[11] , 
     \ms_riscv32_mp_dmdata_out[10] , \ms_riscv32_mp_dmdata_out[9] , 
     \ms_riscv32_mp_dmdata_out[8] , \ms_riscv32_mp_dmdata_out[7] , 
     \ms_riscv32_mp_dmdata_out[6] , \ms_riscv32_mp_dmdata_out[5] , 
     \ms_riscv32_mp_dmdata_out[4] , \ms_riscv32_mp_dmdata_out[3] , 
     \ms_riscv32_mp_dmdata_out[2] , \ms_riscv32_mp_dmdata_out[1] , 
     \ms_riscv32_mp_dmdata_out[0] , ms_riscv32_mp_dmwr_req_out, \ms_riscv32_mp_dmwr_mask_out[3] , 
     \ms_riscv32_mp_dmwr_mask_out[2] , \ms_riscv32_mp_dmwr_mask_out[1] , 
     \ms_riscv32_mp_dmwr_mask_out[0] , \ms_riscv32_mp_data_htrans_out[1] , 
     \ms_riscv32_mp_data_htrans_out[0] , tdo_p, control_chain_scan_out;

event       before_finish;
assign ms_riscv32_mp_clk_in = _ibus[147];
assign ms_riscv32_mp_rst_in = _ibus[146];
assign \ms_riscv32_mp_rc_in[63]  = _ibus[145];
assign \ms_riscv32_mp_rc_in[62]  = _ibus[144];
assign \ms_riscv32_mp_rc_in[61]  = _ibus[143];
assign \ms_riscv32_mp_rc_in[60]  = _ibus[142];
assign \ms_riscv32_mp_rc_in[59]  = _ibus[141];
assign \ms_riscv32_mp_rc_in[58]  = _ibus[140];
assign \ms_riscv32_mp_rc_in[57]  = _ibus[139];
assign \ms_riscv32_mp_rc_in[56]  = _ibus[138];
assign \ms_riscv32_mp_rc_in[55]  = _ibus[137];
assign \ms_riscv32_mp_rc_in[54]  = _ibus[136];
assign \ms_riscv32_mp_rc_in[53]  = _ibus[135];
assign \ms_riscv32_mp_rc_in[52]  = _ibus[134];
assign \ms_riscv32_mp_rc_in[51]  = _ibus[133];
assign \ms_riscv32_mp_rc_in[50]  = _ibus[132];
assign \ms_riscv32_mp_rc_in[49]  = _ibus[131];
assign \ms_riscv32_mp_rc_in[48]  = _ibus[130];
assign \ms_riscv32_mp_rc_in[47]  = _ibus[129];
assign \ms_riscv32_mp_rc_in[46]  = _ibus[128];
assign \ms_riscv32_mp_rc_in[45]  = _ibus[127];
assign \ms_riscv32_mp_rc_in[44]  = _ibus[126];
assign \ms_riscv32_mp_rc_in[43]  = _ibus[125];
assign \ms_riscv32_mp_rc_in[42]  = _ibus[124];
assign \ms_riscv32_mp_rc_in[41]  = _ibus[123];
assign \ms_riscv32_mp_rc_in[40]  = _ibus[122];
assign \ms_riscv32_mp_rc_in[39]  = _ibus[121];
assign \ms_riscv32_mp_rc_in[38]  = _ibus[120];
assign \ms_riscv32_mp_rc_in[37]  = _ibus[119];
assign \ms_riscv32_mp_rc_in[36]  = _ibus[118];
assign \ms_riscv32_mp_rc_in[35]  = _ibus[117];
assign \ms_riscv32_mp_rc_in[34]  = _ibus[116];
assign \ms_riscv32_mp_rc_in[33]  = _ibus[115];
assign \ms_riscv32_mp_rc_in[32]  = _ibus[114];
assign \ms_riscv32_mp_rc_in[31]  = _ibus[113];
assign \ms_riscv32_mp_rc_in[30]  = _ibus[112];
assign \ms_riscv32_mp_rc_in[29]  = _ibus[111];
assign \ms_riscv32_mp_rc_in[28]  = _ibus[110];
assign \ms_riscv32_mp_rc_in[27]  = _ibus[109];
assign \ms_riscv32_mp_rc_in[26]  = _ibus[108];
assign \ms_riscv32_mp_rc_in[25]  = _ibus[107];
assign \ms_riscv32_mp_rc_in[24]  = _ibus[106];
assign \ms_riscv32_mp_rc_in[23]  = _ibus[105];
assign \ms_riscv32_mp_rc_in[22]  = _ibus[104];
assign \ms_riscv32_mp_rc_in[21]  = _ibus[103];
assign \ms_riscv32_mp_rc_in[20]  = _ibus[102];
assign \ms_riscv32_mp_rc_in[19]  = _ibus[101];
assign \ms_riscv32_mp_rc_in[18]  = _ibus[100];
assign \ms_riscv32_mp_rc_in[17]  = _ibus[99];
assign \ms_riscv32_mp_rc_in[16]  = _ibus[98];
assign \ms_riscv32_mp_rc_in[15]  = _ibus[97];
assign \ms_riscv32_mp_rc_in[14]  = _ibus[96];
assign \ms_riscv32_mp_rc_in[13]  = _ibus[95];
assign \ms_riscv32_mp_rc_in[12]  = _ibus[94];
assign \ms_riscv32_mp_rc_in[11]  = _ibus[93];
assign \ms_riscv32_mp_rc_in[10]  = _ibus[92];
assign \ms_riscv32_mp_rc_in[9]  = _ibus[91];
assign \ms_riscv32_mp_rc_in[8]  = _ibus[90];
assign \ms_riscv32_mp_rc_in[7]  = _ibus[89];
assign \ms_riscv32_mp_rc_in[6]  = _ibus[88];
assign \ms_riscv32_mp_rc_in[5]  = _ibus[87];
assign \ms_riscv32_mp_rc_in[4]  = _ibus[86];
assign \ms_riscv32_mp_rc_in[3]  = _ibus[85];
assign \ms_riscv32_mp_rc_in[2]  = _ibus[84];
assign \ms_riscv32_mp_rc_in[1]  = _ibus[83];
assign \ms_riscv32_mp_rc_in[0]  = _ibus[82];
assign \ms_riscv32_mp_instr_in[31]  = _ibus[81];
assign \ms_riscv32_mp_instr_in[30]  = _ibus[80];
assign \ms_riscv32_mp_instr_in[29]  = _ibus[79];
assign \ms_riscv32_mp_instr_in[28]  = _ibus[78];
assign \ms_riscv32_mp_instr_in[27]  = _ibus[77];
assign \ms_riscv32_mp_instr_in[26]  = _ibus[76];
assign \ms_riscv32_mp_instr_in[25]  = _ibus[75];
assign \ms_riscv32_mp_instr_in[24]  = _ibus[74];
assign \ms_riscv32_mp_instr_in[23]  = _ibus[73];
assign \ms_riscv32_mp_instr_in[22]  = _ibus[72];
assign \ms_riscv32_mp_instr_in[21]  = _ibus[71];
assign \ms_riscv32_mp_instr_in[20]  = _ibus[70];
assign \ms_riscv32_mp_instr_in[19]  = _ibus[69];
assign \ms_riscv32_mp_instr_in[18]  = _ibus[68];
assign \ms_riscv32_mp_instr_in[17]  = _ibus[67];
assign \ms_riscv32_mp_instr_in[16]  = _ibus[66];
assign \ms_riscv32_mp_instr_in[15]  = _ibus[65];
assign \ms_riscv32_mp_instr_in[14]  = _ibus[64];
assign \ms_riscv32_mp_instr_in[13]  = _ibus[63];
assign \ms_riscv32_mp_instr_in[12]  = _ibus[62];
assign \ms_riscv32_mp_instr_in[11]  = _ibus[61];
assign \ms_riscv32_mp_instr_in[10]  = _ibus[60];
assign \ms_riscv32_mp_instr_in[9]  = _ibus[59];
assign \ms_riscv32_mp_instr_in[8]  = _ibus[58];
assign \ms_riscv32_mp_instr_in[7]  = _ibus[57];
assign \ms_riscv32_mp_instr_in[6]  = _ibus[56];
assign \ms_riscv32_mp_instr_in[5]  = _ibus[55];
assign \ms_riscv32_mp_instr_in[4]  = _ibus[54];
assign \ms_riscv32_mp_instr_in[3]  = _ibus[53];
assign \ms_riscv32_mp_instr_in[2]  = _ibus[52];
assign \ms_riscv32_mp_instr_in[1]  = _ibus[51];
assign \ms_riscv32_mp_instr_in[0]  = _ibus[50];
assign ms_riscv32_mp_instr_hready_in = _ibus[49];
assign \ms_riscv32_mp_data_in[31]  = _ibus[48];
assign \ms_riscv32_mp_data_in[30]  = _ibus[47];
assign \ms_riscv32_mp_data_in[29]  = _ibus[46];
assign \ms_riscv32_mp_data_in[28]  = _ibus[45];
assign \ms_riscv32_mp_data_in[27]  = _ibus[44];
assign \ms_riscv32_mp_data_in[26]  = _ibus[43];
assign \ms_riscv32_mp_data_in[25]  = _ibus[42];
assign \ms_riscv32_mp_data_in[24]  = _ibus[41];
assign \ms_riscv32_mp_data_in[23]  = _ibus[40];
assign \ms_riscv32_mp_data_in[22]  = _ibus[39];
assign \ms_riscv32_mp_data_in[21]  = _ibus[38];
assign \ms_riscv32_mp_data_in[20]  = _ibus[37];
assign \ms_riscv32_mp_data_in[19]  = _ibus[36];
assign \ms_riscv32_mp_data_in[18]  = _ibus[35];
assign \ms_riscv32_mp_data_in[17]  = _ibus[34];
assign \ms_riscv32_mp_data_in[16]  = _ibus[33];
assign \ms_riscv32_mp_data_in[15]  = _ibus[32];
assign \ms_riscv32_mp_data_in[14]  = _ibus[31];
assign \ms_riscv32_mp_data_in[13]  = _ibus[30];
assign \ms_riscv32_mp_data_in[12]  = _ibus[29];
assign \ms_riscv32_mp_data_in[11]  = _ibus[28];
assign \ms_riscv32_mp_data_in[10]  = _ibus[27];
assign \ms_riscv32_mp_data_in[9]  = _ibus[26];
assign \ms_riscv32_mp_data_in[8]  = _ibus[25];
assign \ms_riscv32_mp_data_in[7]  = _ibus[24];
assign \ms_riscv32_mp_data_in[6]  = _ibus[23];
assign \ms_riscv32_mp_data_in[5]  = _ibus[22];
assign \ms_riscv32_mp_data_in[4]  = _ibus[21];
assign \ms_riscv32_mp_data_in[3]  = _ibus[20];
assign \ms_riscv32_mp_data_in[2]  = _ibus[19];
assign \ms_riscv32_mp_data_in[1]  = _ibus[18];
assign \ms_riscv32_mp_data_in[0]  = _ibus[17];
assign ms_riscv32_mp_data_hready_in = _ibus[16];
assign ms_riscv32_mp_hresp_in = _ibus[15];
assign ms_riscv32_mp_eirq_in = _ibus[14];
assign ms_riscv32_mp_tirq_in = _ibus[13];
assign ms_riscv32_mp_sirq_in = _ibus[12];
assign tms_p = _ibus[11];
assign trst_p = _ibus[10];
assign tdi_p = _ibus[9];
assign tck_p = _ibus[8];
assign ms_riscv32_mp_clk_in_p = _ibus[7];
assign scan_en = _ibus[6];
assign ramclk_p = _ibus[5];
assign control_chain_enable = _ibus[4];
assign control_chain_scan_in = _ibus[3];
assign edt_clock = _ibus[2];
assign edt_update = _ibus[1];
assign edt_channel_in1_p = _ibus[0];

assign _sim_obus[72] = \ms_riscv32_mp_dmaddr_out[31] ;
assign _sim_obus[71] = \ms_riscv32_mp_dmaddr_out[30] ;
assign _sim_obus[70] = \ms_riscv32_mp_dmaddr_out[29] ;
assign _sim_obus[69] = \ms_riscv32_mp_dmaddr_out[28] ;
assign _sim_obus[68] = \ms_riscv32_mp_dmaddr_out[27] ;
assign _sim_obus[67] = \ms_riscv32_mp_dmaddr_out[26] ;
assign _sim_obus[66] = \ms_riscv32_mp_dmaddr_out[25] ;
assign _sim_obus[65] = \ms_riscv32_mp_dmaddr_out[24] ;
assign _sim_obus[64] = \ms_riscv32_mp_dmaddr_out[23] ;
assign _sim_obus[63] = \ms_riscv32_mp_dmaddr_out[22] ;
assign _sim_obus[62] = \ms_riscv32_mp_dmaddr_out[21] ;
assign _sim_obus[61] = \ms_riscv32_mp_dmaddr_out[20] ;
assign _sim_obus[60] = \ms_riscv32_mp_dmaddr_out[19] ;
assign _sim_obus[59] = \ms_riscv32_mp_dmaddr_out[18] ;
assign _sim_obus[58] = \ms_riscv32_mp_dmaddr_out[17] ;
assign _sim_obus[57] = \ms_riscv32_mp_dmaddr_out[16] ;
assign _sim_obus[56] = \ms_riscv32_mp_dmaddr_out[15] ;
assign _sim_obus[55] = \ms_riscv32_mp_dmaddr_out[14] ;
assign _sim_obus[54] = \ms_riscv32_mp_dmaddr_out[13] ;
assign _sim_obus[53] = \ms_riscv32_mp_dmaddr_out[12] ;
assign _sim_obus[52] = \ms_riscv32_mp_dmaddr_out[11] ;
assign _sim_obus[51] = \ms_riscv32_mp_dmaddr_out[10] ;
assign _sim_obus[50] = \ms_riscv32_mp_dmaddr_out[9] ;
assign _sim_obus[49] = \ms_riscv32_mp_dmaddr_out[8] ;
assign _sim_obus[48] = \ms_riscv32_mp_dmaddr_out[7] ;
assign _sim_obus[47] = \ms_riscv32_mp_dmaddr_out[6] ;
assign _sim_obus[46] = \ms_riscv32_mp_dmaddr_out[5] ;
assign _sim_obus[45] = \ms_riscv32_mp_dmaddr_out[4] ;
assign _sim_obus[44] = \ms_riscv32_mp_dmaddr_out[3] ;
assign _sim_obus[43] = \ms_riscv32_mp_dmaddr_out[2] ;
assign _sim_obus[42] = \ms_riscv32_mp_dmaddr_out[1] ;
assign _sim_obus[41] = \ms_riscv32_mp_dmaddr_out[0] ;
assign _sim_obus[40] = \ms_riscv32_mp_dmdata_out[31] ;
assign _sim_obus[39] = \ms_riscv32_mp_dmdata_out[30] ;
assign _sim_obus[38] = \ms_riscv32_mp_dmdata_out[29] ;
assign _sim_obus[37] = \ms_riscv32_mp_dmdata_out[28] ;
assign _sim_obus[36] = \ms_riscv32_mp_dmdata_out[27] ;
assign _sim_obus[35] = \ms_riscv32_mp_dmdata_out[26] ;
assign _sim_obus[34] = \ms_riscv32_mp_dmdata_out[25] ;
assign _sim_obus[33] = \ms_riscv32_mp_dmdata_out[24] ;
assign _sim_obus[32] = \ms_riscv32_mp_dmdata_out[23] ;
assign _sim_obus[31] = \ms_riscv32_mp_dmdata_out[22] ;
assign _sim_obus[30] = \ms_riscv32_mp_dmdata_out[21] ;
assign _sim_obus[29] = \ms_riscv32_mp_dmdata_out[20] ;
assign _sim_obus[28] = \ms_riscv32_mp_dmdata_out[19] ;
assign _sim_obus[27] = \ms_riscv32_mp_dmdata_out[18] ;
assign _sim_obus[26] = \ms_riscv32_mp_dmdata_out[17] ;
assign _sim_obus[25] = \ms_riscv32_mp_dmdata_out[16] ;
assign _sim_obus[24] = \ms_riscv32_mp_dmdata_out[15] ;
assign _sim_obus[23] = \ms_riscv32_mp_dmdata_out[14] ;
assign _sim_obus[22] = \ms_riscv32_mp_dmdata_out[13] ;
assign _sim_obus[21] = \ms_riscv32_mp_dmdata_out[12] ;
assign _sim_obus[20] = \ms_riscv32_mp_dmdata_out[11] ;
assign _sim_obus[19] = \ms_riscv32_mp_dmdata_out[10] ;
assign _sim_obus[18] = \ms_riscv32_mp_dmdata_out[9] ;
assign _sim_obus[17] = \ms_riscv32_mp_dmdata_out[8] ;
assign _sim_obus[16] = \ms_riscv32_mp_dmdata_out[7] ;
assign _sim_obus[15] = \ms_riscv32_mp_dmdata_out[6] ;
assign _sim_obus[14] = \ms_riscv32_mp_dmdata_out[5] ;
assign _sim_obus[13] = \ms_riscv32_mp_dmdata_out[4] ;
assign _sim_obus[12] = \ms_riscv32_mp_dmdata_out[3] ;
assign _sim_obus[11] = \ms_riscv32_mp_dmdata_out[2] ;
assign _sim_obus[10] = \ms_riscv32_mp_dmdata_out[1] ;
assign _sim_obus[9] = \ms_riscv32_mp_dmdata_out[0] ;
assign _sim_obus[8] = ms_riscv32_mp_dmwr_req_out;
assign _sim_obus[7] = \ms_riscv32_mp_dmwr_mask_out[3] ;
assign _sim_obus[6] = \ms_riscv32_mp_dmwr_mask_out[2] ;
assign _sim_obus[5] = \ms_riscv32_mp_dmwr_mask_out[1] ;
assign _sim_obus[4] = \ms_riscv32_mp_dmwr_mask_out[0] ;
assign _sim_obus[3] = \ms_riscv32_mp_data_htrans_out[1] ;
assign _sim_obus[2] = \ms_riscv32_mp_data_htrans_out[0] ;
assign _sim_obus[1] = tdo_p;
assign _sim_obus[0] = control_chain_scan_out;

// Change Path Variables & Get Argument 
integer      _change_path; 
integer      _change_out_path; 
reg[512*8:1]  _new_path; 
reg[512*8:1]  _new_out_path; 
reg[512*8:1]  _new_filename; 
reg[512*8:1]  _vcd_dump_file_name; 
reg[512*8:1]  _utvcd_dump_file_name; 
reg[512*8:1]  _fsdb_dump_file_name; 
reg[512*8:1]  _qwave_dump_file_name; 
reg[512*8:1]  _tmp_filename; 
initial begin 
  _change_path = 0; 
  _change_out_path = 0; 
  if ($value$plusargs("NEWPATH=%s", _new_path)) begin 
    $display("Found New Path %0s\n", _new_path); 
    _change_path = 1; 
  end 
  if ($value$plusargs("NEWOUTPATH=%s", _new_out_path)) begin 
    $display("Found New Out Path %0s\n", _new_out_path); 
    _change_out_path = 1; 
  end 

`ifdef VCD
    $sformat(_vcd_dump_file_name, "JtagBscanPatterns.v.dump");
    if(_change_out_path) begin 
      $sformat(_vcd_dump_file_name, "%0s/%0s", _new_out_path, _vcd_dump_file_name);
    end
    $dumpfile(_vcd_dump_file_name);
    $dumpvars;
`endif

`ifdef UTVCD
    $sformat(_utvcd_dump_file_name, "JtagBscanPatterns.v.dump");
    if(_change_out_path) begin 
      $sformat(_utvcd_dump_file_name, "%0s/%0s", _new_out_path, _utvcd_dump_file_name);
    end
    $dumpfile(_utvcd_dump_file_name);
    $vtDump;
    $dumpvars;
`endif

`ifdef debussy
    $sformat(_fsdb_dump_file_name, "JtagBscanPatterns.v.fsdb");
    if(_change_out_path) begin 
      $sformat(_fsdb_dump_file_name, "%0s/%0s", _new_out_path, _fsdb_dump_file_name);
    end
    $fsdbDumpfile(_fsdb_dump_file_name);
    $fsdbDumpvars;
`endif

`ifdef QWAVE
    $sformat(_qwave_dump_file_name, "JtagBscanPatterns.v.qwave.db");
    if(_change_out_path) begin 
      $sformat(_qwave_dump_file_name, "%0s/%0s", _new_out_path, _qwave_dump_file_name);
    end
    $qwavedb_dumpvars_filename(_qwave_dump_file_name);
    $qwavedb_dumpvars;
`endif
end 

reg /* sparse */[271:0] _nam_obus[72:0];
initial begin 
   if(_change_path) begin 
     $sformat(_new_filename,"%0s/JtagBscanPatterns.v.po.name",_new_path); 
     $display("Loading %0s\n", _new_filename ); 
     $readmemh(_new_filename,_nam_obus,72,0); 
   end 
   else begin
     $display("Loading JtagBscanPatterns.v.po.name");
     $readmemh("JtagBscanPatterns.v.po.name",_nam_obus,72,0);
   end 
end 


// Declare Wires for tracking Vector Type
reg[3:0] _MGCDFT_VECTYPE ;
reg[160:0] _procedure_string ;
reg mgcdft_test_setup, mgcdft_load_unload, mgcdft_shift,
     mgcdft_single_shift, mgcdft_shift_extra, 
     mgcdft_shadow_control, mgcdft_master_observe,
     mgcdft_shadow_observe, mgcdft_skew_load, 
     mgcdft_seq_transparent, mgcdft_launch_capture,
     mgcdft_clock_proc, mgcdft_test_end, mgcdft_unknown; 

event       set_vector_type;
always @(_MGCDFT_VECTYPE) begin
  assign mgcdft_test_setup      = 1'b0;
  assign mgcdft_load_unload     = 1'b0;
  assign mgcdft_shift           = 1'b0;
  assign mgcdft_single_shift    = 1'b0;
  assign mgcdft_shift_extra     = 1'b0;
  assign mgcdft_shadow_control  = 1'b0;
  assign mgcdft_master_observe  = 1'b0;
  assign mgcdft_shadow_observe  = 1'b0;
  assign mgcdft_skew_load       = 1'b0;
  assign mgcdft_seq_transparent = 1'b0;
  assign mgcdft_launch_capture  = 1'b0;
  assign mgcdft_clock_proc      = 1'b0;
  assign mgcdft_test_end        = 1'b0;
  assign mgcdft_unknown         = 1'b0;
  case (_MGCDFT_VECTYPE)
    4'b0001: begin
               assign mgcdft_test_setup      = 1'b1;
               _procedure_string = "TEST_SETUP";
               _scan_shift_count = 0;
             end
    4'b0010: begin
               assign mgcdft_load_unload     = 1'b1;
               _procedure_string = "LOAD";
               _scan_shift_count = 0;
             end
    4'b0011: begin
               assign mgcdft_shift           = 1'b1;
               _procedure_string = "SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0100: begin
               assign mgcdft_single_shift    = 1'b1;
               _procedure_string = "SINGLE_SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0101: begin
               assign mgcdft_shift_extra     = 1'b1;
               _procedure_string = "SHIFT_EXTRA";
               _scan_shift_count = 0;
             end
    4'b0110: begin
               assign mgcdft_shadow_control  = 1'b1;
               _procedure_string = "SHADOW_CONTROL";
               _scan_shift_count = 0;
             end
    4'b0111: begin
               assign mgcdft_master_observe  = 1'b1;
               _procedure_string = "MASTER_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1000: begin
               assign mgcdft_shadow_observe  = 1'b1;
               _procedure_string = "SHADOW_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1001: begin
               assign mgcdft_skew_load       = 1'b1;
               _procedure_string = "SKEW_LOAD";
               _scan_shift_count = 0;
             end
    4'b1010: begin
               assign mgcdft_seq_transparent = 1'b1;
               _procedure_string = "SEQ_TRANSPARENT";
               _scan_shift_count = 0;
             end
    4'b1011: begin
               assign mgcdft_launch_capture  = 1'b1;
               _procedure_string = "LAUNCH_CAPTURE";
               _scan_shift_count = 0;
             end
    4'b1101: begin
               assign mgcdft_clock_proc      = 1'b1;
               _procedure_string = "CLOCK_PROC";
               _scan_shift_count = 0;
             end
    4'b1111: begin
               assign mgcdft_test_end        = 1'b1;
               _procedure_string = "TEST_END";
               _scan_shift_count = 0;
             end
    4'b0000: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
    default: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
  endcase
end

function integer do_finish_summary;
input local_end_vec_file_ok;
integer local_end_vec_file_ok;
begin
  if (_end_vec_file_ok) begin
     $display("\nSimulation finished at time %.0f", $realtime);
     $display("Number of miscompares            = %d", _compare_fail_count);
     $display("Number of 0/1 compares           = %d", _compare_count);
     $display("Number of Z compares             = %d\n", _compare_z_count);
  end

  if ((_end_vec_file_ok) && (_compare_fail == 0) && (_compare_fail_count == 0)) begin
     $display("No error between simulated and expected patterns\n");
  end

  if ((_compare_fail != 0) || (_compare_fail_count != 0)) begin
     $display("Error between simulated and expected patterns\n");
  end

do_finish_summary = local_end_vec_file_ok;
end
endfunction


event       compare_exp_sim_obus;
always @(compare_exp_sim_obus) begin
 _found_fail = 0;
 if (_do_compare) begin
 for(_bit_count = 0;
     (_bit_count < 73);
      _bit_count =_bit_count +1) begin
   if (_msk_obus[_bit_count] === 1'b1) begin
     if (_exp_obus[_bit_count] === 1'bZ) begin
       _compare_z_count = _compare_z_count + 1;
     end
     else begin
       _compare_count = _compare_count + 1;
     end
   end
 end
  if (_exp_obus !== _sim_obus) begin
     for(_bit_count = 0;
         ((_bit_count < 73)&&(_found_fail==0));
          _bit_count =_bit_count +1) begin
        if ((_msk_obus[_bit_count] === 1'b1) &&
            (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
           _found_fail = 1;
           _found_fail_per_cycle = 1;
           _found_fail_obus[_bit_count] = 1'b1;
        end
     end
  end
  if (_found_fail == 1) begin
     for(_bit_count = 0;
         ((_bit_count < 73)&&((_miscompare_limit==0)||(_compare_fail<=_miscompare_limit)));
          _bit_count =_bit_count +1) begin
      if ((_msk_obus[_bit_count] === 1'b1) &&
          (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
        _compare_fail_count = _compare_fail_count + 1;
        _found_fail_obus[_bit_count] = 1'b1;
        $write($realtime, "ns: Mismatch at pin %d name %s, Simulated %b, Expected %b\n",_bit_count,_nam_obus[_bit_count],_sim_obus[_bit_count],_exp_obus[_bit_count]);
        if (_write_DIAG_file == 1) begin
          if (_DIAG_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v_%0d_%0d.fail",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v_%0d.fail",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v__%0d.fail",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v.fail");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _diag_file = $fopen(_tmp_filename);
            if (_diag_file == 0) begin
              $display("ERROR: Couldn't open .fail file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            if(_change_out_path) begin 
              $fwrite(_diag_file, "// This File is simulation generated (%0s/JtagBscanPatterns.v)\n", _new_out_path);
            end
            else begin
              $fwrite(_diag_file, "// This File is simulation generated (JtagBscanPatterns.v)\n");
            end
            $fwrite(_diag_file, "format cycle\n");
            $fwrite(_diag_file, " failures_begin\n");
            $fwrite(_diag_file, "//cycle_number  PO_name  expected_value  simulated_value  ");
            $fwrite(_diag_file, "pattern_id  chain_name  cell_number\n\n");
            _DIAG_file_header = 1;
          end
          if ((_pattern_count == _last_fail_pattern) && (_pattern_count == 0)) begin
             _fail_pattern_cnt = 1; 
          end
          if (_pattern_count > _last_fail_pattern) begin 
             _fail_pattern_cnt = _fail_pattern_cnt + 1;
             _last_fail_pattern = _pattern_count;
          end

          $fwrite(_diag_file, "%d  %s ", _cycle_count, _nam_obus[_bit_count]);
          case ( _exp_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, "            H"); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, "            L"); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, "            Z"); 
                  end
          endcase
          case ( _sim_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, " H  // Pattern %d ", _pattern_count); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, " L  // Pattern %d ", _pattern_count); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, " Z  // Pattern %d ", _pattern_count); 
                  end
            1'bX: begin
                    $fwrite(_diag_file, " X  // Pattern %d ", _pattern_count); 
                  end
          endcase
         if (_scan_shift_count == 0) begin
                 $fwrite(_diag_file, ", simulation_time=%.0f\n", $realtime);
         end // EndIf  _ScanShift_count
        end // EndIf _write_DIAG_file
        if (_write_MASK_file == 1) begin
          if (_MASK_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v_%0d_%0d.mask",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v_%0d.mask",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v__%0d.mask",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "JtagBscanPatterns.v.mask");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _mask_file = $fopen(_tmp_filename);
            if (_mask_file == 0) begin
              $display("ERROR: Couldn't open .mask file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            $fwrite(_mask_file, "%s\n%s\n", "type mask", "");
            _MASK_file_header = 1;
          end
          if (_chain_test_ == 0) begin
            $fwrite(_mask_file, "%d %s\n", _pattern_count,_nam_obus[_bit_count]);
          end
          if (_chain_test_ == 1) begin
            $fwrite(_mask_file, "// %d %s\n", _pattern_count,_nam_obus[_bit_count]);
          end
        end
      end
    end
    _compare_fail = _compare_fail + 1;
  end
 end // if _do_compare
end

reg[302:0]     mem [0:442961];
msrv32_top DUT_inst (.ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in), 
     .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in), 
     .ms_riscv32_mp_rc_in({\ms_riscv32_mp_rc_in[63]  
     , \ms_riscv32_mp_rc_in[62] 
     , \ms_riscv32_mp_rc_in[61] 
     , \ms_riscv32_mp_rc_in[60] 
     , \ms_riscv32_mp_rc_in[59] 
     , \ms_riscv32_mp_rc_in[58] 
     , \ms_riscv32_mp_rc_in[57] 
     , \ms_riscv32_mp_rc_in[56] 
     , \ms_riscv32_mp_rc_in[55] 
     , \ms_riscv32_mp_rc_in[54] 
     , \ms_riscv32_mp_rc_in[53] 
     , \ms_riscv32_mp_rc_in[52] 
     , \ms_riscv32_mp_rc_in[51] 
     , \ms_riscv32_mp_rc_in[50] 
     , \ms_riscv32_mp_rc_in[49] 
     , \ms_riscv32_mp_rc_in[48] 
     , \ms_riscv32_mp_rc_in[47] 
     , \ms_riscv32_mp_rc_in[46] 
     , \ms_riscv32_mp_rc_in[45] 
     , \ms_riscv32_mp_rc_in[44] 
     , \ms_riscv32_mp_rc_in[43] 
     , \ms_riscv32_mp_rc_in[42] 
     , \ms_riscv32_mp_rc_in[41] 
     , \ms_riscv32_mp_rc_in[40] 
     , \ms_riscv32_mp_rc_in[39] 
     , \ms_riscv32_mp_rc_in[38] 
     , \ms_riscv32_mp_rc_in[37] 
     , \ms_riscv32_mp_rc_in[36] 
     , \ms_riscv32_mp_rc_in[35] 
     , \ms_riscv32_mp_rc_in[34] 
     , \ms_riscv32_mp_rc_in[33] 
     , \ms_riscv32_mp_rc_in[32] 
     , \ms_riscv32_mp_rc_in[31] 
     , \ms_riscv32_mp_rc_in[30] 
     , \ms_riscv32_mp_rc_in[29] 
     , \ms_riscv32_mp_rc_in[28] 
     , \ms_riscv32_mp_rc_in[27] 
     , \ms_riscv32_mp_rc_in[26] 
     , \ms_riscv32_mp_rc_in[25] 
     , \ms_riscv32_mp_rc_in[24] 
     , \ms_riscv32_mp_rc_in[23] 
     , \ms_riscv32_mp_rc_in[22] 
     , \ms_riscv32_mp_rc_in[21] 
     , \ms_riscv32_mp_rc_in[20] 
     , \ms_riscv32_mp_rc_in[19] 
     , \ms_riscv32_mp_rc_in[18] 
     , \ms_riscv32_mp_rc_in[17] 
     , \ms_riscv32_mp_rc_in[16] 
     , \ms_riscv32_mp_rc_in[15] 
     , \ms_riscv32_mp_rc_in[14] 
     , \ms_riscv32_mp_rc_in[13] 
     , \ms_riscv32_mp_rc_in[12] 
     , \ms_riscv32_mp_rc_in[11] 
     , \ms_riscv32_mp_rc_in[10] 
     , \ms_riscv32_mp_rc_in[9] 
     , \ms_riscv32_mp_rc_in[8] 
     , \ms_riscv32_mp_rc_in[7] 
     , \ms_riscv32_mp_rc_in[6] 
     , \ms_riscv32_mp_rc_in[5] 
     , \ms_riscv32_mp_rc_in[4] 
     , \ms_riscv32_mp_rc_in[3] 
     , \ms_riscv32_mp_rc_in[2] 
     , \ms_riscv32_mp_rc_in[1] 
     , \ms_riscv32_mp_rc_in[0] 
     }),.ms_riscv32_mp_instr_in({\ms_riscv32_mp_instr_in[31]  
     , \ms_riscv32_mp_instr_in[30] 
     , \ms_riscv32_mp_instr_in[29] 
     , \ms_riscv32_mp_instr_in[28] 
     , \ms_riscv32_mp_instr_in[27] 
     , \ms_riscv32_mp_instr_in[26] 
     , \ms_riscv32_mp_instr_in[25] 
     , \ms_riscv32_mp_instr_in[24] 
     , \ms_riscv32_mp_instr_in[23] 
     , \ms_riscv32_mp_instr_in[22] 
     , \ms_riscv32_mp_instr_in[21] 
     , \ms_riscv32_mp_instr_in[20] 
     , \ms_riscv32_mp_instr_in[19] 
     , \ms_riscv32_mp_instr_in[18] 
     , \ms_riscv32_mp_instr_in[17] 
     , \ms_riscv32_mp_instr_in[16] 
     , \ms_riscv32_mp_instr_in[15] 
     , \ms_riscv32_mp_instr_in[14] 
     , \ms_riscv32_mp_instr_in[13] 
     , \ms_riscv32_mp_instr_in[12] 
     , \ms_riscv32_mp_instr_in[11] 
     , \ms_riscv32_mp_instr_in[10] 
     , \ms_riscv32_mp_instr_in[9] 
     , \ms_riscv32_mp_instr_in[8] 
     , \ms_riscv32_mp_instr_in[7] 
     , \ms_riscv32_mp_instr_in[6] 
     , \ms_riscv32_mp_instr_in[5] 
     , \ms_riscv32_mp_instr_in[4] 
     , \ms_riscv32_mp_instr_in[3] 
     , \ms_riscv32_mp_instr_in[2] 
     , \ms_riscv32_mp_instr_in[1] 
     , \ms_riscv32_mp_instr_in[0] 
      }), .ms_riscv32_mp_instr_hready_in(ms_riscv32_mp_instr_hready_in), 
     .ms_riscv32_mp_data_in({\ms_riscv32_mp_data_in[31]  
     , \ms_riscv32_mp_data_in[30] 
     , \ms_riscv32_mp_data_in[29] 
     , \ms_riscv32_mp_data_in[28] 
     , \ms_riscv32_mp_data_in[27] 
     , \ms_riscv32_mp_data_in[26] 
     , \ms_riscv32_mp_data_in[25] 
     , \ms_riscv32_mp_data_in[24] 
     , \ms_riscv32_mp_data_in[23] 
     , \ms_riscv32_mp_data_in[22] 
     , \ms_riscv32_mp_data_in[21] 
     , \ms_riscv32_mp_data_in[20] 
     , \ms_riscv32_mp_data_in[19] 
     , \ms_riscv32_mp_data_in[18] 
     , \ms_riscv32_mp_data_in[17] 
     , \ms_riscv32_mp_data_in[16] 
     , \ms_riscv32_mp_data_in[15] 
     , \ms_riscv32_mp_data_in[14] 
     , \ms_riscv32_mp_data_in[13] 
     , \ms_riscv32_mp_data_in[12] 
     , \ms_riscv32_mp_data_in[11] 
     , \ms_riscv32_mp_data_in[10] 
     , \ms_riscv32_mp_data_in[9] 
     , \ms_riscv32_mp_data_in[8] 
     , \ms_riscv32_mp_data_in[7] 
     , \ms_riscv32_mp_data_in[6] 
     , \ms_riscv32_mp_data_in[5] 
     , \ms_riscv32_mp_data_in[4] 
     , \ms_riscv32_mp_data_in[3] 
     , \ms_riscv32_mp_data_in[2] 
     , \ms_riscv32_mp_data_in[1] 
     , \ms_riscv32_mp_data_in[0] 
      }), .ms_riscv32_mp_data_hready_in(ms_riscv32_mp_data_hready_in), 
     .ms_riscv32_mp_hresp_in(ms_riscv32_mp_hresp_in), 
     .ms_riscv32_mp_eirq_in(ms_riscv32_mp_eirq_in), 
     .ms_riscv32_mp_tirq_in(ms_riscv32_mp_tirq_in), 
     .ms_riscv32_mp_sirq_in(ms_riscv32_mp_sirq_in), 
     .tms_p(tms_p), .trst_p(trst_p), .tdi_p(tdi_p), 
     .tck_p(tck_p), 
     .ms_riscv32_mp_clk_in_p(ms_riscv32_mp_clk_in_p), 
     .scan_en(scan_en), .ramclk_p(ramclk_p), 
     .control_chain_enable(control_chain_enable), 
     .control_chain_scan_in(control_chain_scan_in), 
     .edt_clock(edt_clock), .edt_update(edt_update), 
     .edt_channel_in1_p(edt_channel_in1_p), 
     .ms_riscv32_mp_dmaddr_out({\ms_riscv32_mp_dmaddr_out[31] 
     , \ms_riscv32_mp_dmaddr_out[30] 
     , \ms_riscv32_mp_dmaddr_out[29] 
     , \ms_riscv32_mp_dmaddr_out[28] 
     , \ms_riscv32_mp_dmaddr_out[27] 
     , \ms_riscv32_mp_dmaddr_out[26] 
     , \ms_riscv32_mp_dmaddr_out[25] 
     , \ms_riscv32_mp_dmaddr_out[24] 
     , \ms_riscv32_mp_dmaddr_out[23] 
     , \ms_riscv32_mp_dmaddr_out[22] 
     , \ms_riscv32_mp_dmaddr_out[21] 
     , \ms_riscv32_mp_dmaddr_out[20] 
     , \ms_riscv32_mp_dmaddr_out[19] 
     , \ms_riscv32_mp_dmaddr_out[18] 
     , \ms_riscv32_mp_dmaddr_out[17] 
     , \ms_riscv32_mp_dmaddr_out[16] 
     , \ms_riscv32_mp_dmaddr_out[15] 
     , \ms_riscv32_mp_dmaddr_out[14] 
     , \ms_riscv32_mp_dmaddr_out[13] 
     , \ms_riscv32_mp_dmaddr_out[12] 
     , \ms_riscv32_mp_dmaddr_out[11] 
     , \ms_riscv32_mp_dmaddr_out[10] 
     , \ms_riscv32_mp_dmaddr_out[9] 
     , \ms_riscv32_mp_dmaddr_out[8] 
     , \ms_riscv32_mp_dmaddr_out[7] 
     , \ms_riscv32_mp_dmaddr_out[6] 
     , \ms_riscv32_mp_dmaddr_out[5] 
     , \ms_riscv32_mp_dmaddr_out[4] 
     , \ms_riscv32_mp_dmaddr_out[3] 
     , \ms_riscv32_mp_dmaddr_out[2] 
     , \ms_riscv32_mp_dmaddr_out[1] 
     , \ms_riscv32_mp_dmaddr_out[0] 
     }), .ms_riscv32_mp_dmdata_out({\ms_riscv32_mp_dmdata_out[31] 
     , \ms_riscv32_mp_dmdata_out[30] 
     , \ms_riscv32_mp_dmdata_out[29] 
     , \ms_riscv32_mp_dmdata_out[28] 
     , \ms_riscv32_mp_dmdata_out[27] 
     , \ms_riscv32_mp_dmdata_out[26] 
     , \ms_riscv32_mp_dmdata_out[25] 
     , \ms_riscv32_mp_dmdata_out[24] 
     , \ms_riscv32_mp_dmdata_out[23] 
     , \ms_riscv32_mp_dmdata_out[22] 
     , \ms_riscv32_mp_dmdata_out[21] 
     , \ms_riscv32_mp_dmdata_out[20] 
     , \ms_riscv32_mp_dmdata_out[19] 
     , \ms_riscv32_mp_dmdata_out[18] 
     , \ms_riscv32_mp_dmdata_out[17] 
     , \ms_riscv32_mp_dmdata_out[16] 
     , \ms_riscv32_mp_dmdata_out[15] 
     , \ms_riscv32_mp_dmdata_out[14] 
     , \ms_riscv32_mp_dmdata_out[13] 
     , \ms_riscv32_mp_dmdata_out[12] 
     , \ms_riscv32_mp_dmdata_out[11] 
     , \ms_riscv32_mp_dmdata_out[10] 
     , \ms_riscv32_mp_dmdata_out[9] 
     , \ms_riscv32_mp_dmdata_out[8] 
     , \ms_riscv32_mp_dmdata_out[7] 
     , \ms_riscv32_mp_dmdata_out[6] 
     , \ms_riscv32_mp_dmdata_out[5] 
     , \ms_riscv32_mp_dmdata_out[4] 
     , \ms_riscv32_mp_dmdata_out[3] 
     , \ms_riscv32_mp_dmdata_out[2] 
     , \ms_riscv32_mp_dmdata_out[1] 
     , \ms_riscv32_mp_dmdata_out[0] 
     }), .ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out), 
     .ms_riscv32_mp_dmwr_mask_out({\ms_riscv32_mp_dmwr_mask_out[3] 
     , \ms_riscv32_mp_dmwr_mask_out[2] 
     , \ms_riscv32_mp_dmwr_mask_out[1] 
     , \ms_riscv32_mp_dmwr_mask_out[0] 
     }), .ms_riscv32_mp_data_htrans_out({\ms_riscv32_mp_data_htrans_out[1] 
     , \ms_riscv32_mp_data_htrans_out[0] }), .tdo_p(tdo_p), 
     .control_chain_scan_out(control_chain_scan_out));

initial begin
_in_restart = 0;
while (_in_restart < 2) begin
_in_restart = _in_restart + 1;
_restart_state     = -1;
if ($value$plusargs("RESTART=%d", _restart_state)) begin
  $display(" Found RESTART   %d", _restart_state);
end

if ((_in_restart < 2) || (_restart_state == 1)) begin
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
if (_restart_state == 1) begin
  #0;
  mgcdft_restart_signal = 1'b1;
//  $display("Reading checkpoint JtagBscanPatterns.v.dat");
//  $restart("JtagBscanPatterns.v.dat");
end

#0;
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
_compare_fail = 0;
_compare_fail_count = 0;
_compare_count = 0;
_compare_z_count = 0;
_pattern_count = 0;
_cycle_count = 0;
_save_cycle_count = 0;
_write_DIAG_file = 0; // change to 1, to generate file
_write_MASK_file = 0; // change to 1, to generate file
_DIAG_file_header = 0;
_diag_file = 0;
_diag_chain_header = 0;
_diag_scan_header = 0;
_fail_pattern_cnt = 0;
_last_fail_pattern = 0;
_MASK_file_header = 0;
_mask_file = 0;
_chain_test_ = 0;
_par_shift_cnt = 0;
_report_bit_cnt = 0;
// Limit # of miscompares before aborting simulation (non-zero)
_miscompare_limit = 0; 
_end_vec_file_ok = 0; 
_scan_shift_count = 0;
_run_testsetup  = 0;
_in_testsetup = 0;
_start_pat      = -1;
_end_pat        = -1;
_end_after_setup = -1;
_no_setup       = -1;
_save_state     = -1;
_override_cfg   = 0;
_pat_num        = -1;
_in_range       = 1;
_do_compare     = 1;
_in_chaintest   = 0;

_skipped_patterns = 0;

_end_simulation   = 0;

if ($value$plusargs("STARTPAT=%d", _start_pat)) begin
  if (_start_pat > -1) begin
    $display(" Found Start pattern number %d", _start_pat);
    _in_range = 0;
    _do_compare = 0;
  end
  else begin
    $display(" Ignoring negative Start pattern number   %d", _start_pat);
    _start_pat = -1;
  end
end
if ($value$plusargs("ENDPAT=%d", _end_pat)) begin
  if (_end_pat > -1) begin
    $display(" Found End pattern number   %d", _end_pat);
  end
  else begin
    $display(" Ignoring negative End pattern number   %d", _end_pat);
    _end_pat = -1;
  end
end

if ($value$plusargs("CHAINTEST=%d", _in_chaintest)) begin
  if (_in_chaintest) begin
    $display(" Found ChainTest identifier %d", _in_chaintest);
  end
end

if ($value$plusargs("END_AFTER_SETUP=%d", _end_after_setup)) begin
  $display(" Found End after setup   %d", _end_after_setup);
  if (_end_after_setup > 0) begin
    _end_pat = 0;
    _in_chaintest = 1;
  end
end

if ($value$plusargs("SKIP_SETUP=%d", _no_setup)) begin
  $display(" Found Skip setup   %d", _no_setup);
  if (_no_setup > 0) begin
    if (_start_pat == -1) begin
      _start_pat = 0;
      _in_chaintest = 1;
    end
    if (_in_chaintest == 1) begin
      _chain_test_ = 1;
    end
    _run_testsetup = 0;
    _in_range = 0;
    _do_compare = 0;
  end
end

if ($value$plusargs("SAVE=%d", _save_state)) begin
  $display(" Found SAVE   %d", _save_state);
end

if ($value$plusargs("CONFIG=%0s", _cfg_file_name)) begin
  $display(" Found CONFIG identifier   %0s", _cfg_file_name);
  _override_cfg = 1;
end
else begin
  _cfg_file_name = "JtagBscanPatterns.v.cfg";
end

if ((_end_pat != -1) && (_end_pat < _start_pat)) begin
  _start_pat = -1;
  _in_range = 1;
  _do_compare = 1;
  $display("STARTPAT less than ENDPAT, ignoring STARTPAT ");
end

// read vector config file
if(_override_cfg) begin 
  _config_file = $fopen(_cfg_file_name, "r");
end
else begin
if(_change_path) begin 
  $sformat(_new_filename,"%0s/JtagBscanPatterns.v.cfg",_new_path); 
  _config_file = $fopen(_new_filename, "r");
end
else begin
  _config_file = $fopen("JtagBscanPatterns.v.cfg", "r");
end

end

if (_config_file == 0) begin
  $display("ERROR: Couldn't open configuration file, simulation aborted\n");
  ->before_finish;
  #0;
  $finish;
end
_fstat = 0;
if (_start_pat != -1) begin
  if (_no_setup > 0) begin
  $display("BEGIN pattern read loop  Skip test_setup\n");
  end
  else if (_in_chaintest == 0) begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start pattern (%d) End pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start pattern (%d) \n",
_start_pat);
    end
  end
  else begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start chain pattern (%d) End chain pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start chain pattern (%d)\n",
_start_pat);
    end
  end
end
else if (_end_pat != -1) begin
  if (_end_after_setup > 0) begin
  $display("BEGIN pattern read loop  End after test_setup\n");
  end
  else if (_in_chaintest == 0) begin
  $display("BEGIN pattern read loop  End pattern (%d)\n", _end_pat);
  end
  else begin
  $display("BEGIN pattern read loop  End chain pattern (%d)\n", _end_pat);
  end
end

// begin pattern read loop
while (!$feof(_config_file) && (!_end_simulation))
begin
         _fstat = $fscanf(_config_file, "%s", _vec_file_name);
         _fstat = $fscanf(_config_file, "%d", _max_index);
   if (_fstat != -1) begin
         _fstat = $fscanf(_config_file, "%d", _vec_pat_count);
         if (_fstat == -1) begin
           _vec_pat_count = -1;
         end
         // skip .vec file if _start_pat greater than this
         if ((_start_pat != -1) && !_in_range && (_vec_pat_count != -1) &&
             !_in_testsetup && !_in_chaintest &&
             ((_pat_num + _vec_pat_count) < _start_pat)) begin
           _max_index = -1;
           if (_chain_test_) begin
             _pattern_count = 0;
             _pat_num = 0;
           end
           _pat_num = _pat_num + _vec_pat_count;
           _skipped_patterns = _skipped_patterns + _vec_pat_count;
           _end_vec_file_ok = 1;
           _chain_test_ = 0;
            $display("Skipping %0s\n", _vec_file_name);
         end
         else begin
          if(_change_path) begin 
            $sformat(_new_filename,"%0s/%0s",_new_path, _vec_file_name); 
            $display("Loading %0s\n", _new_filename ); 
            $readmemb(_new_filename, mem, 0, _max_index);
         end
         else begin
           $display("Loading %0s\n", _vec_file_name);
           $readmemb(_vec_file_name, mem, 0, _max_index);
         end
           _end_vec_file_ok = 0;
         end
   end
   else begin
     _max_index = -1;
     _vec_pat_count = -1;
   end
   _scan_index = 0;
   _repeat_count_nest[0] = 0;
   _repeat_count = 0;
   _repeat_depth = 0;
   _message_index = 0;
   _save_index[0] = 0;
   _found_fail_obus =73'b0000000000000000000000000000000000000000000000000000000000000000000000000;
   for (_index=0; _index <= _max_index; _index = _index+1)
   begin
      vect = mem[_index];
      _exp_obus=73'bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
      _msk_obus=73'b0000000000000000000000000000000000000000000000000000000000000000000000000;
      _MGCDFT_VECTYPE = vect[3:0];
      _pat_type = vect[6:4];
      _tp_num = vect[7];
      //    Range Check
      if ((_start_pat != -1) && ((_start_pat != 0) || (!_in_testsetup)) &&
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
        if (!_chain_test_ && _in_chaintest && !_in_range && !_in_testsetup) begin
          _in_range = 1;
          _do_compare = 1;
        end
        if ((_pat_num == _start_pat) && !_in_range) begin
          _in_range = 1;
          _do_compare = 0;
          _pattern_count = (_pat_num - 1);
          if (_pattern_count < 0) begin
            _pattern_count = 0;
          end
        end
        if (_pat_num == (_start_pat + 1)) begin
          _do_compare = 1;
        end
      end

      if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_end_pat != -1) && !_chain_test_ && _in_chaintest &&
          !_run_testsetup) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_in_range) || (_run_testsetup)) begin
      case (_pat_type)
         3'b000:  begin // end vector
            _index = _max_index + 1;
         end // end vector
         3'b001: ;// skip scan vector, handled by shift vector
         3'b010:  begin // broadside vector
            _found_fail_per_cycle = 0;
            _found_fail_obus =73'b0000000000000000000000000000000000000000000000000000000000000000000000000;
            if (vect[8] == 1'b1) begin
               _pattern_count = _pattern_count + 1;
               _par_shift_cnt = 0;
              if ((!_do_compare) && (_pattern_count >= _start_pat)) begin
                _do_compare = 1;
              end
              if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
                  ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
                // simulation complete, exit
                _index = _max_index + 1;
                _end_vec_file_ok = 1;
                _end_simulation = 1;
                _in_range = 0;
              end
            end
            if (vect[8] === 1'bz) begin
               _pattern_count = 0;
               _par_shift_cnt = 0;
            end
            if(_scan_shift_count) begin
               _scan_shift_count = _scan_shift_count + 1;
            end
            case (_tp_num)
               1'b1: begin // timeplate 1 - gen_tp1
                  _ibus[8] = 1'b0;
                  _ibus[147:9] = vect[302:164];
                  _ibus[7:0] = vect[162:155];

                  #24; // 24 ns
                  _exp_obus[72:0] = vect[154:82];
                  _msk_obus[72:0] = vect[81:9];
                  #0;
                  ->compare_exp_sim_obus;
                  if ((_miscompare_limit)&&(_compare_fail>=_miscompare_limit)) begin
                    $display("ERROR: exceeded miscompare limit(%d), exiting simulation",_miscompare_limit);
                    _end_vec_file_ok = 1;
                    if (_DIAG_file_header == 1) begin
                       if (_diag_scan_header==1) begin
                         $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                       end
                       $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
                       $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
                       $fwrite(_diag_file, "failure_file_end\n");
                       $fclose(_diag_file);
                    end
                    _end_vec_file_ok = do_finish_summary(_end_vec_file_ok);
                    ->before_finish;
                    #0;
                    $finish;
                  end

                  #1; // 25 ns
                  _ibus[8] = vect[163];

                  #50; // 75 ns
                  _ibus[8] = 1'b0;

                  #25; // 100 ns
               end // timeplate 1 - gen_tp1
               default: begin
                  $display("ERROR: corrupt timeplate number\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _tp_num
            _cycle_count = _cycle_count + 1;
            _par_shift_cnt = 0;
         end // broadside vector
         3'b011:  begin // status message vector
            _message_index = vect[38:7];
            case (_message_index)
               0: begin
                  $display("Begin chain test\n");
                 _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                 _chain_test_ = 0;
                  if (_diag_chain_header) begin
                    $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                  end
                  _diag_scan_header = 0;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = -1;
                  _pattern_count = 0;
                  $display("End chain test\n");
               end
               2: begin
                  $display("Status update: simulated through pattern %d\n",_pattern_count);
               end
               3: begin
                  _end_vec_file_ok = 1;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (!_chain_test_) begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (_chain_test_) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                      end
                      else begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               20: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__test_logic_reset");
               end
               21: begin
                  $display($realtime, "ns:  ");
               end
               22: begin
                  $display($realtime, "ns:  ****************************************************************");
               end
               23: begin
                  $display($realtime, "ns:   test_logic_reset test");
               end
               24: begin
                  $display($realtime, "ns:   * Reset the TAP by pulsing trst_p to 1-0-1");
               end
               25: begin
                  $display($realtime, "ns:   * Check if RESET succeeded by shifting through the BYPASS register");
               end
               26: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.bypass ");
                  end
               end
               27: begin
                  $display($realtime, "ns:   * Pre-Load IR with instruction PRELOAD, which differs from the expected post-reset IR instruction");
               end
               28: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[0] ");
                  end
               end
               29: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[1] ");
                  end
               end
               30: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[2] ");
                  end
               end
               31: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[3] ");
                  end
               end
               32: begin
                  $display($realtime, "ns:   * Reset the TAP by setting tms_p=1 for 5 tck_p cycles.");
               end
               33: begin
                  $display($realtime, "ns:  End of the test_logic_reset test");
               end
               34: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__inst_reg");
               end
               35: begin
                  $display($realtime, "ns:   inst_reg test");
               end
               36: begin
                  $display($realtime, "ns:   * Verify that the TAP FSM can skip the IRSHIFT state via");
               end
               37: begin
                  $display($realtime, "ns:     IDLE -> DRSELECT -> IRSELECT -> IRCAPTURE -> IREXIT1 -> IRPAUSE");
               end
               38: begin
                  $display($realtime, "ns:   * Load TDI with a walking one pattern ...000001.");
               end
               39: begin
                  $display($realtime, "ns:   * Compare TDO with the capture value 0001.");
               end
               40: begin
                  $display($realtime, "ns:   * End shifting in IRPAUSE state");
               end
               41: begin
                  $display($realtime, "ns:   * Load    TDI with a walking zero pattern ...111110.");
               end
               42: begin
                  $display($realtime, "ns:   * Compare TDO with a walking one  pattern ...000001.");
               end
               43: begin
                  $display($realtime, "ns:   * Load    TDI with the BYPASS instruction.");
               end
               44: begin
                  $display($realtime, "ns:   * Compare TDO with a walking zero pattern ...111110.");
               end
               45: begin
                  $display($realtime, "ns:   * End shifting on IDLE state");
               end
               46: begin
                  $display($realtime, "ns:  End of the inst_reg test");
               end
               47: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__bypass_reg");
               end
               48: begin
                  $display($realtime, "ns:   bypass_reg test");
               end
               49: begin
                  $display($realtime, "ns:   * Load Instruction Register with BYPASS instruction: 1111.");
               end
               50: begin
                  $display($realtime, "ns:   * Verify that the TAP FSM can skip the SHIFT-DR state via:");
               end
               51: begin
                  $display($realtime, "ns:     IDLE -> SELECT-DR -> CAPTURE-DR -> EXIT1-DR -> PAUSE-DR");
               end
               52: begin
                  $display($realtime, "ns:   * Load BYPASS register with a logic one.");
               end
               53: begin
                  $display($realtime, "ns:   * Compare BYPASS captured value with the standard-imposed value of logic zero.");
               end
               54: begin
                  $display($realtime, "ns:   * End shifting in PAUSE-DR state");
               end
               55: begin
                  $display($realtime, "ns:   * Load BYPASS register with a zero (Skipping capture-DR state).");
               end
               56: begin
                  $display($realtime, "ns:   * Compare TDO with previous scanned-in value of one.");
               end
               57: begin
                  $display($realtime, "ns:   * Verify that the TAP FSM can skip the IDLE state between two DR-STATES, via:");
               end
               58: begin
                  $display($realtime, "ns:     PAUSE-DR -> EXIT2-DR -> UPDATE-DR -> SELECT-DR -> CAPTURE-DR -> EXIT1-DR -> PAUSE-DR.");
               end
               59: begin
                  $display($realtime, "ns:   * End shifting in IDLE state");
               end
               60: begin
                  $display($realtime, "ns:  End of the bypass_reg test");
               end
               61: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__bscan_reg");
               end
               62: begin
                  $display($realtime, "ns:   bscan_reg test");
               end
               63: begin
                  $display($realtime, "ns:   * Loading TAP Instruction Register with PRELOAD instruction.");
               end
               64: begin
                  $display($realtime, "ns:   * Load bscan with a walking one pattern ...000001.");
               end
               65: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[0]");
                    $display($realtime, "ns: Corresponding design object:  edt_channel_in1_p");
                  end
               end
               66: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[1]");
                    $display($realtime, "ns: Corresponding design object:  edt_update");
                  end
               end
               67: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[2]");
                    $display($realtime, "ns: Corresponding design object:  control_chain_scan_out");
                  end
               end
               68: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[3]");
                    $display($realtime, "ns: Corresponding design object:  edt_clock");
                  end
               end
               69: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[4]");
                    $display($realtime, "ns: Corresponding design object:  control_chain_scan_in");
                  end
               end
               70: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[5]");
                    $display($realtime, "ns: Corresponding design object:  control_chain_enable");
                  end
               end
               71: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[6]");
                    $display($realtime, "ns: Corresponding design object:  ramclk_p");
                  end
               end
               72: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[7]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_clk_in_p");
                  end
               end
               73: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[8]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_sirq_in");
                  end
               end
               74: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[9]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_tirq_in");
                  end
               end
               75: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[10]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_eirq_in");
                  end
               end
               76: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[11]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_htrans_out(0)");
                  end
               end
               77: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[12]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_htrans_out(1)");
                  end
               end
               78: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[13]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_hresp_in");
                  end
               end
               79: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[14]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_hready_in");
                  end
               end
               80: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[15]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(0)");
                  end
               end
               81: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[16]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(1)");
                  end
               end
               82: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[17]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(2)");
                  end
               end
               83: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[18]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(3)");
                  end
               end
               84: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[19]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(4)");
                  end
               end
               85: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[20]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(5)");
                  end
               end
               86: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[21]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(6)");
                  end
               end
               87: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[22]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(7)");
                  end
               end
               88: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[23]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(8)");
                  end
               end
               89: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[24]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(9)");
                  end
               end
               90: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[25]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(10)");
                  end
               end
               91: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[26]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(11)");
                  end
               end
               92: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[27]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(12)");
                  end
               end
               93: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[28]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(13)");
                  end
               end
               94: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[29]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(14)");
                  end
               end
               95: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[30]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(15)");
                  end
               end
               96: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[31]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(16)");
                  end
               end
               97: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[32]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(17)");
                  end
               end
               98: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[33]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(18)");
                  end
               end
               99: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[34]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(19)");
                  end
               end
               100: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[35]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(20)");
                  end
               end
               101: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[36]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(21)");
                  end
               end
               102: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[37]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(22)");
                  end
               end
               103: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[38]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(23)");
                  end
               end
               104: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[39]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(24)");
                  end
               end
               105: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[40]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(25)");
                  end
               end
               106: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[41]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(26)");
                  end
               end
               107: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[42]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(27)");
                  end
               end
               108: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[43]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(28)");
                  end
               end
               109: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[44]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(29)");
                  end
               end
               110: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[45]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(30)");
                  end
               end
               111: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[46]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_data_in(31)");
                  end
               end
               112: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[47]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmwr_mask_out(0)");
                  end
               end
               113: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[48]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmwr_mask_out(1)");
                  end
               end
               114: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[49]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmwr_mask_out(2)");
                  end
               end
               115: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[50]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmwr_mask_out(3)");
                  end
               end
               116: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[51]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmwr_req_out");
                  end
               end
               117: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[52] ");
                  end
               end
               118: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[53]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(0)");
                  end
               end
               119: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[54]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(1)");
                  end
               end
               120: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[55]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(2)");
                  end
               end
               121: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[56]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(3)");
                  end
               end
               122: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[57]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(4)");
                  end
               end
               123: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[58]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(5)");
                  end
               end
               124: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[59]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(6)");
                  end
               end
               125: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[60]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(7)");
                  end
               end
               126: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[61]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(8)");
                  end
               end
               127: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[62]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(9)");
                  end
               end
               128: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[63]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(10)");
                  end
               end
               129: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[64]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(11)");
                  end
               end
               130: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[65]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(12)");
                  end
               end
               131: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[66]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(13)");
                  end
               end
               132: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[67]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(14)");
                  end
               end
               133: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[68]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(15)");
                  end
               end
               134: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[69] ");
                  end
               end
               135: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[70]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(16)");
                  end
               end
               136: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[71]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(17)");
                  end
               end
               137: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[72]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(18)");
                  end
               end
               138: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[73]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(19)");
                  end
               end
               139: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[74]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(20)");
                  end
               end
               140: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[75]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(21)");
                  end
               end
               141: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[76]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(22)");
                  end
               end
               142: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[77]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(23)");
                  end
               end
               143: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[78]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(24)");
                  end
               end
               144: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[79]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(25)");
                  end
               end
               145: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[80]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(26)");
                  end
               end
               146: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[81]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(27)");
                  end
               end
               147: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[82]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(28)");
                  end
               end
               148: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[83]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(29)");
                  end
               end
               149: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[84]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(30)");
                  end
               end
               150: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[85]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmdata_out(31)");
                  end
               end
               151: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[86] ");
                  end
               end
               152: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[87]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(0)");
                  end
               end
               153: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[88]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(1)");
                  end
               end
               154: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[89]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(2)");
                  end
               end
               155: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[90]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(3)");
                  end
               end
               156: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[91]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(4)");
                  end
               end
               157: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[92]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(5)");
                  end
               end
               158: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[93]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(6)");
                  end
               end
               159: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[94]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(7)");
                  end
               end
               160: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[95]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(8)");
                  end
               end
               161: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[96]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(9)");
                  end
               end
               162: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[97]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(10)");
                  end
               end
               163: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[98]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(11)");
                  end
               end
               164: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[99]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(12)");
                  end
               end
               165: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[100]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(13)");
                  end
               end
               166: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[101]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(14)");
                  end
               end
               167: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[102]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(15)");
                  end
               end
               168: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[103] ");
                  end
               end
               169: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[104]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(16)");
                  end
               end
               170: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[105]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(17)");
                  end
               end
               171: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[106]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(18)");
                  end
               end
               172: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[107]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(19)");
                  end
               end
               173: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[108]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(20)");
                  end
               end
               174: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[109]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(21)");
                  end
               end
               175: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[110]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(22)");
                  end
               end
               176: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[111]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(23)");
                  end
               end
               177: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[112]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(24)");
                  end
               end
               178: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[113]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(25)");
                  end
               end
               179: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[114]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(26)");
                  end
               end
               180: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[115]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(27)");
                  end
               end
               181: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[116]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(28)");
                  end
               end
               182: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[117]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(29)");
                  end
               end
               183: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[118]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(30)");
                  end
               end
               184: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[119]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_dmaddr_out(31)");
                  end
               end
               185: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[120] ");
                  end
               end
               186: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[121]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_hready_in");
                  end
               end
               187: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[122]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(0)");
                  end
               end
               188: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[123]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(1)");
                  end
               end
               189: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[124]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(2)");
                  end
               end
               190: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[125]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(3)");
                  end
               end
               191: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[126]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(4)");
                  end
               end
               192: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[127]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(5)");
                  end
               end
               193: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[128]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(6)");
                  end
               end
               194: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[129]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(7)");
                  end
               end
               195: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[130]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(8)");
                  end
               end
               196: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[131]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(9)");
                  end
               end
               197: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[132]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(10)");
                  end
               end
               198: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[133]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(11)");
                  end
               end
               199: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[134]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(12)");
                  end
               end
               200: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[135]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(13)");
                  end
               end
               201: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[136]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(14)");
                  end
               end
               202: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[137]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(15)");
                  end
               end
               203: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[138]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(16)");
                  end
               end
               204: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[139]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(17)");
                  end
               end
               205: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[140]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(18)");
                  end
               end
               206: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[141]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(19)");
                  end
               end
               207: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[142]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(20)");
                  end
               end
               208: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[143]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(21)");
                  end
               end
               209: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[144]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(22)");
                  end
               end
               210: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[145]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(23)");
                  end
               end
               211: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[146]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(24)");
                  end
               end
               212: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[147]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(25)");
                  end
               end
               213: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[148]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(26)");
                  end
               end
               214: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[149]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(27)");
                  end
               end
               215: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[150]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(28)");
                  end
               end
               216: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[151]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(29)");
                  end
               end
               217: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[152]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(30)");
                  end
               end
               218: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[153]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_instr_in(31)");
                  end
               end
               219: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[154]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(0)");
                  end
               end
               220: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[155]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(1)");
                  end
               end
               221: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[156]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(2)");
                  end
               end
               222: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[157]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(3)");
                  end
               end
               223: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[158]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(4)");
                  end
               end
               224: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[159]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(5)");
                  end
               end
               225: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[160]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(6)");
                  end
               end
               226: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[161]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(7)");
                  end
               end
               227: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[162]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(8)");
                  end
               end
               228: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[163]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(9)");
                  end
               end
               229: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[164]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(10)");
                  end
               end
               230: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[165]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(11)");
                  end
               end
               231: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[166]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(12)");
                  end
               end
               232: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[167]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(13)");
                  end
               end
               233: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[168]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(14)");
                  end
               end
               234: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[169]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(15)");
                  end
               end
               235: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[170]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(16)");
                  end
               end
               236: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[171]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(17)");
                  end
               end
               237: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[172]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(18)");
                  end
               end
               238: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[173]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(19)");
                  end
               end
               239: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[174]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(20)");
                  end
               end
               240: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[175]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(21)");
                  end
               end
               241: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[176]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(22)");
                  end
               end
               242: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[177]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(23)");
                  end
               end
               243: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[178]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(24)");
                  end
               end
               244: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[179]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(25)");
                  end
               end
               245: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[180]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(26)");
                  end
               end
               246: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[181]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(27)");
                  end
               end
               247: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[182]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(28)");
                  end
               end
               248: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[183]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(29)");
                  end
               end
               249: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[184]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(30)");
                  end
               end
               250: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[185]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(31)");
                  end
               end
               251: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[186]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(32)");
                  end
               end
               252: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[187]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(33)");
                  end
               end
               253: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[188]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(34)");
                  end
               end
               254: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[189]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(35)");
                  end
               end
               255: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[190]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(36)");
                  end
               end
               256: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[191]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(37)");
                  end
               end
               257: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[192]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(38)");
                  end
               end
               258: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[193]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(39)");
                  end
               end
               259: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[194]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(40)");
                  end
               end
               260: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[195]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(41)");
                  end
               end
               261: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[196]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(42)");
                  end
               end
               262: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[197]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(43)");
                  end
               end
               263: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[198]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(44)");
                  end
               end
               264: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[199]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(45)");
                  end
               end
               265: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[200]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(46)");
                  end
               end
               266: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[201]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(47)");
                  end
               end
               267: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[202]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(48)");
                  end
               end
               268: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[203]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(49)");
                  end
               end
               269: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[204]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(50)");
                  end
               end
               270: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[205]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(51)");
                  end
               end
               271: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[206]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(52)");
                  end
               end
               272: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[207]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(53)");
                  end
               end
               273: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[208]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(54)");
                  end
               end
               274: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[209]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(55)");
                  end
               end
               275: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[210]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(56)");
                  end
               end
               276: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[211]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(57)");
                  end
               end
               277: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[212]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(58)");
                  end
               end
               278: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[213]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(59)");
                  end
               end
               279: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[214]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(60)");
                  end
               end
               280: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[215]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(61)");
                  end
               end
               281: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[216]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(62)");
                  end
               end
               282: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[217]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rc_in(63)");
                  end
               end
               283: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[218]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_rst_in");
                  end
               end
               284: begin
                  if (_found_fail_obus[1] === 1'b1) begin
                    $display($realtime, "ns: Corresponding ICL register:  msrv32_top_pass1_rtl_tessent_bscan_interface_I.BScanReg[219]");
                    $display($realtime, "ns: Corresponding design object:  ms_riscv32_mp_clk_in");
                  end
               end
               285: begin
                  $display($realtime, "ns:   * Load bscan with a walking zero pattern ...111110.");
               end
               286: begin
                  $display($realtime, "ns:   * Load bscan with a safe pattern (load each cell BSDL SAFE value).");
               end
               287: begin
                  $display($realtime, "ns:  End of the bscan_reg test");
               end
               288: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__input");
               end
               289: begin
                  $display($realtime, "ns:   input test");
               end
               290: begin
                  $display($realtime, "ns:   * Loading bscan chain with an EVEN pattern:");
               end
               291: begin
                  $display($realtime, "ns:         EVEN pins = 1  and  ODD pins = 0");
               end
               292: begin
                  $display($realtime, "ns:     All control cells are disabled");
               end
               293: begin
                  $display($realtime, "ns:   * Loading TAP Instruction Register with EXTEST instruction.");
               end
               294: begin
                  $display($realtime, "ns:   * Setting input Pins with an ODD pattern:");
               end
               295: begin
                  $display($realtime, "ns:         EVEN pins = 0  and  ODD pins = 1");
               end
               296: begin
                  $display($realtime, "ns:     Setting  edt_channel_in1_p  to '1'");
               end
               297: begin
                  $display($realtime, "ns:     Setting  edt_update  to '0'");
               end
               298: begin
                  $display($realtime, "ns:     Setting  edt_clock  to '0'");
               end
               299: begin
                  $display($realtime, "ns:     Setting  control_chain_scan_in  to '1'");
               end
               300: begin
                  $display($realtime, "ns:     Setting  control_chain_enable  to '0'");
               end
               301: begin
                  $display($realtime, "ns:     Setting  ramclk_p  to '1'");
               end
               302: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_clk_in_p  to '0'");
               end
               303: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_sirq_in  to '1'");
               end
               304: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_tirq_in  to '0'");
               end
               305: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_eirq_in  to '1'");
               end
               306: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_hresp_in  to '0'");
               end
               307: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_hready_in  to '1'");
               end
               308: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(31)  to '1'");
               end
               309: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(30)  to '0'");
               end
               310: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(29)  to '1'");
               end
               311: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(28)  to '0'");
               end
               312: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(27)  to '1'");
               end
               313: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(26)  to '0'");
               end
               314: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(25)  to '1'");
               end
               315: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(24)  to '0'");
               end
               316: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(23)  to '1'");
               end
               317: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(22)  to '0'");
               end
               318: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(21)  to '1'");
               end
               319: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(20)  to '0'");
               end
               320: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(19)  to '1'");
               end
               321: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(18)  to '0'");
               end
               322: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(17)  to '1'");
               end
               323: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(16)  to '0'");
               end
               324: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(15)  to '1'");
               end
               325: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(14)  to '0'");
               end
               326: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(13)  to '1'");
               end
               327: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(12)  to '0'");
               end
               328: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(11)  to '1'");
               end
               329: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(10)  to '0'");
               end
               330: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(9)  to '1'");
               end
               331: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(8)  to '0'");
               end
               332: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(7)  to '1'");
               end
               333: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(6)  to '0'");
               end
               334: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(5)  to '1'");
               end
               335: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(4)  to '0'");
               end
               336: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(3)  to '1'");
               end
               337: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(2)  to '0'");
               end
               338: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(1)  to '1'");
               end
               339: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(0)  to '0'");
               end
               340: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_hready_in  to '1'");
               end
               341: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(31)  to '1'");
               end
               342: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(30)  to '0'");
               end
               343: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(29)  to '1'");
               end
               344: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(28)  to '0'");
               end
               345: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(27)  to '1'");
               end
               346: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(26)  to '0'");
               end
               347: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(25)  to '1'");
               end
               348: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(24)  to '0'");
               end
               349: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(23)  to '1'");
               end
               350: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(22)  to '0'");
               end
               351: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(21)  to '1'");
               end
               352: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(20)  to '0'");
               end
               353: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(19)  to '1'");
               end
               354: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(18)  to '0'");
               end
               355: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(17)  to '1'");
               end
               356: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(16)  to '0'");
               end
               357: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(15)  to '1'");
               end
               358: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(14)  to '0'");
               end
               359: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(13)  to '1'");
               end
               360: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(12)  to '0'");
               end
               361: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(11)  to '1'");
               end
               362: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(10)  to '0'");
               end
               363: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(9)  to '1'");
               end
               364: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(8)  to '0'");
               end
               365: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(7)  to '1'");
               end
               366: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(6)  to '0'");
               end
               367: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(5)  to '1'");
               end
               368: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(4)  to '0'");
               end
               369: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(3)  to '1'");
               end
               370: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(2)  to '0'");
               end
               371: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(1)  to '1'");
               end
               372: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(0)  to '0'");
               end
               373: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(63)  to '1'");
               end
               374: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(62)  to '0'");
               end
               375: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(61)  to '1'");
               end
               376: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(60)  to '0'");
               end
               377: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(59)  to '1'");
               end
               378: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(58)  to '0'");
               end
               379: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(57)  to '1'");
               end
               380: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(56)  to '0'");
               end
               381: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(55)  to '1'");
               end
               382: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(54)  to '0'");
               end
               383: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(53)  to '1'");
               end
               384: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(52)  to '0'");
               end
               385: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(51)  to '1'");
               end
               386: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(50)  to '0'");
               end
               387: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(49)  to '1'");
               end
               388: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(48)  to '0'");
               end
               389: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(47)  to '1'");
               end
               390: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(46)  to '0'");
               end
               391: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(45)  to '1'");
               end
               392: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(44)  to '0'");
               end
               393: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(43)  to '1'");
               end
               394: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(42)  to '0'");
               end
               395: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(41)  to '1'");
               end
               396: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(40)  to '0'");
               end
               397: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(39)  to '1'");
               end
               398: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(38)  to '0'");
               end
               399: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(37)  to '1'");
               end
               400: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(36)  to '0'");
               end
               401: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(35)  to '1'");
               end
               402: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(34)  to '0'");
               end
               403: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(33)  to '1'");
               end
               404: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(32)  to '0'");
               end
               405: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(31)  to '1'");
               end
               406: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(30)  to '0'");
               end
               407: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(29)  to '1'");
               end
               408: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(28)  to '0'");
               end
               409: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(27)  to '1'");
               end
               410: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(26)  to '0'");
               end
               411: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(25)  to '1'");
               end
               412: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(24)  to '0'");
               end
               413: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(23)  to '1'");
               end
               414: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(22)  to '0'");
               end
               415: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(21)  to '1'");
               end
               416: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(20)  to '0'");
               end
               417: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(19)  to '1'");
               end
               418: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(18)  to '0'");
               end
               419: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(17)  to '1'");
               end
               420: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(16)  to '0'");
               end
               421: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(15)  to '1'");
               end
               422: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(14)  to '0'");
               end
               423: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(13)  to '1'");
               end
               424: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(12)  to '0'");
               end
               425: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(11)  to '1'");
               end
               426: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(10)  to '0'");
               end
               427: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(9)  to '1'");
               end
               428: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(8)  to '0'");
               end
               429: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(7)  to '1'");
               end
               430: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(6)  to '0'");
               end
               431: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(5)  to '1'");
               end
               432: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(4)  to '0'");
               end
               433: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(3)  to '1'");
               end
               434: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(2)  to '0'");
               end
               435: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(1)  to '1'");
               end
               436: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(0)  to '0'");
               end
               437: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rst_in  to '0'");
               end
               438: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_clk_in  to '1'");
               end
               439: begin
                  $display($realtime, "ns:   * Checking bscan captured values from previous pattern and");
               end
               440: begin
                  $display($realtime, "ns:     loading bscan chain with an ODD pattern:");
               end
               441: begin
                  $display($realtime, "ns:   * Setting input Pins with an EVEN pattern:");
               end
               442: begin
                  $display($realtime, "ns:     Setting  edt_channel_in1_p  to '0'");
               end
               443: begin
                  $display($realtime, "ns:     Setting  edt_update  to '1'");
               end
               444: begin
                  $display($realtime, "ns:     Setting  edt_clock  to '1'");
               end
               445: begin
                  $display($realtime, "ns:     Setting  control_chain_scan_in  to '0'");
               end
               446: begin
                  $display($realtime, "ns:     Setting  control_chain_enable  to '1'");
               end
               447: begin
                  $display($realtime, "ns:     Setting  ramclk_p  to '0'");
               end
               448: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_clk_in_p  to '1'");
               end
               449: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_sirq_in  to '0'");
               end
               450: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_tirq_in  to '1'");
               end
               451: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_eirq_in  to '0'");
               end
               452: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_hresp_in  to '1'");
               end
               453: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_hready_in  to '0'");
               end
               454: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(31)  to '0'");
               end
               455: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(30)  to '1'");
               end
               456: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(29)  to '0'");
               end
               457: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(28)  to '1'");
               end
               458: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(27)  to '0'");
               end
               459: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(26)  to '1'");
               end
               460: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(25)  to '0'");
               end
               461: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(24)  to '1'");
               end
               462: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(23)  to '0'");
               end
               463: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(22)  to '1'");
               end
               464: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(21)  to '0'");
               end
               465: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(20)  to '1'");
               end
               466: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(19)  to '0'");
               end
               467: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(18)  to '1'");
               end
               468: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(17)  to '0'");
               end
               469: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(16)  to '1'");
               end
               470: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(15)  to '0'");
               end
               471: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(14)  to '1'");
               end
               472: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(13)  to '0'");
               end
               473: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(12)  to '1'");
               end
               474: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(11)  to '0'");
               end
               475: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(10)  to '1'");
               end
               476: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(9)  to '0'");
               end
               477: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(8)  to '1'");
               end
               478: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(7)  to '0'");
               end
               479: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(6)  to '1'");
               end
               480: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(5)  to '0'");
               end
               481: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(4)  to '1'");
               end
               482: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(3)  to '0'");
               end
               483: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(2)  to '1'");
               end
               484: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(1)  to '0'");
               end
               485: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_data_in(0)  to '1'");
               end
               486: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_hready_in  to '0'");
               end
               487: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(31)  to '0'");
               end
               488: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(30)  to '1'");
               end
               489: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(29)  to '0'");
               end
               490: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(28)  to '1'");
               end
               491: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(27)  to '0'");
               end
               492: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(26)  to '1'");
               end
               493: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(25)  to '0'");
               end
               494: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(24)  to '1'");
               end
               495: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(23)  to '0'");
               end
               496: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(22)  to '1'");
               end
               497: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(21)  to '0'");
               end
               498: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(20)  to '1'");
               end
               499: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(19)  to '0'");
               end
               500: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(18)  to '1'");
               end
               501: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(17)  to '0'");
               end
               502: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(16)  to '1'");
               end
               503: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(15)  to '0'");
               end
               504: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(14)  to '1'");
               end
               505: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(13)  to '0'");
               end
               506: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(12)  to '1'");
               end
               507: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(11)  to '0'");
               end
               508: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(10)  to '1'");
               end
               509: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(9)  to '0'");
               end
               510: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(8)  to '1'");
               end
               511: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(7)  to '0'");
               end
               512: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(6)  to '1'");
               end
               513: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(5)  to '0'");
               end
               514: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(4)  to '1'");
               end
               515: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(3)  to '0'");
               end
               516: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(2)  to '1'");
               end
               517: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(1)  to '0'");
               end
               518: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_instr_in(0)  to '1'");
               end
               519: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(63)  to '0'");
               end
               520: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(62)  to '1'");
               end
               521: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(61)  to '0'");
               end
               522: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(60)  to '1'");
               end
               523: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(59)  to '0'");
               end
               524: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(58)  to '1'");
               end
               525: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(57)  to '0'");
               end
               526: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(56)  to '1'");
               end
               527: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(55)  to '0'");
               end
               528: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(54)  to '1'");
               end
               529: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(53)  to '0'");
               end
               530: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(52)  to '1'");
               end
               531: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(51)  to '0'");
               end
               532: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(50)  to '1'");
               end
               533: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(49)  to '0'");
               end
               534: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(48)  to '1'");
               end
               535: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(47)  to '0'");
               end
               536: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(46)  to '1'");
               end
               537: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(45)  to '0'");
               end
               538: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(44)  to '1'");
               end
               539: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(43)  to '0'");
               end
               540: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(42)  to '1'");
               end
               541: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(41)  to '0'");
               end
               542: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(40)  to '1'");
               end
               543: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(39)  to '0'");
               end
               544: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(38)  to '1'");
               end
               545: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(37)  to '0'");
               end
               546: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(36)  to '1'");
               end
               547: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(35)  to '0'");
               end
               548: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(34)  to '1'");
               end
               549: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(33)  to '0'");
               end
               550: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(32)  to '1'");
               end
               551: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(31)  to '0'");
               end
               552: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(30)  to '1'");
               end
               553: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(29)  to '0'");
               end
               554: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(28)  to '1'");
               end
               555: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(27)  to '0'");
               end
               556: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(26)  to '1'");
               end
               557: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(25)  to '0'");
               end
               558: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(24)  to '1'");
               end
               559: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(23)  to '0'");
               end
               560: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(22)  to '1'");
               end
               561: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(21)  to '0'");
               end
               562: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(20)  to '1'");
               end
               563: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(19)  to '0'");
               end
               564: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(18)  to '1'");
               end
               565: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(17)  to '0'");
               end
               566: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(16)  to '1'");
               end
               567: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(15)  to '0'");
               end
               568: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(14)  to '1'");
               end
               569: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(13)  to '0'");
               end
               570: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(12)  to '1'");
               end
               571: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(11)  to '0'");
               end
               572: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(10)  to '1'");
               end
               573: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(9)  to '0'");
               end
               574: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(8)  to '1'");
               end
               575: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(7)  to '0'");
               end
               576: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(6)  to '1'");
               end
               577: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(5)  to '0'");
               end
               578: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(4)  to '1'");
               end
               579: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(3)  to '0'");
               end
               580: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(2)  to '1'");
               end
               581: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(1)  to '0'");
               end
               582: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rc_in(0)  to '1'");
               end
               583: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_rst_in  to '1'");
               end
               584: begin
                  $display($realtime, "ns:     Setting  ms_riscv32_mp_clk_in  to '0'");
               end
               585: begin
                  $display($realtime, "ns:   * Checking bscan  captured  values and loading bscan with a");
               end
               586: begin
                  $display($realtime, "ns:     safe value.");
               end
               587: begin
                  $display($realtime, "ns:  End of the input test");
               end
               588: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__sample");
               end
               589: begin
                  $display($realtime, "ns:   sample test");
               end
               590: begin
                  $display($realtime, "ns:     All pad driver are controlled by the functional logic");
               end
               591: begin
                  $display($realtime, "ns:   * Loading TAP Instruction Register with SAMPLE instruction.");
               end
               592: begin
                  $display($realtime, "ns:  End of the sample test");
               end
               593: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__highz");
               end
               594: begin
                  $display($realtime, "ns:   highz test");
               end
               595: begin
                  $display($realtime, "ns:   * Testing disabled outputs");
               end
               596: begin
                  $display($realtime, "ns:   * Loading all control and assym.drivers cells with a disabling value");
               end
               597: begin
                  $display($realtime, "ns:     Data registers are all zero");
               end
               598: begin
                  $display($realtime, "ns:   * Comparing all disabled output pins to 'Z'");
               end
               599: begin
                  $display($realtime, "ns:     Checking  control_chain_scan_out  with 'Z'");
               end
               600: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_data_htrans_out(1)  with 'Z'");
               end
               601: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_data_htrans_out(0)  with 'Z'");
               end
               602: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(3)  with 'Z'");
               end
               603: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(2)  with 'Z'");
               end
               604: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(1)  with 'Z'");
               end
               605: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(0)  with 'Z'");
               end
               606: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_req_out  with 'Z'");
               end
               607: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(31)  with 'Z'");
               end
               608: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(30)  with 'Z'");
               end
               609: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(29)  with 'Z'");
               end
               610: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(28)  with 'Z'");
               end
               611: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(27)  with 'Z'");
               end
               612: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(26)  with 'Z'");
               end
               613: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(25)  with 'Z'");
               end
               614: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(24)  with 'Z'");
               end
               615: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(23)  with 'Z'");
               end
               616: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(22)  with 'Z'");
               end
               617: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(21)  with 'Z'");
               end
               618: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(20)  with 'Z'");
               end
               619: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(19)  with 'Z'");
               end
               620: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(18)  with 'Z'");
               end
               621: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(17)  with 'Z'");
               end
               622: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(16)  with 'Z'");
               end
               623: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(15)  with 'Z'");
               end
               624: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(14)  with 'Z'");
               end
               625: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(13)  with 'Z'");
               end
               626: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(12)  with 'Z'");
               end
               627: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(11)  with 'Z'");
               end
               628: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(10)  with 'Z'");
               end
               629: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(9)  with 'Z'");
               end
               630: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(8)  with 'Z'");
               end
               631: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(7)  with 'Z'");
               end
               632: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(6)  with 'Z'");
               end
               633: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(5)  with 'Z'");
               end
               634: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(4)  with 'Z'");
               end
               635: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(3)  with 'Z'");
               end
               636: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(2)  with 'Z'");
               end
               637: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(1)  with 'Z'");
               end
               638: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(0)  with 'Z'");
               end
               639: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(31)  with 'Z'");
               end
               640: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(30)  with 'Z'");
               end
               641: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(29)  with 'Z'");
               end
               642: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(28)  with 'Z'");
               end
               643: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(27)  with 'Z'");
               end
               644: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(26)  with 'Z'");
               end
               645: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(25)  with 'Z'");
               end
               646: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(24)  with 'Z'");
               end
               647: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(23)  with 'Z'");
               end
               648: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(22)  with 'Z'");
               end
               649: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(21)  with 'Z'");
               end
               650: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(20)  with 'Z'");
               end
               651: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(19)  with 'Z'");
               end
               652: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(18)  with 'Z'");
               end
               653: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(17)  with 'Z'");
               end
               654: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(16)  with 'Z'");
               end
               655: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(15)  with 'Z'");
               end
               656: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(14)  with 'Z'");
               end
               657: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(13)  with 'Z'");
               end
               658: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(12)  with 'Z'");
               end
               659: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(11)  with 'Z'");
               end
               660: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(10)  with 'Z'");
               end
               661: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(9)  with 'Z'");
               end
               662: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(8)  with 'Z'");
               end
               663: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(7)  with 'Z'");
               end
               664: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(6)  with 'Z'");
               end
               665: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(5)  with 'Z'");
               end
               666: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(4)  with 'Z'");
               end
               667: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(3)  with 'Z'");
               end
               668: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(2)  with 'Z'");
               end
               669: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(1)  with 'Z'");
               end
               670: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(0)  with 'Z'");
               end
               671: begin
                  $display($realtime, "ns:   * Testing the HIGHZ instruction");
               end
               672: begin
                  $display($realtime, "ns:   1- Load all CONTROL and assym drivers cells with their ENABLING value");
               end
               673: begin
                  $display($realtime, "ns:   2- Use the HIGHZ TAP instruction to disable all pins");
               end
               674: begin
                  $display($realtime, "ns:   3- Compare all disabled output pins with 'Z'");
               end
               675: begin
                  $display($realtime, "ns:   * Loading all control bscan cells with enabling values");
               end
               676: begin
                  $display($realtime, "ns:   * Loading TAP Instruction Register with HIGHZ instruction.");
               end
               677: begin
                  $display($realtime, "ns:   * Comparing all JTAG output pins to 'Z'");
               end
               678: begin
                  $display($realtime, "ns:   * Comparing TDO output pin to 'Z' in RTI state");
               end
               679: begin
                  $display($realtime, "ns:  End of the highz test");
               end
               680: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__clamp");
               end
               681: begin
                  $display($realtime, "ns:   clamp test");
               end
               682: begin
                  $display($realtime, "ns:   * clamp test for enable group Engroup0,");
               end
               683: begin
                  $display($realtime, "ns:     which includes the following control cells:");
               end
               684: begin
                  $display($realtime, "ns:           cell: 120");
               end
               685: begin
                  $display($realtime, "ns:           cell: 103");
               end
               686: begin
                  $display($realtime, "ns:           cell: 86");
               end
               687: begin
                  $display($realtime, "ns:           cell: 69");
               end
               688: begin
                  $display($realtime, "ns:           cell: 52");
               end
               689: begin
                  $display($realtime, "ns:   * Comparing enabled Output Pins with an EVEN pattern:");
               end
               690: begin
                  $display($realtime, "ns:     Open-drain/source pins are compared only if enabled");
               end
               691: begin
                  $display($realtime, "ns:     Checking  control_chain_scan_out  with '0'");
               end
               692: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_data_htrans_out(1)  with '0'");
               end
               693: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_data_htrans_out(0)  with '1'");
               end
               694: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(3)  with '0'");
               end
               695: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(2)  with '1'");
               end
               696: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(1)  with '0'");
               end
               697: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(0)  with '1'");
               end
               698: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_req_out  with '1'");
               end
               699: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(31)  with '1'");
               end
               700: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(30)  with '0'");
               end
               701: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(29)  with '1'");
               end
               702: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(28)  with '0'");
               end
               703: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(27)  with '1'");
               end
               704: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(26)  with '0'");
               end
               705: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(25)  with '1'");
               end
               706: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(24)  with '0'");
               end
               707: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(23)  with '1'");
               end
               708: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(22)  with '0'");
               end
               709: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(21)  with '1'");
               end
               710: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(20)  with '0'");
               end
               711: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(19)  with '1'");
               end
               712: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(18)  with '0'");
               end
               713: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(17)  with '1'");
               end
               714: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(16)  with '0'");
               end
               715: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(15)  with '1'");
               end
               716: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(14)  with '0'");
               end
               717: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(13)  with '1'");
               end
               718: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(12)  with '0'");
               end
               719: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(11)  with '1'");
               end
               720: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(10)  with '0'");
               end
               721: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(9)  with '1'");
               end
               722: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(8)  with '0'");
               end
               723: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(7)  with '1'");
               end
               724: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(6)  with '0'");
               end
               725: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(5)  with '1'");
               end
               726: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(4)  with '0'");
               end
               727: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(3)  with '1'");
               end
               728: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(2)  with '0'");
               end
               729: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(1)  with '1'");
               end
               730: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(0)  with '0'");
               end
               731: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(31)  with '1'");
               end
               732: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(30)  with '0'");
               end
               733: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(29)  with '1'");
               end
               734: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(28)  with '0'");
               end
               735: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(27)  with '1'");
               end
               736: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(26)  with '0'");
               end
               737: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(25)  with '1'");
               end
               738: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(24)  with '0'");
               end
               739: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(23)  with '1'");
               end
               740: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(22)  with '0'");
               end
               741: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(21)  with '1'");
               end
               742: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(20)  with '0'");
               end
               743: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(19)  with '1'");
               end
               744: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(18)  with '0'");
               end
               745: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(17)  with '1'");
               end
               746: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(16)  with '0'");
               end
               747: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(15)  with '1'");
               end
               748: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(14)  with '0'");
               end
               749: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(13)  with '1'");
               end
               750: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(12)  with '0'");
               end
               751: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(11)  with '1'");
               end
               752: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(10)  with '0'");
               end
               753: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(9)  with '1'");
               end
               754: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(8)  with '0'");
               end
               755: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(7)  with '1'");
               end
               756: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(6)  with '0'");
               end
               757: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(5)  with '1'");
               end
               758: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(4)  with '0'");
               end
               759: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(3)  with '1'");
               end
               760: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(2)  with '0'");
               end
               761: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(1)  with '1'");
               end
               762: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(0)  with '0'");
               end
               763: begin
                  $display($realtime, "ns:   * Loading TAP Instruction Register with CLAMP instruction.");
               end
               764: begin
                  $display($realtime, "ns:   * Shifting a logic 1 into  the  BYPASS register,");
               end
               765: begin
                  $display($realtime, "ns:     while expecting a logic 0 over the TDO port.");
               end
               766: begin
                  $display($realtime, "ns:   * Re-Comparing enabled Output Pins");
               end
               767: begin
                  $display($realtime, "ns:   * Loading bscan chain with an ODD pattern:");
               end
               768: begin
                  $display($realtime, "ns:   * Comparing enabled Output Pins with an ODD pattern:");
               end
               769: begin
                  $display($realtime, "ns:     Checking  control_chain_scan_out  with '1'");
               end
               770: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_data_htrans_out(1)  with '1'");
               end
               771: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_data_htrans_out(0)  with '0'");
               end
               772: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(3)  with '1'");
               end
               773: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(2)  with '0'");
               end
               774: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(1)  with '1'");
               end
               775: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_mask_out(0)  with '0'");
               end
               776: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmwr_req_out  with '0'");
               end
               777: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(31)  with '0'");
               end
               778: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(30)  with '1'");
               end
               779: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(29)  with '0'");
               end
               780: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(28)  with '1'");
               end
               781: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(27)  with '0'");
               end
               782: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(26)  with '1'");
               end
               783: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(25)  with '0'");
               end
               784: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(24)  with '1'");
               end
               785: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(23)  with '0'");
               end
               786: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(22)  with '1'");
               end
               787: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(21)  with '0'");
               end
               788: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(20)  with '1'");
               end
               789: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(19)  with '0'");
               end
               790: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(18)  with '1'");
               end
               791: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(17)  with '0'");
               end
               792: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(16)  with '1'");
               end
               793: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(15)  with '0'");
               end
               794: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(14)  with '1'");
               end
               795: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(13)  with '0'");
               end
               796: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(12)  with '1'");
               end
               797: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(11)  with '0'");
               end
               798: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(10)  with '1'");
               end
               799: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(9)  with '0'");
               end
               800: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(8)  with '1'");
               end
               801: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(7)  with '0'");
               end
               802: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(6)  with '1'");
               end
               803: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(5)  with '0'");
               end
               804: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(4)  with '1'");
               end
               805: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(3)  with '0'");
               end
               806: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(2)  with '1'");
               end
               807: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(1)  with '0'");
               end
               808: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmdata_out(0)  with '1'");
               end
               809: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(31)  with '0'");
               end
               810: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(30)  with '1'");
               end
               811: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(29)  with '0'");
               end
               812: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(28)  with '1'");
               end
               813: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(27)  with '0'");
               end
               814: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(26)  with '1'");
               end
               815: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(25)  with '0'");
               end
               816: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(24)  with '1'");
               end
               817: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(23)  with '0'");
               end
               818: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(22)  with '1'");
               end
               819: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(21)  with '0'");
               end
               820: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(20)  with '1'");
               end
               821: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(19)  with '0'");
               end
               822: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(18)  with '1'");
               end
               823: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(17)  with '0'");
               end
               824: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(16)  with '1'");
               end
               825: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(15)  with '0'");
               end
               826: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(14)  with '1'");
               end
               827: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(13)  with '0'");
               end
               828: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(12)  with '1'");
               end
               829: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(11)  with '0'");
               end
               830: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(10)  with '1'");
               end
               831: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(9)  with '0'");
               end
               832: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(8)  with '1'");
               end
               833: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(7)  with '0'");
               end
               834: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(6)  with '1'");
               end
               835: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(5)  with '0'");
               end
               836: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(4)  with '1'");
               end
               837: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(3)  with '0'");
               end
               838: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(2)  with '1'");
               end
               839: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(1)  with '0'");
               end
               840: begin
                  $display($realtime, "ns:     Checking  ms_riscv32_mp_dmaddr_out(0)  with '1'");
               end
               841: begin
                  $display($realtime, "ns:   * Loading boundary scan chain  with a SAFE pin pattern.");
               end
               842: begin
                  $display($realtime, "ns:  End of the clamp test");
               end
               843: begin
                  $display($realtime, "ns: Pattern_set JtagBscanTestStep__output");
               end
               844: begin
                  $display($realtime, "ns:   output test");
               end
               845: begin
                  $display($realtime, "ns:   * output test for enable group Engroup0,");
               end
               846: begin
                  $display($realtime, "ns:   * Checking bscan captured values from previous EVEN pattern");
               end
               847: begin
                  $display($realtime, "ns:   * Comparing enabled Output Pins with an EVEN pattern just before the update-DR state");
               end
               848: begin
                  $display($realtime, "ns:   * Loading boundary scan chain  with a SAFE pin pattern, and");
               end
               849: begin
                  $display($realtime, "ns:     Comparing captured TDO data for an ODD pattern.");
               end
               850: begin
                  $display($realtime, "ns:  End of the output test");
               end
               default: begin
                  $display("ERROR: corrupt message index\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _message_index
         end
         default: begin
            $display("ERROR: corrupt vector number\n");
            ->before_finish;
            #0;
            $finish;
         end
      endcase
   end // if in_range
      else begin
      case (_pat_type)  // _pat_type = vect[6:4]; 
         3'b011:  begin // status message vector
            _message_index = vect[38:7]; 
            case (_message_index)
               0: begin
                  _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                  if (_pat_num > -1) begin
                    $display("Skipped chain pattern %d\n",_pat_num);
                  end
                  _chain_test_ = 0;
                  _pat_num = -1;
                  $display("End chain test\n");
               end
               3: begin 
                  _end_vec_file_ok = 1;
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      _skipped_patterns = _skipped_patterns + 1;
                    end
                  end
                  if (_pat_num > -1) begin
                    if (_chain_test_) begin
                      $display("Skipped chain pattern %d\n",_pat_num);
                    end
                    else begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               default: begin
                  // Skip
               end
            endcase // _message_index
         end
         default: begin
            // Skip
         end
      endcase
      end // else !_in_range
   end // index loop
end // file_cnt loop

if (_save_state == 1) begin
  #1;
  mgcdft_save_signal = 1'b1;
//  $display("Writing checkpoint JtagBscanPatterns.v.dat");
//  $save("JtagBscanPatterns.v.dat");
  #1;
  $stop;
end
end
end  // while _in_restart
 if (_DIAG_file_header == 1) begin
    if (_diag_scan_header==1) begin
      $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
    end
    $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
    $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
    $fwrite(_diag_file, "failure_file_end\n");
    $fclose(_diag_file);
 end


#1;
if (_end_vec_file_ok == 0) begin
  $display("ERROR: Pattern file corrupted, simulation aborted\n");
end
_end_vec_file_ok = do_finish_summary(_end_vec_file_ok);
#1;
->before_finish;
#0;
$finish;
end
endmodule

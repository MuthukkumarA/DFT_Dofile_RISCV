/*
----------------------------------------------------------------------------------
-                                                                                -
-  Unpublished work. Copyright 2021 Siemens                                      -
-                                                                                -
-  This material contains trade secrets or otherwise confidential                -
-  information owned by Siemens Industry Software Inc. or its affiliates         -
-  (collectively, SISW), or its licensors. Access to and use of this             -
-  information is strictly limited as set forth in the Customer's                -
-  applicable agreements with SISW.                                              -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: Tessent Shell                                                -
-          Version: 2022.2                                                       -
-       Created on: Tue Apr  7 17:29:58 IST 2026                                 -
----------------------------------------------------------------------------------


*/
/*
--=============================================================================
--
--  File        :  msrv32_top_pass1_rtl_tessent_bscan_logical_group_DEF.v
--  Description :  Boundary scan group DEF RTL description
--
--=============================================================================
*/
module msrv32_top_pass1_rtl_tessent_bscan_logical_group_DEF 
			(
			capture_shift_clock ,
			CELL0_BSCAN_SO ,
			CELL219_BSCAN_SI ,
			control_chain_enable_fromPad ,
			control_chain_enable_toCore ,
			control_chain_scan_in_fromPad ,
			control_chain_scan_in_toCore ,
			control_chain_scan_out_fromCore ,
			control_chain_scan_out_toPad ,
			edt_channel_in1_p_fromPad ,
			edt_channel_in1_p_toCore ,
			edt_clock_fromPad ,
			edt_clock_toCore ,
			edt_update_fromPad ,
			edt_update_toCore ,
			EN1_en1 ,
			EN1_userEnable1 ,
			EN2_en1 ,
			EN2_userEnable1 ,
			EN3_en1 ,
			EN3_userEnable1 ,
			EN4_en1 ,
			EN4_userEnable1 ,
			EN5_en1 ,
			EN5_userEnable1 ,
			forceDisable ,
			ms_riscv32_mp_clk_in_fromPad ,
			ms_riscv32_mp_clk_in_p_fromPad ,
			ms_riscv32_mp_clk_in_p_toCore ,
			ms_riscv32_mp_data_hready_in_fromPad ,
			ms_riscv32_mp_data_hready_in_toCore ,
			ms_riscv32_mp_data_htrans_out_0_fromCore ,
			ms_riscv32_mp_data_htrans_out_0_toPad ,
			ms_riscv32_mp_data_htrans_out_1_fromCore ,
			ms_riscv32_mp_data_htrans_out_1_toPad ,
			ms_riscv32_mp_data_in_0_fromPad ,
			ms_riscv32_mp_data_in_0_toCore ,
			ms_riscv32_mp_data_in_10_fromPad ,
			ms_riscv32_mp_data_in_10_toCore ,
			ms_riscv32_mp_data_in_11_fromPad ,
			ms_riscv32_mp_data_in_11_toCore ,
			ms_riscv32_mp_data_in_12_fromPad ,
			ms_riscv32_mp_data_in_12_toCore ,
			ms_riscv32_mp_data_in_13_fromPad ,
			ms_riscv32_mp_data_in_13_toCore ,
			ms_riscv32_mp_data_in_14_fromPad ,
			ms_riscv32_mp_data_in_14_toCore ,
			ms_riscv32_mp_data_in_15_fromPad ,
			ms_riscv32_mp_data_in_15_toCore ,
			ms_riscv32_mp_data_in_16_fromPad ,
			ms_riscv32_mp_data_in_16_toCore ,
			ms_riscv32_mp_data_in_17_fromPad ,
			ms_riscv32_mp_data_in_17_toCore ,
			ms_riscv32_mp_data_in_18_fromPad ,
			ms_riscv32_mp_data_in_18_toCore ,
			ms_riscv32_mp_data_in_19_fromPad ,
			ms_riscv32_mp_data_in_19_toCore ,
			ms_riscv32_mp_data_in_1_fromPad ,
			ms_riscv32_mp_data_in_1_toCore ,
			ms_riscv32_mp_data_in_20_fromPad ,
			ms_riscv32_mp_data_in_20_toCore ,
			ms_riscv32_mp_data_in_21_fromPad ,
			ms_riscv32_mp_data_in_21_toCore ,
			ms_riscv32_mp_data_in_22_fromPad ,
			ms_riscv32_mp_data_in_22_toCore ,
			ms_riscv32_mp_data_in_23_fromPad ,
			ms_riscv32_mp_data_in_23_toCore ,
			ms_riscv32_mp_data_in_24_fromPad ,
			ms_riscv32_mp_data_in_24_toCore ,
			ms_riscv32_mp_data_in_25_fromPad ,
			ms_riscv32_mp_data_in_25_toCore ,
			ms_riscv32_mp_data_in_26_fromPad ,
			ms_riscv32_mp_data_in_26_toCore ,
			ms_riscv32_mp_data_in_27_fromPad ,
			ms_riscv32_mp_data_in_27_toCore ,
			ms_riscv32_mp_data_in_28_fromPad ,
			ms_riscv32_mp_data_in_28_toCore ,
			ms_riscv32_mp_data_in_29_fromPad ,
			ms_riscv32_mp_data_in_29_toCore ,
			ms_riscv32_mp_data_in_2_fromPad ,
			ms_riscv32_mp_data_in_2_toCore ,
			ms_riscv32_mp_data_in_30_fromPad ,
			ms_riscv32_mp_data_in_30_toCore ,
			ms_riscv32_mp_data_in_31_fromPad ,
			ms_riscv32_mp_data_in_31_toCore ,
			ms_riscv32_mp_data_in_3_fromPad ,
			ms_riscv32_mp_data_in_3_toCore ,
			ms_riscv32_mp_data_in_4_fromPad ,
			ms_riscv32_mp_data_in_4_toCore ,
			ms_riscv32_mp_data_in_5_fromPad ,
			ms_riscv32_mp_data_in_5_toCore ,
			ms_riscv32_mp_data_in_6_fromPad ,
			ms_riscv32_mp_data_in_6_toCore ,
			ms_riscv32_mp_data_in_7_fromPad ,
			ms_riscv32_mp_data_in_7_toCore ,
			ms_riscv32_mp_data_in_8_fromPad ,
			ms_riscv32_mp_data_in_8_toCore ,
			ms_riscv32_mp_data_in_9_fromPad ,
			ms_riscv32_mp_data_in_9_toCore ,
			ms_riscv32_mp_dmaddr_out_0_fromCore ,
			ms_riscv32_mp_dmaddr_out_0_toPad ,
			ms_riscv32_mp_dmaddr_out_10_fromCore ,
			ms_riscv32_mp_dmaddr_out_10_toPad ,
			ms_riscv32_mp_dmaddr_out_11_fromCore ,
			ms_riscv32_mp_dmaddr_out_11_toPad ,
			ms_riscv32_mp_dmaddr_out_12_fromCore ,
			ms_riscv32_mp_dmaddr_out_12_toPad ,
			ms_riscv32_mp_dmaddr_out_13_fromCore ,
			ms_riscv32_mp_dmaddr_out_13_toPad ,
			ms_riscv32_mp_dmaddr_out_14_fromCore ,
			ms_riscv32_mp_dmaddr_out_14_toPad ,
			ms_riscv32_mp_dmaddr_out_15_fromCore ,
			ms_riscv32_mp_dmaddr_out_15_toPad ,
			ms_riscv32_mp_dmaddr_out_16_fromCore ,
			ms_riscv32_mp_dmaddr_out_16_toPad ,
			ms_riscv32_mp_dmaddr_out_17_fromCore ,
			ms_riscv32_mp_dmaddr_out_17_toPad ,
			ms_riscv32_mp_dmaddr_out_18_fromCore ,
			ms_riscv32_mp_dmaddr_out_18_toPad ,
			ms_riscv32_mp_dmaddr_out_19_fromCore ,
			ms_riscv32_mp_dmaddr_out_19_toPad ,
			ms_riscv32_mp_dmaddr_out_1_fromCore ,
			ms_riscv32_mp_dmaddr_out_1_toPad ,
			ms_riscv32_mp_dmaddr_out_20_fromCore ,
			ms_riscv32_mp_dmaddr_out_20_toPad ,
			ms_riscv32_mp_dmaddr_out_21_fromCore ,
			ms_riscv32_mp_dmaddr_out_21_toPad ,
			ms_riscv32_mp_dmaddr_out_22_fromCore ,
			ms_riscv32_mp_dmaddr_out_22_toPad ,
			ms_riscv32_mp_dmaddr_out_23_fromCore ,
			ms_riscv32_mp_dmaddr_out_23_toPad ,
			ms_riscv32_mp_dmaddr_out_24_fromCore ,
			ms_riscv32_mp_dmaddr_out_24_toPad ,
			ms_riscv32_mp_dmaddr_out_25_fromCore ,
			ms_riscv32_mp_dmaddr_out_25_toPad ,
			ms_riscv32_mp_dmaddr_out_26_fromCore ,
			ms_riscv32_mp_dmaddr_out_26_toPad ,
			ms_riscv32_mp_dmaddr_out_27_fromCore ,
			ms_riscv32_mp_dmaddr_out_27_toPad ,
			ms_riscv32_mp_dmaddr_out_28_fromCore ,
			ms_riscv32_mp_dmaddr_out_28_toPad ,
			ms_riscv32_mp_dmaddr_out_29_fromCore ,
			ms_riscv32_mp_dmaddr_out_29_toPad ,
			ms_riscv32_mp_dmaddr_out_2_fromCore ,
			ms_riscv32_mp_dmaddr_out_2_toPad ,
			ms_riscv32_mp_dmaddr_out_30_fromCore ,
			ms_riscv32_mp_dmaddr_out_30_toPad ,
			ms_riscv32_mp_dmaddr_out_31_fromCore ,
			ms_riscv32_mp_dmaddr_out_31_toPad ,
			ms_riscv32_mp_dmaddr_out_3_fromCore ,
			ms_riscv32_mp_dmaddr_out_3_toPad ,
			ms_riscv32_mp_dmaddr_out_4_fromCore ,
			ms_riscv32_mp_dmaddr_out_4_toPad ,
			ms_riscv32_mp_dmaddr_out_5_fromCore ,
			ms_riscv32_mp_dmaddr_out_5_toPad ,
			ms_riscv32_mp_dmaddr_out_6_fromCore ,
			ms_riscv32_mp_dmaddr_out_6_toPad ,
			ms_riscv32_mp_dmaddr_out_7_fromCore ,
			ms_riscv32_mp_dmaddr_out_7_toPad ,
			ms_riscv32_mp_dmaddr_out_8_fromCore ,
			ms_riscv32_mp_dmaddr_out_8_toPad ,
			ms_riscv32_mp_dmaddr_out_9_fromCore ,
			ms_riscv32_mp_dmaddr_out_9_toPad ,
			ms_riscv32_mp_dmdata_out_0_fromCore ,
			ms_riscv32_mp_dmdata_out_0_toPad ,
			ms_riscv32_mp_dmdata_out_10_fromCore ,
			ms_riscv32_mp_dmdata_out_10_toPad ,
			ms_riscv32_mp_dmdata_out_11_fromCore ,
			ms_riscv32_mp_dmdata_out_11_toPad ,
			ms_riscv32_mp_dmdata_out_12_fromCore ,
			ms_riscv32_mp_dmdata_out_12_toPad ,
			ms_riscv32_mp_dmdata_out_13_fromCore ,
			ms_riscv32_mp_dmdata_out_13_toPad ,
			ms_riscv32_mp_dmdata_out_14_fromCore ,
			ms_riscv32_mp_dmdata_out_14_toPad ,
			ms_riscv32_mp_dmdata_out_15_fromCore ,
			ms_riscv32_mp_dmdata_out_15_toPad ,
			ms_riscv32_mp_dmdata_out_16_fromCore ,
			ms_riscv32_mp_dmdata_out_16_toPad ,
			ms_riscv32_mp_dmdata_out_17_fromCore ,
			ms_riscv32_mp_dmdata_out_17_toPad ,
			ms_riscv32_mp_dmdata_out_18_fromCore ,
			ms_riscv32_mp_dmdata_out_18_toPad ,
			ms_riscv32_mp_dmdata_out_19_fromCore ,
			ms_riscv32_mp_dmdata_out_19_toPad ,
			ms_riscv32_mp_dmdata_out_1_fromCore ,
			ms_riscv32_mp_dmdata_out_1_toPad ,
			ms_riscv32_mp_dmdata_out_20_fromCore ,
			ms_riscv32_mp_dmdata_out_20_toPad ,
			ms_riscv32_mp_dmdata_out_21_fromCore ,
			ms_riscv32_mp_dmdata_out_21_toPad ,
			ms_riscv32_mp_dmdata_out_22_fromCore ,
			ms_riscv32_mp_dmdata_out_22_toPad ,
			ms_riscv32_mp_dmdata_out_23_fromCore ,
			ms_riscv32_mp_dmdata_out_23_toPad ,
			ms_riscv32_mp_dmdata_out_24_fromCore ,
			ms_riscv32_mp_dmdata_out_24_toPad ,
			ms_riscv32_mp_dmdata_out_25_fromCore ,
			ms_riscv32_mp_dmdata_out_25_toPad ,
			ms_riscv32_mp_dmdata_out_26_fromCore ,
			ms_riscv32_mp_dmdata_out_26_toPad ,
			ms_riscv32_mp_dmdata_out_27_fromCore ,
			ms_riscv32_mp_dmdata_out_27_toPad ,
			ms_riscv32_mp_dmdata_out_28_fromCore ,
			ms_riscv32_mp_dmdata_out_28_toPad ,
			ms_riscv32_mp_dmdata_out_29_fromCore ,
			ms_riscv32_mp_dmdata_out_29_toPad ,
			ms_riscv32_mp_dmdata_out_2_fromCore ,
			ms_riscv32_mp_dmdata_out_2_toPad ,
			ms_riscv32_mp_dmdata_out_30_fromCore ,
			ms_riscv32_mp_dmdata_out_30_toPad ,
			ms_riscv32_mp_dmdata_out_31_fromCore ,
			ms_riscv32_mp_dmdata_out_31_toPad ,
			ms_riscv32_mp_dmdata_out_3_fromCore ,
			ms_riscv32_mp_dmdata_out_3_toPad ,
			ms_riscv32_mp_dmdata_out_4_fromCore ,
			ms_riscv32_mp_dmdata_out_4_toPad ,
			ms_riscv32_mp_dmdata_out_5_fromCore ,
			ms_riscv32_mp_dmdata_out_5_toPad ,
			ms_riscv32_mp_dmdata_out_6_fromCore ,
			ms_riscv32_mp_dmdata_out_6_toPad ,
			ms_riscv32_mp_dmdata_out_7_fromCore ,
			ms_riscv32_mp_dmdata_out_7_toPad ,
			ms_riscv32_mp_dmdata_out_8_fromCore ,
			ms_riscv32_mp_dmdata_out_8_toPad ,
			ms_riscv32_mp_dmdata_out_9_fromCore ,
			ms_riscv32_mp_dmdata_out_9_toPad ,
			ms_riscv32_mp_dmwr_mask_out_0_fromCore ,
			ms_riscv32_mp_dmwr_mask_out_0_toPad ,
			ms_riscv32_mp_dmwr_mask_out_1_fromCore ,
			ms_riscv32_mp_dmwr_mask_out_1_toPad ,
			ms_riscv32_mp_dmwr_mask_out_2_fromCore ,
			ms_riscv32_mp_dmwr_mask_out_2_toPad ,
			ms_riscv32_mp_dmwr_mask_out_3_fromCore ,
			ms_riscv32_mp_dmwr_mask_out_3_toPad ,
			ms_riscv32_mp_dmwr_req_out_fromCore ,
			ms_riscv32_mp_dmwr_req_out_toPad ,
			ms_riscv32_mp_eirq_in_fromPad ,
			ms_riscv32_mp_eirq_in_toCore ,
			ms_riscv32_mp_hresp_in_fromPad ,
			ms_riscv32_mp_hresp_in_toCore ,
			ms_riscv32_mp_instr_hready_in_fromPad ,
			ms_riscv32_mp_instr_hready_in_toCore ,
			ms_riscv32_mp_instr_in_0_fromPad ,
			ms_riscv32_mp_instr_in_0_toCore ,
			ms_riscv32_mp_instr_in_10_fromPad ,
			ms_riscv32_mp_instr_in_10_toCore ,
			ms_riscv32_mp_instr_in_11_fromPad ,
			ms_riscv32_mp_instr_in_11_toCore ,
			ms_riscv32_mp_instr_in_12_fromPad ,
			ms_riscv32_mp_instr_in_12_toCore ,
			ms_riscv32_mp_instr_in_13_fromPad ,
			ms_riscv32_mp_instr_in_13_toCore ,
			ms_riscv32_mp_instr_in_14_fromPad ,
			ms_riscv32_mp_instr_in_14_toCore ,
			ms_riscv32_mp_instr_in_15_fromPad ,
			ms_riscv32_mp_instr_in_15_toCore ,
			ms_riscv32_mp_instr_in_16_fromPad ,
			ms_riscv32_mp_instr_in_16_toCore ,
			ms_riscv32_mp_instr_in_17_fromPad ,
			ms_riscv32_mp_instr_in_17_toCore ,
			ms_riscv32_mp_instr_in_18_fromPad ,
			ms_riscv32_mp_instr_in_18_toCore ,
			ms_riscv32_mp_instr_in_19_fromPad ,
			ms_riscv32_mp_instr_in_19_toCore ,
			ms_riscv32_mp_instr_in_1_fromPad ,
			ms_riscv32_mp_instr_in_1_toCore ,
			ms_riscv32_mp_instr_in_20_fromPad ,
			ms_riscv32_mp_instr_in_20_toCore ,
			ms_riscv32_mp_instr_in_21_fromPad ,
			ms_riscv32_mp_instr_in_21_toCore ,
			ms_riscv32_mp_instr_in_22_fromPad ,
			ms_riscv32_mp_instr_in_22_toCore ,
			ms_riscv32_mp_instr_in_23_fromPad ,
			ms_riscv32_mp_instr_in_23_toCore ,
			ms_riscv32_mp_instr_in_24_fromPad ,
			ms_riscv32_mp_instr_in_24_toCore ,
			ms_riscv32_mp_instr_in_25_fromPad ,
			ms_riscv32_mp_instr_in_25_toCore ,
			ms_riscv32_mp_instr_in_26_fromPad ,
			ms_riscv32_mp_instr_in_26_toCore ,
			ms_riscv32_mp_instr_in_27_fromPad ,
			ms_riscv32_mp_instr_in_27_toCore ,
			ms_riscv32_mp_instr_in_28_fromPad ,
			ms_riscv32_mp_instr_in_28_toCore ,
			ms_riscv32_mp_instr_in_29_fromPad ,
			ms_riscv32_mp_instr_in_29_toCore ,
			ms_riscv32_mp_instr_in_2_fromPad ,
			ms_riscv32_mp_instr_in_2_toCore ,
			ms_riscv32_mp_instr_in_30_fromPad ,
			ms_riscv32_mp_instr_in_30_toCore ,
			ms_riscv32_mp_instr_in_31_fromPad ,
			ms_riscv32_mp_instr_in_31_toCore ,
			ms_riscv32_mp_instr_in_3_fromPad ,
			ms_riscv32_mp_instr_in_3_toCore ,
			ms_riscv32_mp_instr_in_4_fromPad ,
			ms_riscv32_mp_instr_in_4_toCore ,
			ms_riscv32_mp_instr_in_5_fromPad ,
			ms_riscv32_mp_instr_in_5_toCore ,
			ms_riscv32_mp_instr_in_6_fromPad ,
			ms_riscv32_mp_instr_in_6_toCore ,
			ms_riscv32_mp_instr_in_7_fromPad ,
			ms_riscv32_mp_instr_in_7_toCore ,
			ms_riscv32_mp_instr_in_8_fromPad ,
			ms_riscv32_mp_instr_in_8_toCore ,
			ms_riscv32_mp_instr_in_9_fromPad ,
			ms_riscv32_mp_instr_in_9_toCore ,
			ms_riscv32_mp_rc_in_0_fromPad ,
			ms_riscv32_mp_rc_in_0_toCore ,
			ms_riscv32_mp_rc_in_10_fromPad ,
			ms_riscv32_mp_rc_in_10_toCore ,
			ms_riscv32_mp_rc_in_11_fromPad ,
			ms_riscv32_mp_rc_in_11_toCore ,
			ms_riscv32_mp_rc_in_12_fromPad ,
			ms_riscv32_mp_rc_in_12_toCore ,
			ms_riscv32_mp_rc_in_13_fromPad ,
			ms_riscv32_mp_rc_in_13_toCore ,
			ms_riscv32_mp_rc_in_14_fromPad ,
			ms_riscv32_mp_rc_in_14_toCore ,
			ms_riscv32_mp_rc_in_15_fromPad ,
			ms_riscv32_mp_rc_in_15_toCore ,
			ms_riscv32_mp_rc_in_16_fromPad ,
			ms_riscv32_mp_rc_in_16_toCore ,
			ms_riscv32_mp_rc_in_17_fromPad ,
			ms_riscv32_mp_rc_in_17_toCore ,
			ms_riscv32_mp_rc_in_18_fromPad ,
			ms_riscv32_mp_rc_in_18_toCore ,
			ms_riscv32_mp_rc_in_19_fromPad ,
			ms_riscv32_mp_rc_in_19_toCore ,
			ms_riscv32_mp_rc_in_1_fromPad ,
			ms_riscv32_mp_rc_in_1_toCore ,
			ms_riscv32_mp_rc_in_20_fromPad ,
			ms_riscv32_mp_rc_in_20_toCore ,
			ms_riscv32_mp_rc_in_21_fromPad ,
			ms_riscv32_mp_rc_in_21_toCore ,
			ms_riscv32_mp_rc_in_22_fromPad ,
			ms_riscv32_mp_rc_in_22_toCore ,
			ms_riscv32_mp_rc_in_23_fromPad ,
			ms_riscv32_mp_rc_in_23_toCore ,
			ms_riscv32_mp_rc_in_24_fromPad ,
			ms_riscv32_mp_rc_in_24_toCore ,
			ms_riscv32_mp_rc_in_25_fromPad ,
			ms_riscv32_mp_rc_in_25_toCore ,
			ms_riscv32_mp_rc_in_26_fromPad ,
			ms_riscv32_mp_rc_in_26_toCore ,
			ms_riscv32_mp_rc_in_27_fromPad ,
			ms_riscv32_mp_rc_in_27_toCore ,
			ms_riscv32_mp_rc_in_28_fromPad ,
			ms_riscv32_mp_rc_in_28_toCore ,
			ms_riscv32_mp_rc_in_29_fromPad ,
			ms_riscv32_mp_rc_in_29_toCore ,
			ms_riscv32_mp_rc_in_2_fromPad ,
			ms_riscv32_mp_rc_in_2_toCore ,
			ms_riscv32_mp_rc_in_30_fromPad ,
			ms_riscv32_mp_rc_in_30_toCore ,
			ms_riscv32_mp_rc_in_31_fromPad ,
			ms_riscv32_mp_rc_in_31_toCore ,
			ms_riscv32_mp_rc_in_32_fromPad ,
			ms_riscv32_mp_rc_in_32_toCore ,
			ms_riscv32_mp_rc_in_33_fromPad ,
			ms_riscv32_mp_rc_in_33_toCore ,
			ms_riscv32_mp_rc_in_34_fromPad ,
			ms_riscv32_mp_rc_in_34_toCore ,
			ms_riscv32_mp_rc_in_35_fromPad ,
			ms_riscv32_mp_rc_in_35_toCore ,
			ms_riscv32_mp_rc_in_36_fromPad ,
			ms_riscv32_mp_rc_in_36_toCore ,
			ms_riscv32_mp_rc_in_37_fromPad ,
			ms_riscv32_mp_rc_in_37_toCore ,
			ms_riscv32_mp_rc_in_38_fromPad ,
			ms_riscv32_mp_rc_in_38_toCore ,
			ms_riscv32_mp_rc_in_39_fromPad ,
			ms_riscv32_mp_rc_in_39_toCore ,
			ms_riscv32_mp_rc_in_3_fromPad ,
			ms_riscv32_mp_rc_in_3_toCore ,
			ms_riscv32_mp_rc_in_40_fromPad ,
			ms_riscv32_mp_rc_in_40_toCore ,
			ms_riscv32_mp_rc_in_41_fromPad ,
			ms_riscv32_mp_rc_in_41_toCore ,
			ms_riscv32_mp_rc_in_42_fromPad ,
			ms_riscv32_mp_rc_in_42_toCore ,
			ms_riscv32_mp_rc_in_43_fromPad ,
			ms_riscv32_mp_rc_in_43_toCore ,
			ms_riscv32_mp_rc_in_44_fromPad ,
			ms_riscv32_mp_rc_in_44_toCore ,
			ms_riscv32_mp_rc_in_45_fromPad ,
			ms_riscv32_mp_rc_in_45_toCore ,
			ms_riscv32_mp_rc_in_46_fromPad ,
			ms_riscv32_mp_rc_in_46_toCore ,
			ms_riscv32_mp_rc_in_47_fromPad ,
			ms_riscv32_mp_rc_in_47_toCore ,
			ms_riscv32_mp_rc_in_48_fromPad ,
			ms_riscv32_mp_rc_in_48_toCore ,
			ms_riscv32_mp_rc_in_49_fromPad ,
			ms_riscv32_mp_rc_in_49_toCore ,
			ms_riscv32_mp_rc_in_4_fromPad ,
			ms_riscv32_mp_rc_in_4_toCore ,
			ms_riscv32_mp_rc_in_50_fromPad ,
			ms_riscv32_mp_rc_in_50_toCore ,
			ms_riscv32_mp_rc_in_51_fromPad ,
			ms_riscv32_mp_rc_in_51_toCore ,
			ms_riscv32_mp_rc_in_52_fromPad ,
			ms_riscv32_mp_rc_in_52_toCore ,
			ms_riscv32_mp_rc_in_53_fromPad ,
			ms_riscv32_mp_rc_in_53_toCore ,
			ms_riscv32_mp_rc_in_54_fromPad ,
			ms_riscv32_mp_rc_in_54_toCore ,
			ms_riscv32_mp_rc_in_55_fromPad ,
			ms_riscv32_mp_rc_in_55_toCore ,
			ms_riscv32_mp_rc_in_56_fromPad ,
			ms_riscv32_mp_rc_in_56_toCore ,
			ms_riscv32_mp_rc_in_57_fromPad ,
			ms_riscv32_mp_rc_in_57_toCore ,
			ms_riscv32_mp_rc_in_58_fromPad ,
			ms_riscv32_mp_rc_in_58_toCore ,
			ms_riscv32_mp_rc_in_59_fromPad ,
			ms_riscv32_mp_rc_in_59_toCore ,
			ms_riscv32_mp_rc_in_5_fromPad ,
			ms_riscv32_mp_rc_in_5_toCore ,
			ms_riscv32_mp_rc_in_60_fromPad ,
			ms_riscv32_mp_rc_in_60_toCore ,
			ms_riscv32_mp_rc_in_61_fromPad ,
			ms_riscv32_mp_rc_in_61_toCore ,
			ms_riscv32_mp_rc_in_62_fromPad ,
			ms_riscv32_mp_rc_in_62_toCore ,
			ms_riscv32_mp_rc_in_63_fromPad ,
			ms_riscv32_mp_rc_in_63_toCore ,
			ms_riscv32_mp_rc_in_6_fromPad ,
			ms_riscv32_mp_rc_in_6_toCore ,
			ms_riscv32_mp_rc_in_7_fromPad ,
			ms_riscv32_mp_rc_in_7_toCore ,
			ms_riscv32_mp_rc_in_8_fromPad ,
			ms_riscv32_mp_rc_in_8_toCore ,
			ms_riscv32_mp_rc_in_9_fromPad ,
			ms_riscv32_mp_rc_in_9_toCore ,
			ms_riscv32_mp_rst_in_fromPad ,
			ms_riscv32_mp_rst_in_toCore ,
			ms_riscv32_mp_sirq_in_fromPad ,
			ms_riscv32_mp_sirq_in_toCore ,
			ms_riscv32_mp_tirq_in_fromPad ,
			ms_riscv32_mp_tirq_in_toCore ,
			ramclk_p_fromPad ,
			ramclk_p_toCore ,
			selectJtagInput ,
			selectJtagOutput ,
			shiftBscan2Edge ,
			update_clock    
 			);
input          capture_shift_clock ;
output         CELL0_BSCAN_SO ;
input          CELL219_BSCAN_SI ;
input          control_chain_enable_fromPad ;
output         control_chain_enable_toCore ;
input          control_chain_scan_in_fromPad ;
output         control_chain_scan_in_toCore ;
input          control_chain_scan_out_fromCore ;
output         control_chain_scan_out_toPad ;
input          edt_channel_in1_p_fromPad ;
output         edt_channel_in1_p_toCore ;
input          edt_clock_fromPad ;
output         edt_clock_toCore ;
input          edt_update_fromPad ;
output         edt_update_toCore ;
output         EN1_en1 ;
input          EN1_userEnable1 ;
output         EN2_en1 ;
input          EN2_userEnable1 ;
output         EN3_en1 ;
input          EN3_userEnable1 ;
output         EN4_en1 ;
input          EN4_userEnable1 ;
output         EN5_en1 ;
input          EN5_userEnable1 ;
input          forceDisable ;
input          ms_riscv32_mp_clk_in_fromPad ;
input          ms_riscv32_mp_clk_in_p_fromPad ;
output         ms_riscv32_mp_clk_in_p_toCore ;
input          ms_riscv32_mp_data_hready_in_fromPad ;
output         ms_riscv32_mp_data_hready_in_toCore ;
input          ms_riscv32_mp_data_htrans_out_0_fromCore ;
output         ms_riscv32_mp_data_htrans_out_0_toPad ;
input          ms_riscv32_mp_data_htrans_out_1_fromCore ;
output         ms_riscv32_mp_data_htrans_out_1_toPad ;
input          ms_riscv32_mp_data_in_0_fromPad ;
output         ms_riscv32_mp_data_in_0_toCore ;
input          ms_riscv32_mp_data_in_10_fromPad ;
output         ms_riscv32_mp_data_in_10_toCore ;
input          ms_riscv32_mp_data_in_11_fromPad ;
output         ms_riscv32_mp_data_in_11_toCore ;
input          ms_riscv32_mp_data_in_12_fromPad ;
output         ms_riscv32_mp_data_in_12_toCore ;
input          ms_riscv32_mp_data_in_13_fromPad ;
output         ms_riscv32_mp_data_in_13_toCore ;
input          ms_riscv32_mp_data_in_14_fromPad ;
output         ms_riscv32_mp_data_in_14_toCore ;
input          ms_riscv32_mp_data_in_15_fromPad ;
output         ms_riscv32_mp_data_in_15_toCore ;
input          ms_riscv32_mp_data_in_16_fromPad ;
output         ms_riscv32_mp_data_in_16_toCore ;
input          ms_riscv32_mp_data_in_17_fromPad ;
output         ms_riscv32_mp_data_in_17_toCore ;
input          ms_riscv32_mp_data_in_18_fromPad ;
output         ms_riscv32_mp_data_in_18_toCore ;
input          ms_riscv32_mp_data_in_19_fromPad ;
output         ms_riscv32_mp_data_in_19_toCore ;
input          ms_riscv32_mp_data_in_1_fromPad ;
output         ms_riscv32_mp_data_in_1_toCore ;
input          ms_riscv32_mp_data_in_20_fromPad ;
output         ms_riscv32_mp_data_in_20_toCore ;
input          ms_riscv32_mp_data_in_21_fromPad ;
output         ms_riscv32_mp_data_in_21_toCore ;
input          ms_riscv32_mp_data_in_22_fromPad ;
output         ms_riscv32_mp_data_in_22_toCore ;
input          ms_riscv32_mp_data_in_23_fromPad ;
output         ms_riscv32_mp_data_in_23_toCore ;
input          ms_riscv32_mp_data_in_24_fromPad ;
output         ms_riscv32_mp_data_in_24_toCore ;
input          ms_riscv32_mp_data_in_25_fromPad ;
output         ms_riscv32_mp_data_in_25_toCore ;
input          ms_riscv32_mp_data_in_26_fromPad ;
output         ms_riscv32_mp_data_in_26_toCore ;
input          ms_riscv32_mp_data_in_27_fromPad ;
output         ms_riscv32_mp_data_in_27_toCore ;
input          ms_riscv32_mp_data_in_28_fromPad ;
output         ms_riscv32_mp_data_in_28_toCore ;
input          ms_riscv32_mp_data_in_29_fromPad ;
output         ms_riscv32_mp_data_in_29_toCore ;
input          ms_riscv32_mp_data_in_2_fromPad ;
output         ms_riscv32_mp_data_in_2_toCore ;
input          ms_riscv32_mp_data_in_30_fromPad ;
output         ms_riscv32_mp_data_in_30_toCore ;
input          ms_riscv32_mp_data_in_31_fromPad ;
output         ms_riscv32_mp_data_in_31_toCore ;
input          ms_riscv32_mp_data_in_3_fromPad ;
output         ms_riscv32_mp_data_in_3_toCore ;
input          ms_riscv32_mp_data_in_4_fromPad ;
output         ms_riscv32_mp_data_in_4_toCore ;
input          ms_riscv32_mp_data_in_5_fromPad ;
output         ms_riscv32_mp_data_in_5_toCore ;
input          ms_riscv32_mp_data_in_6_fromPad ;
output         ms_riscv32_mp_data_in_6_toCore ;
input          ms_riscv32_mp_data_in_7_fromPad ;
output         ms_riscv32_mp_data_in_7_toCore ;
input          ms_riscv32_mp_data_in_8_fromPad ;
output         ms_riscv32_mp_data_in_8_toCore ;
input          ms_riscv32_mp_data_in_9_fromPad ;
output         ms_riscv32_mp_data_in_9_toCore ;
input          ms_riscv32_mp_dmaddr_out_0_fromCore ;
output         ms_riscv32_mp_dmaddr_out_0_toPad ;
input          ms_riscv32_mp_dmaddr_out_10_fromCore ;
output         ms_riscv32_mp_dmaddr_out_10_toPad ;
input          ms_riscv32_mp_dmaddr_out_11_fromCore ;
output         ms_riscv32_mp_dmaddr_out_11_toPad ;
input          ms_riscv32_mp_dmaddr_out_12_fromCore ;
output         ms_riscv32_mp_dmaddr_out_12_toPad ;
input          ms_riscv32_mp_dmaddr_out_13_fromCore ;
output         ms_riscv32_mp_dmaddr_out_13_toPad ;
input          ms_riscv32_mp_dmaddr_out_14_fromCore ;
output         ms_riscv32_mp_dmaddr_out_14_toPad ;
input          ms_riscv32_mp_dmaddr_out_15_fromCore ;
output         ms_riscv32_mp_dmaddr_out_15_toPad ;
input          ms_riscv32_mp_dmaddr_out_16_fromCore ;
output         ms_riscv32_mp_dmaddr_out_16_toPad ;
input          ms_riscv32_mp_dmaddr_out_17_fromCore ;
output         ms_riscv32_mp_dmaddr_out_17_toPad ;
input          ms_riscv32_mp_dmaddr_out_18_fromCore ;
output         ms_riscv32_mp_dmaddr_out_18_toPad ;
input          ms_riscv32_mp_dmaddr_out_19_fromCore ;
output         ms_riscv32_mp_dmaddr_out_19_toPad ;
input          ms_riscv32_mp_dmaddr_out_1_fromCore ;
output         ms_riscv32_mp_dmaddr_out_1_toPad ;
input          ms_riscv32_mp_dmaddr_out_20_fromCore ;
output         ms_riscv32_mp_dmaddr_out_20_toPad ;
input          ms_riscv32_mp_dmaddr_out_21_fromCore ;
output         ms_riscv32_mp_dmaddr_out_21_toPad ;
input          ms_riscv32_mp_dmaddr_out_22_fromCore ;
output         ms_riscv32_mp_dmaddr_out_22_toPad ;
input          ms_riscv32_mp_dmaddr_out_23_fromCore ;
output         ms_riscv32_mp_dmaddr_out_23_toPad ;
input          ms_riscv32_mp_dmaddr_out_24_fromCore ;
output         ms_riscv32_mp_dmaddr_out_24_toPad ;
input          ms_riscv32_mp_dmaddr_out_25_fromCore ;
output         ms_riscv32_mp_dmaddr_out_25_toPad ;
input          ms_riscv32_mp_dmaddr_out_26_fromCore ;
output         ms_riscv32_mp_dmaddr_out_26_toPad ;
input          ms_riscv32_mp_dmaddr_out_27_fromCore ;
output         ms_riscv32_mp_dmaddr_out_27_toPad ;
input          ms_riscv32_mp_dmaddr_out_28_fromCore ;
output         ms_riscv32_mp_dmaddr_out_28_toPad ;
input          ms_riscv32_mp_dmaddr_out_29_fromCore ;
output         ms_riscv32_mp_dmaddr_out_29_toPad ;
input          ms_riscv32_mp_dmaddr_out_2_fromCore ;
output         ms_riscv32_mp_dmaddr_out_2_toPad ;
input          ms_riscv32_mp_dmaddr_out_30_fromCore ;
output         ms_riscv32_mp_dmaddr_out_30_toPad ;
input          ms_riscv32_mp_dmaddr_out_31_fromCore ;
output         ms_riscv32_mp_dmaddr_out_31_toPad ;
input          ms_riscv32_mp_dmaddr_out_3_fromCore ;
output         ms_riscv32_mp_dmaddr_out_3_toPad ;
input          ms_riscv32_mp_dmaddr_out_4_fromCore ;
output         ms_riscv32_mp_dmaddr_out_4_toPad ;
input          ms_riscv32_mp_dmaddr_out_5_fromCore ;
output         ms_riscv32_mp_dmaddr_out_5_toPad ;
input          ms_riscv32_mp_dmaddr_out_6_fromCore ;
output         ms_riscv32_mp_dmaddr_out_6_toPad ;
input          ms_riscv32_mp_dmaddr_out_7_fromCore ;
output         ms_riscv32_mp_dmaddr_out_7_toPad ;
input          ms_riscv32_mp_dmaddr_out_8_fromCore ;
output         ms_riscv32_mp_dmaddr_out_8_toPad ;
input          ms_riscv32_mp_dmaddr_out_9_fromCore ;
output         ms_riscv32_mp_dmaddr_out_9_toPad ;
input          ms_riscv32_mp_dmdata_out_0_fromCore ;
output         ms_riscv32_mp_dmdata_out_0_toPad ;
input          ms_riscv32_mp_dmdata_out_10_fromCore ;
output         ms_riscv32_mp_dmdata_out_10_toPad ;
input          ms_riscv32_mp_dmdata_out_11_fromCore ;
output         ms_riscv32_mp_dmdata_out_11_toPad ;
input          ms_riscv32_mp_dmdata_out_12_fromCore ;
output         ms_riscv32_mp_dmdata_out_12_toPad ;
input          ms_riscv32_mp_dmdata_out_13_fromCore ;
output         ms_riscv32_mp_dmdata_out_13_toPad ;
input          ms_riscv32_mp_dmdata_out_14_fromCore ;
output         ms_riscv32_mp_dmdata_out_14_toPad ;
input          ms_riscv32_mp_dmdata_out_15_fromCore ;
output         ms_riscv32_mp_dmdata_out_15_toPad ;
input          ms_riscv32_mp_dmdata_out_16_fromCore ;
output         ms_riscv32_mp_dmdata_out_16_toPad ;
input          ms_riscv32_mp_dmdata_out_17_fromCore ;
output         ms_riscv32_mp_dmdata_out_17_toPad ;
input          ms_riscv32_mp_dmdata_out_18_fromCore ;
output         ms_riscv32_mp_dmdata_out_18_toPad ;
input          ms_riscv32_mp_dmdata_out_19_fromCore ;
output         ms_riscv32_mp_dmdata_out_19_toPad ;
input          ms_riscv32_mp_dmdata_out_1_fromCore ;
output         ms_riscv32_mp_dmdata_out_1_toPad ;
input          ms_riscv32_mp_dmdata_out_20_fromCore ;
output         ms_riscv32_mp_dmdata_out_20_toPad ;
input          ms_riscv32_mp_dmdata_out_21_fromCore ;
output         ms_riscv32_mp_dmdata_out_21_toPad ;
input          ms_riscv32_mp_dmdata_out_22_fromCore ;
output         ms_riscv32_mp_dmdata_out_22_toPad ;
input          ms_riscv32_mp_dmdata_out_23_fromCore ;
output         ms_riscv32_mp_dmdata_out_23_toPad ;
input          ms_riscv32_mp_dmdata_out_24_fromCore ;
output         ms_riscv32_mp_dmdata_out_24_toPad ;
input          ms_riscv32_mp_dmdata_out_25_fromCore ;
output         ms_riscv32_mp_dmdata_out_25_toPad ;
input          ms_riscv32_mp_dmdata_out_26_fromCore ;
output         ms_riscv32_mp_dmdata_out_26_toPad ;
input          ms_riscv32_mp_dmdata_out_27_fromCore ;
output         ms_riscv32_mp_dmdata_out_27_toPad ;
input          ms_riscv32_mp_dmdata_out_28_fromCore ;
output         ms_riscv32_mp_dmdata_out_28_toPad ;
input          ms_riscv32_mp_dmdata_out_29_fromCore ;
output         ms_riscv32_mp_dmdata_out_29_toPad ;
input          ms_riscv32_mp_dmdata_out_2_fromCore ;
output         ms_riscv32_mp_dmdata_out_2_toPad ;
input          ms_riscv32_mp_dmdata_out_30_fromCore ;
output         ms_riscv32_mp_dmdata_out_30_toPad ;
input          ms_riscv32_mp_dmdata_out_31_fromCore ;
output         ms_riscv32_mp_dmdata_out_31_toPad ;
input          ms_riscv32_mp_dmdata_out_3_fromCore ;
output         ms_riscv32_mp_dmdata_out_3_toPad ;
input          ms_riscv32_mp_dmdata_out_4_fromCore ;
output         ms_riscv32_mp_dmdata_out_4_toPad ;
input          ms_riscv32_mp_dmdata_out_5_fromCore ;
output         ms_riscv32_mp_dmdata_out_5_toPad ;
input          ms_riscv32_mp_dmdata_out_6_fromCore ;
output         ms_riscv32_mp_dmdata_out_6_toPad ;
input          ms_riscv32_mp_dmdata_out_7_fromCore ;
output         ms_riscv32_mp_dmdata_out_7_toPad ;
input          ms_riscv32_mp_dmdata_out_8_fromCore ;
output         ms_riscv32_mp_dmdata_out_8_toPad ;
input          ms_riscv32_mp_dmdata_out_9_fromCore ;
output         ms_riscv32_mp_dmdata_out_9_toPad ;
input          ms_riscv32_mp_dmwr_mask_out_0_fromCore ;
output         ms_riscv32_mp_dmwr_mask_out_0_toPad ;
input          ms_riscv32_mp_dmwr_mask_out_1_fromCore ;
output         ms_riscv32_mp_dmwr_mask_out_1_toPad ;
input          ms_riscv32_mp_dmwr_mask_out_2_fromCore ;
output         ms_riscv32_mp_dmwr_mask_out_2_toPad ;
input          ms_riscv32_mp_dmwr_mask_out_3_fromCore ;
output         ms_riscv32_mp_dmwr_mask_out_3_toPad ;
input          ms_riscv32_mp_dmwr_req_out_fromCore ;
output         ms_riscv32_mp_dmwr_req_out_toPad ;
input          ms_riscv32_mp_eirq_in_fromPad ;
output         ms_riscv32_mp_eirq_in_toCore ;
input          ms_riscv32_mp_hresp_in_fromPad ;
output         ms_riscv32_mp_hresp_in_toCore ;
input          ms_riscv32_mp_instr_hready_in_fromPad ;
output         ms_riscv32_mp_instr_hready_in_toCore ;
input          ms_riscv32_mp_instr_in_0_fromPad ;
output         ms_riscv32_mp_instr_in_0_toCore ;
input          ms_riscv32_mp_instr_in_10_fromPad ;
output         ms_riscv32_mp_instr_in_10_toCore ;
input          ms_riscv32_mp_instr_in_11_fromPad ;
output         ms_riscv32_mp_instr_in_11_toCore ;
input          ms_riscv32_mp_instr_in_12_fromPad ;
output         ms_riscv32_mp_instr_in_12_toCore ;
input          ms_riscv32_mp_instr_in_13_fromPad ;
output         ms_riscv32_mp_instr_in_13_toCore ;
input          ms_riscv32_mp_instr_in_14_fromPad ;
output         ms_riscv32_mp_instr_in_14_toCore ;
input          ms_riscv32_mp_instr_in_15_fromPad ;
output         ms_riscv32_mp_instr_in_15_toCore ;
input          ms_riscv32_mp_instr_in_16_fromPad ;
output         ms_riscv32_mp_instr_in_16_toCore ;
input          ms_riscv32_mp_instr_in_17_fromPad ;
output         ms_riscv32_mp_instr_in_17_toCore ;
input          ms_riscv32_mp_instr_in_18_fromPad ;
output         ms_riscv32_mp_instr_in_18_toCore ;
input          ms_riscv32_mp_instr_in_19_fromPad ;
output         ms_riscv32_mp_instr_in_19_toCore ;
input          ms_riscv32_mp_instr_in_1_fromPad ;
output         ms_riscv32_mp_instr_in_1_toCore ;
input          ms_riscv32_mp_instr_in_20_fromPad ;
output         ms_riscv32_mp_instr_in_20_toCore ;
input          ms_riscv32_mp_instr_in_21_fromPad ;
output         ms_riscv32_mp_instr_in_21_toCore ;
input          ms_riscv32_mp_instr_in_22_fromPad ;
output         ms_riscv32_mp_instr_in_22_toCore ;
input          ms_riscv32_mp_instr_in_23_fromPad ;
output         ms_riscv32_mp_instr_in_23_toCore ;
input          ms_riscv32_mp_instr_in_24_fromPad ;
output         ms_riscv32_mp_instr_in_24_toCore ;
input          ms_riscv32_mp_instr_in_25_fromPad ;
output         ms_riscv32_mp_instr_in_25_toCore ;
input          ms_riscv32_mp_instr_in_26_fromPad ;
output         ms_riscv32_mp_instr_in_26_toCore ;
input          ms_riscv32_mp_instr_in_27_fromPad ;
output         ms_riscv32_mp_instr_in_27_toCore ;
input          ms_riscv32_mp_instr_in_28_fromPad ;
output         ms_riscv32_mp_instr_in_28_toCore ;
input          ms_riscv32_mp_instr_in_29_fromPad ;
output         ms_riscv32_mp_instr_in_29_toCore ;
input          ms_riscv32_mp_instr_in_2_fromPad ;
output         ms_riscv32_mp_instr_in_2_toCore ;
input          ms_riscv32_mp_instr_in_30_fromPad ;
output         ms_riscv32_mp_instr_in_30_toCore ;
input          ms_riscv32_mp_instr_in_31_fromPad ;
output         ms_riscv32_mp_instr_in_31_toCore ;
input          ms_riscv32_mp_instr_in_3_fromPad ;
output         ms_riscv32_mp_instr_in_3_toCore ;
input          ms_riscv32_mp_instr_in_4_fromPad ;
output         ms_riscv32_mp_instr_in_4_toCore ;
input          ms_riscv32_mp_instr_in_5_fromPad ;
output         ms_riscv32_mp_instr_in_5_toCore ;
input          ms_riscv32_mp_instr_in_6_fromPad ;
output         ms_riscv32_mp_instr_in_6_toCore ;
input          ms_riscv32_mp_instr_in_7_fromPad ;
output         ms_riscv32_mp_instr_in_7_toCore ;
input          ms_riscv32_mp_instr_in_8_fromPad ;
output         ms_riscv32_mp_instr_in_8_toCore ;
input          ms_riscv32_mp_instr_in_9_fromPad ;
output         ms_riscv32_mp_instr_in_9_toCore ;
input          ms_riscv32_mp_rc_in_0_fromPad ;
output         ms_riscv32_mp_rc_in_0_toCore ;
input          ms_riscv32_mp_rc_in_10_fromPad ;
output         ms_riscv32_mp_rc_in_10_toCore ;
input          ms_riscv32_mp_rc_in_11_fromPad ;
output         ms_riscv32_mp_rc_in_11_toCore ;
input          ms_riscv32_mp_rc_in_12_fromPad ;
output         ms_riscv32_mp_rc_in_12_toCore ;
input          ms_riscv32_mp_rc_in_13_fromPad ;
output         ms_riscv32_mp_rc_in_13_toCore ;
input          ms_riscv32_mp_rc_in_14_fromPad ;
output         ms_riscv32_mp_rc_in_14_toCore ;
input          ms_riscv32_mp_rc_in_15_fromPad ;
output         ms_riscv32_mp_rc_in_15_toCore ;
input          ms_riscv32_mp_rc_in_16_fromPad ;
output         ms_riscv32_mp_rc_in_16_toCore ;
input          ms_riscv32_mp_rc_in_17_fromPad ;
output         ms_riscv32_mp_rc_in_17_toCore ;
input          ms_riscv32_mp_rc_in_18_fromPad ;
output         ms_riscv32_mp_rc_in_18_toCore ;
input          ms_riscv32_mp_rc_in_19_fromPad ;
output         ms_riscv32_mp_rc_in_19_toCore ;
input          ms_riscv32_mp_rc_in_1_fromPad ;
output         ms_riscv32_mp_rc_in_1_toCore ;
input          ms_riscv32_mp_rc_in_20_fromPad ;
output         ms_riscv32_mp_rc_in_20_toCore ;
input          ms_riscv32_mp_rc_in_21_fromPad ;
output         ms_riscv32_mp_rc_in_21_toCore ;
input          ms_riscv32_mp_rc_in_22_fromPad ;
output         ms_riscv32_mp_rc_in_22_toCore ;
input          ms_riscv32_mp_rc_in_23_fromPad ;
output         ms_riscv32_mp_rc_in_23_toCore ;
input          ms_riscv32_mp_rc_in_24_fromPad ;
output         ms_riscv32_mp_rc_in_24_toCore ;
input          ms_riscv32_mp_rc_in_25_fromPad ;
output         ms_riscv32_mp_rc_in_25_toCore ;
input          ms_riscv32_mp_rc_in_26_fromPad ;
output         ms_riscv32_mp_rc_in_26_toCore ;
input          ms_riscv32_mp_rc_in_27_fromPad ;
output         ms_riscv32_mp_rc_in_27_toCore ;
input          ms_riscv32_mp_rc_in_28_fromPad ;
output         ms_riscv32_mp_rc_in_28_toCore ;
input          ms_riscv32_mp_rc_in_29_fromPad ;
output         ms_riscv32_mp_rc_in_29_toCore ;
input          ms_riscv32_mp_rc_in_2_fromPad ;
output         ms_riscv32_mp_rc_in_2_toCore ;
input          ms_riscv32_mp_rc_in_30_fromPad ;
output         ms_riscv32_mp_rc_in_30_toCore ;
input          ms_riscv32_mp_rc_in_31_fromPad ;
output         ms_riscv32_mp_rc_in_31_toCore ;
input          ms_riscv32_mp_rc_in_32_fromPad ;
output         ms_riscv32_mp_rc_in_32_toCore ;
input          ms_riscv32_mp_rc_in_33_fromPad ;
output         ms_riscv32_mp_rc_in_33_toCore ;
input          ms_riscv32_mp_rc_in_34_fromPad ;
output         ms_riscv32_mp_rc_in_34_toCore ;
input          ms_riscv32_mp_rc_in_35_fromPad ;
output         ms_riscv32_mp_rc_in_35_toCore ;
input          ms_riscv32_mp_rc_in_36_fromPad ;
output         ms_riscv32_mp_rc_in_36_toCore ;
input          ms_riscv32_mp_rc_in_37_fromPad ;
output         ms_riscv32_mp_rc_in_37_toCore ;
input          ms_riscv32_mp_rc_in_38_fromPad ;
output         ms_riscv32_mp_rc_in_38_toCore ;
input          ms_riscv32_mp_rc_in_39_fromPad ;
output         ms_riscv32_mp_rc_in_39_toCore ;
input          ms_riscv32_mp_rc_in_3_fromPad ;
output         ms_riscv32_mp_rc_in_3_toCore ;
input          ms_riscv32_mp_rc_in_40_fromPad ;
output         ms_riscv32_mp_rc_in_40_toCore ;
input          ms_riscv32_mp_rc_in_41_fromPad ;
output         ms_riscv32_mp_rc_in_41_toCore ;
input          ms_riscv32_mp_rc_in_42_fromPad ;
output         ms_riscv32_mp_rc_in_42_toCore ;
input          ms_riscv32_mp_rc_in_43_fromPad ;
output         ms_riscv32_mp_rc_in_43_toCore ;
input          ms_riscv32_mp_rc_in_44_fromPad ;
output         ms_riscv32_mp_rc_in_44_toCore ;
input          ms_riscv32_mp_rc_in_45_fromPad ;
output         ms_riscv32_mp_rc_in_45_toCore ;
input          ms_riscv32_mp_rc_in_46_fromPad ;
output         ms_riscv32_mp_rc_in_46_toCore ;
input          ms_riscv32_mp_rc_in_47_fromPad ;
output         ms_riscv32_mp_rc_in_47_toCore ;
input          ms_riscv32_mp_rc_in_48_fromPad ;
output         ms_riscv32_mp_rc_in_48_toCore ;
input          ms_riscv32_mp_rc_in_49_fromPad ;
output         ms_riscv32_mp_rc_in_49_toCore ;
input          ms_riscv32_mp_rc_in_4_fromPad ;
output         ms_riscv32_mp_rc_in_4_toCore ;
input          ms_riscv32_mp_rc_in_50_fromPad ;
output         ms_riscv32_mp_rc_in_50_toCore ;
input          ms_riscv32_mp_rc_in_51_fromPad ;
output         ms_riscv32_mp_rc_in_51_toCore ;
input          ms_riscv32_mp_rc_in_52_fromPad ;
output         ms_riscv32_mp_rc_in_52_toCore ;
input          ms_riscv32_mp_rc_in_53_fromPad ;
output         ms_riscv32_mp_rc_in_53_toCore ;
input          ms_riscv32_mp_rc_in_54_fromPad ;
output         ms_riscv32_mp_rc_in_54_toCore ;
input          ms_riscv32_mp_rc_in_55_fromPad ;
output         ms_riscv32_mp_rc_in_55_toCore ;
input          ms_riscv32_mp_rc_in_56_fromPad ;
output         ms_riscv32_mp_rc_in_56_toCore ;
input          ms_riscv32_mp_rc_in_57_fromPad ;
output         ms_riscv32_mp_rc_in_57_toCore ;
input          ms_riscv32_mp_rc_in_58_fromPad ;
output         ms_riscv32_mp_rc_in_58_toCore ;
input          ms_riscv32_mp_rc_in_59_fromPad ;
output         ms_riscv32_mp_rc_in_59_toCore ;
input          ms_riscv32_mp_rc_in_5_fromPad ;
output         ms_riscv32_mp_rc_in_5_toCore ;
input          ms_riscv32_mp_rc_in_60_fromPad ;
output         ms_riscv32_mp_rc_in_60_toCore ;
input          ms_riscv32_mp_rc_in_61_fromPad ;
output         ms_riscv32_mp_rc_in_61_toCore ;
input          ms_riscv32_mp_rc_in_62_fromPad ;
output         ms_riscv32_mp_rc_in_62_toCore ;
input          ms_riscv32_mp_rc_in_63_fromPad ;
output         ms_riscv32_mp_rc_in_63_toCore ;
input          ms_riscv32_mp_rc_in_6_fromPad ;
output         ms_riscv32_mp_rc_in_6_toCore ;
input          ms_riscv32_mp_rc_in_7_fromPad ;
output         ms_riscv32_mp_rc_in_7_toCore ;
input          ms_riscv32_mp_rc_in_8_fromPad ;
output         ms_riscv32_mp_rc_in_8_toCore ;
input          ms_riscv32_mp_rc_in_9_fromPad ;
output         ms_riscv32_mp_rc_in_9_toCore ;
input          ms_riscv32_mp_rst_in_fromPad ;
output         ms_riscv32_mp_rst_in_toCore ;
input          ms_riscv32_mp_sirq_in_fromPad ;
output         ms_riscv32_mp_sirq_in_toCore ;
input          ms_riscv32_mp_tirq_in_fromPad ;
output         ms_riscv32_mp_tirq_in_toCore ;
input          ramclk_p_fromPad ;
output         ramclk_p_toCore ;
input          selectJtagInput ;
input          selectJtagOutput ;
input          shiftBscan2Edge ;
input          update_clock ;
 
wire LOGICLOW;
wire LOGICHIGH;
wire bscanShift1_WIRE ;
wire bscanShift10_WIRE ;
wire bscanShift100_WIRE ;
wire bscanShift101_WIRE ;
wire bscanShift102_WIRE ;
wire bscanShift103_WIRE ;
wire bscanShift104_WIRE ;
wire bscanShift105_WIRE ;
wire bscanShift106_WIRE ;
wire bscanShift107_WIRE ;
wire bscanShift108_WIRE ;
wire bscanShift109_WIRE ;
wire bscanShift11_WIRE ;
wire bscanShift110_WIRE ;
wire bscanShift111_WIRE ;
wire bscanShift112_WIRE ;
wire bscanShift113_WIRE ;
wire bscanShift114_WIRE ;
wire bscanShift115_WIRE ;
wire bscanShift116_WIRE ;
wire bscanShift117_WIRE ;
wire bscanShift118_WIRE ;
wire bscanShift119_WIRE ;
wire bscanShift12_WIRE ;
wire bscanShift120_WIRE ;
wire bscanShift121_WIRE ;
wire bscanShift122_WIRE ;
wire bscanShift123_WIRE ;
wire bscanShift124_WIRE ;
wire bscanShift125_WIRE ;
wire bscanShift126_WIRE ;
wire bscanShift127_WIRE ;
wire bscanShift128_WIRE ;
wire bscanShift129_WIRE ;
wire bscanShift13_WIRE ;
wire bscanShift130_WIRE ;
wire bscanShift131_WIRE ;
wire bscanShift132_WIRE ;
wire bscanShift133_WIRE ;
wire bscanShift134_WIRE ;
wire bscanShift135_WIRE ;
wire bscanShift136_WIRE ;
wire bscanShift137_WIRE ;
wire bscanShift138_WIRE ;
wire bscanShift139_WIRE ;
wire bscanShift14_WIRE ;
wire bscanShift140_WIRE ;
wire bscanShift141_WIRE ;
wire bscanShift142_WIRE ;
wire bscanShift143_WIRE ;
wire bscanShift144_WIRE ;
wire bscanShift145_WIRE ;
wire bscanShift146_WIRE ;
wire bscanShift147_WIRE ;
wire bscanShift148_WIRE ;
wire bscanShift149_WIRE ;
wire bscanShift15_WIRE ;
wire bscanShift150_WIRE ;
wire bscanShift151_WIRE ;
wire bscanShift152_WIRE ;
wire bscanShift153_WIRE ;
wire bscanShift154_WIRE ;
wire bscanShift155_WIRE ;
wire bscanShift156_WIRE ;
wire bscanShift157_WIRE ;
wire bscanShift158_WIRE ;
wire bscanShift159_WIRE ;
wire bscanShift16_WIRE ;
wire bscanShift160_WIRE ;
wire bscanShift161_WIRE ;
wire bscanShift162_WIRE ;
wire bscanShift163_WIRE ;
wire bscanShift164_WIRE ;
wire bscanShift165_WIRE ;
wire bscanShift166_WIRE ;
wire bscanShift167_WIRE ;
wire bscanShift168_WIRE ;
wire bscanShift169_WIRE ;
wire bscanShift17_WIRE ;
wire bscanShift170_WIRE ;
wire bscanShift171_WIRE ;
wire bscanShift172_WIRE ;
wire bscanShift173_WIRE ;
wire bscanShift174_WIRE ;
wire bscanShift175_WIRE ;
wire bscanShift176_WIRE ;
wire bscanShift177_WIRE ;
wire bscanShift178_WIRE ;
wire bscanShift179_WIRE ;
wire bscanShift18_WIRE ;
wire bscanShift180_WIRE ;
wire bscanShift181_WIRE ;
wire bscanShift182_WIRE ;
wire bscanShift183_WIRE ;
wire bscanShift184_WIRE ;
wire bscanShift185_WIRE ;
wire bscanShift186_WIRE ;
wire bscanShift187_WIRE ;
wire bscanShift188_WIRE ;
wire bscanShift189_WIRE ;
wire bscanShift19_WIRE ;
wire bscanShift190_WIRE ;
wire bscanShift191_WIRE ;
wire bscanShift192_WIRE ;
wire bscanShift193_WIRE ;
wire bscanShift194_WIRE ;
wire bscanShift195_WIRE ;
wire bscanShift196_WIRE ;
wire bscanShift197_WIRE ;
wire bscanShift198_WIRE ;
wire bscanShift199_WIRE ;
wire bscanShift2_WIRE ;
wire bscanShift20_WIRE ;
wire bscanShift200_WIRE ;
wire bscanShift201_WIRE ;
wire bscanShift202_WIRE ;
wire bscanShift203_WIRE ;
wire bscanShift204_WIRE ;
wire bscanShift205_WIRE ;
wire bscanShift206_WIRE ;
wire bscanShift207_WIRE ;
wire bscanShift208_WIRE ;
wire bscanShift209_WIRE ;
wire bscanShift21_WIRE ;
wire bscanShift210_WIRE ;
wire bscanShift211_WIRE ;
wire bscanShift212_WIRE ;
wire bscanShift213_WIRE ;
wire bscanShift214_WIRE ;
wire bscanShift215_WIRE ;
wire bscanShift216_WIRE ;
wire bscanShift217_WIRE ;
wire bscanShift218_WIRE ;
wire bscanShift219_WIRE ;
wire bscanShift22_WIRE ;
wire bscanShift23_WIRE ;
wire bscanShift24_WIRE ;
wire bscanShift25_WIRE ;
wire bscanShift26_WIRE ;
wire bscanShift27_WIRE ;
wire bscanShift28_WIRE ;
wire bscanShift29_WIRE ;
wire bscanShift3_WIRE ;
wire bscanShift30_WIRE ;
wire bscanShift31_WIRE ;
wire bscanShift32_WIRE ;
wire bscanShift33_WIRE ;
wire bscanShift34_WIRE ;
wire bscanShift35_WIRE ;
wire bscanShift36_WIRE ;
wire bscanShift37_WIRE ;
wire bscanShift38_WIRE ;
wire bscanShift39_WIRE ;
wire bscanShift4_WIRE ;
wire bscanShift40_WIRE ;
wire bscanShift41_WIRE ;
wire bscanShift42_WIRE ;
wire bscanShift43_WIRE ;
wire bscanShift44_WIRE ;
wire bscanShift45_WIRE ;
wire bscanShift46_WIRE ;
wire bscanShift47_WIRE ;
wire bscanShift48_WIRE ;
wire bscanShift49_WIRE ;
wire bscanShift5_WIRE ;
wire bscanShift50_WIRE ;
wire bscanShift51_WIRE ;
wire bscanShift52_WIRE ;
wire bscanShift53_WIRE ;
wire bscanShift54_WIRE ;
wire bscanShift55_WIRE ;
wire bscanShift56_WIRE ;
wire bscanShift57_WIRE ;
wire bscanShift58_WIRE ;
wire bscanShift59_WIRE ;
wire bscanShift6_WIRE ;
wire bscanShift60_WIRE ;
wire bscanShift61_WIRE ;
wire bscanShift62_WIRE ;
wire bscanShift63_WIRE ;
wire bscanShift64_WIRE ;
wire bscanShift65_WIRE ;
wire bscanShift66_WIRE ;
wire bscanShift67_WIRE ;
wire bscanShift68_WIRE ;
wire bscanShift69_WIRE ;
wire bscanShift7_WIRE ;
wire bscanShift70_WIRE ;
wire bscanShift71_WIRE ;
wire bscanShift72_WIRE ;
wire bscanShift73_WIRE ;
wire bscanShift74_WIRE ;
wire bscanShift75_WIRE ;
wire bscanShift76_WIRE ;
wire bscanShift77_WIRE ;
wire bscanShift78_WIRE ;
wire bscanShift79_WIRE ;
wire bscanShift8_WIRE ;
wire bscanShift80_WIRE ;
wire bscanShift81_WIRE ;
wire bscanShift82_WIRE ;
wire bscanShift83_WIRE ;
wire bscanShift84_WIRE ;
wire bscanShift85_WIRE ;
wire bscanShift86_WIRE ;
wire bscanShift87_WIRE ;
wire bscanShift88_WIRE ;
wire bscanShift89_WIRE ;
wire bscanShift9_WIRE ;
wire bscanShift90_WIRE ;
wire bscanShift91_WIRE ;
wire bscanShift92_WIRE ;
wire bscanShift93_WIRE ;
wire bscanShift94_WIRE ;
wire bscanShift95_WIRE ;
wire bscanShift96_WIRE ;
wire bscanShift97_WIRE ;
wire bscanShift98_WIRE ;
wire bscanShift99_WIRE ;
 
assign LOGICHIGH = 1'b1;
assign LOGICLOW  = 1'b0;
 
msrv32_top_pass1_rtl_tessent_bscan_cell_in_s ms_riscv32_mp_clk_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_clk_in_fromPad  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .bscanShiftIn            ( CELL219_BSCAN_SI            ),
                         .bscanShiftOut           ( bscanShift219_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rst_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rst_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rst_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift219_WIRE          ),
                         .bscanShiftOut           ( bscanShift218_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_63_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_63_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_63_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift218_WIRE          ),
                         .bscanShiftOut           ( bscanShift217_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_62_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_62_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_62_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift217_WIRE          ),
                         .bscanShiftOut           ( bscanShift216_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_61_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_61_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_61_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift216_WIRE          ),
                         .bscanShiftOut           ( bscanShift215_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_60_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_60_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_60_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift215_WIRE          ),
                         .bscanShiftOut           ( bscanShift214_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_59_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_59_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_59_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift214_WIRE          ),
                         .bscanShiftOut           ( bscanShift213_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_58_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_58_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_58_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift213_WIRE          ),
                         .bscanShiftOut           ( bscanShift212_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_57_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_57_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_57_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift212_WIRE          ),
                         .bscanShiftOut           ( bscanShift211_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_56_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_56_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_56_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift211_WIRE          ),
                         .bscanShiftOut           ( bscanShift210_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_55_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_55_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_55_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift210_WIRE          ),
                         .bscanShiftOut           ( bscanShift209_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_54_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_54_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_54_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift209_WIRE          ),
                         .bscanShiftOut           ( bscanShift208_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_53_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_53_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_53_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift208_WIRE          ),
                         .bscanShiftOut           ( bscanShift207_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_52_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_52_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_52_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift207_WIRE          ),
                         .bscanShiftOut           ( bscanShift206_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_51_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_51_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_51_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift206_WIRE          ),
                         .bscanShiftOut           ( bscanShift205_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_50_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_50_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_50_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift205_WIRE          ),
                         .bscanShiftOut           ( bscanShift204_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_49_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_49_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_49_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift204_WIRE          ),
                         .bscanShiftOut           ( bscanShift203_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_48_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_48_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_48_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift203_WIRE          ),
                         .bscanShiftOut           ( bscanShift202_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_47_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_47_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_47_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift202_WIRE          ),
                         .bscanShiftOut           ( bscanShift201_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_46_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_46_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_46_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift201_WIRE          ),
                         .bscanShiftOut           ( bscanShift200_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_45_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_45_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_45_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift200_WIRE          ),
                         .bscanShiftOut           ( bscanShift199_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_44_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_44_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_44_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift199_WIRE          ),
                         .bscanShiftOut           ( bscanShift198_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_43_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_43_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_43_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift198_WIRE          ),
                         .bscanShiftOut           ( bscanShift197_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_42_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_42_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_42_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift197_WIRE          ),
                         .bscanShiftOut           ( bscanShift196_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_41_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_41_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_41_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift196_WIRE          ),
                         .bscanShiftOut           ( bscanShift195_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_40_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_40_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_40_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift195_WIRE          ),
                         .bscanShiftOut           ( bscanShift194_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_39_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_39_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_39_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift194_WIRE          ),
                         .bscanShiftOut           ( bscanShift193_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_38_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_38_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_38_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift193_WIRE          ),
                         .bscanShiftOut           ( bscanShift192_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_37_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_37_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_37_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift192_WIRE          ),
                         .bscanShiftOut           ( bscanShift191_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_36_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_36_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_36_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift191_WIRE          ),
                         .bscanShiftOut           ( bscanShift190_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_35_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_35_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_35_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift190_WIRE          ),
                         .bscanShiftOut           ( bscanShift189_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_34_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_34_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_34_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift189_WIRE          ),
                         .bscanShiftOut           ( bscanShift188_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_33_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_33_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_33_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift188_WIRE          ),
                         .bscanShiftOut           ( bscanShift187_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_32_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_32_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_32_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift187_WIRE          ),
                         .bscanShiftOut           ( bscanShift186_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_31_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_31_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_31_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift186_WIRE          ),
                         .bscanShiftOut           ( bscanShift185_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_30_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_30_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_30_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift185_WIRE          ),
                         .bscanShiftOut           ( bscanShift184_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_29_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_29_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_29_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift184_WIRE          ),
                         .bscanShiftOut           ( bscanShift183_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_28_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_28_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_28_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift183_WIRE          ),
                         .bscanShiftOut           ( bscanShift182_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_27_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_27_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_27_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift182_WIRE          ),
                         .bscanShiftOut           ( bscanShift181_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_26_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_26_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_26_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift181_WIRE          ),
                         .bscanShiftOut           ( bscanShift180_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_25_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_25_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_25_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift180_WIRE          ),
                         .bscanShiftOut           ( bscanShift179_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_24_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_24_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_24_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift179_WIRE          ),
                         .bscanShiftOut           ( bscanShift178_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_23_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_23_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_23_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift178_WIRE          ),
                         .bscanShiftOut           ( bscanShift177_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_22_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_22_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_22_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift177_WIRE          ),
                         .bscanShiftOut           ( bscanShift176_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_21_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_21_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_21_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift176_WIRE          ),
                         .bscanShiftOut           ( bscanShift175_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_20_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_20_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_20_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift175_WIRE          ),
                         .bscanShiftOut           ( bscanShift174_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_19_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_19_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_19_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift174_WIRE          ),
                         .bscanShiftOut           ( bscanShift173_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_18_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_18_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_18_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift173_WIRE          ),
                         .bscanShiftOut           ( bscanShift172_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_17_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_17_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_17_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift172_WIRE          ),
                         .bscanShiftOut           ( bscanShift171_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_16_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_16_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_16_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift171_WIRE          ),
                         .bscanShiftOut           ( bscanShift170_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_15_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_15_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_15_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift170_WIRE          ),
                         .bscanShiftOut           ( bscanShift169_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_14_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_14_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_14_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift169_WIRE          ),
                         .bscanShiftOut           ( bscanShift168_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_13_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_13_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_13_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift168_WIRE          ),
                         .bscanShiftOut           ( bscanShift167_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_12_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_12_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_12_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift167_WIRE          ),
                         .bscanShiftOut           ( bscanShift166_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_11_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_11_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_11_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift166_WIRE          ),
                         .bscanShiftOut           ( bscanShift165_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_10_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_10_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_10_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift165_WIRE          ),
                         .bscanShiftOut           ( bscanShift164_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_9_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_9_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_9_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift164_WIRE          ),
                         .bscanShiftOut           ( bscanShift163_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_8_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_8_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_8_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift163_WIRE          ),
                         .bscanShiftOut           ( bscanShift162_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_7_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_7_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_7_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift162_WIRE          ),
                         .bscanShiftOut           ( bscanShift161_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_6_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_6_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_6_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift161_WIRE          ),
                         .bscanShiftOut           ( bscanShift160_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_5_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_5_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_5_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift160_WIRE          ),
                         .bscanShiftOut           ( bscanShift159_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_4_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_4_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_4_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift159_WIRE          ),
                         .bscanShiftOut           ( bscanShift158_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_3_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_3_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_3_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift158_WIRE          ),
                         .bscanShiftOut           ( bscanShift157_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_2_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_2_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_2_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift157_WIRE          ),
                         .bscanShiftOut           ( bscanShift156_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_1_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_1_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_1_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift156_WIRE          ),
                         .bscanShiftOut           ( bscanShift155_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_rc_in_0_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_rc_in_0_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_rc_in_0_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift155_WIRE          ),
                         .bscanShiftOut           ( bscanShift154_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_31_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_31_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_31_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift154_WIRE          ),
                         .bscanShiftOut           ( bscanShift153_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_30_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_30_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_30_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift153_WIRE          ),
                         .bscanShiftOut           ( bscanShift152_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_29_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_29_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_29_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift152_WIRE          ),
                         .bscanShiftOut           ( bscanShift151_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_28_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_28_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_28_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift151_WIRE          ),
                         .bscanShiftOut           ( bscanShift150_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_27_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_27_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_27_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift150_WIRE          ),
                         .bscanShiftOut           ( bscanShift149_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_26_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_26_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_26_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift149_WIRE          ),
                         .bscanShiftOut           ( bscanShift148_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_25_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_25_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_25_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift148_WIRE          ),
                         .bscanShiftOut           ( bscanShift147_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_24_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_24_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_24_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift147_WIRE          ),
                         .bscanShiftOut           ( bscanShift146_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_23_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_23_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_23_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift146_WIRE          ),
                         .bscanShiftOut           ( bscanShift145_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_22_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_22_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_22_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift145_WIRE          ),
                         .bscanShiftOut           ( bscanShift144_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_21_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_21_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_21_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift144_WIRE          ),
                         .bscanShiftOut           ( bscanShift143_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_20_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_20_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_20_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift143_WIRE          ),
                         .bscanShiftOut           ( bscanShift142_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_19_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_19_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_19_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift142_WIRE          ),
                         .bscanShiftOut           ( bscanShift141_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_18_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_18_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_18_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift141_WIRE          ),
                         .bscanShiftOut           ( bscanShift140_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_17_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_17_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_17_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift140_WIRE          ),
                         .bscanShiftOut           ( bscanShift139_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_16_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_16_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_16_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift139_WIRE          ),
                         .bscanShiftOut           ( bscanShift138_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_15_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_15_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_15_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift138_WIRE          ),
                         .bscanShiftOut           ( bscanShift137_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_14_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_14_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_14_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift137_WIRE          ),
                         .bscanShiftOut           ( bscanShift136_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_13_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_13_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_13_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift136_WIRE          ),
                         .bscanShiftOut           ( bscanShift135_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_12_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_12_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_12_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift135_WIRE          ),
                         .bscanShiftOut           ( bscanShift134_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_11_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_11_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_11_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift134_WIRE          ),
                         .bscanShiftOut           ( bscanShift133_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_10_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_10_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_10_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift133_WIRE          ),
                         .bscanShiftOut           ( bscanShift132_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_9_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_9_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_9_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift132_WIRE          ),
                         .bscanShiftOut           ( bscanShift131_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_8_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_8_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_8_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift131_WIRE          ),
                         .bscanShiftOut           ( bscanShift130_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_7_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_7_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_7_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift130_WIRE          ),
                         .bscanShiftOut           ( bscanShift129_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_6_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_6_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_6_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift129_WIRE          ),
                         .bscanShiftOut           ( bscanShift128_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_5_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_5_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_5_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift128_WIRE          ),
                         .bscanShiftOut           ( bscanShift127_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_4_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_4_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_4_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift127_WIRE          ),
                         .bscanShiftOut           ( bscanShift126_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_3_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_3_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_3_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift126_WIRE          ),
                         .bscanShiftOut           ( bscanShift125_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_2_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_2_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_2_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift125_WIRE          ),
                         .bscanShiftOut           ( bscanShift124_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_1_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_1_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_1_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift124_WIRE          ),
                         .bscanShiftOut           ( bscanShift123_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_in_0_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_in_0_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_in_0_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift123_WIRE          ),
                         .bscanShiftOut           ( bscanShift122_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_instr_hready_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_instr_hready_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_instr_hready_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift122_WIRE          ),
                         .bscanShiftOut           ( bscanShift121_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_en_1 EN1_BCELL
                         (
                         .userEnable              ( EN1_userEnable1             ),
                         .padEnable1              ( EN1_en1                     ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .forceDisable            ( forceDisable                ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift121_WIRE          ),
                         .bscanShiftOut           ( bscanShift120_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_31_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_31_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_31_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift120_WIRE          ),
                         .bscanShiftOut           ( bscanShift119_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_30_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_30_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_30_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift119_WIRE          ),
                         .bscanShiftOut           ( bscanShift118_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_29_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_29_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_29_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift118_WIRE          ),
                         .bscanShiftOut           ( bscanShift117_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_28_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_28_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_28_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift117_WIRE          ),
                         .bscanShiftOut           ( bscanShift116_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_27_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_27_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_27_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift116_WIRE          ),
                         .bscanShiftOut           ( bscanShift115_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_26_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_26_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_26_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift115_WIRE          ),
                         .bscanShiftOut           ( bscanShift114_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_25_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_25_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_25_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift114_WIRE          ),
                         .bscanShiftOut           ( bscanShift113_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_24_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_24_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_24_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift113_WIRE          ),
                         .bscanShiftOut           ( bscanShift112_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_23_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_23_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_23_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift112_WIRE          ),
                         .bscanShiftOut           ( bscanShift111_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_22_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_22_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_22_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift111_WIRE          ),
                         .bscanShiftOut           ( bscanShift110_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_21_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_21_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_21_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift110_WIRE          ),
                         .bscanShiftOut           ( bscanShift109_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_20_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_20_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_20_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift109_WIRE          ),
                         .bscanShiftOut           ( bscanShift108_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_19_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_19_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_19_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift108_WIRE          ),
                         .bscanShiftOut           ( bscanShift107_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_18_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_18_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_18_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift107_WIRE          ),
                         .bscanShiftOut           ( bscanShift106_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_17_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_17_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_17_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift106_WIRE          ),
                         .bscanShiftOut           ( bscanShift105_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_16_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_16_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_16_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift105_WIRE          ),
                         .bscanShiftOut           ( bscanShift104_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_en_1 EN2_BCELL
                         (
                         .userEnable              ( EN2_userEnable1             ),
                         .padEnable1              ( EN2_en1                     ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .forceDisable            ( forceDisable                ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift104_WIRE          ),
                         .bscanShiftOut           ( bscanShift103_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_15_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_15_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_15_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift103_WIRE          ),
                         .bscanShiftOut           ( bscanShift102_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_14_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_14_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_14_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift102_WIRE          ),
                         .bscanShiftOut           ( bscanShift101_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_13_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_13_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_13_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift101_WIRE          ),
                         .bscanShiftOut           ( bscanShift100_WIRE          )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_12_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_12_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_12_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift100_WIRE          ),
                         .bscanShiftOut           ( bscanShift99_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_11_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_11_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_11_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift99_WIRE           ),
                         .bscanShiftOut           ( bscanShift98_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_10_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_10_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_10_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift98_WIRE           ),
                         .bscanShiftOut           ( bscanShift97_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_9_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_9_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_9_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift97_WIRE           ),
                         .bscanShiftOut           ( bscanShift96_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_8_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_8_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_8_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift96_WIRE           ),
                         .bscanShiftOut           ( bscanShift95_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_7_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_7_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_7_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift95_WIRE           ),
                         .bscanShiftOut           ( bscanShift94_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_6_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_6_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_6_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift94_WIRE           ),
                         .bscanShiftOut           ( bscanShift93_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_5_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_5_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_5_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift93_WIRE           ),
                         .bscanShiftOut           ( bscanShift92_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_4_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_4_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_4_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift92_WIRE           ),
                         .bscanShiftOut           ( bscanShift91_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_3_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_3_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_3_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift91_WIRE           ),
                         .bscanShiftOut           ( bscanShift90_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_2_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_2_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_2_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift90_WIRE           ),
                         .bscanShiftOut           ( bscanShift89_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_1_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_1_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_1_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift89_WIRE           ),
                         .bscanShiftOut           ( bscanShift88_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmaddr_out_0_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmaddr_out_0_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmaddr_out_0_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift88_WIRE           ),
                         .bscanShiftOut           ( bscanShift87_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_en_1 EN3_BCELL
                         (
                         .userEnable              ( EN3_userEnable1             ),
                         .padEnable1              ( EN3_en1                     ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .forceDisable            ( forceDisable                ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift87_WIRE           ),
                         .bscanShiftOut           ( bscanShift86_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_31_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_31_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_31_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift86_WIRE           ),
                         .bscanShiftOut           ( bscanShift85_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_30_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_30_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_30_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift85_WIRE           ),
                         .bscanShiftOut           ( bscanShift84_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_29_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_29_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_29_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift84_WIRE           ),
                         .bscanShiftOut           ( bscanShift83_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_28_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_28_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_28_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift83_WIRE           ),
                         .bscanShiftOut           ( bscanShift82_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_27_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_27_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_27_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift82_WIRE           ),
                         .bscanShiftOut           ( bscanShift81_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_26_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_26_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_26_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift81_WIRE           ),
                         .bscanShiftOut           ( bscanShift80_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_25_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_25_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_25_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift80_WIRE           ),
                         .bscanShiftOut           ( bscanShift79_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_24_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_24_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_24_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift79_WIRE           ),
                         .bscanShiftOut           ( bscanShift78_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_23_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_23_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_23_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift78_WIRE           ),
                         .bscanShiftOut           ( bscanShift77_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_22_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_22_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_22_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift77_WIRE           ),
                         .bscanShiftOut           ( bscanShift76_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_21_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_21_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_21_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift76_WIRE           ),
                         .bscanShiftOut           ( bscanShift75_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_20_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_20_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_20_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift75_WIRE           ),
                         .bscanShiftOut           ( bscanShift74_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_19_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_19_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_19_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift74_WIRE           ),
                         .bscanShiftOut           ( bscanShift73_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_18_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_18_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_18_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift73_WIRE           ),
                         .bscanShiftOut           ( bscanShift72_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_17_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_17_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_17_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift72_WIRE           ),
                         .bscanShiftOut           ( bscanShift71_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_16_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_16_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_16_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift71_WIRE           ),
                         .bscanShiftOut           ( bscanShift70_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_en_1 EN4_BCELL
                         (
                         .userEnable              ( EN4_userEnable1             ),
                         .padEnable1              ( EN4_en1                     ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .forceDisable            ( forceDisable                ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift70_WIRE           ),
                         .bscanShiftOut           ( bscanShift69_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_15_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_15_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_15_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift69_WIRE           ),
                         .bscanShiftOut           ( bscanShift68_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_14_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_14_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_14_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift68_WIRE           ),
                         .bscanShiftOut           ( bscanShift67_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_13_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_13_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_13_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift67_WIRE           ),
                         .bscanShiftOut           ( bscanShift66_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_12_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_12_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_12_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift66_WIRE           ),
                         .bscanShiftOut           ( bscanShift65_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_11_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_11_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_11_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift65_WIRE           ),
                         .bscanShiftOut           ( bscanShift64_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_10_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_10_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_10_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift64_WIRE           ),
                         .bscanShiftOut           ( bscanShift63_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_9_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_9_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_9_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift63_WIRE           ),
                         .bscanShiftOut           ( bscanShift62_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_8_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_8_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_8_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift62_WIRE           ),
                         .bscanShiftOut           ( bscanShift61_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_7_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_7_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_7_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift61_WIRE           ),
                         .bscanShiftOut           ( bscanShift60_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_6_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_6_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_6_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift60_WIRE           ),
                         .bscanShiftOut           ( bscanShift59_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_5_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_5_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_5_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift59_WIRE           ),
                         .bscanShiftOut           ( bscanShift58_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_4_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_4_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_4_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift58_WIRE           ),
                         .bscanShiftOut           ( bscanShift57_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_3_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_3_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_3_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift57_WIRE           ),
                         .bscanShiftOut           ( bscanShift56_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_2_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_2_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_2_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift56_WIRE           ),
                         .bscanShiftOut           ( bscanShift55_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_1_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_1_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_1_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift55_WIRE           ),
                         .bscanShiftOut           ( bscanShift54_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmdata_out_0_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmdata_out_0_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmdata_out_0_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift54_WIRE           ),
                         .bscanShiftOut           ( bscanShift53_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_en_1 EN5_BCELL
                         (
                         .userEnable              ( EN5_userEnable1             ),
                         .padEnable1              ( EN5_en1                     ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .forceDisable            ( forceDisable                ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift53_WIRE           ),
                         .bscanShiftOut           ( bscanShift52_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmwr_req_out_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmwr_req_out_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmwr_req_out_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift52_WIRE           ),
                         .bscanShiftOut           ( bscanShift51_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmwr_mask_out_3_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmwr_mask_out_3_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmwr_mask_out_3_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift51_WIRE           ),
                         .bscanShiftOut           ( bscanShift50_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmwr_mask_out_2_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmwr_mask_out_2_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmwr_mask_out_2_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift50_WIRE           ),
                         .bscanShiftOut           ( bscanShift49_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmwr_mask_out_1_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmwr_mask_out_1_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmwr_mask_out_1_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift49_WIRE           ),
                         .bscanShiftOut           ( bscanShift48_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_dmwr_mask_out_0_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_dmwr_mask_out_0_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_dmwr_mask_out_0_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift48_WIRE           ),
                         .bscanShiftOut           ( bscanShift47_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_31_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_31_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_31_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift47_WIRE           ),
                         .bscanShiftOut           ( bscanShift46_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_30_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_30_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_30_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift46_WIRE           ),
                         .bscanShiftOut           ( bscanShift45_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_29_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_29_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_29_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift45_WIRE           ),
                         .bscanShiftOut           ( bscanShift44_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_28_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_28_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_28_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift44_WIRE           ),
                         .bscanShiftOut           ( bscanShift43_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_27_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_27_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_27_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift43_WIRE           ),
                         .bscanShiftOut           ( bscanShift42_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_26_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_26_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_26_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift42_WIRE           ),
                         .bscanShiftOut           ( bscanShift41_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_25_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_25_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_25_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift41_WIRE           ),
                         .bscanShiftOut           ( bscanShift40_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_24_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_24_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_24_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift40_WIRE           ),
                         .bscanShiftOut           ( bscanShift39_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_23_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_23_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_23_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift39_WIRE           ),
                         .bscanShiftOut           ( bscanShift38_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_22_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_22_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_22_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift38_WIRE           ),
                         .bscanShiftOut           ( bscanShift37_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_21_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_21_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_21_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift37_WIRE           ),
                         .bscanShiftOut           ( bscanShift36_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_20_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_20_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_20_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift36_WIRE           ),
                         .bscanShiftOut           ( bscanShift35_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_19_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_19_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_19_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift35_WIRE           ),
                         .bscanShiftOut           ( bscanShift34_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_18_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_18_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_18_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift34_WIRE           ),
                         .bscanShiftOut           ( bscanShift33_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_17_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_17_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_17_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift33_WIRE           ),
                         .bscanShiftOut           ( bscanShift32_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_16_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_16_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_16_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift32_WIRE           ),
                         .bscanShiftOut           ( bscanShift31_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_15_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_15_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_15_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift31_WIRE           ),
                         .bscanShiftOut           ( bscanShift30_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_14_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_14_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_14_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift30_WIRE           ),
                         .bscanShiftOut           ( bscanShift29_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_13_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_13_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_13_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift29_WIRE           ),
                         .bscanShiftOut           ( bscanShift28_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_12_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_12_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_12_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift28_WIRE           ),
                         .bscanShiftOut           ( bscanShift27_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_11_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_11_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_11_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift27_WIRE           ),
                         .bscanShiftOut           ( bscanShift26_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_10_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_10_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_10_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift26_WIRE           ),
                         .bscanShiftOut           ( bscanShift25_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_9_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_9_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_9_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift25_WIRE           ),
                         .bscanShiftOut           ( bscanShift24_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_8_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_8_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_8_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift24_WIRE           ),
                         .bscanShiftOut           ( bscanShift23_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_7_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_7_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_7_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift23_WIRE           ),
                         .bscanShiftOut           ( bscanShift22_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_6_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_6_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_6_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift22_WIRE           ),
                         .bscanShiftOut           ( bscanShift21_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_5_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_5_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_5_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift21_WIRE           ),
                         .bscanShiftOut           ( bscanShift20_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_4_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_4_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_4_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift20_WIRE           ),
                         .bscanShiftOut           ( bscanShift19_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_3_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_3_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_3_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift19_WIRE           ),
                         .bscanShiftOut           ( bscanShift18_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_2_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_2_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_2_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift18_WIRE           ),
                         .bscanShiftOut           ( bscanShift17_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_1_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_1_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_1_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift17_WIRE           ),
                         .bscanShiftOut           ( bscanShift16_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_in_0_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_in_0_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_in_0_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift16_WIRE           ),
                         .bscanShiftOut           ( bscanShift15_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_data_hready_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_data_hready_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_data_hready_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift15_WIRE           ),
                         .bscanShiftOut           ( bscanShift14_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_hresp_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_hresp_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_hresp_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift14_WIRE           ),
                         .bscanShiftOut           ( bscanShift13_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_data_htrans_out_1_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_data_htrans_out_1_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_data_htrans_out_1_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift13_WIRE           ),
                         .bscanShiftOut           ( bscanShift12_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out ms_riscv32_mp_data_htrans_out_0_BCELL
                         (
                         .fromCore                ( ms_riscv32_mp_data_htrans_out_0_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( ms_riscv32_mp_data_htrans_out_0_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift12_WIRE           ),
                         .bscanShiftOut           ( bscanShift11_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_eirq_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_eirq_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_eirq_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift11_WIRE           ),
                         .bscanShiftOut           ( bscanShift10_WIRE           )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_tirq_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_tirq_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_tirq_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift10_WIRE           ),
                         .bscanShiftOut           ( bscanShift9_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_sirq_in_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_sirq_in_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_sirq_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift9_WIRE            ),
                         .bscanShiftOut           ( bscanShift8_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ms_riscv32_mp_clk_in_p_BCELL
                         (
                         .fromPad                 ( ms_riscv32_mp_clk_in_p_fromPad  ),
                         .toCore                  ( ms_riscv32_mp_clk_in_p_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift8_WIRE            ),
                         .bscanShiftOut           ( bscanShift7_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in ramclk_p_BCELL
                         (
                         .fromPad                 ( ramclk_p_fromPad            ),
                         .toCore                  ( ramclk_p_toCore             ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift7_WIRE            ),
                         .bscanShiftOut           ( bscanShift6_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in control_chain_enable_BCELL
                         (
                         .fromPad                 ( control_chain_enable_fromPad  ),
                         .toCore                  ( control_chain_enable_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift6_WIRE            ),
                         .bscanShiftOut           ( bscanShift5_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in control_chain_scan_in_BCELL
                         (
                         .fromPad                 ( control_chain_scan_in_fromPad  ),
                         .toCore                  ( control_chain_scan_in_toCore  ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift5_WIRE            ),
                         .bscanShiftOut           ( bscanShift4_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in edt_clock_BCELL
                         (
                         .fromPad                 ( edt_clock_fromPad           ),
                         .toCore                  ( edt_clock_toCore            ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift4_WIRE            ),
                         .bscanShiftOut           ( bscanShift3_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_out control_chain_scan_out_BCELL
                         (
                         .fromCore                ( control_chain_scan_out_fromCore  ),
                         .selectJtagOutput        ( selectJtagOutput            ),
                         .toPad                   ( control_chain_scan_out_toPad  ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift3_WIRE            ),
                         .bscanShiftOut           ( bscanShift2_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in edt_update_BCELL
                         (
                         .fromPad                 ( edt_update_fromPad          ),
                         .toCore                  ( edt_update_toCore           ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift2_WIRE            ),
                         .bscanShiftOut           ( bscanShift1_WIRE            )
                         );

msrv32_top_pass1_rtl_tessent_bscan_cell_in edt_channel_in1_p_BCELL
                         (
                         .fromPad                 ( edt_channel_in1_p_fromPad   ),
                         .toCore                  ( edt_channel_in1_p_toCore    ),
                         .selectJtagInput         ( selectJtagInput             ),
                         .clockBscan              ( capture_shift_clock         ),
                         .shiftBscan2Edge         ( shiftBscan2Edge             ),
                         .updateBscan             ( update_clock                ),
                         .bscanShiftIn            ( bscanShift1_WIRE            ),
                         .bscanShiftOut           ( CELL0_BSCAN_SO              )
                         );

endmodule

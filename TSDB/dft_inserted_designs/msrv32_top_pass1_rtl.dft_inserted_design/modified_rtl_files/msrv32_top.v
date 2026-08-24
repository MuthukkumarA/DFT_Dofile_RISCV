/*********************************

//File Name: msrv32_top.v

//Module Name: msrv32_top

//Description: This module will be used to hold the address of next instruction to be executed.

//Dependencies: msrv32_decoder.v
//              msrv32_immediate_generator.v
//              msrv32_alu.v
//              msrv32_branch_unit.v
//              msrv32_load_unit.v
//              msrv32_reg_bloc.v

//Version: 1.0

//Engineer: Alistair, Nishikant, Prasanna

//Email: tech_support@maven-silicon.com

//************************************/

`timescale 1ns / 1ps

module msrv32_top #(

   parameter BOOT_ADDRESS = 32'h00000000
    
   )(
     input  ms_riscv32_mp_clk_in,
     input  ms_riscv32_mp_rst_in,
      
   // connection with Real Time Counter
     input   [63:0] ms_riscv32_mp_rc_in,
     
   // connections with Instruction Memory
     output  [31:0] ms_riscv32_mp_imaddr_out,
     input   [31:0] ms_riscv32_mp_instr_in,
    input  ms_riscv32_mp_instr_hready_in,           //AHB ready

   // connections with Data Memory
     output  [31:0] ms_riscv32_mp_dmaddr_out,
     output  [31:0] ms_riscv32_mp_dmdata_out,
     output         ms_riscv32_mp_dmwr_req_out,
     output  [3:0 ] ms_riscv32_mp_dmwr_mask_out,
     input   [31:0] ms_riscv32_mp_data_in,
     input  ms_riscv32_mp_data_hready_in,            //AHB ready
     input  ms_riscv32_mp_hresp_in,                  //AHB response
     output [1:0] ms_riscv32_mp_data_htrans_out,     //AHB data trans
     
   //connections with Interrupt Controller
     input  ms_riscv32_mp_eirq_in,
     input  ms_riscv32_mp_tirq_in,
     input  ms_riscv32_mp_sirq_in,
    
   //TAP Interface
     input  tms_p,trst_p,tdi_p,tck_p,
     output tdo_p,
     
   //tessent_bD 
    // input tck,tdi,tms,trst,
     //output tdo,
	
   //occ
     input ms_riscv32_mp_clk_in_p,scan_en,shift_capture_clock,ramclk_p,

   //LBIST
     input control_chain_enable,control_chain_scan_in,shift_clock_src_p,edt_clock,
     output control_chain_scan_out,

   //EDT
     input edt_update,edt_channel_in1_p,
     output edt_channel_out1_p
   
    );


   //IO pad cell definations
     
     wire [31:0] EN1_en1_ts1, EN3_en1_ts1;
     wire [3:0] EN5_en1_ts1;
     wire [1:0] EN5_en1_ts2;
     wire [63:0] ms_riscv32_mp_rc_in_63_fromPad_ts1, 
                 ms_riscv32_mp_rc_in_62_toCore_ts1, 
                 ms_riscv32_mp_rc_in_61_toCore, 
                 ms_riscv32_mp_rc_in_61_toCore_ts1, 
                 ms_riscv32_mp_rc_in_60_toCore_ts1, 
                 ms_riscv32_mp_rc_in_59_toCore, 
                 ms_riscv32_mp_rc_in_59_toCore_ts1, 
                 ms_riscv32_mp_rc_in_58_toCore_ts1, 
                 ms_riscv32_mp_rc_in_57_toCore, 
                 ms_riscv32_mp_rc_in_57_toCore_ts1, 
                 ms_riscv32_mp_rc_in_56_toCore_ts1, 
                 ms_riscv32_mp_rc_in_55_toCore, 
                 ms_riscv32_mp_rc_in_55_toCore_ts1, 
                 ms_riscv32_mp_rc_in_54_toCore_ts1, 
                 ms_riscv32_mp_rc_in_53_toCore, 
                 ms_riscv32_mp_rc_in_53_toCore_ts1, 
                 ms_riscv32_mp_rc_in_52_toCore_ts1, 
                 ms_riscv32_mp_rc_in_51_toCore, 
                 ms_riscv32_mp_rc_in_51_toCore_ts1, 
                 ms_riscv32_mp_rc_in_50_toCore_ts1, 
                 ms_riscv32_mp_rc_in_49_toCore, 
                 ms_riscv32_mp_rc_in_49_toCore_ts1, 
                 ms_riscv32_mp_rc_in_48_toCore_ts1, 
                 ms_riscv32_mp_rc_in_47_toCore, 
                 ms_riscv32_mp_rc_in_47_toCore_ts1, 
                 ms_riscv32_mp_rc_in_46_toCore_ts1, 
                 ms_riscv32_mp_rc_in_45_toCore, 
                 ms_riscv32_mp_rc_in_45_toCore_ts1, 
                 ms_riscv32_mp_rc_in_44_toCore_ts1, 
                 ms_riscv32_mp_rc_in_43_toCore, 
                 ms_riscv32_mp_rc_in_43_toCore_ts1, 
                 ms_riscv32_mp_rc_in_42_toCore_ts1, 
                 ms_riscv32_mp_rc_in_41_toCore, 
                 ms_riscv32_mp_rc_in_41_toCore_ts1, 
                 ms_riscv32_mp_rc_in_40_toCore_ts1, 
                 ms_riscv32_mp_rc_in_39_toCore, 
                 ms_riscv32_mp_rc_in_39_toCore_ts1, 
                 ms_riscv32_mp_rc_in_38_toCore_ts1, 
                 ms_riscv32_mp_rc_in_37_toCore, 
                 ms_riscv32_mp_rc_in_37_toCore_ts1, 
                 ms_riscv32_mp_rc_in_36_toCore_ts1, 
                 ms_riscv32_mp_rc_in_35_toCore, 
                 ms_riscv32_mp_rc_in_35_toCore_ts1, 
                 ms_riscv32_mp_rc_in_34_toCore_ts1, 
                 ms_riscv32_mp_rc_in_33_toCore, 
                 ms_riscv32_mp_rc_in_33_toCore_ts1, 
                 ms_riscv32_mp_rc_in_32_toCore_ts1, 
                 ms_riscv32_mp_rc_in_31_toCore, 
                 ms_riscv32_mp_rc_in_31_toCore_ts1, 
                 ms_riscv32_mp_rc_in_30_toCore_ts1, 
                 ms_riscv32_mp_rc_in_29_toCore, 
                 ms_riscv32_mp_rc_in_29_toCore_ts1, 
                 ms_riscv32_mp_rc_in_28_toCore_ts1, 
                 ms_riscv32_mp_rc_in_27_toCore, 
                 ms_riscv32_mp_rc_in_27_toCore_ts1, 
                 ms_riscv32_mp_rc_in_26_toCore_ts1, 
                 ms_riscv32_mp_rc_in_25_toCore, 
                 ms_riscv32_mp_rc_in_25_toCore_ts1, 
                 ms_riscv32_mp_rc_in_24_toCore_ts1, 
                 ms_riscv32_mp_rc_in_23_toCore, 
                 ms_riscv32_mp_rc_in_23_toCore_ts1, 
                 ms_riscv32_mp_rc_in_22_toCore_ts1, 
                 ms_riscv32_mp_rc_in_21_toCore, 
                 ms_riscv32_mp_rc_in_21_toCore_ts1, 
                 ms_riscv32_mp_rc_in_20_toCore_ts1, 
                 ms_riscv32_mp_rc_in_19_toCore, 
                 ms_riscv32_mp_rc_in_19_toCore_ts1, 
                 ms_riscv32_mp_rc_in_18_toCore_ts1, 
                 ms_riscv32_mp_rc_in_17_toCore, 
                 ms_riscv32_mp_rc_in_17_toCore_ts1, 
                 ms_riscv32_mp_rc_in_16_toCore_ts1, 
                 ms_riscv32_mp_rc_in_15_toCore, 
                 ms_riscv32_mp_rc_in_15_toCore_ts1, 
                 ms_riscv32_mp_rc_in_14_toCore_ts1, 
                 ms_riscv32_mp_rc_in_13_toCore, 
                 ms_riscv32_mp_rc_in_13_toCore_ts1, 
                 ms_riscv32_mp_rc_in_12_toCore_ts1, 
                 ms_riscv32_mp_rc_in_11_toCore, 
                 ms_riscv32_mp_rc_in_11_toCore_ts1, 
                 ms_riscv32_mp_rc_in_10_toCore_ts1, 
                 ms_riscv32_mp_rc_in_9_toCore, ms_riscv32_mp_rc_in_9_toCore_ts1, 
                 ms_riscv32_mp_rc_in_8_toCore_ts1, ms_riscv32_mp_rc_in_7_toCore, 
                 ms_riscv32_mp_rc_in_7_toCore_ts1, 
                 ms_riscv32_mp_rc_in_6_toCore_ts1, ms_riscv32_mp_rc_in_5_toCore, 
                 ms_riscv32_mp_rc_in_5_toCore_ts1, 
                 ms_riscv32_mp_rc_in_4_toCore_ts1, ms_riscv32_mp_rc_in_3_toCore, 
                 ms_riscv32_mp_rc_in_3_toCore_ts1, 
                 ms_riscv32_mp_rc_in_2_toCore_ts1, ms_riscv32_mp_rc_in_1_toCore, 
                 ms_riscv32_mp_rc_in_1_toCore_ts1, 
                 ms_riscv32_mp_rc_in_0_toCore_ts1;
     wire [31:0] ms_riscv32_mp_instr_in_31_fromPad_ts1, 
                 ms_riscv32_mp_instr_in_30_toCore_ts1, 
                 ms_riscv32_mp_instr_in_29_toCore, 
                 ms_riscv32_mp_instr_in_29_toCore_ts1, 
                 ms_riscv32_mp_instr_in_28_toCore_ts1, 
                 ms_riscv32_mp_instr_in_27_toCore, 
                 ms_riscv32_mp_instr_in_27_toCore_ts1, 
                 ms_riscv32_mp_instr_in_26_toCore_ts1, 
                 ms_riscv32_mp_instr_in_25_toCore, 
                 ms_riscv32_mp_instr_in_25_toCore_ts1, 
                 ms_riscv32_mp_instr_in_24_toCore_ts1, 
                 ms_riscv32_mp_instr_in_23_toCore, 
                 ms_riscv32_mp_instr_in_23_toCore_ts1, 
                 ms_riscv32_mp_instr_in_22_toCore_ts1, 
                 ms_riscv32_mp_instr_in_21_toCore, 
                 ms_riscv32_mp_instr_in_21_toCore_ts1, 
                 ms_riscv32_mp_instr_in_20_toCore_ts1, 
                 ms_riscv32_mp_instr_in_19_toCore, 
                 ms_riscv32_mp_instr_in_19_toCore_ts1, 
                 ms_riscv32_mp_instr_in_18_toCore_ts1, 
                 ms_riscv32_mp_instr_in_17_toCore, 
                 ms_riscv32_mp_instr_in_17_toCore_ts1, 
                 ms_riscv32_mp_instr_in_16_toCore_ts1, 
                 ms_riscv32_mp_instr_in_15_toCore, 
                 ms_riscv32_mp_instr_in_15_toCore_ts1, 
                 ms_riscv32_mp_instr_in_14_toCore_ts1, 
                 ms_riscv32_mp_instr_in_13_toCore, 
                 ms_riscv32_mp_instr_in_13_toCore_ts1, 
                 ms_riscv32_mp_instr_in_12_toCore_ts1, 
                 ms_riscv32_mp_instr_in_11_toCore, 
                 ms_riscv32_mp_instr_in_11_toCore_ts1, 
                 ms_riscv32_mp_instr_in_10_toCore_ts1, 
                 ms_riscv32_mp_instr_in_9_toCore, 
                 ms_riscv32_mp_instr_in_9_toCore_ts1, 
                 ms_riscv32_mp_instr_in_8_toCore_ts1, 
                 ms_riscv32_mp_instr_in_7_toCore, 
                 ms_riscv32_mp_instr_in_7_toCore_ts1, 
                 ms_riscv32_mp_instr_in_6_toCore_ts1, 
                 ms_riscv32_mp_instr_in_5_toCore, 
                 ms_riscv32_mp_instr_in_5_toCore_ts1, 
                 ms_riscv32_mp_instr_in_4_toCore_ts1, 
                 ms_riscv32_mp_instr_in_3_toCore, 
                 ms_riscv32_mp_instr_in_3_toCore_ts1, 
                 ms_riscv32_mp_instr_in_2_toCore_ts1, 
                 ms_riscv32_mp_instr_in_1_toCore, 
                 ms_riscv32_mp_instr_in_1_toCore_ts1, 
                 ms_riscv32_mp_instr_in_0_toCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_31_toPad_ts1, 
                 ms_riscv32_mp_dmaddr_out_30_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_29_fromCore, 
                 ms_riscv32_mp_dmaddr_out_29_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_28_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_27_fromCore, 
                 ms_riscv32_mp_dmaddr_out_27_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_26_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_25_fromCore, 
                 ms_riscv32_mp_dmaddr_out_25_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_24_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_23_fromCore, 
                 ms_riscv32_mp_dmaddr_out_23_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_22_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_21_fromCore, 
                 ms_riscv32_mp_dmaddr_out_21_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_20_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_19_fromCore, 
                 ms_riscv32_mp_dmaddr_out_19_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_18_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_17_fromCore, 
                 ms_riscv32_mp_dmaddr_out_17_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_16_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_15_fromCore, 
                 ms_riscv32_mp_dmaddr_out_15_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_14_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_13_fromCore, 
                 ms_riscv32_mp_dmaddr_out_13_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_12_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_11_fromCore, 
                 ms_riscv32_mp_dmaddr_out_11_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_10_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_9_fromCore, 
                 ms_riscv32_mp_dmaddr_out_9_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_8_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_7_fromCore, 
                 ms_riscv32_mp_dmaddr_out_7_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_6_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_5_fromCore, 
                 ms_riscv32_mp_dmaddr_out_5_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_4_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_3_fromCore, 
                 ms_riscv32_mp_dmaddr_out_3_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_2_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_1_fromCore, 
                 ms_riscv32_mp_dmaddr_out_1_fromCore_ts1, 
                 ms_riscv32_mp_dmaddr_out_0_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_31_toPad_ts1, 
                 ms_riscv32_mp_dmdata_out_30_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_29_fromCore, 
                 ms_riscv32_mp_dmdata_out_29_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_28_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_27_fromCore, 
                 ms_riscv32_mp_dmdata_out_27_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_26_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_25_fromCore, 
                 ms_riscv32_mp_dmdata_out_25_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_24_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_23_fromCore, 
                 ms_riscv32_mp_dmdata_out_23_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_22_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_21_fromCore, 
                 ms_riscv32_mp_dmdata_out_21_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_20_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_19_fromCore, 
                 ms_riscv32_mp_dmdata_out_19_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_18_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_17_fromCore, 
                 ms_riscv32_mp_dmdata_out_17_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_16_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_15_fromCore, 
                 ms_riscv32_mp_dmdata_out_15_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_14_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_13_fromCore, 
                 ms_riscv32_mp_dmdata_out_13_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_12_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_11_fromCore, 
                 ms_riscv32_mp_dmdata_out_11_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_10_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_9_fromCore, 
                 ms_riscv32_mp_dmdata_out_9_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_8_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_7_fromCore, 
                 ms_riscv32_mp_dmdata_out_7_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_6_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_5_fromCore, 
                 ms_riscv32_mp_dmdata_out_5_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_4_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_3_fromCore, 
                 ms_riscv32_mp_dmdata_out_3_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_2_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_1_fromCore, 
                 ms_riscv32_mp_dmdata_out_1_fromCore_ts1, 
                 ms_riscv32_mp_dmdata_out_0_fromCore_ts1;
     wire [3:0] ms_riscv32_mp_dmwr_mask_out_3_toPad_ts1, 
                ms_riscv32_mp_dmwr_mask_out_2_fromCore_ts1, 
                ms_riscv32_mp_dmwr_mask_out_1_fromCore, 
                ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1, 
                ms_riscv32_mp_dmwr_mask_out_0_fromCore_ts1;
     wire [31:0] ms_riscv32_mp_data_in_31_fromPad_ts1, 
                 ms_riscv32_mp_data_in_30_toCore_ts1, 
                 ms_riscv32_mp_data_in_29_toCore, 
                 ms_riscv32_mp_data_in_29_toCore_ts1, 
                 ms_riscv32_mp_data_in_28_toCore_ts1, 
                 ms_riscv32_mp_data_in_27_toCore, 
                 ms_riscv32_mp_data_in_27_toCore_ts1, 
                 ms_riscv32_mp_data_in_26_toCore_ts1, 
                 ms_riscv32_mp_data_in_25_toCore, 
                 ms_riscv32_mp_data_in_25_toCore_ts1, 
                 ms_riscv32_mp_data_in_24_toCore_ts1, 
                 ms_riscv32_mp_data_in_23_toCore, 
                 ms_riscv32_mp_data_in_23_toCore_ts1, 
                 ms_riscv32_mp_data_in_22_toCore_ts1, 
                 ms_riscv32_mp_data_in_21_toCore, 
                 ms_riscv32_mp_data_in_21_toCore_ts1, 
                 ms_riscv32_mp_data_in_20_toCore_ts1, 
                 ms_riscv32_mp_data_in_19_toCore, 
                 ms_riscv32_mp_data_in_19_toCore_ts1, 
                 ms_riscv32_mp_data_in_18_toCore_ts1, 
                 ms_riscv32_mp_data_in_17_toCore, 
                 ms_riscv32_mp_data_in_17_toCore_ts1, 
                 ms_riscv32_mp_data_in_16_toCore_ts1, 
                 ms_riscv32_mp_data_in_15_toCore, 
                 ms_riscv32_mp_data_in_15_toCore_ts1, 
                 ms_riscv32_mp_data_in_14_toCore_ts1, 
                 ms_riscv32_mp_data_in_13_toCore, 
                 ms_riscv32_mp_data_in_13_toCore_ts1, 
                 ms_riscv32_mp_data_in_12_toCore_ts1, 
                 ms_riscv32_mp_data_in_11_toCore, 
                 ms_riscv32_mp_data_in_11_toCore_ts1, 
                 ms_riscv32_mp_data_in_10_toCore_ts1, 
                 ms_riscv32_mp_data_in_9_toCore, 
                 ms_riscv32_mp_data_in_9_toCore_ts1, 
                 ms_riscv32_mp_data_in_8_toCore_ts1, 
                 ms_riscv32_mp_data_in_7_toCore, 
                 ms_riscv32_mp_data_in_7_toCore_ts1, 
                 ms_riscv32_mp_data_in_6_toCore_ts1, 
                 ms_riscv32_mp_data_in_5_toCore, 
                 ms_riscv32_mp_data_in_5_toCore_ts1, 
                 ms_riscv32_mp_data_in_4_toCore_ts1, 
                 ms_riscv32_mp_data_in_3_toCore, 
                 ms_riscv32_mp_data_in_3_toCore_ts1, 
                 ms_riscv32_mp_data_in_2_toCore_ts1, 
                 ms_riscv32_mp_data_in_1_toCore, 
                 ms_riscv32_mp_data_in_1_toCore_ts1, 
                 ms_riscv32_mp_data_in_0_toCore_ts1;
     wire msrv32_top_pass1_rtl_tessent_tap_main_inst_so, 
          msrv32_top_pass1_rtl_tessent_tap_main_inst_tdo_en, tdi_i_so, 
          tms_i_to_tms, msrv32_top_pass1_rtl_tessent_sib_sri_inst_so, 
          msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst_so, 
          msrv32_top_pass1_rtl_tessent_tap_main_inst_to_select, 
          msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst_so, 
          msrv32_top_pass1_rtl_tessent_sib_sri_inst_to_select, 
          msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst_to_select, tck_i_C, 
          shift_dr_en, update_dr_en, test_logic_reset, capture_dr_en, trst_i_C, 
          scan_en_ts1, async_set_reset_static_disable, 
          tessent_persistent_cell_async_set_reset_dynamic_disable_Y, 
          async_set_reset_dynamic_disable_inv_ts1, rst_pad_C, host_bscan_to_sel, 
          force_disable, select_jtag_input, select_jtag_output, scan_out, 
          to_bscan_force_disable, to_bscan_select_jtag_input, 
          to_bscan_select_jtag_output, to_bscan_capture_shift_clock, 
          to_bscan_update_clock, to_bscan_shift_en, to_bscan_scan_in, 
          from_bscan_scan_out, EN1_en1, EN3_en1, EN5_en1, 
          ms_riscv32_mp_clk_in_fromPad, ms_riscv32_mp_rst_in_fromPad, 
          ms_riscv32_mp_rc_in_63_fromPad, ms_riscv32_mp_instr_in_31_fromPad, 
          ms_riscv32_mp_instr_hready_in_fromPad, 
          ms_riscv32_mp_dmaddr_out_31_toPad, ms_riscv32_mp_dmdata_out_31_toPad, 
          ms_riscv32_mp_dmwr_req_out_toPad, ms_riscv32_mp_dmwr_mask_out_3_toPad, 
          ms_riscv32_mp_data_in_31_fromPad, 
          ms_riscv32_mp_data_hready_in_fromPad, ms_riscv32_mp_hresp_in_fromPad, 
          ms_riscv32_mp_data_htrans_out_1_toPad, ms_riscv32_mp_eirq_in_fromPad, 
          ms_riscv32_mp_tirq_in_fromPad, ms_riscv32_mp_sirq_in_fromPad, 
          ms_riscv32_mp_clk_in_p_fromPad, ramclk_p_fromPad, 
          control_chain_enable_fromPad, control_chain_scan_in_fromPad, 
          edt_clock_fromPad, control_chain_scan_out_toPad, edt_update_fromPad, 
          edt_channel_in1_p_fromPad;
     wire [1:0] ms_riscv32_mp_data_htrans_out_1_toPad_ts1, 
                ms_riscv32_mp_data_htrans_out_0_fromCore_ts1;
     ipad tms_i ( .PAD(tms_p), .C(tms_i_to_tms) );
     ipad trst_i ( .PAD(trst_p), .C(trst_i_C) );
     ipad tdi_i ( .PAD(tdi_p), .C(tdi_i_so) );
     ipad tck_i ( .PAD(tck_p), .C(tck_i_C) );
     opad tdo_i ( .I(msrv32_top_pass1_rtl_tessent_tap_main_inst_so), .OEN(msrv32_top_pass1_rtl_tessent_tap_main_inst_tdo_en), .PAD(tdo_p) );

     ipad clk_pad ( .PAD(ms_riscv32_mp_clk_in), .C(ms_riscv32_mp_clk_in_fromPad) );
     ipad rst_pad ( .PAD( ms_riscv32_mp_rst_in), .C(ms_riscv32_mp_rst_in_fromPad));
     ipad hready_pad ( .PAD( ms_riscv32_mp_instr_hready_in), .C(ms_riscv32_mp_instr_hready_in_fromPad));
     
   // added by MK 
     ipad sirq_pad (.PAD(ms_riscv32_mp_sirq_in), .C(ms_riscv32_mp_sirq_in_fromPad));
     ipad tirq_pad (.PAD(ms_riscv32_mp_tirq_in), .C(ms_riscv32_mp_tirq_in_fromPad));
     ipad eirq_pad (.PAD(ms_riscv32_mp_eirq_in), .C(ms_riscv32_mp_eirq_in_fromPad));

     ipad mp_hresp_in_pad (.PAD (ms_riscv32_mp_hresp_in), .C(ms_riscv32_mp_hresp_in_fromPad));
     ipad mp_data_hready_in_pad (.PAD (ms_riscv32_mp_data_hready_in), .C(ms_riscv32_mp_data_hready_in_fromPad));

    // ipad tck_pad (.PAD(tck), .C());
   //  ipad tdi_pad (.PAD(tdi), .C());
    // ipad tms_pad (.PAD(tms), .C());
    // ipad trst_pad (.PAD(trst), .C());
    // opad tdo_pad ( .I(), .OEN(1'b1), .PAD(tdo) );
     


     ipad mp_clk_in_p_pad (.PAD(ms_riscv32_mp_clk_in_p), .C(ms_riscv32_mp_clk_in_p_fromPad));
     ipad scan_en_pad (.PAD(scan_en), .C(scan_en_ts1));
     ipad shift_capture_clock_pad (.PAD(shift_capture_clock), .C());
     ipad ramclk_p_pad (.PAD(ramclk_p), .C(ramclk_p_fromPad));


     ipad control_chain_enable_pad (.PAD(control_chain_enable), .C(control_chain_enable_fromPad));
     ipad control_chain_scan_in_pad (.PAD(control_chain_scan_in), .C(control_chain_scan_in_fromPad));
     ipad shift_clock_src_p_pad (.PAD(shift_clock_src_p), .C());
     ipad edt_clock_pad (.PAD(edt_clock), .C(edt_clock_fromPad));

     opad control_chain_scan_out_pad ( .I(control_chain_scan_out_toPad), .OEN(EN5_en1), .PAD(control_chain_scan_out));
	

     ipad edt_update_pad (.PAD(edt_update), .C(edt_update_fromPad));
     ipad edt_channel_in1_p_pad (.PAD(edt_channel_in1_p), .C(edt_channel_in1_p_fromPad));
     
     opad edt_channel_out1_p_pad ( .I(), .OEN(1'b1), .PAD(edt_channel_out1_p));
   
     
     
     

     opad mp_dmwr_req_out_pad (.I(ms_riscv32_mp_dmwr_req_out_toPad), .OEN(EN5_en1), .PAD(ms_riscv32_mp_dmwr_req_out));

     genvar i;
     	for (i=0;i<2;i=i+1)
     	begin
         wire ms_riscv32_mp_data_htrans_out_0_fromCore;

		//ms_riscv32_mp_data_htrans_out
	     opad mp_data_htrans_out_pad (.I(ms_riscv32_mp_data_htrans_out_0_fromCore), .OEN(EN5_en1_ts2[i * 1]), .PAD (ms_riscv32_mp_data_htrans_out[i]));
     	
           assign ms_riscv32_mp_data_htrans_out_0_fromCore = ms_riscv32_mp_data_htrans_out_0_fromCore_ts1[i * 1];
         end


//	genvar i;
     	for (i=0;i<32;i=i+1)
     	begin
         wire ms_riscv32_mp_data_in_30_toCore, ms_riscv32_mp_data_in_28_toCore, 
              ms_riscv32_mp_data_in_26_toCore, ms_riscv32_mp_data_in_24_toCore, 
              ms_riscv32_mp_data_in_22_toCore, ms_riscv32_mp_data_in_20_toCore, 
              ms_riscv32_mp_data_in_18_toCore, ms_riscv32_mp_data_in_16_toCore, 
              ms_riscv32_mp_data_in_14_toCore, ms_riscv32_mp_data_in_12_toCore, 
              ms_riscv32_mp_data_in_10_toCore, ms_riscv32_mp_data_in_8_toCore, 
              ms_riscv32_mp_data_in_6_toCore, ms_riscv32_mp_data_in_4_toCore, 
              ms_riscv32_mp_data_in_2_toCore, ms_riscv32_mp_data_in_0_toCore;

	     ipad mp_data_in_pad (.PAD ( ms_riscv32_mp_data_in[i]), .C(ms_riscv32_mp_data_in_0_toCore));
     	
           assign ms_riscv32_mp_data_in_30_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_30_toCore;

           assign ms_riscv32_mp_data_in_30_toCore = ms_riscv32_mp_data_in_29_toCore[i * 1];

           assign ms_riscv32_mp_data_in_28_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_28_toCore;

           assign ms_riscv32_mp_data_in_28_toCore = ms_riscv32_mp_data_in_27_toCore[i * 1];

           assign ms_riscv32_mp_data_in_26_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_26_toCore;

           assign ms_riscv32_mp_data_in_26_toCore = ms_riscv32_mp_data_in_25_toCore[i * 1];

           assign ms_riscv32_mp_data_in_24_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_24_toCore;

           assign ms_riscv32_mp_data_in_24_toCore = ms_riscv32_mp_data_in_23_toCore[i * 1];

           assign ms_riscv32_mp_data_in_22_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_22_toCore;

           assign ms_riscv32_mp_data_in_22_toCore = ms_riscv32_mp_data_in_21_toCore[i * 1];

           assign ms_riscv32_mp_data_in_20_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_20_toCore;

           assign ms_riscv32_mp_data_in_20_toCore = ms_riscv32_mp_data_in_19_toCore[i * 1];

           assign ms_riscv32_mp_data_in_18_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_18_toCore;

           assign ms_riscv32_mp_data_in_18_toCore = ms_riscv32_mp_data_in_17_toCore[i * 1];

           assign ms_riscv32_mp_data_in_16_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_16_toCore;

           assign ms_riscv32_mp_data_in_16_toCore = ms_riscv32_mp_data_in_15_toCore[i * 1];

           assign ms_riscv32_mp_data_in_14_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_14_toCore;

           assign ms_riscv32_mp_data_in_14_toCore = ms_riscv32_mp_data_in_13_toCore[i * 1];

           assign ms_riscv32_mp_data_in_12_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_12_toCore;

           assign ms_riscv32_mp_data_in_12_toCore = ms_riscv32_mp_data_in_11_toCore[i * 1];

           assign ms_riscv32_mp_data_in_10_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_10_toCore;

           assign ms_riscv32_mp_data_in_10_toCore = ms_riscv32_mp_data_in_9_toCore[i * 1];

           assign ms_riscv32_mp_data_in_8_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_8_toCore;

           assign ms_riscv32_mp_data_in_8_toCore = ms_riscv32_mp_data_in_7_toCore[i * 1];

           assign ms_riscv32_mp_data_in_6_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_6_toCore;

           assign ms_riscv32_mp_data_in_6_toCore = ms_riscv32_mp_data_in_5_toCore[i * 1];

           assign ms_riscv32_mp_data_in_4_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_4_toCore;

           assign ms_riscv32_mp_data_in_4_toCore = ms_riscv32_mp_data_in_3_toCore[i * 1];

           assign ms_riscv32_mp_data_in_2_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_2_toCore;

           assign ms_riscv32_mp_data_in_2_toCore = ms_riscv32_mp_data_in_1_toCore[i * 1];

           assign ms_riscv32_mp_data_in_0_toCore_ts1[i * 1] = ms_riscv32_mp_data_in_0_toCore;
         end

	
	for (i=0;i<4;i=i+1)
     	begin
         wire ms_riscv32_mp_dmwr_mask_out_2_fromCore, 
              ms_riscv32_mp_dmwr_mask_out_0_fromCore;

		//ms_riscv32_mp_dmwr_mask_out
	     opad mp_dmwr_mask_out_pad (.I(ms_riscv32_mp_dmwr_mask_out_0_fromCore), .OEN(EN5_en1_ts1[i * 1]), .PAD ( ms_riscv32_mp_dmwr_mask_out[i]));
     	
           assign ms_riscv32_mp_dmwr_mask_out_2_fromCore = ms_riscv32_mp_dmwr_mask_out_2_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmwr_mask_out_1_fromCore[i * 1] = ms_riscv32_mp_dmwr_mask_out_2_fromCore;

           assign ms_riscv32_mp_dmwr_mask_out_0_fromCore = ms_riscv32_mp_dmwr_mask_out_0_fromCore_ts1[i * 1];
         end


	for (i=0;i<32;i=i+1)
     	begin
        wire ms_riscv32_mp_dmdata_out_30_fromCore, 
             ms_riscv32_mp_dmdata_out_28_fromCore, 
             ms_riscv32_mp_dmdata_out_26_fromCore, 
             ms_riscv32_mp_dmdata_out_24_fromCore, 
             ms_riscv32_mp_dmdata_out_22_fromCore, 
             ms_riscv32_mp_dmdata_out_20_fromCore, 
             ms_riscv32_mp_dmdata_out_18_fromCore, 
             ms_riscv32_mp_dmdata_out_16_fromCore, 
             ms_riscv32_mp_dmdata_out_14_fromCore, 
             ms_riscv32_mp_dmdata_out_12_fromCore, 
             ms_riscv32_mp_dmdata_out_10_fromCore, 
             ms_riscv32_mp_dmdata_out_8_fromCore, 
             ms_riscv32_mp_dmdata_out_6_fromCore, 
             ms_riscv32_mp_dmdata_out_4_fromCore, 
             ms_riscv32_mp_dmdata_out_2_fromCore, 
             ms_riscv32_mp_dmdata_out_0_fromCore;

		
		// ms_riscv32_mp_dmdata_out
		opad  mp_dmdata_out_pad (.I(ms_riscv32_mp_dmdata_out_0_fromCore), .OEN(EN3_en1_ts1[i * 1]), .PAD (ms_riscv32_mp_dmdata_out[i]));
     	
           assign ms_riscv32_mp_dmdata_out_30_fromCore = ms_riscv32_mp_dmdata_out_30_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_29_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_30_fromCore;

           assign ms_riscv32_mp_dmdata_out_28_fromCore = ms_riscv32_mp_dmdata_out_28_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_27_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_28_fromCore;

           assign ms_riscv32_mp_dmdata_out_26_fromCore = ms_riscv32_mp_dmdata_out_26_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_25_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_26_fromCore;

           assign ms_riscv32_mp_dmdata_out_24_fromCore = ms_riscv32_mp_dmdata_out_24_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_23_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_24_fromCore;

           assign ms_riscv32_mp_dmdata_out_22_fromCore = ms_riscv32_mp_dmdata_out_22_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_21_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_22_fromCore;

           assign ms_riscv32_mp_dmdata_out_20_fromCore = ms_riscv32_mp_dmdata_out_20_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_19_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_20_fromCore;

           assign ms_riscv32_mp_dmdata_out_18_fromCore = ms_riscv32_mp_dmdata_out_18_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_17_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_18_fromCore;

           assign ms_riscv32_mp_dmdata_out_16_fromCore = ms_riscv32_mp_dmdata_out_16_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_15_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_16_fromCore;

           assign ms_riscv32_mp_dmdata_out_14_fromCore = ms_riscv32_mp_dmdata_out_14_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_13_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_14_fromCore;

           assign ms_riscv32_mp_dmdata_out_12_fromCore = ms_riscv32_mp_dmdata_out_12_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_11_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_12_fromCore;

           assign ms_riscv32_mp_dmdata_out_10_fromCore = ms_riscv32_mp_dmdata_out_10_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_9_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_10_fromCore;

           assign ms_riscv32_mp_dmdata_out_8_fromCore = ms_riscv32_mp_dmdata_out_8_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_7_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_8_fromCore;

           assign ms_riscv32_mp_dmdata_out_6_fromCore = ms_riscv32_mp_dmdata_out_6_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_5_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_6_fromCore;

           assign ms_riscv32_mp_dmdata_out_4_fromCore = ms_riscv32_mp_dmdata_out_4_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_3_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_4_fromCore;

           assign ms_riscv32_mp_dmdata_out_2_fromCore = ms_riscv32_mp_dmdata_out_2_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmdata_out_1_fromCore[i * 1] = ms_riscv32_mp_dmdata_out_2_fromCore;

           assign ms_riscv32_mp_dmdata_out_0_fromCore = ms_riscv32_mp_dmdata_out_0_fromCore_ts1[i * 1];
         end


	

	for (i=0;i<32;i=i+1)
     	begin
        wire ms_riscv32_mp_dmaddr_out_30_fromCore, 
             ms_riscv32_mp_dmaddr_out_28_fromCore, 
             ms_riscv32_mp_dmaddr_out_26_fromCore, 
             ms_riscv32_mp_dmaddr_out_24_fromCore, 
             ms_riscv32_mp_dmaddr_out_22_fromCore, 
             ms_riscv32_mp_dmaddr_out_20_fromCore, 
             ms_riscv32_mp_dmaddr_out_18_fromCore, 
             ms_riscv32_mp_dmaddr_out_16_fromCore, 
             ms_riscv32_mp_dmaddr_out_14_fromCore, 
             ms_riscv32_mp_dmaddr_out_12_fromCore, 
             ms_riscv32_mp_dmaddr_out_10_fromCore, 
             ms_riscv32_mp_dmaddr_out_8_fromCore, 
             ms_riscv32_mp_dmaddr_out_6_fromCore, 
             ms_riscv32_mp_dmaddr_out_4_fromCore, 
             ms_riscv32_mp_dmaddr_out_2_fromCore, 
             ms_riscv32_mp_dmaddr_out_0_fromCore;

		
		// ms_riscv32_mp_dmaddr_out
		opad mp_dmaddr_out_pad (.I(ms_riscv32_mp_dmaddr_out_0_fromCore), .OEN(EN1_en1_ts1[i * 1]), .PAD (ms_riscv32_mp_dmaddr_out[i]));
     	
           assign ms_riscv32_mp_dmaddr_out_30_fromCore = ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_29_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_30_fromCore;

           assign ms_riscv32_mp_dmaddr_out_28_fromCore = ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_27_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_28_fromCore;

           assign ms_riscv32_mp_dmaddr_out_26_fromCore = ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_25_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_26_fromCore;

           assign ms_riscv32_mp_dmaddr_out_24_fromCore = ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_23_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_24_fromCore;

           assign ms_riscv32_mp_dmaddr_out_22_fromCore = ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_21_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_22_fromCore;

           assign ms_riscv32_mp_dmaddr_out_20_fromCore = ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_19_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_20_fromCore;

           assign ms_riscv32_mp_dmaddr_out_18_fromCore = ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_17_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_18_fromCore;

           assign ms_riscv32_mp_dmaddr_out_16_fromCore = ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_15_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_16_fromCore;

           assign ms_riscv32_mp_dmaddr_out_14_fromCore = ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_13_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_14_fromCore;

           assign ms_riscv32_mp_dmaddr_out_12_fromCore = ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_11_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_12_fromCore;

           assign ms_riscv32_mp_dmaddr_out_10_fromCore = ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_9_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_10_fromCore;

           assign ms_riscv32_mp_dmaddr_out_8_fromCore = ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_7_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_8_fromCore;

           assign ms_riscv32_mp_dmaddr_out_6_fromCore = ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_5_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_6_fromCore;

           assign ms_riscv32_mp_dmaddr_out_4_fromCore = ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_3_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_4_fromCore;

           assign ms_riscv32_mp_dmaddr_out_2_fromCore = ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[i * 1];

           assign ms_riscv32_mp_dmaddr_out_1_fromCore[i * 1] = ms_riscv32_mp_dmaddr_out_2_fromCore;

           assign ms_riscv32_mp_dmaddr_out_0_fromCore = ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[i * 1];
         end



	for (i=0;i<32;i=i+1)
     	begin
         wire ms_riscv32_mp_instr_in_30_toCore, 
              ms_riscv32_mp_instr_in_28_toCore, 
              ms_riscv32_mp_instr_in_26_toCore, 
              ms_riscv32_mp_instr_in_24_toCore, 
              ms_riscv32_mp_instr_in_22_toCore, 
              ms_riscv32_mp_instr_in_20_toCore, 
              ms_riscv32_mp_instr_in_18_toCore, 
              ms_riscv32_mp_instr_in_16_toCore, 
              ms_riscv32_mp_instr_in_14_toCore, 
              ms_riscv32_mp_instr_in_12_toCore, 
              ms_riscv32_mp_instr_in_10_toCore, ms_riscv32_mp_instr_in_8_toCore, 
              ms_riscv32_mp_instr_in_6_toCore, ms_riscv32_mp_instr_in_4_toCore, 
              ms_riscv32_mp_instr_in_2_toCore, ms_riscv32_mp_instr_in_0_toCore;

		//ms_riscv32_mp_instr_in
	
	     ipad mp_instr_in_pad (.PAD (ms_riscv32_mp_instr_in[i]), .C(ms_riscv32_mp_instr_in_0_toCore));
     	
           assign ms_riscv32_mp_instr_in_30_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_30_toCore;

           assign ms_riscv32_mp_instr_in_30_toCore = ms_riscv32_mp_instr_in_29_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_28_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_28_toCore;

           assign ms_riscv32_mp_instr_in_28_toCore = ms_riscv32_mp_instr_in_27_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_26_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_26_toCore;

           assign ms_riscv32_mp_instr_in_26_toCore = ms_riscv32_mp_instr_in_25_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_24_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_24_toCore;

           assign ms_riscv32_mp_instr_in_24_toCore = ms_riscv32_mp_instr_in_23_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_22_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_22_toCore;

           assign ms_riscv32_mp_instr_in_22_toCore = ms_riscv32_mp_instr_in_21_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_20_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_20_toCore;

           assign ms_riscv32_mp_instr_in_20_toCore = ms_riscv32_mp_instr_in_19_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_18_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_18_toCore;

           assign ms_riscv32_mp_instr_in_18_toCore = ms_riscv32_mp_instr_in_17_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_16_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_16_toCore;

           assign ms_riscv32_mp_instr_in_16_toCore = ms_riscv32_mp_instr_in_15_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_14_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_14_toCore;

           assign ms_riscv32_mp_instr_in_14_toCore = ms_riscv32_mp_instr_in_13_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_12_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_12_toCore;

           assign ms_riscv32_mp_instr_in_12_toCore = ms_riscv32_mp_instr_in_11_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_10_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_10_toCore;

           assign ms_riscv32_mp_instr_in_10_toCore = ms_riscv32_mp_instr_in_9_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_8_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_8_toCore;

           assign ms_riscv32_mp_instr_in_8_toCore = ms_riscv32_mp_instr_in_7_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_6_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_6_toCore;

           assign ms_riscv32_mp_instr_in_6_toCore = ms_riscv32_mp_instr_in_5_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_4_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_4_toCore;

           assign ms_riscv32_mp_instr_in_4_toCore = ms_riscv32_mp_instr_in_3_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_2_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_2_toCore;

           assign ms_riscv32_mp_instr_in_2_toCore = ms_riscv32_mp_instr_in_1_toCore[i * 1];

           assign ms_riscv32_mp_instr_in_0_toCore_ts1[i * 1] = ms_riscv32_mp_instr_in_0_toCore;
         end

	
	
       	for (i=0;i<64;i=i+1)
     	begin
         wire ms_riscv32_mp_rc_in_62_toCore, ms_riscv32_mp_rc_in_60_toCore, 
              ms_riscv32_mp_rc_in_58_toCore, ms_riscv32_mp_rc_in_56_toCore, 
              ms_riscv32_mp_rc_in_54_toCore, ms_riscv32_mp_rc_in_52_toCore, 
              ms_riscv32_mp_rc_in_50_toCore, ms_riscv32_mp_rc_in_48_toCore, 
              ms_riscv32_mp_rc_in_46_toCore, ms_riscv32_mp_rc_in_44_toCore, 
              ms_riscv32_mp_rc_in_42_toCore, ms_riscv32_mp_rc_in_40_toCore, 
              ms_riscv32_mp_rc_in_38_toCore, ms_riscv32_mp_rc_in_36_toCore, 
              ms_riscv32_mp_rc_in_34_toCore, ms_riscv32_mp_rc_in_32_toCore, 
              ms_riscv32_mp_rc_in_30_toCore, ms_riscv32_mp_rc_in_28_toCore, 
              ms_riscv32_mp_rc_in_26_toCore, ms_riscv32_mp_rc_in_24_toCore, 
              ms_riscv32_mp_rc_in_22_toCore, ms_riscv32_mp_rc_in_20_toCore, 
              ms_riscv32_mp_rc_in_18_toCore, ms_riscv32_mp_rc_in_16_toCore, 
              ms_riscv32_mp_rc_in_14_toCore, ms_riscv32_mp_rc_in_12_toCore, 
              ms_riscv32_mp_rc_in_10_toCore, ms_riscv32_mp_rc_in_8_toCore, 
              ms_riscv32_mp_rc_in_6_toCore, ms_riscv32_mp_rc_in_4_toCore, 
              ms_riscv32_mp_rc_in_2_toCore, ms_riscv32_mp_rc_in_0_toCore;

		//ms_riscv32_mp_rc_in
	
	     ipad ms_riscv32_mp_rc_in_pad (.PAD (ms_riscv32_mp_rc_in[i]), .C(ms_riscv32_mp_rc_in_0_toCore));
     	
           assign ms_riscv32_mp_rc_in_62_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_62_toCore;

           assign ms_riscv32_mp_rc_in_62_toCore = ms_riscv32_mp_rc_in_61_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_60_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_60_toCore;

           assign ms_riscv32_mp_rc_in_60_toCore = ms_riscv32_mp_rc_in_59_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_58_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_58_toCore;

           assign ms_riscv32_mp_rc_in_58_toCore = ms_riscv32_mp_rc_in_57_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_56_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_56_toCore;

           assign ms_riscv32_mp_rc_in_56_toCore = ms_riscv32_mp_rc_in_55_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_54_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_54_toCore;

           assign ms_riscv32_mp_rc_in_54_toCore = ms_riscv32_mp_rc_in_53_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_52_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_52_toCore;

           assign ms_riscv32_mp_rc_in_52_toCore = ms_riscv32_mp_rc_in_51_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_50_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_50_toCore;

           assign ms_riscv32_mp_rc_in_50_toCore = ms_riscv32_mp_rc_in_49_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_48_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_48_toCore;

           assign ms_riscv32_mp_rc_in_48_toCore = ms_riscv32_mp_rc_in_47_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_46_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_46_toCore;

           assign ms_riscv32_mp_rc_in_46_toCore = ms_riscv32_mp_rc_in_45_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_44_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_44_toCore;

           assign ms_riscv32_mp_rc_in_44_toCore = ms_riscv32_mp_rc_in_43_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_42_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_42_toCore;

           assign ms_riscv32_mp_rc_in_42_toCore = ms_riscv32_mp_rc_in_41_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_40_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_40_toCore;

           assign ms_riscv32_mp_rc_in_40_toCore = ms_riscv32_mp_rc_in_39_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_38_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_38_toCore;

           assign ms_riscv32_mp_rc_in_38_toCore = ms_riscv32_mp_rc_in_37_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_36_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_36_toCore;

           assign ms_riscv32_mp_rc_in_36_toCore = ms_riscv32_mp_rc_in_35_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_34_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_34_toCore;

           assign ms_riscv32_mp_rc_in_34_toCore = ms_riscv32_mp_rc_in_33_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_32_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_32_toCore;

           assign ms_riscv32_mp_rc_in_32_toCore = ms_riscv32_mp_rc_in_31_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_30_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_30_toCore;

           assign ms_riscv32_mp_rc_in_30_toCore = ms_riscv32_mp_rc_in_29_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_28_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_28_toCore;

           assign ms_riscv32_mp_rc_in_28_toCore = ms_riscv32_mp_rc_in_27_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_26_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_26_toCore;

           assign ms_riscv32_mp_rc_in_26_toCore = ms_riscv32_mp_rc_in_25_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_24_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_24_toCore;

           assign ms_riscv32_mp_rc_in_24_toCore = ms_riscv32_mp_rc_in_23_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_22_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_22_toCore;

           assign ms_riscv32_mp_rc_in_22_toCore = ms_riscv32_mp_rc_in_21_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_20_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_20_toCore;

           assign ms_riscv32_mp_rc_in_20_toCore = ms_riscv32_mp_rc_in_19_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_18_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_18_toCore;

           assign ms_riscv32_mp_rc_in_18_toCore = ms_riscv32_mp_rc_in_17_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_16_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_16_toCore;

           assign ms_riscv32_mp_rc_in_16_toCore = ms_riscv32_mp_rc_in_15_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_14_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_14_toCore;

           assign ms_riscv32_mp_rc_in_14_toCore = ms_riscv32_mp_rc_in_13_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_12_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_12_toCore;

           assign ms_riscv32_mp_rc_in_12_toCore = ms_riscv32_mp_rc_in_11_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_10_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_10_toCore;

           assign ms_riscv32_mp_rc_in_10_toCore = ms_riscv32_mp_rc_in_9_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_8_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_8_toCore;

           assign ms_riscv32_mp_rc_in_8_toCore = ms_riscv32_mp_rc_in_7_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_6_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_6_toCore;

           assign ms_riscv32_mp_rc_in_6_toCore = ms_riscv32_mp_rc_in_5_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_4_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_4_toCore;

           assign ms_riscv32_mp_rc_in_4_toCore = ms_riscv32_mp_rc_in_3_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_2_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_2_toCore;

           assign ms_riscv32_mp_rc_in_2_toCore = ms_riscv32_mp_rc_in_1_toCore[i * 1];

           assign ms_riscv32_mp_rc_in_0_toCore_ts1[i * 1] = ms_riscv32_mp_rc_in_0_toCore;
         end

	
// ms_riscv32_mp_imaddr_out : this port i set the condition dont touch; 





   // writeback selection
   parameter WB_ALU               =  3'b000;
   parameter WB_LU                =  3'b001;
   parameter WB_IMM               =  3'b010;
   parameter WB_IADDER_OUT        =  3'b011;
   parameter WB_CSR               =  3'b100;
   parameter WB_PC_PLUS           =  3'b101;

   // ---------------------------------
   // Internal wires and registers
   // ---------------------------------
   wire [31:0] iaddr;
   wire [31:0] pc;
   wire [31:0] pc_plus_4;
   wire        misaligned_instr;
   wire [31:0] pc_mux;
   wire [31:0] rs2;
   wire        mem_wr_req;
   
   wire 	   flush;
   wire [6:0 ] opcode;
   wire [2:0 ] funct3;
   wire [6:0 ] funct7;
   wire [4:0 ] rs1_addr;
   wire [4:0 ] rs2_addr;
   wire [4:0 ] rd_addr;
   wire [11:0] csr_addr;
   wire [31:7] instr_31_to_7;
   wire [31:0] rs1;
   wire [31:0] imm;
   wire        iadder_src;
   wire 	   wr_en_csr_file;
   wire 	   wr_en_integer_file;
   wire [11:0] csr_addr_reg;
   wire [2:0] csr_op_reg;
   wire [31:0] imm_reg;
   wire [31:0] rs1_reg;
   wire [31:0] pc_reg2;
   wire i_or_e;
   wire set_cause;
   wire [3:0 ] cause;
      wire set_epc;
   wire instret_inc;
   wire mie_clear;
   wire mie_set;
   wire misaligned_exception;
   wire mie;
   wire meie_out;
   wire mtie_out;
   wire msie_out;
   wire meip_out;
   wire mtip_out;
   wire msip_out;
   wire  rf_wr_en_reg;
   wire csr_wr_en_reg;
   wire csr_wr_en_reg_file;
   wire integer_wr_en_reg_file;
   wire [4:0] rd_addr_reg;
   wire [2:0] wb_mux_sel;
   wire [2:0] wb_mux_sel_reg; 
   wire [31:0] lu_output;
   wire [31:0] alu_result;
   wire [31:0] csr_data;
   wire [31:0] pc_plus_4_reg;
   wire [31:0] iadder_out_reg;
   wire [31:0] rs2_reg;
   wire alu_src_reg;
   wire [31:0] wb_mux_out;
   wire [31:0] alu_2nd_src_mux;
   
   wire illegal_instr;
   wire branch_taken;
   wire [31:0] next_pc;
   reg [31:0] pc_reg;
   wire misaligned_load;
   wire misaligned_store;
   wire [3:0] cause_in;
   wire [1:0] pc_src;
   wire trap_taken;
   wire [1:0] load_size_reg;
   wire [3:0] alu_opcode_reg;
   wire load_unsigned_reg;
/////////////////////////////////////////////////
         
   
   
   
   
   wire [31:0] iadder_out;
   
   wire [31:0] epc;
   wire [31:0] trap_address;
   
   wire [3:0] alu_opcode;
   
   wire [3:0] mem_wr_mask;
   wire [1:0] load_size;
   
   wire load_unsigned;
   
   wire alu_src;
   
   wire csr_wr_en;
   wire rf_wr_en;
   
   
   wire [2:0] imm_type;
   wire [2:0] csr_op;
   
   
   

   
   
   wire [31:0] su_data_out;
   wire [31:0] su_d_addr;
   wire [3:0] su_wr_mask;
   wire su_wr_req;
   
    
   // ---------------------------------
   // PIPELINE STAGE 1
   // ---------------------------------
    
   // PC MUX
    
   msrv32_pc PC(.rst_in(ms_riscv32_mp_rst_in),
                .ahb_ready_in(ms_riscv32_mp_instr_hready_in),
     	        .pc_src_in(pc_src),
    	        .epc_in(epc),
                .trap_address_in(trap_address),
   	        .branch_taken_in(branch_taken),
   	        .iaddr_in(iaddr[31:1]),
    	        .pc_in(pc),
     	        .pc_plus_4_out(pc_plus_4),
	        .misaligned_instr_out(misaligned_instr),
    	        .pc_mux_out(pc_mux),
		.i_addr_out(ms_riscv32_mp_imaddr_out)
               // .clk(ms_riscv32_mp_clk_in)
               );
			   
   msrv32_reg_block_1 REG1 (.clk_in(ms_riscv32_mp_clk_in),
							.rst_in(ms_riscv32_mp_rst_in),
							.pc_mux_in(pc_mux),
							.pc_out(pc)
							);
     
   // ---------------------------------
   // PIPELINE STAGE 2
   // ---------------------------------       
   //Instruction_decoder
    //complete
   msrv32_instruction_decoder ID (.flush_in(flush),
								  .instr_in(ms_riscv32_mp_instr_in),
								  .opcode_out(opcode),
								  .funct3_out(funct3),
								  .funct7_out(funct7),
								  .rs1_addr_out(rs1_addr),
								  .rs2_addr_out(rs2_addr),
								  .rd_addr_out(rd_addr),
								  .csr_addr_out(csr_addr),
								  .instr_31_7_out(instr_31_to_7)
                                 );
    
    //complete
   msrv32_store_unit SU (
                         .funct3_in(funct3[1:0]), 
                         .ahb_ready_in(ms_riscv32_mp_data_hready_in),
                         .iadder_in(iaddr), 
                         .rs2_in(rs2),
                         .mem_wr_req_in(mem_wr_req),
                         .data_out(ms_riscv32_mp_dmdata_out),
                         .d_addr_out(ms_riscv32_mp_dmaddr_out),
                         .wr_mask_out(ms_riscv32_mp_dmwr_mask_out),
                         .wr_req_out(ms_riscv32_mp_dmwr_req_out),
                         .ahb_htrans_out(ms_riscv32_mp_data_htrans_out)
                        );
    
    //Decoder

   msrv32_dec DEC (
                   .opcode_in(opcode),
                   .funct7_5_in(funct7[5]),
                   .funct3_in(funct3),
                   .iadder_1_to_0_in(iaddr[1:0]),
                   .trap_taken_in(trap_taken),
                    
                   .alu_opcode_out(alu_opcode),
                   .mem_wr_req_out(mem_wr_req),
                   .load_size_out(load_size),
                   .load_unsigned_out(load_unsigned),
                   .alu_src_out(alu_src),
                   .iadder_src_out(iadder_src),
                   .csr_wr_en_out(csr_wr_en),
                   .rf_wr_en_out(rf_wr_en),
                   .wb_mux_sel_out(wb_mux_sel),
                   .imm_type_out(imm_type),
                   .csr_op_out(csr_op),
                   .illegal_instr_out(illegal_instr),
                   .misaligned_load_out(misaligned_load),
                   .misaligned_store_out(misaligned_store)
                  );
    
   //Immediate Generator

   msrv32_img IMG (
                   .instr_in(instr_31_to_7),
                   .imm_type_in(imm_type),
                   .imm_out(imm)
                  );
    

   // Immediate Adder
    //complete
   msrv32_immediate_adder imm_adder(.pc_in(pc),
									.rs1_in(rs1),
									.imm_in(imm),
									.iadder_src_in(iadder_src),
									.iadder_out(iaddr)

   );
    
   //Branch Unit

   msrv32_bu BU (
                 .opcode_6_to_2_in(opcode[6:2]),
                 .funct3_in(funct3),
                 .rs1_in(rs1),
                 .rs2_in(rs2),
                 .branch_taken_out(branch_taken)
                );
    
       
   //Integer File

   msrv32_integer_file IRF(
    
        .clk_in(ms_riscv32_mp_clk_in),
        .reset_in(ms_riscv32_mp_rst_in),
        .rs_1_addr_in(rs1_addr),
        .rs_2_addr_in(rs2_addr),    
        .rs_1_out(rs1),
        .rs_2_out(rs2),
        
        .rd_addr_in(rd_addr_reg),
        .wr_en_in(integer_wr_en_reg_file),
        .rd_in(wb_mux_out)

    );
    
   msrv32_wr_en_generator WREN (.flush_in(flush),
							    .rf_wr_en_reg_in(rf_wr_en_reg),
								.csr_wr_en_reg_in(csr_wr_en_reg),
								.wr_en_integer_file_out(integer_wr_en_reg_file),
								.wr_en_csr_file_out(csr_wr_en_reg_file)
							   );
		
   //CSR file

   msrv32_csr_file CSRF(.clk_in(ms_riscv32_mp_clk_in),
						.rst_in(ms_riscv32_mp_rst_in),
						.wr_en_in(csr_wr_en_reg_file),
						.csr_addr_in(csr_addr_reg),
						.csr_op_in(csr_op_reg),
						.csr_uimm_in(imm_reg[4:0]),
						.csr_data_in(rs1_reg),
						.csr_data_out(csr_data),
						.pc_in(pc_reg2),
						.iadder_in(iadder_out_reg),
						.e_irq_in(ms_riscv32_mp_eirq_in),
						.t_irq_in(ms_riscv32_mp_tirq_in),
						.s_irq_in(ms_riscv32_mp_sirq_in),
						.i_or_e_in(i_or_e),
						.set_cause_in(set_cause),
						.cause_in(cause),
						.set_epc_in(set_epc),
						.instret_inc_in(instret_inc),
						.mie_clear_in(mie_clear),
						.mie_set_in(mie_set),
						.misaligned_exception_in(misaligned_exception),
						.mie_out(mie),
						.meie_out(meie),
						.mtie_out(mtie),
						.msie_out(msie),
						.meip_out(meip),
						.mtip_out(mtip),
						.msip_out(msip),
						.real_time_in(ms_riscv32_mp_rc_in),
						.epc_out(epc),
						.trap_address_out(trap_address)

    );
    
    //Machine Control
   
   msrv32_machine_control MC(

        .clk_in(ms_riscv32_mp_clk_in),
        .reset_in(ms_riscv32_mp_rst_in),
        
        .illegal_instr_in(illegal_instr),
        .misaligned_instr_in(misaligned_instr),
        .misaligned_load_in(misaligned_load),
        .misaligned_store_in(misaligned_store),
        
        .opcode_6_to_2_in(opcode[6:2]),
        .funct3_in(funct3),
        .funct7_in(funct7),
        .rs1_addr_in(rs1_addr),
        .rs2_addr_in(rs2_addr),
        .rd_addr_in(rd_addr),
        
        .e_irq_in(ms_riscv32_mp_eirq_in),
        .t_irq_in(ms_riscv32_mp_tirq_in),
        .s_irq_in(ms_riscv32_mp_sirq_in),
        
        .i_or_e_out(i_or_e),   //i_or_e use this local wire
        .set_cause_out(set_cause), //   set_cause use this local wire

        .cause_out(cause),   //cause use this local wire
        .set_epc_out(set_epc), //set_epc use this local wire
        .instret_inc_out(instret_inc), //instret_inc use this local wire
        .mie_clear_out(mie_clear), //mie_clear use this local wire
        .mie_set_out(mie_set), //mie_set use this local wire
        .misaligned_exception_out(misaligned_exception), //misaligned_exception use this local wire
        .mie_in(mie),   //mie use this local wire
        .meie_in(meie),
        .mtie_in(mtie),
        .msie_in(msie),
        .meip_in(meip),
        .mtip_in(mtip),
        .msip_in(msip),
        
        .pc_src_out(pc_src),
        
        .flush_out(flush),
        
        .trap_taken_out(trap_taken)

   );    

    
   // Stages 1/2 interface registers
   msrv32_reg_block_2  REG2 (
                             .rd_addr_in(rd_addr),
	                     .csr_addr_in(csr_addr),
	                     .rs1_in(rs1),
	                     .rs2_in(rs2),
	                     .pc_in(pc),
	                     .pc_plus_4_in(pc_plus_4),
	                     .iadder_in(iaddr),
	                     .imm_in(imm),
	                     .alu_opcode_in(alu_opcode),
	                     .load_size_in(load_size),
	                     .wb_mux_sel_in(wb_mux_sel),
	                     .csr_op_in(csr_op),
	                     .load_unsigned_in(load_unsigned),
	                     .alu_src_in(alu_src),
	                     .csr_wr_en_in(csr_wr_en),
	                     .rf_wr_en_in(rf_wr_en),
	                     .branch_taken_in(branch_taken),
	    
		 	     .clk_in(ms_riscv32_mp_clk_in),
	                     .reset_in(reset_in),

                             .rd_addr_reg_out(rd_addr_reg),
	                     .csr_addr_reg_out(csr_addr_reg),
	                     .rs1_reg_out(rs1_reg),
                             .rs2_reg_out(rs2_reg),
	                     .pc_reg_out(pc_reg2),
	                     .pc_plus_4_reg_out(pc_plus_4_reg),
	                     .iadder_out_reg_out(iadder_out_reg),
	                     .imm_reg_out(imm_reg),
	                     .alu_opcode_reg_out(alu_opcode_reg),
	                     .load_size_reg_out(load_size_reg),
	                     .wb_mux_sel_reg_out(wb_mux_sel_reg),
	                     .csr_op_reg_out(csr_op_reg),
	                     .load_unsigned_reg_out(load_unsigned_reg),
	                     .alu_src_reg_out(alu_src_reg),   // 
	                     .csr_wr_en_reg_out(csr_wr_en_reg),
	                     .rf_wr_en_reg_out(rf_wr_en_reg)
                            );
    
   // ---------------------------------
   // PIPELINE STAGE 3
   // ---------------------------------
    
   // Load Unit

   msrv32_lu LU (
                 .load_size_in(load_size_reg),
                 .clk_in(ms_riscv32_mp_clk_in),
                 //.misaligned_load_in(misaligned_load),
                 .load_unsigned_in(load_unsigned_reg),
                 .data_in(ms_riscv32_mp_data_in),
                 .iadder_1_to_0_in(iadder_out_reg[1:0]),
                 .lu_output(lu_output),
                 .ahb_resp_in(ms_riscv32_mp_hresp_in)
                );
    
      
   //ALU

   msrv32_alu ALU (
                   .op_1_in(rs1_reg),
                   .op_2_in(alu_2nd_src_mux),
                   .opcode_in(alu_opcode_reg),
                   .result_out(alu_result)
                  );    
    
   msrv32_wb_mux_sel_unit WBMUX(.wb_mux_sel_reg_in(wb_mux_sel_reg), 
                                .alu_result_in(alu_result),.lu_output_in(lu_output),.imm_reg_in(imm_reg),
			                    .iadder_out_reg_in(iadder_out_reg),.csr_data_in(csr_data),.pc_plus_4_reg_in(pc_plus_4_reg),.rs2_reg_in(rs2_reg),   
			                    .alu_source_reg_in(alu_src_reg),
			                    .wb_mux_out(wb_mux_out), 
				                .alu_2nd_src_mux_out(alu_2nd_src_mux));   
   
    

  msrv32_top_pass1_rtl_tessent_tap_main msrv32_top_pass1_rtl_tessent_tap_main_inst(
      .tdi(tdi_i_so), .tms(tms_i_to_tms), .tck(tck_i_C), .trst(trst_i_C), .tdo(msrv32_top_pass1_rtl_tessent_tap_main_inst_so), 
      .fsm_state(), .host_bscan_to_sel(host_bscan_to_sel), .host_bscan_from_so(scan_out), 
      .force_disable(force_disable), .select_jtag_input(select_jtag_input), .select_jtag_output(select_jtag_output), 
      .extest_pulse(), .extest_train(), .host_1_to_sel(msrv32_top_pass1_rtl_tessent_tap_main_inst_to_select), 
      .host_1_from_so(msrv32_top_pass1_rtl_tessent_sib_sri_inst_so), .capture_dr_en(capture_dr_en), 
      .test_logic_reset(test_logic_reset), .shift_dr_en(shift_dr_en), .update_dr_en(update_dr_en), 
      .tdo_en(msrv32_top_pass1_rtl_tessent_tap_main_inst_tdo_en)
  );

  msrv32_top_pass1_rtl_tessent_sib_1 msrv32_top_pass1_rtl_tessent_sib_sri_inst(
      .ijtag_reset(test_logic_reset), .ijtag_sel(msrv32_top_pass1_rtl_tessent_tap_main_inst_to_select), 
      .ijtag_si(tdi_i_so), .ijtag_ce(capture_dr_en), .ijtag_se(shift_dr_en), .ijtag_ue(update_dr_en), 
      .ijtag_tck(tck_i_C), .ijtag_so(msrv32_top_pass1_rtl_tessent_sib_sri_inst_so), 
      .ijtag_from_so(msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst_so), .ijtag_to_sel(msrv32_top_pass1_rtl_tessent_sib_sri_inst_to_select)
  );

  msrv32_top_pass1_rtl_tessent_sib_2 msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(test_logic_reset), .ijtag_sel(msrv32_top_pass1_rtl_tessent_sib_sri_inst_to_select), 
      .ijtag_si(tdi_i_so), .ijtag_ce(capture_dr_en), .ijtag_se(shift_dr_en), .ijtag_ue(update_dr_en), 
      .ijtag_tck(tck_i_C), .ijtag_so(msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_from_so(msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst_so), .ijtag_to_sel(msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst_to_select)
  );

  msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(test_logic_reset), .ijtag_sel(msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(tdi_i_so), .ijtag_ce(capture_dr_en), .ijtag_se(shift_dr_en), .ijtag_ue(update_dr_en), 
      .ijtag_tck(tck_i_C), .async_set_reset_static_disable(async_set_reset_static_disable), 
      .ijtag_so(msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst_so)
  );

  or02 tessent_persistent_cell_async_set_reset_dynamic_disable(
      .A0(scan_en_ts1), .A1(async_set_reset_static_disable), .Y(tessent_persistent_cell_async_set_reset_dynamic_disable_Y)
  );

  inv01 async_set_reset_dynamic_disable_inv(
      .A(tessent_persistent_cell_async_set_reset_dynamic_disable_Y), .Y(async_set_reset_dynamic_disable_inv_ts1)
  );

  and02 dft_ctrl_async_set_reset_dynamic_disable_inv_and2(
      .A0(rst_pad_C), .A1(async_set_reset_dynamic_disable_inv_ts1), .Y()
  );

  msrv32_top_pass1_rtl_tessent_bscan_interface msrv32_top_pass1_rtl_tessent_bscan_interface_I(
      .ijtag_tck(tck_i_C), .scan_in(tdi_i_so), .bscan_select(host_bscan_to_sel), 
      .ijtag_shift_en(shift_dr_en), .ijtag_update_en(update_dr_en), .ijtag_capture_en(capture_dr_en), 
      .force_disable(force_disable), .select_jtag_input(select_jtag_input), .select_jtag_output(select_jtag_output), 
      .output_pad_disable(1'b0), .bscan_clamp_enable(1'b0), .from_bscan_scan_out(from_bscan_scan_out), 
      .scan_out(scan_out), .to_bscan_force_disable(to_bscan_force_disable), .to_bscan_tck(), 
      .to_bscan_select(), .to_bscan_shift_en(to_bscan_shift_en), .to_bscan_update_en(), 
      .to_bscan_capture_shift_clock(to_bscan_capture_shift_clock), .to_bscan_update_clock(to_bscan_update_clock), 
      .to_bscan_capture_en(), .to_bscan_select_jtag_input(to_bscan_select_jtag_input), 
      .to_bscan_select_jtag_output(to_bscan_select_jtag_output), .to_bscan_pad_sel(), 
      .to_bscan_scan_in(to_bscan_scan_in)
  );

  msrv32_top_pass1_rtl_tessent_bscan_logical_group_DEF msrv32_top_pass1_rtl_tessent_bscan_logical_group_DEF_inst(
      .capture_shift_clock(to_bscan_capture_shift_clock), .CELL0_BSCAN_SO(from_bscan_scan_out), 
      .CELL219_BSCAN_SI(to_bscan_scan_in), .control_chain_enable_fromPad(control_chain_enable_fromPad), 
      .control_chain_enable_toCore(), .control_chain_scan_in_fromPad(control_chain_scan_in_fromPad), 
      .control_chain_scan_in_toCore(), .control_chain_scan_out_fromCore(), .control_chain_scan_out_toPad(control_chain_scan_out_toPad), 
      .edt_channel_in1_p_fromPad(edt_channel_in1_p_fromPad), .edt_channel_in1_p_toCore(), 
      .edt_clock_fromPad(edt_clock_fromPad), .edt_clock_toCore(), .edt_update_fromPad(edt_update_fromPad), 
      .edt_update_toCore(), .EN1_en1(EN1_en1), .EN1_userEnable1(1'b1), .EN2_en1(EN1_en1_ts1[15]), 
      .EN2_userEnable1(1'b1), .EN3_en1(EN3_en1), .EN3_userEnable1(1'b1), .EN4_en1(EN3_en1_ts1[15]), 
      .EN4_userEnable1(1'b1), .EN5_en1(EN5_en1), .EN5_userEnable1(1'b1), .forceDisable(to_bscan_force_disable), 
      .ms_riscv32_mp_clk_in_fromPad(ms_riscv32_mp_clk_in_fromPad), .ms_riscv32_mp_clk_in_p_fromPad(ms_riscv32_mp_clk_in_p_fromPad), 
      .ms_riscv32_mp_clk_in_p_toCore(), .ms_riscv32_mp_data_hready_in_fromPad(ms_riscv32_mp_data_hready_in_fromPad), 
      .ms_riscv32_mp_data_hready_in_toCore(), .ms_riscv32_mp_data_htrans_out_0_fromCore(ms_riscv32_mp_data_htrans_out_1_toPad_ts1[0]), 
      .ms_riscv32_mp_data_htrans_out_0_toPad(ms_riscv32_mp_data_htrans_out_0_fromCore_ts1[0]), 
      .ms_riscv32_mp_data_htrans_out_1_fromCore(), .ms_riscv32_mp_data_htrans_out_1_toPad(ms_riscv32_mp_data_htrans_out_1_toPad), 
      .ms_riscv32_mp_data_in_0_fromPad(ms_riscv32_mp_data_in_0_toCore_ts1[0]), 
      .ms_riscv32_mp_data_in_0_toCore(ms_riscv32_mp_data_in_1_toCore_ts1[0]), .ms_riscv32_mp_data_in_10_fromPad(ms_riscv32_mp_data_in_10_toCore_ts1[10]), 
      .ms_riscv32_mp_data_in_10_toCore(ms_riscv32_mp_data_in_11_toCore_ts1[10]), 
      .ms_riscv32_mp_data_in_11_fromPad(ms_riscv32_mp_data_in_11_toCore_ts1[11]), 
      .ms_riscv32_mp_data_in_11_toCore(ms_riscv32_mp_data_in_11_toCore[11]), .ms_riscv32_mp_data_in_12_fromPad(ms_riscv32_mp_data_in_12_toCore_ts1[12]), 
      .ms_riscv32_mp_data_in_12_toCore(ms_riscv32_mp_data_in_13_toCore_ts1[12]), 
      .ms_riscv32_mp_data_in_13_fromPad(ms_riscv32_mp_data_in_13_toCore_ts1[13]), 
      .ms_riscv32_mp_data_in_13_toCore(ms_riscv32_mp_data_in_13_toCore[13]), .ms_riscv32_mp_data_in_14_fromPad(ms_riscv32_mp_data_in_14_toCore_ts1[14]), 
      .ms_riscv32_mp_data_in_14_toCore(ms_riscv32_mp_data_in_15_toCore_ts1[14]), 
      .ms_riscv32_mp_data_in_15_fromPad(ms_riscv32_mp_data_in_15_toCore_ts1[15]), 
      .ms_riscv32_mp_data_in_15_toCore(ms_riscv32_mp_data_in_15_toCore[15]), .ms_riscv32_mp_data_in_16_fromPad(ms_riscv32_mp_data_in_16_toCore_ts1[16]), 
      .ms_riscv32_mp_data_in_16_toCore(ms_riscv32_mp_data_in_17_toCore_ts1[16]), 
      .ms_riscv32_mp_data_in_17_fromPad(ms_riscv32_mp_data_in_17_toCore_ts1[17]), 
      .ms_riscv32_mp_data_in_17_toCore(ms_riscv32_mp_data_in_17_toCore[17]), .ms_riscv32_mp_data_in_18_fromPad(ms_riscv32_mp_data_in_18_toCore_ts1[18]), 
      .ms_riscv32_mp_data_in_18_toCore(ms_riscv32_mp_data_in_19_toCore_ts1[18]), 
      .ms_riscv32_mp_data_in_19_fromPad(ms_riscv32_mp_data_in_19_toCore_ts1[19]), 
      .ms_riscv32_mp_data_in_19_toCore(ms_riscv32_mp_data_in_19_toCore[19]), .ms_riscv32_mp_data_in_1_fromPad(ms_riscv32_mp_data_in_1_toCore_ts1[1]), 
      .ms_riscv32_mp_data_in_1_toCore(ms_riscv32_mp_data_in_1_toCore[1]), .ms_riscv32_mp_data_in_20_fromPad(ms_riscv32_mp_data_in_20_toCore_ts1[20]), 
      .ms_riscv32_mp_data_in_20_toCore(ms_riscv32_mp_data_in_21_toCore_ts1[20]), 
      .ms_riscv32_mp_data_in_21_fromPad(ms_riscv32_mp_data_in_21_toCore_ts1[21]), 
      .ms_riscv32_mp_data_in_21_toCore(ms_riscv32_mp_data_in_21_toCore[21]), .ms_riscv32_mp_data_in_22_fromPad(ms_riscv32_mp_data_in_22_toCore_ts1[22]), 
      .ms_riscv32_mp_data_in_22_toCore(ms_riscv32_mp_data_in_23_toCore_ts1[22]), 
      .ms_riscv32_mp_data_in_23_fromPad(ms_riscv32_mp_data_in_23_toCore_ts1[23]), 
      .ms_riscv32_mp_data_in_23_toCore(ms_riscv32_mp_data_in_23_toCore[23]), .ms_riscv32_mp_data_in_24_fromPad(ms_riscv32_mp_data_in_24_toCore_ts1[24]), 
      .ms_riscv32_mp_data_in_24_toCore(ms_riscv32_mp_data_in_25_toCore_ts1[24]), 
      .ms_riscv32_mp_data_in_25_fromPad(ms_riscv32_mp_data_in_25_toCore_ts1[25]), 
      .ms_riscv32_mp_data_in_25_toCore(ms_riscv32_mp_data_in_25_toCore[25]), .ms_riscv32_mp_data_in_26_fromPad(ms_riscv32_mp_data_in_26_toCore_ts1[26]), 
      .ms_riscv32_mp_data_in_26_toCore(ms_riscv32_mp_data_in_27_toCore_ts1[26]), 
      .ms_riscv32_mp_data_in_27_fromPad(ms_riscv32_mp_data_in_27_toCore_ts1[27]), 
      .ms_riscv32_mp_data_in_27_toCore(ms_riscv32_mp_data_in_27_toCore[27]), .ms_riscv32_mp_data_in_28_fromPad(ms_riscv32_mp_data_in_28_toCore_ts1[28]), 
      .ms_riscv32_mp_data_in_28_toCore(ms_riscv32_mp_data_in_29_toCore_ts1[28]), 
      .ms_riscv32_mp_data_in_29_fromPad(ms_riscv32_mp_data_in_29_toCore_ts1[29]), 
      .ms_riscv32_mp_data_in_29_toCore(ms_riscv32_mp_data_in_29_toCore[29]), .ms_riscv32_mp_data_in_2_fromPad(ms_riscv32_mp_data_in_2_toCore_ts1[2]), 
      .ms_riscv32_mp_data_in_2_toCore(ms_riscv32_mp_data_in_3_toCore_ts1[2]), .ms_riscv32_mp_data_in_30_fromPad(ms_riscv32_mp_data_in_30_toCore_ts1[30]), 
      .ms_riscv32_mp_data_in_30_toCore(ms_riscv32_mp_data_in_31_fromPad_ts1[30]), 
      .ms_riscv32_mp_data_in_31_fromPad(ms_riscv32_mp_data_in_31_fromPad), .ms_riscv32_mp_data_in_31_toCore(), 
      .ms_riscv32_mp_data_in_3_fromPad(ms_riscv32_mp_data_in_3_toCore_ts1[3]), 
      .ms_riscv32_mp_data_in_3_toCore(ms_riscv32_mp_data_in_3_toCore[3]), .ms_riscv32_mp_data_in_4_fromPad(ms_riscv32_mp_data_in_4_toCore_ts1[4]), 
      .ms_riscv32_mp_data_in_4_toCore(ms_riscv32_mp_data_in_5_toCore_ts1[4]), .ms_riscv32_mp_data_in_5_fromPad(ms_riscv32_mp_data_in_5_toCore_ts1[5]), 
      .ms_riscv32_mp_data_in_5_toCore(ms_riscv32_mp_data_in_5_toCore[5]), .ms_riscv32_mp_data_in_6_fromPad(ms_riscv32_mp_data_in_6_toCore_ts1[6]), 
      .ms_riscv32_mp_data_in_6_toCore(ms_riscv32_mp_data_in_7_toCore_ts1[6]), .ms_riscv32_mp_data_in_7_fromPad(ms_riscv32_mp_data_in_7_toCore_ts1[7]), 
      .ms_riscv32_mp_data_in_7_toCore(ms_riscv32_mp_data_in_7_toCore[7]), .ms_riscv32_mp_data_in_8_fromPad(ms_riscv32_mp_data_in_8_toCore_ts1[8]), 
      .ms_riscv32_mp_data_in_8_toCore(ms_riscv32_mp_data_in_9_toCore_ts1[8]), .ms_riscv32_mp_data_in_9_fromPad(ms_riscv32_mp_data_in_9_toCore_ts1[9]), 
      .ms_riscv32_mp_data_in_9_toCore(ms_riscv32_mp_data_in_9_toCore[9]), .ms_riscv32_mp_dmaddr_out_0_fromCore(ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[0]), 
      .ms_riscv32_mp_dmaddr_out_0_toPad(ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[0]), 
      .ms_riscv32_mp_dmaddr_out_10_fromCore(ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[10]), 
      .ms_riscv32_mp_dmaddr_out_10_toPad(ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[10]), 
      .ms_riscv32_mp_dmaddr_out_11_fromCore(ms_riscv32_mp_dmaddr_out_11_fromCore[11]), 
      .ms_riscv32_mp_dmaddr_out_11_toPad(ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[11]), 
      .ms_riscv32_mp_dmaddr_out_12_fromCore(ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[12]), 
      .ms_riscv32_mp_dmaddr_out_12_toPad(ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[12]), 
      .ms_riscv32_mp_dmaddr_out_13_fromCore(ms_riscv32_mp_dmaddr_out_13_fromCore[13]), 
      .ms_riscv32_mp_dmaddr_out_13_toPad(ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[13]), 
      .ms_riscv32_mp_dmaddr_out_14_fromCore(ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[14]), 
      .ms_riscv32_mp_dmaddr_out_14_toPad(ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[14]), 
      .ms_riscv32_mp_dmaddr_out_15_fromCore(ms_riscv32_mp_dmaddr_out_15_fromCore[15]), 
      .ms_riscv32_mp_dmaddr_out_15_toPad(ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[15]), 
      .ms_riscv32_mp_dmaddr_out_16_fromCore(ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[16]), 
      .ms_riscv32_mp_dmaddr_out_16_toPad(ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[16]), 
      .ms_riscv32_mp_dmaddr_out_17_fromCore(ms_riscv32_mp_dmaddr_out_17_fromCore[17]), 
      .ms_riscv32_mp_dmaddr_out_17_toPad(ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[17]), 
      .ms_riscv32_mp_dmaddr_out_18_fromCore(ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[18]), 
      .ms_riscv32_mp_dmaddr_out_18_toPad(ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[18]), 
      .ms_riscv32_mp_dmaddr_out_19_fromCore(ms_riscv32_mp_dmaddr_out_19_fromCore[19]), 
      .ms_riscv32_mp_dmaddr_out_19_toPad(ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[19]), 
      .ms_riscv32_mp_dmaddr_out_1_fromCore(ms_riscv32_mp_dmaddr_out_1_fromCore[1]), 
      .ms_riscv32_mp_dmaddr_out_1_toPad(ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[1]), 
      .ms_riscv32_mp_dmaddr_out_20_fromCore(ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[20]), 
      .ms_riscv32_mp_dmaddr_out_20_toPad(ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[20]), 
      .ms_riscv32_mp_dmaddr_out_21_fromCore(ms_riscv32_mp_dmaddr_out_21_fromCore[21]), 
      .ms_riscv32_mp_dmaddr_out_21_toPad(ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[21]), 
      .ms_riscv32_mp_dmaddr_out_22_fromCore(ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[22]), 
      .ms_riscv32_mp_dmaddr_out_22_toPad(ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[22]), 
      .ms_riscv32_mp_dmaddr_out_23_fromCore(ms_riscv32_mp_dmaddr_out_23_fromCore[23]), 
      .ms_riscv32_mp_dmaddr_out_23_toPad(ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[23]), 
      .ms_riscv32_mp_dmaddr_out_24_fromCore(ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[24]), 
      .ms_riscv32_mp_dmaddr_out_24_toPad(ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[24]), 
      .ms_riscv32_mp_dmaddr_out_25_fromCore(ms_riscv32_mp_dmaddr_out_25_fromCore[25]), 
      .ms_riscv32_mp_dmaddr_out_25_toPad(ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[25]), 
      .ms_riscv32_mp_dmaddr_out_26_fromCore(ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[26]), 
      .ms_riscv32_mp_dmaddr_out_26_toPad(ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[26]), 
      .ms_riscv32_mp_dmaddr_out_27_fromCore(ms_riscv32_mp_dmaddr_out_27_fromCore[27]), 
      .ms_riscv32_mp_dmaddr_out_27_toPad(ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[27]), 
      .ms_riscv32_mp_dmaddr_out_28_fromCore(ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[28]), 
      .ms_riscv32_mp_dmaddr_out_28_toPad(ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[28]), 
      .ms_riscv32_mp_dmaddr_out_29_fromCore(ms_riscv32_mp_dmaddr_out_29_fromCore[29]), 
      .ms_riscv32_mp_dmaddr_out_29_toPad(ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[29]), 
      .ms_riscv32_mp_dmaddr_out_2_fromCore(ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[2]), 
      .ms_riscv32_mp_dmaddr_out_2_toPad(ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[2]), 
      .ms_riscv32_mp_dmaddr_out_30_fromCore(ms_riscv32_mp_dmaddr_out_31_toPad_ts1[30]), 
      .ms_riscv32_mp_dmaddr_out_30_toPad(ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[30]), 
      .ms_riscv32_mp_dmaddr_out_31_fromCore(), .ms_riscv32_mp_dmaddr_out_31_toPad(ms_riscv32_mp_dmaddr_out_31_toPad), 
      .ms_riscv32_mp_dmaddr_out_3_fromCore(ms_riscv32_mp_dmaddr_out_3_fromCore[3]), 
      .ms_riscv32_mp_dmaddr_out_3_toPad(ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[3]), 
      .ms_riscv32_mp_dmaddr_out_4_fromCore(ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[4]), 
      .ms_riscv32_mp_dmaddr_out_4_toPad(ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[4]), 
      .ms_riscv32_mp_dmaddr_out_5_fromCore(ms_riscv32_mp_dmaddr_out_5_fromCore[5]), 
      .ms_riscv32_mp_dmaddr_out_5_toPad(ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[5]), 
      .ms_riscv32_mp_dmaddr_out_6_fromCore(ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[6]), 
      .ms_riscv32_mp_dmaddr_out_6_toPad(ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[6]), 
      .ms_riscv32_mp_dmaddr_out_7_fromCore(ms_riscv32_mp_dmaddr_out_7_fromCore[7]), 
      .ms_riscv32_mp_dmaddr_out_7_toPad(ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[7]), 
      .ms_riscv32_mp_dmaddr_out_8_fromCore(ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[8]), 
      .ms_riscv32_mp_dmaddr_out_8_toPad(ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[8]), 
      .ms_riscv32_mp_dmaddr_out_9_fromCore(ms_riscv32_mp_dmaddr_out_9_fromCore[9]), 
      .ms_riscv32_mp_dmaddr_out_9_toPad(ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[9]), 
      .ms_riscv32_mp_dmdata_out_0_fromCore(ms_riscv32_mp_dmdata_out_1_fromCore_ts1[0]), 
      .ms_riscv32_mp_dmdata_out_0_toPad(ms_riscv32_mp_dmdata_out_0_fromCore_ts1[0]), 
      .ms_riscv32_mp_dmdata_out_10_fromCore(ms_riscv32_mp_dmdata_out_11_fromCore_ts1[10]), 
      .ms_riscv32_mp_dmdata_out_10_toPad(ms_riscv32_mp_dmdata_out_10_fromCore_ts1[10]), 
      .ms_riscv32_mp_dmdata_out_11_fromCore(ms_riscv32_mp_dmdata_out_11_fromCore[11]), 
      .ms_riscv32_mp_dmdata_out_11_toPad(ms_riscv32_mp_dmdata_out_11_fromCore_ts1[11]), 
      .ms_riscv32_mp_dmdata_out_12_fromCore(ms_riscv32_mp_dmdata_out_13_fromCore_ts1[12]), 
      .ms_riscv32_mp_dmdata_out_12_toPad(ms_riscv32_mp_dmdata_out_12_fromCore_ts1[12]), 
      .ms_riscv32_mp_dmdata_out_13_fromCore(ms_riscv32_mp_dmdata_out_13_fromCore[13]), 
      .ms_riscv32_mp_dmdata_out_13_toPad(ms_riscv32_mp_dmdata_out_13_fromCore_ts1[13]), 
      .ms_riscv32_mp_dmdata_out_14_fromCore(ms_riscv32_mp_dmdata_out_15_fromCore_ts1[14]), 
      .ms_riscv32_mp_dmdata_out_14_toPad(ms_riscv32_mp_dmdata_out_14_fromCore_ts1[14]), 
      .ms_riscv32_mp_dmdata_out_15_fromCore(ms_riscv32_mp_dmdata_out_15_fromCore[15]), 
      .ms_riscv32_mp_dmdata_out_15_toPad(ms_riscv32_mp_dmdata_out_15_fromCore_ts1[15]), 
      .ms_riscv32_mp_dmdata_out_16_fromCore(ms_riscv32_mp_dmdata_out_17_fromCore_ts1[16]), 
      .ms_riscv32_mp_dmdata_out_16_toPad(ms_riscv32_mp_dmdata_out_16_fromCore_ts1[16]), 
      .ms_riscv32_mp_dmdata_out_17_fromCore(ms_riscv32_mp_dmdata_out_17_fromCore[17]), 
      .ms_riscv32_mp_dmdata_out_17_toPad(ms_riscv32_mp_dmdata_out_17_fromCore_ts1[17]), 
      .ms_riscv32_mp_dmdata_out_18_fromCore(ms_riscv32_mp_dmdata_out_19_fromCore_ts1[18]), 
      .ms_riscv32_mp_dmdata_out_18_toPad(ms_riscv32_mp_dmdata_out_18_fromCore_ts1[18]), 
      .ms_riscv32_mp_dmdata_out_19_fromCore(ms_riscv32_mp_dmdata_out_19_fromCore[19]), 
      .ms_riscv32_mp_dmdata_out_19_toPad(ms_riscv32_mp_dmdata_out_19_fromCore_ts1[19]), 
      .ms_riscv32_mp_dmdata_out_1_fromCore(ms_riscv32_mp_dmdata_out_1_fromCore[1]), 
      .ms_riscv32_mp_dmdata_out_1_toPad(ms_riscv32_mp_dmdata_out_1_fromCore_ts1[1]), 
      .ms_riscv32_mp_dmdata_out_20_fromCore(ms_riscv32_mp_dmdata_out_21_fromCore_ts1[20]), 
      .ms_riscv32_mp_dmdata_out_20_toPad(ms_riscv32_mp_dmdata_out_20_fromCore_ts1[20]), 
      .ms_riscv32_mp_dmdata_out_21_fromCore(ms_riscv32_mp_dmdata_out_21_fromCore[21]), 
      .ms_riscv32_mp_dmdata_out_21_toPad(ms_riscv32_mp_dmdata_out_21_fromCore_ts1[21]), 
      .ms_riscv32_mp_dmdata_out_22_fromCore(ms_riscv32_mp_dmdata_out_23_fromCore_ts1[22]), 
      .ms_riscv32_mp_dmdata_out_22_toPad(ms_riscv32_mp_dmdata_out_22_fromCore_ts1[22]), 
      .ms_riscv32_mp_dmdata_out_23_fromCore(ms_riscv32_mp_dmdata_out_23_fromCore[23]), 
      .ms_riscv32_mp_dmdata_out_23_toPad(ms_riscv32_mp_dmdata_out_23_fromCore_ts1[23]), 
      .ms_riscv32_mp_dmdata_out_24_fromCore(ms_riscv32_mp_dmdata_out_25_fromCore_ts1[24]), 
      .ms_riscv32_mp_dmdata_out_24_toPad(ms_riscv32_mp_dmdata_out_24_fromCore_ts1[24]), 
      .ms_riscv32_mp_dmdata_out_25_fromCore(ms_riscv32_mp_dmdata_out_25_fromCore[25]), 
      .ms_riscv32_mp_dmdata_out_25_toPad(ms_riscv32_mp_dmdata_out_25_fromCore_ts1[25]), 
      .ms_riscv32_mp_dmdata_out_26_fromCore(ms_riscv32_mp_dmdata_out_27_fromCore_ts1[26]), 
      .ms_riscv32_mp_dmdata_out_26_toPad(ms_riscv32_mp_dmdata_out_26_fromCore_ts1[26]), 
      .ms_riscv32_mp_dmdata_out_27_fromCore(ms_riscv32_mp_dmdata_out_27_fromCore[27]), 
      .ms_riscv32_mp_dmdata_out_27_toPad(ms_riscv32_mp_dmdata_out_27_fromCore_ts1[27]), 
      .ms_riscv32_mp_dmdata_out_28_fromCore(ms_riscv32_mp_dmdata_out_29_fromCore_ts1[28]), 
      .ms_riscv32_mp_dmdata_out_28_toPad(ms_riscv32_mp_dmdata_out_28_fromCore_ts1[28]), 
      .ms_riscv32_mp_dmdata_out_29_fromCore(ms_riscv32_mp_dmdata_out_29_fromCore[29]), 
      .ms_riscv32_mp_dmdata_out_29_toPad(ms_riscv32_mp_dmdata_out_29_fromCore_ts1[29]), 
      .ms_riscv32_mp_dmdata_out_2_fromCore(ms_riscv32_mp_dmdata_out_3_fromCore_ts1[2]), 
      .ms_riscv32_mp_dmdata_out_2_toPad(ms_riscv32_mp_dmdata_out_2_fromCore_ts1[2]), 
      .ms_riscv32_mp_dmdata_out_30_fromCore(ms_riscv32_mp_dmdata_out_31_toPad_ts1[30]), 
      .ms_riscv32_mp_dmdata_out_30_toPad(ms_riscv32_mp_dmdata_out_30_fromCore_ts1[30]), 
      .ms_riscv32_mp_dmdata_out_31_fromCore(), .ms_riscv32_mp_dmdata_out_31_toPad(ms_riscv32_mp_dmdata_out_31_toPad), 
      .ms_riscv32_mp_dmdata_out_3_fromCore(ms_riscv32_mp_dmdata_out_3_fromCore[3]), 
      .ms_riscv32_mp_dmdata_out_3_toPad(ms_riscv32_mp_dmdata_out_3_fromCore_ts1[3]), 
      .ms_riscv32_mp_dmdata_out_4_fromCore(ms_riscv32_mp_dmdata_out_5_fromCore_ts1[4]), 
      .ms_riscv32_mp_dmdata_out_4_toPad(ms_riscv32_mp_dmdata_out_4_fromCore_ts1[4]), 
      .ms_riscv32_mp_dmdata_out_5_fromCore(ms_riscv32_mp_dmdata_out_5_fromCore[5]), 
      .ms_riscv32_mp_dmdata_out_5_toPad(ms_riscv32_mp_dmdata_out_5_fromCore_ts1[5]), 
      .ms_riscv32_mp_dmdata_out_6_fromCore(ms_riscv32_mp_dmdata_out_7_fromCore_ts1[6]), 
      .ms_riscv32_mp_dmdata_out_6_toPad(ms_riscv32_mp_dmdata_out_6_fromCore_ts1[6]), 
      .ms_riscv32_mp_dmdata_out_7_fromCore(ms_riscv32_mp_dmdata_out_7_fromCore[7]), 
      .ms_riscv32_mp_dmdata_out_7_toPad(ms_riscv32_mp_dmdata_out_7_fromCore_ts1[7]), 
      .ms_riscv32_mp_dmdata_out_8_fromCore(ms_riscv32_mp_dmdata_out_9_fromCore_ts1[8]), 
      .ms_riscv32_mp_dmdata_out_8_toPad(ms_riscv32_mp_dmdata_out_8_fromCore_ts1[8]), 
      .ms_riscv32_mp_dmdata_out_9_fromCore(ms_riscv32_mp_dmdata_out_9_fromCore[9]), 
      .ms_riscv32_mp_dmdata_out_9_toPad(ms_riscv32_mp_dmdata_out_9_fromCore_ts1[9]), 
      .ms_riscv32_mp_dmwr_mask_out_0_fromCore(ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[0]), 
      .ms_riscv32_mp_dmwr_mask_out_0_toPad(ms_riscv32_mp_dmwr_mask_out_0_fromCore_ts1[0]), 
      .ms_riscv32_mp_dmwr_mask_out_1_fromCore(ms_riscv32_mp_dmwr_mask_out_1_fromCore[1]), 
      .ms_riscv32_mp_dmwr_mask_out_1_toPad(ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[1]), 
      .ms_riscv32_mp_dmwr_mask_out_2_fromCore(ms_riscv32_mp_dmwr_mask_out_3_toPad_ts1[2]), 
      .ms_riscv32_mp_dmwr_mask_out_2_toPad(ms_riscv32_mp_dmwr_mask_out_2_fromCore_ts1[2]), 
      .ms_riscv32_mp_dmwr_mask_out_3_fromCore(), .ms_riscv32_mp_dmwr_mask_out_3_toPad(ms_riscv32_mp_dmwr_mask_out_3_toPad), 
      .ms_riscv32_mp_dmwr_req_out_fromCore(), .ms_riscv32_mp_dmwr_req_out_toPad(ms_riscv32_mp_dmwr_req_out_toPad), 
      .ms_riscv32_mp_eirq_in_fromPad(ms_riscv32_mp_eirq_in_fromPad), .ms_riscv32_mp_eirq_in_toCore(), 
      .ms_riscv32_mp_hresp_in_fromPad(ms_riscv32_mp_hresp_in_fromPad), .ms_riscv32_mp_hresp_in_toCore(), 
      .ms_riscv32_mp_instr_hready_in_fromPad(ms_riscv32_mp_instr_hready_in_fromPad), 
      .ms_riscv32_mp_instr_hready_in_toCore(), .ms_riscv32_mp_instr_in_0_fromPad(ms_riscv32_mp_instr_in_0_toCore_ts1[0]), 
      .ms_riscv32_mp_instr_in_0_toCore(ms_riscv32_mp_instr_in_1_toCore_ts1[0]), 
      .ms_riscv32_mp_instr_in_10_fromPad(ms_riscv32_mp_instr_in_10_toCore_ts1[10]), 
      .ms_riscv32_mp_instr_in_10_toCore(ms_riscv32_mp_instr_in_11_toCore_ts1[10]), 
      .ms_riscv32_mp_instr_in_11_fromPad(ms_riscv32_mp_instr_in_11_toCore_ts1[11]), 
      .ms_riscv32_mp_instr_in_11_toCore(ms_riscv32_mp_instr_in_11_toCore[11]), 
      .ms_riscv32_mp_instr_in_12_fromPad(ms_riscv32_mp_instr_in_12_toCore_ts1[12]), 
      .ms_riscv32_mp_instr_in_12_toCore(ms_riscv32_mp_instr_in_13_toCore_ts1[12]), 
      .ms_riscv32_mp_instr_in_13_fromPad(ms_riscv32_mp_instr_in_13_toCore_ts1[13]), 
      .ms_riscv32_mp_instr_in_13_toCore(ms_riscv32_mp_instr_in_13_toCore[13]), 
      .ms_riscv32_mp_instr_in_14_fromPad(ms_riscv32_mp_instr_in_14_toCore_ts1[14]), 
      .ms_riscv32_mp_instr_in_14_toCore(ms_riscv32_mp_instr_in_15_toCore_ts1[14]), 
      .ms_riscv32_mp_instr_in_15_fromPad(ms_riscv32_mp_instr_in_15_toCore_ts1[15]), 
      .ms_riscv32_mp_instr_in_15_toCore(ms_riscv32_mp_instr_in_15_toCore[15]), 
      .ms_riscv32_mp_instr_in_16_fromPad(ms_riscv32_mp_instr_in_16_toCore_ts1[16]), 
      .ms_riscv32_mp_instr_in_16_toCore(ms_riscv32_mp_instr_in_17_toCore_ts1[16]), 
      .ms_riscv32_mp_instr_in_17_fromPad(ms_riscv32_mp_instr_in_17_toCore_ts1[17]), 
      .ms_riscv32_mp_instr_in_17_toCore(ms_riscv32_mp_instr_in_17_toCore[17]), 
      .ms_riscv32_mp_instr_in_18_fromPad(ms_riscv32_mp_instr_in_18_toCore_ts1[18]), 
      .ms_riscv32_mp_instr_in_18_toCore(ms_riscv32_mp_instr_in_19_toCore_ts1[18]), 
      .ms_riscv32_mp_instr_in_19_fromPad(ms_riscv32_mp_instr_in_19_toCore_ts1[19]), 
      .ms_riscv32_mp_instr_in_19_toCore(ms_riscv32_mp_instr_in_19_toCore[19]), 
      .ms_riscv32_mp_instr_in_1_fromPad(ms_riscv32_mp_instr_in_1_toCore_ts1[1]), 
      .ms_riscv32_mp_instr_in_1_toCore(ms_riscv32_mp_instr_in_1_toCore[1]), .ms_riscv32_mp_instr_in_20_fromPad(ms_riscv32_mp_instr_in_20_toCore_ts1[20]), 
      .ms_riscv32_mp_instr_in_20_toCore(ms_riscv32_mp_instr_in_21_toCore_ts1[20]), 
      .ms_riscv32_mp_instr_in_21_fromPad(ms_riscv32_mp_instr_in_21_toCore_ts1[21]), 
      .ms_riscv32_mp_instr_in_21_toCore(ms_riscv32_mp_instr_in_21_toCore[21]), 
      .ms_riscv32_mp_instr_in_22_fromPad(ms_riscv32_mp_instr_in_22_toCore_ts1[22]), 
      .ms_riscv32_mp_instr_in_22_toCore(ms_riscv32_mp_instr_in_23_toCore_ts1[22]), 
      .ms_riscv32_mp_instr_in_23_fromPad(ms_riscv32_mp_instr_in_23_toCore_ts1[23]), 
      .ms_riscv32_mp_instr_in_23_toCore(ms_riscv32_mp_instr_in_23_toCore[23]), 
      .ms_riscv32_mp_instr_in_24_fromPad(ms_riscv32_mp_instr_in_24_toCore_ts1[24]), 
      .ms_riscv32_mp_instr_in_24_toCore(ms_riscv32_mp_instr_in_25_toCore_ts1[24]), 
      .ms_riscv32_mp_instr_in_25_fromPad(ms_riscv32_mp_instr_in_25_toCore_ts1[25]), 
      .ms_riscv32_mp_instr_in_25_toCore(ms_riscv32_mp_instr_in_25_toCore[25]), 
      .ms_riscv32_mp_instr_in_26_fromPad(ms_riscv32_mp_instr_in_26_toCore_ts1[26]), 
      .ms_riscv32_mp_instr_in_26_toCore(ms_riscv32_mp_instr_in_27_toCore_ts1[26]), 
      .ms_riscv32_mp_instr_in_27_fromPad(ms_riscv32_mp_instr_in_27_toCore_ts1[27]), 
      .ms_riscv32_mp_instr_in_27_toCore(ms_riscv32_mp_instr_in_27_toCore[27]), 
      .ms_riscv32_mp_instr_in_28_fromPad(ms_riscv32_mp_instr_in_28_toCore_ts1[28]), 
      .ms_riscv32_mp_instr_in_28_toCore(ms_riscv32_mp_instr_in_29_toCore_ts1[28]), 
      .ms_riscv32_mp_instr_in_29_fromPad(ms_riscv32_mp_instr_in_29_toCore_ts1[29]), 
      .ms_riscv32_mp_instr_in_29_toCore(ms_riscv32_mp_instr_in_29_toCore[29]), 
      .ms_riscv32_mp_instr_in_2_fromPad(ms_riscv32_mp_instr_in_2_toCore_ts1[2]), 
      .ms_riscv32_mp_instr_in_2_toCore(ms_riscv32_mp_instr_in_3_toCore_ts1[2]), 
      .ms_riscv32_mp_instr_in_30_fromPad(ms_riscv32_mp_instr_in_30_toCore_ts1[30]), 
      .ms_riscv32_mp_instr_in_30_toCore(ms_riscv32_mp_instr_in_31_fromPad_ts1[30]), 
      .ms_riscv32_mp_instr_in_31_fromPad(ms_riscv32_mp_instr_in_31_fromPad), .ms_riscv32_mp_instr_in_31_toCore(), 
      .ms_riscv32_mp_instr_in_3_fromPad(ms_riscv32_mp_instr_in_3_toCore_ts1[3]), 
      .ms_riscv32_mp_instr_in_3_toCore(ms_riscv32_mp_instr_in_3_toCore[3]), .ms_riscv32_mp_instr_in_4_fromPad(ms_riscv32_mp_instr_in_4_toCore_ts1[4]), 
      .ms_riscv32_mp_instr_in_4_toCore(ms_riscv32_mp_instr_in_5_toCore_ts1[4]), 
      .ms_riscv32_mp_instr_in_5_fromPad(ms_riscv32_mp_instr_in_5_toCore_ts1[5]), 
      .ms_riscv32_mp_instr_in_5_toCore(ms_riscv32_mp_instr_in_5_toCore[5]), .ms_riscv32_mp_instr_in_6_fromPad(ms_riscv32_mp_instr_in_6_toCore_ts1[6]), 
      .ms_riscv32_mp_instr_in_6_toCore(ms_riscv32_mp_instr_in_7_toCore_ts1[6]), 
      .ms_riscv32_mp_instr_in_7_fromPad(ms_riscv32_mp_instr_in_7_toCore_ts1[7]), 
      .ms_riscv32_mp_instr_in_7_toCore(ms_riscv32_mp_instr_in_7_toCore[7]), .ms_riscv32_mp_instr_in_8_fromPad(ms_riscv32_mp_instr_in_8_toCore_ts1[8]), 
      .ms_riscv32_mp_instr_in_8_toCore(ms_riscv32_mp_instr_in_9_toCore_ts1[8]), 
      .ms_riscv32_mp_instr_in_9_fromPad(ms_riscv32_mp_instr_in_9_toCore_ts1[9]), 
      .ms_riscv32_mp_instr_in_9_toCore(ms_riscv32_mp_instr_in_9_toCore[9]), .ms_riscv32_mp_rc_in_0_fromPad(ms_riscv32_mp_rc_in_0_toCore_ts1[0]), 
      .ms_riscv32_mp_rc_in_0_toCore(ms_riscv32_mp_rc_in_1_toCore_ts1[0]), .ms_riscv32_mp_rc_in_10_fromPad(ms_riscv32_mp_rc_in_10_toCore_ts1[10]), 
      .ms_riscv32_mp_rc_in_10_toCore(ms_riscv32_mp_rc_in_11_toCore_ts1[10]), .ms_riscv32_mp_rc_in_11_fromPad(ms_riscv32_mp_rc_in_11_toCore_ts1[11]), 
      .ms_riscv32_mp_rc_in_11_toCore(ms_riscv32_mp_rc_in_11_toCore[11]), .ms_riscv32_mp_rc_in_12_fromPad(ms_riscv32_mp_rc_in_12_toCore_ts1[12]), 
      .ms_riscv32_mp_rc_in_12_toCore(ms_riscv32_mp_rc_in_13_toCore_ts1[12]), .ms_riscv32_mp_rc_in_13_fromPad(ms_riscv32_mp_rc_in_13_toCore_ts1[13]), 
      .ms_riscv32_mp_rc_in_13_toCore(ms_riscv32_mp_rc_in_13_toCore[13]), .ms_riscv32_mp_rc_in_14_fromPad(ms_riscv32_mp_rc_in_14_toCore_ts1[14]), 
      .ms_riscv32_mp_rc_in_14_toCore(ms_riscv32_mp_rc_in_15_toCore_ts1[14]), .ms_riscv32_mp_rc_in_15_fromPad(ms_riscv32_mp_rc_in_15_toCore_ts1[15]), 
      .ms_riscv32_mp_rc_in_15_toCore(ms_riscv32_mp_rc_in_15_toCore[15]), .ms_riscv32_mp_rc_in_16_fromPad(ms_riscv32_mp_rc_in_16_toCore_ts1[16]), 
      .ms_riscv32_mp_rc_in_16_toCore(ms_riscv32_mp_rc_in_17_toCore_ts1[16]), .ms_riscv32_mp_rc_in_17_fromPad(ms_riscv32_mp_rc_in_17_toCore_ts1[17]), 
      .ms_riscv32_mp_rc_in_17_toCore(ms_riscv32_mp_rc_in_17_toCore[17]), .ms_riscv32_mp_rc_in_18_fromPad(ms_riscv32_mp_rc_in_18_toCore_ts1[18]), 
      .ms_riscv32_mp_rc_in_18_toCore(ms_riscv32_mp_rc_in_19_toCore_ts1[18]), .ms_riscv32_mp_rc_in_19_fromPad(ms_riscv32_mp_rc_in_19_toCore_ts1[19]), 
      .ms_riscv32_mp_rc_in_19_toCore(ms_riscv32_mp_rc_in_19_toCore[19]), .ms_riscv32_mp_rc_in_1_fromPad(ms_riscv32_mp_rc_in_1_toCore_ts1[1]), 
      .ms_riscv32_mp_rc_in_1_toCore(ms_riscv32_mp_rc_in_1_toCore[1]), .ms_riscv32_mp_rc_in_20_fromPad(ms_riscv32_mp_rc_in_20_toCore_ts1[20]), 
      .ms_riscv32_mp_rc_in_20_toCore(ms_riscv32_mp_rc_in_21_toCore_ts1[20]), .ms_riscv32_mp_rc_in_21_fromPad(ms_riscv32_mp_rc_in_21_toCore_ts1[21]), 
      .ms_riscv32_mp_rc_in_21_toCore(ms_riscv32_mp_rc_in_21_toCore[21]), .ms_riscv32_mp_rc_in_22_fromPad(ms_riscv32_mp_rc_in_22_toCore_ts1[22]), 
      .ms_riscv32_mp_rc_in_22_toCore(ms_riscv32_mp_rc_in_23_toCore_ts1[22]), .ms_riscv32_mp_rc_in_23_fromPad(ms_riscv32_mp_rc_in_23_toCore_ts1[23]), 
      .ms_riscv32_mp_rc_in_23_toCore(ms_riscv32_mp_rc_in_23_toCore[23]), .ms_riscv32_mp_rc_in_24_fromPad(ms_riscv32_mp_rc_in_24_toCore_ts1[24]), 
      .ms_riscv32_mp_rc_in_24_toCore(ms_riscv32_mp_rc_in_25_toCore_ts1[24]), .ms_riscv32_mp_rc_in_25_fromPad(ms_riscv32_mp_rc_in_25_toCore_ts1[25]), 
      .ms_riscv32_mp_rc_in_25_toCore(ms_riscv32_mp_rc_in_25_toCore[25]), .ms_riscv32_mp_rc_in_26_fromPad(ms_riscv32_mp_rc_in_26_toCore_ts1[26]), 
      .ms_riscv32_mp_rc_in_26_toCore(ms_riscv32_mp_rc_in_27_toCore_ts1[26]), .ms_riscv32_mp_rc_in_27_fromPad(ms_riscv32_mp_rc_in_27_toCore_ts1[27]), 
      .ms_riscv32_mp_rc_in_27_toCore(ms_riscv32_mp_rc_in_27_toCore[27]), .ms_riscv32_mp_rc_in_28_fromPad(ms_riscv32_mp_rc_in_28_toCore_ts1[28]), 
      .ms_riscv32_mp_rc_in_28_toCore(ms_riscv32_mp_rc_in_29_toCore_ts1[28]), .ms_riscv32_mp_rc_in_29_fromPad(ms_riscv32_mp_rc_in_29_toCore_ts1[29]), 
      .ms_riscv32_mp_rc_in_29_toCore(ms_riscv32_mp_rc_in_29_toCore[29]), .ms_riscv32_mp_rc_in_2_fromPad(ms_riscv32_mp_rc_in_2_toCore_ts1[2]), 
      .ms_riscv32_mp_rc_in_2_toCore(ms_riscv32_mp_rc_in_3_toCore_ts1[2]), .ms_riscv32_mp_rc_in_30_fromPad(ms_riscv32_mp_rc_in_30_toCore_ts1[30]), 
      .ms_riscv32_mp_rc_in_30_toCore(ms_riscv32_mp_rc_in_31_toCore_ts1[30]), .ms_riscv32_mp_rc_in_31_fromPad(ms_riscv32_mp_rc_in_31_toCore_ts1[31]), 
      .ms_riscv32_mp_rc_in_31_toCore(ms_riscv32_mp_rc_in_31_toCore[31]), .ms_riscv32_mp_rc_in_32_fromPad(ms_riscv32_mp_rc_in_32_toCore_ts1[32]), 
      .ms_riscv32_mp_rc_in_32_toCore(ms_riscv32_mp_rc_in_33_toCore_ts1[32]), .ms_riscv32_mp_rc_in_33_fromPad(ms_riscv32_mp_rc_in_33_toCore_ts1[33]), 
      .ms_riscv32_mp_rc_in_33_toCore(ms_riscv32_mp_rc_in_33_toCore[33]), .ms_riscv32_mp_rc_in_34_fromPad(ms_riscv32_mp_rc_in_34_toCore_ts1[34]), 
      .ms_riscv32_mp_rc_in_34_toCore(ms_riscv32_mp_rc_in_35_toCore_ts1[34]), .ms_riscv32_mp_rc_in_35_fromPad(ms_riscv32_mp_rc_in_35_toCore_ts1[35]), 
      .ms_riscv32_mp_rc_in_35_toCore(ms_riscv32_mp_rc_in_35_toCore[35]), .ms_riscv32_mp_rc_in_36_fromPad(ms_riscv32_mp_rc_in_36_toCore_ts1[36]), 
      .ms_riscv32_mp_rc_in_36_toCore(ms_riscv32_mp_rc_in_37_toCore_ts1[36]), .ms_riscv32_mp_rc_in_37_fromPad(ms_riscv32_mp_rc_in_37_toCore_ts1[37]), 
      .ms_riscv32_mp_rc_in_37_toCore(ms_riscv32_mp_rc_in_37_toCore[37]), .ms_riscv32_mp_rc_in_38_fromPad(ms_riscv32_mp_rc_in_38_toCore_ts1[38]), 
      .ms_riscv32_mp_rc_in_38_toCore(ms_riscv32_mp_rc_in_39_toCore_ts1[38]), .ms_riscv32_mp_rc_in_39_fromPad(ms_riscv32_mp_rc_in_39_toCore_ts1[39]), 
      .ms_riscv32_mp_rc_in_39_toCore(ms_riscv32_mp_rc_in_39_toCore[39]), .ms_riscv32_mp_rc_in_3_fromPad(ms_riscv32_mp_rc_in_3_toCore_ts1[3]), 
      .ms_riscv32_mp_rc_in_3_toCore(ms_riscv32_mp_rc_in_3_toCore[3]), .ms_riscv32_mp_rc_in_40_fromPad(ms_riscv32_mp_rc_in_40_toCore_ts1[40]), 
      .ms_riscv32_mp_rc_in_40_toCore(ms_riscv32_mp_rc_in_41_toCore_ts1[40]), .ms_riscv32_mp_rc_in_41_fromPad(ms_riscv32_mp_rc_in_41_toCore_ts1[41]), 
      .ms_riscv32_mp_rc_in_41_toCore(ms_riscv32_mp_rc_in_41_toCore[41]), .ms_riscv32_mp_rc_in_42_fromPad(ms_riscv32_mp_rc_in_42_toCore_ts1[42]), 
      .ms_riscv32_mp_rc_in_42_toCore(ms_riscv32_mp_rc_in_43_toCore_ts1[42]), .ms_riscv32_mp_rc_in_43_fromPad(ms_riscv32_mp_rc_in_43_toCore_ts1[43]), 
      .ms_riscv32_mp_rc_in_43_toCore(ms_riscv32_mp_rc_in_43_toCore[43]), .ms_riscv32_mp_rc_in_44_fromPad(ms_riscv32_mp_rc_in_44_toCore_ts1[44]), 
      .ms_riscv32_mp_rc_in_44_toCore(ms_riscv32_mp_rc_in_45_toCore_ts1[44]), .ms_riscv32_mp_rc_in_45_fromPad(ms_riscv32_mp_rc_in_45_toCore_ts1[45]), 
      .ms_riscv32_mp_rc_in_45_toCore(ms_riscv32_mp_rc_in_45_toCore[45]), .ms_riscv32_mp_rc_in_46_fromPad(ms_riscv32_mp_rc_in_46_toCore_ts1[46]), 
      .ms_riscv32_mp_rc_in_46_toCore(ms_riscv32_mp_rc_in_47_toCore_ts1[46]), .ms_riscv32_mp_rc_in_47_fromPad(ms_riscv32_mp_rc_in_47_toCore_ts1[47]), 
      .ms_riscv32_mp_rc_in_47_toCore(ms_riscv32_mp_rc_in_47_toCore[47]), .ms_riscv32_mp_rc_in_48_fromPad(ms_riscv32_mp_rc_in_48_toCore_ts1[48]), 
      .ms_riscv32_mp_rc_in_48_toCore(ms_riscv32_mp_rc_in_49_toCore_ts1[48]), .ms_riscv32_mp_rc_in_49_fromPad(ms_riscv32_mp_rc_in_49_toCore_ts1[49]), 
      .ms_riscv32_mp_rc_in_49_toCore(ms_riscv32_mp_rc_in_49_toCore[49]), .ms_riscv32_mp_rc_in_4_fromPad(ms_riscv32_mp_rc_in_4_toCore_ts1[4]), 
      .ms_riscv32_mp_rc_in_4_toCore(ms_riscv32_mp_rc_in_5_toCore_ts1[4]), .ms_riscv32_mp_rc_in_50_fromPad(ms_riscv32_mp_rc_in_50_toCore_ts1[50]), 
      .ms_riscv32_mp_rc_in_50_toCore(ms_riscv32_mp_rc_in_51_toCore_ts1[50]), .ms_riscv32_mp_rc_in_51_fromPad(ms_riscv32_mp_rc_in_51_toCore_ts1[51]), 
      .ms_riscv32_mp_rc_in_51_toCore(ms_riscv32_mp_rc_in_51_toCore[51]), .ms_riscv32_mp_rc_in_52_fromPad(ms_riscv32_mp_rc_in_52_toCore_ts1[52]), 
      .ms_riscv32_mp_rc_in_52_toCore(ms_riscv32_mp_rc_in_53_toCore_ts1[52]), .ms_riscv32_mp_rc_in_53_fromPad(ms_riscv32_mp_rc_in_53_toCore_ts1[53]), 
      .ms_riscv32_mp_rc_in_53_toCore(ms_riscv32_mp_rc_in_53_toCore[53]), .ms_riscv32_mp_rc_in_54_fromPad(ms_riscv32_mp_rc_in_54_toCore_ts1[54]), 
      .ms_riscv32_mp_rc_in_54_toCore(ms_riscv32_mp_rc_in_55_toCore_ts1[54]), .ms_riscv32_mp_rc_in_55_fromPad(ms_riscv32_mp_rc_in_55_toCore_ts1[55]), 
      .ms_riscv32_mp_rc_in_55_toCore(ms_riscv32_mp_rc_in_55_toCore[55]), .ms_riscv32_mp_rc_in_56_fromPad(ms_riscv32_mp_rc_in_56_toCore_ts1[56]), 
      .ms_riscv32_mp_rc_in_56_toCore(ms_riscv32_mp_rc_in_57_toCore_ts1[56]), .ms_riscv32_mp_rc_in_57_fromPad(ms_riscv32_mp_rc_in_57_toCore_ts1[57]), 
      .ms_riscv32_mp_rc_in_57_toCore(ms_riscv32_mp_rc_in_57_toCore[57]), .ms_riscv32_mp_rc_in_58_fromPad(ms_riscv32_mp_rc_in_58_toCore_ts1[58]), 
      .ms_riscv32_mp_rc_in_58_toCore(ms_riscv32_mp_rc_in_59_toCore_ts1[58]), .ms_riscv32_mp_rc_in_59_fromPad(ms_riscv32_mp_rc_in_59_toCore_ts1[59]), 
      .ms_riscv32_mp_rc_in_59_toCore(ms_riscv32_mp_rc_in_59_toCore[59]), .ms_riscv32_mp_rc_in_5_fromPad(ms_riscv32_mp_rc_in_5_toCore_ts1[5]), 
      .ms_riscv32_mp_rc_in_5_toCore(ms_riscv32_mp_rc_in_5_toCore[5]), .ms_riscv32_mp_rc_in_60_fromPad(ms_riscv32_mp_rc_in_60_toCore_ts1[60]), 
      .ms_riscv32_mp_rc_in_60_toCore(ms_riscv32_mp_rc_in_61_toCore_ts1[60]), .ms_riscv32_mp_rc_in_61_fromPad(ms_riscv32_mp_rc_in_61_toCore_ts1[61]), 
      .ms_riscv32_mp_rc_in_61_toCore(ms_riscv32_mp_rc_in_61_toCore[61]), .ms_riscv32_mp_rc_in_62_fromPad(ms_riscv32_mp_rc_in_62_toCore_ts1[62]), 
      .ms_riscv32_mp_rc_in_62_toCore(ms_riscv32_mp_rc_in_63_fromPad_ts1[62]), .ms_riscv32_mp_rc_in_63_fromPad(ms_riscv32_mp_rc_in_63_fromPad), 
      .ms_riscv32_mp_rc_in_63_toCore(), .ms_riscv32_mp_rc_in_6_fromPad(ms_riscv32_mp_rc_in_6_toCore_ts1[6]), 
      .ms_riscv32_mp_rc_in_6_toCore(ms_riscv32_mp_rc_in_7_toCore_ts1[6]), .ms_riscv32_mp_rc_in_7_fromPad(ms_riscv32_mp_rc_in_7_toCore_ts1[7]), 
      .ms_riscv32_mp_rc_in_7_toCore(ms_riscv32_mp_rc_in_7_toCore[7]), .ms_riscv32_mp_rc_in_8_fromPad(ms_riscv32_mp_rc_in_8_toCore_ts1[8]), 
      .ms_riscv32_mp_rc_in_8_toCore(ms_riscv32_mp_rc_in_9_toCore_ts1[8]), .ms_riscv32_mp_rc_in_9_fromPad(ms_riscv32_mp_rc_in_9_toCore_ts1[9]), 
      .ms_riscv32_mp_rc_in_9_toCore(ms_riscv32_mp_rc_in_9_toCore[9]), .ms_riscv32_mp_rst_in_fromPad(ms_riscv32_mp_rst_in_fromPad), 
      .ms_riscv32_mp_rst_in_toCore(rst_pad_C), .ms_riscv32_mp_sirq_in_fromPad(ms_riscv32_mp_sirq_in_fromPad), 
      .ms_riscv32_mp_sirq_in_toCore(), .ms_riscv32_mp_tirq_in_fromPad(ms_riscv32_mp_tirq_in_fromPad), 
      .ms_riscv32_mp_tirq_in_toCore(), .ramclk_p_fromPad(ramclk_p_fromPad), .ramclk_p_toCore(), 
      .selectJtagInput(to_bscan_select_jtag_input), .selectJtagOutput(to_bscan_select_jtag_output), 
      .shiftBscan2Edge(to_bscan_shift_en), .update_clock(to_bscan_update_clock)
  );

  assign EN1_en1_ts1[31] = EN1_en1;

  assign EN1_en1_ts1[30] = EN1_en1;

  assign EN1_en1_ts1[29] = EN1_en1;

  assign EN1_en1_ts1[28] = EN1_en1;

  assign EN1_en1_ts1[27] = EN1_en1;

  assign EN1_en1_ts1[26] = EN1_en1;

  assign EN1_en1_ts1[25] = EN1_en1;

  assign EN1_en1_ts1[24] = EN1_en1;

  assign EN1_en1_ts1[23] = EN1_en1;

  assign EN1_en1_ts1[22] = EN1_en1;

  assign EN1_en1_ts1[21] = EN1_en1;

  assign EN1_en1_ts1[20] = EN1_en1;

  assign EN1_en1_ts1[19] = EN1_en1;

  assign EN1_en1_ts1[18] = EN1_en1;

  assign EN1_en1_ts1[17] = EN1_en1;

  assign EN1_en1_ts1[16] = EN1_en1;

  assign EN1_en1_ts1[14] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[13] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[12] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[11] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[10] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[9] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[8] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[7] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[6] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[5] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[4] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[3] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[2] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[1] = EN1_en1_ts1[15];

  assign EN1_en1_ts1[0] = EN1_en1_ts1[15];

  assign EN3_en1_ts1[31] = EN3_en1;

  assign EN3_en1_ts1[30] = EN3_en1;

  assign EN3_en1_ts1[29] = EN3_en1;

  assign EN3_en1_ts1[28] = EN3_en1;

  assign EN3_en1_ts1[27] = EN3_en1;

  assign EN3_en1_ts1[26] = EN3_en1;

  assign EN3_en1_ts1[25] = EN3_en1;

  assign EN3_en1_ts1[24] = EN3_en1;

  assign EN3_en1_ts1[23] = EN3_en1;

  assign EN3_en1_ts1[22] = EN3_en1;

  assign EN3_en1_ts1[21] = EN3_en1;

  assign EN3_en1_ts1[20] = EN3_en1;

  assign EN3_en1_ts1[19] = EN3_en1;

  assign EN3_en1_ts1[18] = EN3_en1;

  assign EN3_en1_ts1[17] = EN3_en1;

  assign EN3_en1_ts1[16] = EN3_en1;

  assign EN3_en1_ts1[14] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[13] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[12] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[11] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[10] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[9] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[8] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[7] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[6] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[5] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[4] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[3] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[2] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[1] = EN3_en1_ts1[15];

  assign EN3_en1_ts1[0] = EN3_en1_ts1[15];

  assign EN5_en1_ts1[3] = EN5_en1;

  assign EN5_en1_ts1[2] = EN5_en1;

  assign EN5_en1_ts1[1] = EN5_en1;

  assign EN5_en1_ts1[0] = EN5_en1;

  assign EN5_en1_ts2[1] = EN5_en1;

  assign EN5_en1_ts2[0] = EN5_en1;

  assign ms_riscv32_mp_rc_in_63_fromPad = ms_riscv32_mp_rc_in_63_fromPad_ts1[63];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[0] = ms_riscv32_mp_rc_in_62_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[1] = ms_riscv32_mp_rc_in_62_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[2] = ms_riscv32_mp_rc_in_62_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[3] = ms_riscv32_mp_rc_in_62_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[4] = ms_riscv32_mp_rc_in_62_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[5] = ms_riscv32_mp_rc_in_62_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[6] = ms_riscv32_mp_rc_in_62_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[7] = ms_riscv32_mp_rc_in_62_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[8] = ms_riscv32_mp_rc_in_62_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[9] = ms_riscv32_mp_rc_in_62_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[10] = ms_riscv32_mp_rc_in_62_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[11] = ms_riscv32_mp_rc_in_62_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[12] = ms_riscv32_mp_rc_in_62_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[13] = ms_riscv32_mp_rc_in_62_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[14] = ms_riscv32_mp_rc_in_62_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[15] = ms_riscv32_mp_rc_in_62_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[16] = ms_riscv32_mp_rc_in_62_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[17] = ms_riscv32_mp_rc_in_62_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[18] = ms_riscv32_mp_rc_in_62_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[19] = ms_riscv32_mp_rc_in_62_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[20] = ms_riscv32_mp_rc_in_62_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[21] = ms_riscv32_mp_rc_in_62_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[22] = ms_riscv32_mp_rc_in_62_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[23] = ms_riscv32_mp_rc_in_62_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[24] = ms_riscv32_mp_rc_in_62_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[25] = ms_riscv32_mp_rc_in_62_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[26] = ms_riscv32_mp_rc_in_62_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[27] = ms_riscv32_mp_rc_in_62_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[28] = ms_riscv32_mp_rc_in_62_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[29] = ms_riscv32_mp_rc_in_62_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[30] = ms_riscv32_mp_rc_in_62_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[31] = ms_riscv32_mp_rc_in_62_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[32] = ms_riscv32_mp_rc_in_62_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[33] = ms_riscv32_mp_rc_in_62_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[34] = ms_riscv32_mp_rc_in_62_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[35] = ms_riscv32_mp_rc_in_62_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[36] = ms_riscv32_mp_rc_in_62_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[37] = ms_riscv32_mp_rc_in_62_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[38] = ms_riscv32_mp_rc_in_62_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[39] = ms_riscv32_mp_rc_in_62_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[40] = ms_riscv32_mp_rc_in_62_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[41] = ms_riscv32_mp_rc_in_62_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[42] = ms_riscv32_mp_rc_in_62_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[43] = ms_riscv32_mp_rc_in_62_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[44] = ms_riscv32_mp_rc_in_62_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[45] = ms_riscv32_mp_rc_in_62_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[46] = ms_riscv32_mp_rc_in_62_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[47] = ms_riscv32_mp_rc_in_62_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[48] = ms_riscv32_mp_rc_in_62_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[49] = ms_riscv32_mp_rc_in_62_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[50] = ms_riscv32_mp_rc_in_62_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[51] = ms_riscv32_mp_rc_in_62_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[52] = ms_riscv32_mp_rc_in_62_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[53] = ms_riscv32_mp_rc_in_62_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[54] = ms_riscv32_mp_rc_in_62_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[55] = ms_riscv32_mp_rc_in_62_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[56] = ms_riscv32_mp_rc_in_62_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[57] = ms_riscv32_mp_rc_in_62_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[58] = ms_riscv32_mp_rc_in_62_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[59] = ms_riscv32_mp_rc_in_62_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[60] = ms_riscv32_mp_rc_in_62_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[61] = ms_riscv32_mp_rc_in_62_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_63_fromPad_ts1[63] = ms_riscv32_mp_rc_in_62_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_61_toCore[0] = ms_riscv32_mp_rc_in_61_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_61_toCore[1] = ms_riscv32_mp_rc_in_61_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_61_toCore[2] = ms_riscv32_mp_rc_in_61_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_61_toCore[3] = ms_riscv32_mp_rc_in_61_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_61_toCore[4] = ms_riscv32_mp_rc_in_61_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_61_toCore[5] = ms_riscv32_mp_rc_in_61_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_61_toCore[6] = ms_riscv32_mp_rc_in_61_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_61_toCore[7] = ms_riscv32_mp_rc_in_61_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_61_toCore[8] = ms_riscv32_mp_rc_in_61_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_61_toCore[9] = ms_riscv32_mp_rc_in_61_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_61_toCore[10] = ms_riscv32_mp_rc_in_61_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_61_toCore[11] = ms_riscv32_mp_rc_in_61_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_61_toCore[12] = ms_riscv32_mp_rc_in_61_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_61_toCore[13] = ms_riscv32_mp_rc_in_61_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_61_toCore[14] = ms_riscv32_mp_rc_in_61_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_61_toCore[15] = ms_riscv32_mp_rc_in_61_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_61_toCore[16] = ms_riscv32_mp_rc_in_61_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_61_toCore[17] = ms_riscv32_mp_rc_in_61_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_61_toCore[18] = ms_riscv32_mp_rc_in_61_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_61_toCore[19] = ms_riscv32_mp_rc_in_61_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_61_toCore[20] = ms_riscv32_mp_rc_in_61_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_61_toCore[21] = ms_riscv32_mp_rc_in_61_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_61_toCore[22] = ms_riscv32_mp_rc_in_61_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_61_toCore[23] = ms_riscv32_mp_rc_in_61_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_61_toCore[24] = ms_riscv32_mp_rc_in_61_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_61_toCore[25] = ms_riscv32_mp_rc_in_61_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_61_toCore[26] = ms_riscv32_mp_rc_in_61_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_61_toCore[27] = ms_riscv32_mp_rc_in_61_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_61_toCore[28] = ms_riscv32_mp_rc_in_61_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_61_toCore[29] = ms_riscv32_mp_rc_in_61_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_61_toCore[30] = ms_riscv32_mp_rc_in_61_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_61_toCore[31] = ms_riscv32_mp_rc_in_61_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_61_toCore[32] = ms_riscv32_mp_rc_in_61_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_61_toCore[33] = ms_riscv32_mp_rc_in_61_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_61_toCore[34] = ms_riscv32_mp_rc_in_61_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_61_toCore[35] = ms_riscv32_mp_rc_in_61_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_61_toCore[36] = ms_riscv32_mp_rc_in_61_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_61_toCore[37] = ms_riscv32_mp_rc_in_61_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_61_toCore[38] = ms_riscv32_mp_rc_in_61_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_61_toCore[39] = ms_riscv32_mp_rc_in_61_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_61_toCore[40] = ms_riscv32_mp_rc_in_61_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_61_toCore[41] = ms_riscv32_mp_rc_in_61_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_61_toCore[42] = ms_riscv32_mp_rc_in_61_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_61_toCore[43] = ms_riscv32_mp_rc_in_61_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_61_toCore[44] = ms_riscv32_mp_rc_in_61_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_61_toCore[45] = ms_riscv32_mp_rc_in_61_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_61_toCore[46] = ms_riscv32_mp_rc_in_61_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_61_toCore[47] = ms_riscv32_mp_rc_in_61_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_61_toCore[48] = ms_riscv32_mp_rc_in_61_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_61_toCore[49] = ms_riscv32_mp_rc_in_61_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_61_toCore[50] = ms_riscv32_mp_rc_in_61_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_61_toCore[51] = ms_riscv32_mp_rc_in_61_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_61_toCore[52] = ms_riscv32_mp_rc_in_61_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_61_toCore[53] = ms_riscv32_mp_rc_in_61_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_61_toCore[54] = ms_riscv32_mp_rc_in_61_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_61_toCore[55] = ms_riscv32_mp_rc_in_61_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_61_toCore[56] = ms_riscv32_mp_rc_in_61_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_61_toCore[57] = ms_riscv32_mp_rc_in_61_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_61_toCore[58] = ms_riscv32_mp_rc_in_61_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_61_toCore[59] = ms_riscv32_mp_rc_in_61_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_61_toCore[60] = ms_riscv32_mp_rc_in_61_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_61_toCore[62] = ms_riscv32_mp_rc_in_61_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_61_toCore[63] = ms_riscv32_mp_rc_in_61_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[0] = ms_riscv32_mp_rc_in_60_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[1] = ms_riscv32_mp_rc_in_60_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[2] = ms_riscv32_mp_rc_in_60_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[3] = ms_riscv32_mp_rc_in_60_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[4] = ms_riscv32_mp_rc_in_60_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[5] = ms_riscv32_mp_rc_in_60_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[6] = ms_riscv32_mp_rc_in_60_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[7] = ms_riscv32_mp_rc_in_60_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[8] = ms_riscv32_mp_rc_in_60_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[9] = ms_riscv32_mp_rc_in_60_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[10] = ms_riscv32_mp_rc_in_60_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[11] = ms_riscv32_mp_rc_in_60_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[12] = ms_riscv32_mp_rc_in_60_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[13] = ms_riscv32_mp_rc_in_60_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[14] = ms_riscv32_mp_rc_in_60_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[15] = ms_riscv32_mp_rc_in_60_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[16] = ms_riscv32_mp_rc_in_60_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[17] = ms_riscv32_mp_rc_in_60_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[18] = ms_riscv32_mp_rc_in_60_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[19] = ms_riscv32_mp_rc_in_60_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[20] = ms_riscv32_mp_rc_in_60_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[21] = ms_riscv32_mp_rc_in_60_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[22] = ms_riscv32_mp_rc_in_60_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[23] = ms_riscv32_mp_rc_in_60_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[24] = ms_riscv32_mp_rc_in_60_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[25] = ms_riscv32_mp_rc_in_60_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[26] = ms_riscv32_mp_rc_in_60_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[27] = ms_riscv32_mp_rc_in_60_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[28] = ms_riscv32_mp_rc_in_60_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[29] = ms_riscv32_mp_rc_in_60_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[30] = ms_riscv32_mp_rc_in_60_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[31] = ms_riscv32_mp_rc_in_60_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[32] = ms_riscv32_mp_rc_in_60_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[33] = ms_riscv32_mp_rc_in_60_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[34] = ms_riscv32_mp_rc_in_60_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[35] = ms_riscv32_mp_rc_in_60_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[36] = ms_riscv32_mp_rc_in_60_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[37] = ms_riscv32_mp_rc_in_60_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[38] = ms_riscv32_mp_rc_in_60_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[39] = ms_riscv32_mp_rc_in_60_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[40] = ms_riscv32_mp_rc_in_60_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[41] = ms_riscv32_mp_rc_in_60_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[42] = ms_riscv32_mp_rc_in_60_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[43] = ms_riscv32_mp_rc_in_60_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[44] = ms_riscv32_mp_rc_in_60_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[45] = ms_riscv32_mp_rc_in_60_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[46] = ms_riscv32_mp_rc_in_60_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[47] = ms_riscv32_mp_rc_in_60_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[48] = ms_riscv32_mp_rc_in_60_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[49] = ms_riscv32_mp_rc_in_60_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[50] = ms_riscv32_mp_rc_in_60_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[51] = ms_riscv32_mp_rc_in_60_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[52] = ms_riscv32_mp_rc_in_60_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[53] = ms_riscv32_mp_rc_in_60_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[54] = ms_riscv32_mp_rc_in_60_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[55] = ms_riscv32_mp_rc_in_60_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[56] = ms_riscv32_mp_rc_in_60_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[57] = ms_riscv32_mp_rc_in_60_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[58] = ms_riscv32_mp_rc_in_60_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[59] = ms_riscv32_mp_rc_in_60_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[61] = ms_riscv32_mp_rc_in_60_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[62] = ms_riscv32_mp_rc_in_60_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_61_toCore_ts1[63] = ms_riscv32_mp_rc_in_60_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_59_toCore[0] = ms_riscv32_mp_rc_in_59_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_59_toCore[1] = ms_riscv32_mp_rc_in_59_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_59_toCore[2] = ms_riscv32_mp_rc_in_59_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_59_toCore[3] = ms_riscv32_mp_rc_in_59_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_59_toCore[4] = ms_riscv32_mp_rc_in_59_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_59_toCore[5] = ms_riscv32_mp_rc_in_59_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_59_toCore[6] = ms_riscv32_mp_rc_in_59_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_59_toCore[7] = ms_riscv32_mp_rc_in_59_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_59_toCore[8] = ms_riscv32_mp_rc_in_59_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_59_toCore[9] = ms_riscv32_mp_rc_in_59_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_59_toCore[10] = ms_riscv32_mp_rc_in_59_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_59_toCore[11] = ms_riscv32_mp_rc_in_59_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_59_toCore[12] = ms_riscv32_mp_rc_in_59_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_59_toCore[13] = ms_riscv32_mp_rc_in_59_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_59_toCore[14] = ms_riscv32_mp_rc_in_59_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_59_toCore[15] = ms_riscv32_mp_rc_in_59_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_59_toCore[16] = ms_riscv32_mp_rc_in_59_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_59_toCore[17] = ms_riscv32_mp_rc_in_59_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_59_toCore[18] = ms_riscv32_mp_rc_in_59_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_59_toCore[19] = ms_riscv32_mp_rc_in_59_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_59_toCore[20] = ms_riscv32_mp_rc_in_59_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_59_toCore[21] = ms_riscv32_mp_rc_in_59_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_59_toCore[22] = ms_riscv32_mp_rc_in_59_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_59_toCore[23] = ms_riscv32_mp_rc_in_59_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_59_toCore[24] = ms_riscv32_mp_rc_in_59_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_59_toCore[25] = ms_riscv32_mp_rc_in_59_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_59_toCore[26] = ms_riscv32_mp_rc_in_59_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_59_toCore[27] = ms_riscv32_mp_rc_in_59_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_59_toCore[28] = ms_riscv32_mp_rc_in_59_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_59_toCore[29] = ms_riscv32_mp_rc_in_59_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_59_toCore[30] = ms_riscv32_mp_rc_in_59_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_59_toCore[31] = ms_riscv32_mp_rc_in_59_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_59_toCore[32] = ms_riscv32_mp_rc_in_59_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_59_toCore[33] = ms_riscv32_mp_rc_in_59_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_59_toCore[34] = ms_riscv32_mp_rc_in_59_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_59_toCore[35] = ms_riscv32_mp_rc_in_59_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_59_toCore[36] = ms_riscv32_mp_rc_in_59_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_59_toCore[37] = ms_riscv32_mp_rc_in_59_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_59_toCore[38] = ms_riscv32_mp_rc_in_59_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_59_toCore[39] = ms_riscv32_mp_rc_in_59_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_59_toCore[40] = ms_riscv32_mp_rc_in_59_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_59_toCore[41] = ms_riscv32_mp_rc_in_59_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_59_toCore[42] = ms_riscv32_mp_rc_in_59_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_59_toCore[43] = ms_riscv32_mp_rc_in_59_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_59_toCore[44] = ms_riscv32_mp_rc_in_59_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_59_toCore[45] = ms_riscv32_mp_rc_in_59_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_59_toCore[46] = ms_riscv32_mp_rc_in_59_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_59_toCore[47] = ms_riscv32_mp_rc_in_59_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_59_toCore[48] = ms_riscv32_mp_rc_in_59_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_59_toCore[49] = ms_riscv32_mp_rc_in_59_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_59_toCore[50] = ms_riscv32_mp_rc_in_59_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_59_toCore[51] = ms_riscv32_mp_rc_in_59_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_59_toCore[52] = ms_riscv32_mp_rc_in_59_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_59_toCore[53] = ms_riscv32_mp_rc_in_59_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_59_toCore[54] = ms_riscv32_mp_rc_in_59_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_59_toCore[55] = ms_riscv32_mp_rc_in_59_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_59_toCore[56] = ms_riscv32_mp_rc_in_59_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_59_toCore[57] = ms_riscv32_mp_rc_in_59_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_59_toCore[58] = ms_riscv32_mp_rc_in_59_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_59_toCore[60] = ms_riscv32_mp_rc_in_59_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_59_toCore[61] = ms_riscv32_mp_rc_in_59_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_59_toCore[62] = ms_riscv32_mp_rc_in_59_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_59_toCore[63] = ms_riscv32_mp_rc_in_59_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[0] = ms_riscv32_mp_rc_in_58_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[1] = ms_riscv32_mp_rc_in_58_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[2] = ms_riscv32_mp_rc_in_58_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[3] = ms_riscv32_mp_rc_in_58_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[4] = ms_riscv32_mp_rc_in_58_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[5] = ms_riscv32_mp_rc_in_58_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[6] = ms_riscv32_mp_rc_in_58_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[7] = ms_riscv32_mp_rc_in_58_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[8] = ms_riscv32_mp_rc_in_58_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[9] = ms_riscv32_mp_rc_in_58_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[10] = ms_riscv32_mp_rc_in_58_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[11] = ms_riscv32_mp_rc_in_58_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[12] = ms_riscv32_mp_rc_in_58_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[13] = ms_riscv32_mp_rc_in_58_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[14] = ms_riscv32_mp_rc_in_58_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[15] = ms_riscv32_mp_rc_in_58_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[16] = ms_riscv32_mp_rc_in_58_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[17] = ms_riscv32_mp_rc_in_58_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[18] = ms_riscv32_mp_rc_in_58_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[19] = ms_riscv32_mp_rc_in_58_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[20] = ms_riscv32_mp_rc_in_58_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[21] = ms_riscv32_mp_rc_in_58_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[22] = ms_riscv32_mp_rc_in_58_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[23] = ms_riscv32_mp_rc_in_58_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[24] = ms_riscv32_mp_rc_in_58_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[25] = ms_riscv32_mp_rc_in_58_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[26] = ms_riscv32_mp_rc_in_58_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[27] = ms_riscv32_mp_rc_in_58_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[28] = ms_riscv32_mp_rc_in_58_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[29] = ms_riscv32_mp_rc_in_58_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[30] = ms_riscv32_mp_rc_in_58_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[31] = ms_riscv32_mp_rc_in_58_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[32] = ms_riscv32_mp_rc_in_58_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[33] = ms_riscv32_mp_rc_in_58_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[34] = ms_riscv32_mp_rc_in_58_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[35] = ms_riscv32_mp_rc_in_58_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[36] = ms_riscv32_mp_rc_in_58_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[37] = ms_riscv32_mp_rc_in_58_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[38] = ms_riscv32_mp_rc_in_58_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[39] = ms_riscv32_mp_rc_in_58_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[40] = ms_riscv32_mp_rc_in_58_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[41] = ms_riscv32_mp_rc_in_58_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[42] = ms_riscv32_mp_rc_in_58_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[43] = ms_riscv32_mp_rc_in_58_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[44] = ms_riscv32_mp_rc_in_58_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[45] = ms_riscv32_mp_rc_in_58_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[46] = ms_riscv32_mp_rc_in_58_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[47] = ms_riscv32_mp_rc_in_58_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[48] = ms_riscv32_mp_rc_in_58_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[49] = ms_riscv32_mp_rc_in_58_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[50] = ms_riscv32_mp_rc_in_58_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[51] = ms_riscv32_mp_rc_in_58_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[52] = ms_riscv32_mp_rc_in_58_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[53] = ms_riscv32_mp_rc_in_58_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[54] = ms_riscv32_mp_rc_in_58_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[55] = ms_riscv32_mp_rc_in_58_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[56] = ms_riscv32_mp_rc_in_58_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[57] = ms_riscv32_mp_rc_in_58_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[59] = ms_riscv32_mp_rc_in_58_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[60] = ms_riscv32_mp_rc_in_58_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[61] = ms_riscv32_mp_rc_in_58_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[62] = ms_riscv32_mp_rc_in_58_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_59_toCore_ts1[63] = ms_riscv32_mp_rc_in_58_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_57_toCore[0] = ms_riscv32_mp_rc_in_57_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_57_toCore[1] = ms_riscv32_mp_rc_in_57_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_57_toCore[2] = ms_riscv32_mp_rc_in_57_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_57_toCore[3] = ms_riscv32_mp_rc_in_57_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_57_toCore[4] = ms_riscv32_mp_rc_in_57_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_57_toCore[5] = ms_riscv32_mp_rc_in_57_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_57_toCore[6] = ms_riscv32_mp_rc_in_57_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_57_toCore[7] = ms_riscv32_mp_rc_in_57_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_57_toCore[8] = ms_riscv32_mp_rc_in_57_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_57_toCore[9] = ms_riscv32_mp_rc_in_57_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_57_toCore[10] = ms_riscv32_mp_rc_in_57_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_57_toCore[11] = ms_riscv32_mp_rc_in_57_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_57_toCore[12] = ms_riscv32_mp_rc_in_57_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_57_toCore[13] = ms_riscv32_mp_rc_in_57_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_57_toCore[14] = ms_riscv32_mp_rc_in_57_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_57_toCore[15] = ms_riscv32_mp_rc_in_57_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_57_toCore[16] = ms_riscv32_mp_rc_in_57_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_57_toCore[17] = ms_riscv32_mp_rc_in_57_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_57_toCore[18] = ms_riscv32_mp_rc_in_57_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_57_toCore[19] = ms_riscv32_mp_rc_in_57_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_57_toCore[20] = ms_riscv32_mp_rc_in_57_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_57_toCore[21] = ms_riscv32_mp_rc_in_57_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_57_toCore[22] = ms_riscv32_mp_rc_in_57_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_57_toCore[23] = ms_riscv32_mp_rc_in_57_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_57_toCore[24] = ms_riscv32_mp_rc_in_57_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_57_toCore[25] = ms_riscv32_mp_rc_in_57_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_57_toCore[26] = ms_riscv32_mp_rc_in_57_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_57_toCore[27] = ms_riscv32_mp_rc_in_57_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_57_toCore[28] = ms_riscv32_mp_rc_in_57_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_57_toCore[29] = ms_riscv32_mp_rc_in_57_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_57_toCore[30] = ms_riscv32_mp_rc_in_57_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_57_toCore[31] = ms_riscv32_mp_rc_in_57_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_57_toCore[32] = ms_riscv32_mp_rc_in_57_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_57_toCore[33] = ms_riscv32_mp_rc_in_57_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_57_toCore[34] = ms_riscv32_mp_rc_in_57_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_57_toCore[35] = ms_riscv32_mp_rc_in_57_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_57_toCore[36] = ms_riscv32_mp_rc_in_57_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_57_toCore[37] = ms_riscv32_mp_rc_in_57_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_57_toCore[38] = ms_riscv32_mp_rc_in_57_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_57_toCore[39] = ms_riscv32_mp_rc_in_57_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_57_toCore[40] = ms_riscv32_mp_rc_in_57_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_57_toCore[41] = ms_riscv32_mp_rc_in_57_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_57_toCore[42] = ms_riscv32_mp_rc_in_57_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_57_toCore[43] = ms_riscv32_mp_rc_in_57_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_57_toCore[44] = ms_riscv32_mp_rc_in_57_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_57_toCore[45] = ms_riscv32_mp_rc_in_57_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_57_toCore[46] = ms_riscv32_mp_rc_in_57_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_57_toCore[47] = ms_riscv32_mp_rc_in_57_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_57_toCore[48] = ms_riscv32_mp_rc_in_57_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_57_toCore[49] = ms_riscv32_mp_rc_in_57_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_57_toCore[50] = ms_riscv32_mp_rc_in_57_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_57_toCore[51] = ms_riscv32_mp_rc_in_57_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_57_toCore[52] = ms_riscv32_mp_rc_in_57_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_57_toCore[53] = ms_riscv32_mp_rc_in_57_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_57_toCore[54] = ms_riscv32_mp_rc_in_57_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_57_toCore[55] = ms_riscv32_mp_rc_in_57_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_57_toCore[56] = ms_riscv32_mp_rc_in_57_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_57_toCore[58] = ms_riscv32_mp_rc_in_57_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_57_toCore[59] = ms_riscv32_mp_rc_in_57_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_57_toCore[60] = ms_riscv32_mp_rc_in_57_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_57_toCore[61] = ms_riscv32_mp_rc_in_57_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_57_toCore[62] = ms_riscv32_mp_rc_in_57_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_57_toCore[63] = ms_riscv32_mp_rc_in_57_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[0] = ms_riscv32_mp_rc_in_56_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[1] = ms_riscv32_mp_rc_in_56_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[2] = ms_riscv32_mp_rc_in_56_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[3] = ms_riscv32_mp_rc_in_56_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[4] = ms_riscv32_mp_rc_in_56_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[5] = ms_riscv32_mp_rc_in_56_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[6] = ms_riscv32_mp_rc_in_56_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[7] = ms_riscv32_mp_rc_in_56_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[8] = ms_riscv32_mp_rc_in_56_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[9] = ms_riscv32_mp_rc_in_56_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[10] = ms_riscv32_mp_rc_in_56_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[11] = ms_riscv32_mp_rc_in_56_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[12] = ms_riscv32_mp_rc_in_56_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[13] = ms_riscv32_mp_rc_in_56_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[14] = ms_riscv32_mp_rc_in_56_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[15] = ms_riscv32_mp_rc_in_56_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[16] = ms_riscv32_mp_rc_in_56_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[17] = ms_riscv32_mp_rc_in_56_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[18] = ms_riscv32_mp_rc_in_56_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[19] = ms_riscv32_mp_rc_in_56_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[20] = ms_riscv32_mp_rc_in_56_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[21] = ms_riscv32_mp_rc_in_56_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[22] = ms_riscv32_mp_rc_in_56_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[23] = ms_riscv32_mp_rc_in_56_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[24] = ms_riscv32_mp_rc_in_56_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[25] = ms_riscv32_mp_rc_in_56_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[26] = ms_riscv32_mp_rc_in_56_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[27] = ms_riscv32_mp_rc_in_56_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[28] = ms_riscv32_mp_rc_in_56_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[29] = ms_riscv32_mp_rc_in_56_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[30] = ms_riscv32_mp_rc_in_56_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[31] = ms_riscv32_mp_rc_in_56_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[32] = ms_riscv32_mp_rc_in_56_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[33] = ms_riscv32_mp_rc_in_56_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[34] = ms_riscv32_mp_rc_in_56_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[35] = ms_riscv32_mp_rc_in_56_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[36] = ms_riscv32_mp_rc_in_56_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[37] = ms_riscv32_mp_rc_in_56_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[38] = ms_riscv32_mp_rc_in_56_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[39] = ms_riscv32_mp_rc_in_56_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[40] = ms_riscv32_mp_rc_in_56_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[41] = ms_riscv32_mp_rc_in_56_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[42] = ms_riscv32_mp_rc_in_56_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[43] = ms_riscv32_mp_rc_in_56_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[44] = ms_riscv32_mp_rc_in_56_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[45] = ms_riscv32_mp_rc_in_56_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[46] = ms_riscv32_mp_rc_in_56_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[47] = ms_riscv32_mp_rc_in_56_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[48] = ms_riscv32_mp_rc_in_56_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[49] = ms_riscv32_mp_rc_in_56_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[50] = ms_riscv32_mp_rc_in_56_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[51] = ms_riscv32_mp_rc_in_56_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[52] = ms_riscv32_mp_rc_in_56_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[53] = ms_riscv32_mp_rc_in_56_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[54] = ms_riscv32_mp_rc_in_56_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[55] = ms_riscv32_mp_rc_in_56_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[57] = ms_riscv32_mp_rc_in_56_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[58] = ms_riscv32_mp_rc_in_56_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[59] = ms_riscv32_mp_rc_in_56_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[60] = ms_riscv32_mp_rc_in_56_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[61] = ms_riscv32_mp_rc_in_56_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[62] = ms_riscv32_mp_rc_in_56_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_57_toCore_ts1[63] = ms_riscv32_mp_rc_in_56_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_55_toCore[0] = ms_riscv32_mp_rc_in_55_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_55_toCore[1] = ms_riscv32_mp_rc_in_55_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_55_toCore[2] = ms_riscv32_mp_rc_in_55_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_55_toCore[3] = ms_riscv32_mp_rc_in_55_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_55_toCore[4] = ms_riscv32_mp_rc_in_55_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_55_toCore[5] = ms_riscv32_mp_rc_in_55_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_55_toCore[6] = ms_riscv32_mp_rc_in_55_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_55_toCore[7] = ms_riscv32_mp_rc_in_55_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_55_toCore[8] = ms_riscv32_mp_rc_in_55_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_55_toCore[9] = ms_riscv32_mp_rc_in_55_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_55_toCore[10] = ms_riscv32_mp_rc_in_55_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_55_toCore[11] = ms_riscv32_mp_rc_in_55_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_55_toCore[12] = ms_riscv32_mp_rc_in_55_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_55_toCore[13] = ms_riscv32_mp_rc_in_55_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_55_toCore[14] = ms_riscv32_mp_rc_in_55_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_55_toCore[15] = ms_riscv32_mp_rc_in_55_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_55_toCore[16] = ms_riscv32_mp_rc_in_55_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_55_toCore[17] = ms_riscv32_mp_rc_in_55_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_55_toCore[18] = ms_riscv32_mp_rc_in_55_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_55_toCore[19] = ms_riscv32_mp_rc_in_55_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_55_toCore[20] = ms_riscv32_mp_rc_in_55_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_55_toCore[21] = ms_riscv32_mp_rc_in_55_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_55_toCore[22] = ms_riscv32_mp_rc_in_55_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_55_toCore[23] = ms_riscv32_mp_rc_in_55_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_55_toCore[24] = ms_riscv32_mp_rc_in_55_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_55_toCore[25] = ms_riscv32_mp_rc_in_55_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_55_toCore[26] = ms_riscv32_mp_rc_in_55_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_55_toCore[27] = ms_riscv32_mp_rc_in_55_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_55_toCore[28] = ms_riscv32_mp_rc_in_55_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_55_toCore[29] = ms_riscv32_mp_rc_in_55_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_55_toCore[30] = ms_riscv32_mp_rc_in_55_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_55_toCore[31] = ms_riscv32_mp_rc_in_55_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_55_toCore[32] = ms_riscv32_mp_rc_in_55_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_55_toCore[33] = ms_riscv32_mp_rc_in_55_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_55_toCore[34] = ms_riscv32_mp_rc_in_55_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_55_toCore[35] = ms_riscv32_mp_rc_in_55_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_55_toCore[36] = ms_riscv32_mp_rc_in_55_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_55_toCore[37] = ms_riscv32_mp_rc_in_55_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_55_toCore[38] = ms_riscv32_mp_rc_in_55_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_55_toCore[39] = ms_riscv32_mp_rc_in_55_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_55_toCore[40] = ms_riscv32_mp_rc_in_55_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_55_toCore[41] = ms_riscv32_mp_rc_in_55_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_55_toCore[42] = ms_riscv32_mp_rc_in_55_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_55_toCore[43] = ms_riscv32_mp_rc_in_55_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_55_toCore[44] = ms_riscv32_mp_rc_in_55_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_55_toCore[45] = ms_riscv32_mp_rc_in_55_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_55_toCore[46] = ms_riscv32_mp_rc_in_55_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_55_toCore[47] = ms_riscv32_mp_rc_in_55_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_55_toCore[48] = ms_riscv32_mp_rc_in_55_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_55_toCore[49] = ms_riscv32_mp_rc_in_55_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_55_toCore[50] = ms_riscv32_mp_rc_in_55_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_55_toCore[51] = ms_riscv32_mp_rc_in_55_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_55_toCore[52] = ms_riscv32_mp_rc_in_55_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_55_toCore[53] = ms_riscv32_mp_rc_in_55_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_55_toCore[54] = ms_riscv32_mp_rc_in_55_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_55_toCore[56] = ms_riscv32_mp_rc_in_55_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_55_toCore[57] = ms_riscv32_mp_rc_in_55_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_55_toCore[58] = ms_riscv32_mp_rc_in_55_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_55_toCore[59] = ms_riscv32_mp_rc_in_55_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_55_toCore[60] = ms_riscv32_mp_rc_in_55_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_55_toCore[61] = ms_riscv32_mp_rc_in_55_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_55_toCore[62] = ms_riscv32_mp_rc_in_55_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_55_toCore[63] = ms_riscv32_mp_rc_in_55_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[0] = ms_riscv32_mp_rc_in_54_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[1] = ms_riscv32_mp_rc_in_54_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[2] = ms_riscv32_mp_rc_in_54_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[3] = ms_riscv32_mp_rc_in_54_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[4] = ms_riscv32_mp_rc_in_54_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[5] = ms_riscv32_mp_rc_in_54_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[6] = ms_riscv32_mp_rc_in_54_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[7] = ms_riscv32_mp_rc_in_54_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[8] = ms_riscv32_mp_rc_in_54_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[9] = ms_riscv32_mp_rc_in_54_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[10] = ms_riscv32_mp_rc_in_54_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[11] = ms_riscv32_mp_rc_in_54_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[12] = ms_riscv32_mp_rc_in_54_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[13] = ms_riscv32_mp_rc_in_54_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[14] = ms_riscv32_mp_rc_in_54_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[15] = ms_riscv32_mp_rc_in_54_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[16] = ms_riscv32_mp_rc_in_54_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[17] = ms_riscv32_mp_rc_in_54_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[18] = ms_riscv32_mp_rc_in_54_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[19] = ms_riscv32_mp_rc_in_54_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[20] = ms_riscv32_mp_rc_in_54_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[21] = ms_riscv32_mp_rc_in_54_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[22] = ms_riscv32_mp_rc_in_54_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[23] = ms_riscv32_mp_rc_in_54_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[24] = ms_riscv32_mp_rc_in_54_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[25] = ms_riscv32_mp_rc_in_54_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[26] = ms_riscv32_mp_rc_in_54_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[27] = ms_riscv32_mp_rc_in_54_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[28] = ms_riscv32_mp_rc_in_54_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[29] = ms_riscv32_mp_rc_in_54_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[30] = ms_riscv32_mp_rc_in_54_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[31] = ms_riscv32_mp_rc_in_54_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[32] = ms_riscv32_mp_rc_in_54_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[33] = ms_riscv32_mp_rc_in_54_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[34] = ms_riscv32_mp_rc_in_54_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[35] = ms_riscv32_mp_rc_in_54_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[36] = ms_riscv32_mp_rc_in_54_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[37] = ms_riscv32_mp_rc_in_54_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[38] = ms_riscv32_mp_rc_in_54_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[39] = ms_riscv32_mp_rc_in_54_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[40] = ms_riscv32_mp_rc_in_54_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[41] = ms_riscv32_mp_rc_in_54_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[42] = ms_riscv32_mp_rc_in_54_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[43] = ms_riscv32_mp_rc_in_54_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[44] = ms_riscv32_mp_rc_in_54_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[45] = ms_riscv32_mp_rc_in_54_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[46] = ms_riscv32_mp_rc_in_54_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[47] = ms_riscv32_mp_rc_in_54_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[48] = ms_riscv32_mp_rc_in_54_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[49] = ms_riscv32_mp_rc_in_54_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[50] = ms_riscv32_mp_rc_in_54_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[51] = ms_riscv32_mp_rc_in_54_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[52] = ms_riscv32_mp_rc_in_54_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[53] = ms_riscv32_mp_rc_in_54_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[55] = ms_riscv32_mp_rc_in_54_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[56] = ms_riscv32_mp_rc_in_54_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[57] = ms_riscv32_mp_rc_in_54_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[58] = ms_riscv32_mp_rc_in_54_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[59] = ms_riscv32_mp_rc_in_54_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[60] = ms_riscv32_mp_rc_in_54_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[61] = ms_riscv32_mp_rc_in_54_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[62] = ms_riscv32_mp_rc_in_54_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_55_toCore_ts1[63] = ms_riscv32_mp_rc_in_54_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_53_toCore[0] = ms_riscv32_mp_rc_in_53_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_53_toCore[1] = ms_riscv32_mp_rc_in_53_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_53_toCore[2] = ms_riscv32_mp_rc_in_53_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_53_toCore[3] = ms_riscv32_mp_rc_in_53_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_53_toCore[4] = ms_riscv32_mp_rc_in_53_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_53_toCore[5] = ms_riscv32_mp_rc_in_53_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_53_toCore[6] = ms_riscv32_mp_rc_in_53_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_53_toCore[7] = ms_riscv32_mp_rc_in_53_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_53_toCore[8] = ms_riscv32_mp_rc_in_53_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_53_toCore[9] = ms_riscv32_mp_rc_in_53_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_53_toCore[10] = ms_riscv32_mp_rc_in_53_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_53_toCore[11] = ms_riscv32_mp_rc_in_53_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_53_toCore[12] = ms_riscv32_mp_rc_in_53_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_53_toCore[13] = ms_riscv32_mp_rc_in_53_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_53_toCore[14] = ms_riscv32_mp_rc_in_53_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_53_toCore[15] = ms_riscv32_mp_rc_in_53_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_53_toCore[16] = ms_riscv32_mp_rc_in_53_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_53_toCore[17] = ms_riscv32_mp_rc_in_53_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_53_toCore[18] = ms_riscv32_mp_rc_in_53_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_53_toCore[19] = ms_riscv32_mp_rc_in_53_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_53_toCore[20] = ms_riscv32_mp_rc_in_53_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_53_toCore[21] = ms_riscv32_mp_rc_in_53_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_53_toCore[22] = ms_riscv32_mp_rc_in_53_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_53_toCore[23] = ms_riscv32_mp_rc_in_53_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_53_toCore[24] = ms_riscv32_mp_rc_in_53_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_53_toCore[25] = ms_riscv32_mp_rc_in_53_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_53_toCore[26] = ms_riscv32_mp_rc_in_53_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_53_toCore[27] = ms_riscv32_mp_rc_in_53_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_53_toCore[28] = ms_riscv32_mp_rc_in_53_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_53_toCore[29] = ms_riscv32_mp_rc_in_53_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_53_toCore[30] = ms_riscv32_mp_rc_in_53_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_53_toCore[31] = ms_riscv32_mp_rc_in_53_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_53_toCore[32] = ms_riscv32_mp_rc_in_53_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_53_toCore[33] = ms_riscv32_mp_rc_in_53_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_53_toCore[34] = ms_riscv32_mp_rc_in_53_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_53_toCore[35] = ms_riscv32_mp_rc_in_53_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_53_toCore[36] = ms_riscv32_mp_rc_in_53_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_53_toCore[37] = ms_riscv32_mp_rc_in_53_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_53_toCore[38] = ms_riscv32_mp_rc_in_53_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_53_toCore[39] = ms_riscv32_mp_rc_in_53_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_53_toCore[40] = ms_riscv32_mp_rc_in_53_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_53_toCore[41] = ms_riscv32_mp_rc_in_53_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_53_toCore[42] = ms_riscv32_mp_rc_in_53_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_53_toCore[43] = ms_riscv32_mp_rc_in_53_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_53_toCore[44] = ms_riscv32_mp_rc_in_53_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_53_toCore[45] = ms_riscv32_mp_rc_in_53_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_53_toCore[46] = ms_riscv32_mp_rc_in_53_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_53_toCore[47] = ms_riscv32_mp_rc_in_53_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_53_toCore[48] = ms_riscv32_mp_rc_in_53_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_53_toCore[49] = ms_riscv32_mp_rc_in_53_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_53_toCore[50] = ms_riscv32_mp_rc_in_53_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_53_toCore[51] = ms_riscv32_mp_rc_in_53_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_53_toCore[52] = ms_riscv32_mp_rc_in_53_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_53_toCore[54] = ms_riscv32_mp_rc_in_53_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_53_toCore[55] = ms_riscv32_mp_rc_in_53_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_53_toCore[56] = ms_riscv32_mp_rc_in_53_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_53_toCore[57] = ms_riscv32_mp_rc_in_53_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_53_toCore[58] = ms_riscv32_mp_rc_in_53_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_53_toCore[59] = ms_riscv32_mp_rc_in_53_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_53_toCore[60] = ms_riscv32_mp_rc_in_53_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_53_toCore[61] = ms_riscv32_mp_rc_in_53_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_53_toCore[62] = ms_riscv32_mp_rc_in_53_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_53_toCore[63] = ms_riscv32_mp_rc_in_53_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[0] = ms_riscv32_mp_rc_in_52_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[1] = ms_riscv32_mp_rc_in_52_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[2] = ms_riscv32_mp_rc_in_52_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[3] = ms_riscv32_mp_rc_in_52_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[4] = ms_riscv32_mp_rc_in_52_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[5] = ms_riscv32_mp_rc_in_52_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[6] = ms_riscv32_mp_rc_in_52_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[7] = ms_riscv32_mp_rc_in_52_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[8] = ms_riscv32_mp_rc_in_52_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[9] = ms_riscv32_mp_rc_in_52_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[10] = ms_riscv32_mp_rc_in_52_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[11] = ms_riscv32_mp_rc_in_52_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[12] = ms_riscv32_mp_rc_in_52_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[13] = ms_riscv32_mp_rc_in_52_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[14] = ms_riscv32_mp_rc_in_52_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[15] = ms_riscv32_mp_rc_in_52_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[16] = ms_riscv32_mp_rc_in_52_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[17] = ms_riscv32_mp_rc_in_52_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[18] = ms_riscv32_mp_rc_in_52_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[19] = ms_riscv32_mp_rc_in_52_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[20] = ms_riscv32_mp_rc_in_52_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[21] = ms_riscv32_mp_rc_in_52_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[22] = ms_riscv32_mp_rc_in_52_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[23] = ms_riscv32_mp_rc_in_52_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[24] = ms_riscv32_mp_rc_in_52_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[25] = ms_riscv32_mp_rc_in_52_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[26] = ms_riscv32_mp_rc_in_52_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[27] = ms_riscv32_mp_rc_in_52_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[28] = ms_riscv32_mp_rc_in_52_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[29] = ms_riscv32_mp_rc_in_52_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[30] = ms_riscv32_mp_rc_in_52_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[31] = ms_riscv32_mp_rc_in_52_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[32] = ms_riscv32_mp_rc_in_52_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[33] = ms_riscv32_mp_rc_in_52_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[34] = ms_riscv32_mp_rc_in_52_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[35] = ms_riscv32_mp_rc_in_52_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[36] = ms_riscv32_mp_rc_in_52_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[37] = ms_riscv32_mp_rc_in_52_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[38] = ms_riscv32_mp_rc_in_52_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[39] = ms_riscv32_mp_rc_in_52_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[40] = ms_riscv32_mp_rc_in_52_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[41] = ms_riscv32_mp_rc_in_52_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[42] = ms_riscv32_mp_rc_in_52_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[43] = ms_riscv32_mp_rc_in_52_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[44] = ms_riscv32_mp_rc_in_52_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[45] = ms_riscv32_mp_rc_in_52_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[46] = ms_riscv32_mp_rc_in_52_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[47] = ms_riscv32_mp_rc_in_52_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[48] = ms_riscv32_mp_rc_in_52_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[49] = ms_riscv32_mp_rc_in_52_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[50] = ms_riscv32_mp_rc_in_52_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[51] = ms_riscv32_mp_rc_in_52_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[53] = ms_riscv32_mp_rc_in_52_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[54] = ms_riscv32_mp_rc_in_52_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[55] = ms_riscv32_mp_rc_in_52_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[56] = ms_riscv32_mp_rc_in_52_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[57] = ms_riscv32_mp_rc_in_52_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[58] = ms_riscv32_mp_rc_in_52_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[59] = ms_riscv32_mp_rc_in_52_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[60] = ms_riscv32_mp_rc_in_52_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[61] = ms_riscv32_mp_rc_in_52_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[62] = ms_riscv32_mp_rc_in_52_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_53_toCore_ts1[63] = ms_riscv32_mp_rc_in_52_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_51_toCore[0] = ms_riscv32_mp_rc_in_51_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_51_toCore[1] = ms_riscv32_mp_rc_in_51_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_51_toCore[2] = ms_riscv32_mp_rc_in_51_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_51_toCore[3] = ms_riscv32_mp_rc_in_51_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_51_toCore[4] = ms_riscv32_mp_rc_in_51_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_51_toCore[5] = ms_riscv32_mp_rc_in_51_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_51_toCore[6] = ms_riscv32_mp_rc_in_51_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_51_toCore[7] = ms_riscv32_mp_rc_in_51_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_51_toCore[8] = ms_riscv32_mp_rc_in_51_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_51_toCore[9] = ms_riscv32_mp_rc_in_51_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_51_toCore[10] = ms_riscv32_mp_rc_in_51_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_51_toCore[11] = ms_riscv32_mp_rc_in_51_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_51_toCore[12] = ms_riscv32_mp_rc_in_51_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_51_toCore[13] = ms_riscv32_mp_rc_in_51_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_51_toCore[14] = ms_riscv32_mp_rc_in_51_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_51_toCore[15] = ms_riscv32_mp_rc_in_51_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_51_toCore[16] = ms_riscv32_mp_rc_in_51_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_51_toCore[17] = ms_riscv32_mp_rc_in_51_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_51_toCore[18] = ms_riscv32_mp_rc_in_51_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_51_toCore[19] = ms_riscv32_mp_rc_in_51_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_51_toCore[20] = ms_riscv32_mp_rc_in_51_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_51_toCore[21] = ms_riscv32_mp_rc_in_51_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_51_toCore[22] = ms_riscv32_mp_rc_in_51_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_51_toCore[23] = ms_riscv32_mp_rc_in_51_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_51_toCore[24] = ms_riscv32_mp_rc_in_51_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_51_toCore[25] = ms_riscv32_mp_rc_in_51_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_51_toCore[26] = ms_riscv32_mp_rc_in_51_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_51_toCore[27] = ms_riscv32_mp_rc_in_51_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_51_toCore[28] = ms_riscv32_mp_rc_in_51_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_51_toCore[29] = ms_riscv32_mp_rc_in_51_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_51_toCore[30] = ms_riscv32_mp_rc_in_51_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_51_toCore[31] = ms_riscv32_mp_rc_in_51_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_51_toCore[32] = ms_riscv32_mp_rc_in_51_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_51_toCore[33] = ms_riscv32_mp_rc_in_51_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_51_toCore[34] = ms_riscv32_mp_rc_in_51_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_51_toCore[35] = ms_riscv32_mp_rc_in_51_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_51_toCore[36] = ms_riscv32_mp_rc_in_51_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_51_toCore[37] = ms_riscv32_mp_rc_in_51_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_51_toCore[38] = ms_riscv32_mp_rc_in_51_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_51_toCore[39] = ms_riscv32_mp_rc_in_51_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_51_toCore[40] = ms_riscv32_mp_rc_in_51_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_51_toCore[41] = ms_riscv32_mp_rc_in_51_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_51_toCore[42] = ms_riscv32_mp_rc_in_51_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_51_toCore[43] = ms_riscv32_mp_rc_in_51_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_51_toCore[44] = ms_riscv32_mp_rc_in_51_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_51_toCore[45] = ms_riscv32_mp_rc_in_51_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_51_toCore[46] = ms_riscv32_mp_rc_in_51_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_51_toCore[47] = ms_riscv32_mp_rc_in_51_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_51_toCore[48] = ms_riscv32_mp_rc_in_51_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_51_toCore[49] = ms_riscv32_mp_rc_in_51_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_51_toCore[50] = ms_riscv32_mp_rc_in_51_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_51_toCore[52] = ms_riscv32_mp_rc_in_51_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_51_toCore[53] = ms_riscv32_mp_rc_in_51_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_51_toCore[54] = ms_riscv32_mp_rc_in_51_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_51_toCore[55] = ms_riscv32_mp_rc_in_51_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_51_toCore[56] = ms_riscv32_mp_rc_in_51_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_51_toCore[57] = ms_riscv32_mp_rc_in_51_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_51_toCore[58] = ms_riscv32_mp_rc_in_51_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_51_toCore[59] = ms_riscv32_mp_rc_in_51_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_51_toCore[60] = ms_riscv32_mp_rc_in_51_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_51_toCore[61] = ms_riscv32_mp_rc_in_51_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_51_toCore[62] = ms_riscv32_mp_rc_in_51_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_51_toCore[63] = ms_riscv32_mp_rc_in_51_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[0] = ms_riscv32_mp_rc_in_50_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[1] = ms_riscv32_mp_rc_in_50_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[2] = ms_riscv32_mp_rc_in_50_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[3] = ms_riscv32_mp_rc_in_50_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[4] = ms_riscv32_mp_rc_in_50_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[5] = ms_riscv32_mp_rc_in_50_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[6] = ms_riscv32_mp_rc_in_50_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[7] = ms_riscv32_mp_rc_in_50_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[8] = ms_riscv32_mp_rc_in_50_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[9] = ms_riscv32_mp_rc_in_50_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[10] = ms_riscv32_mp_rc_in_50_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[11] = ms_riscv32_mp_rc_in_50_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[12] = ms_riscv32_mp_rc_in_50_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[13] = ms_riscv32_mp_rc_in_50_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[14] = ms_riscv32_mp_rc_in_50_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[15] = ms_riscv32_mp_rc_in_50_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[16] = ms_riscv32_mp_rc_in_50_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[17] = ms_riscv32_mp_rc_in_50_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[18] = ms_riscv32_mp_rc_in_50_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[19] = ms_riscv32_mp_rc_in_50_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[20] = ms_riscv32_mp_rc_in_50_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[21] = ms_riscv32_mp_rc_in_50_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[22] = ms_riscv32_mp_rc_in_50_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[23] = ms_riscv32_mp_rc_in_50_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[24] = ms_riscv32_mp_rc_in_50_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[25] = ms_riscv32_mp_rc_in_50_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[26] = ms_riscv32_mp_rc_in_50_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[27] = ms_riscv32_mp_rc_in_50_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[28] = ms_riscv32_mp_rc_in_50_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[29] = ms_riscv32_mp_rc_in_50_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[30] = ms_riscv32_mp_rc_in_50_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[31] = ms_riscv32_mp_rc_in_50_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[32] = ms_riscv32_mp_rc_in_50_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[33] = ms_riscv32_mp_rc_in_50_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[34] = ms_riscv32_mp_rc_in_50_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[35] = ms_riscv32_mp_rc_in_50_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[36] = ms_riscv32_mp_rc_in_50_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[37] = ms_riscv32_mp_rc_in_50_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[38] = ms_riscv32_mp_rc_in_50_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[39] = ms_riscv32_mp_rc_in_50_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[40] = ms_riscv32_mp_rc_in_50_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[41] = ms_riscv32_mp_rc_in_50_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[42] = ms_riscv32_mp_rc_in_50_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[43] = ms_riscv32_mp_rc_in_50_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[44] = ms_riscv32_mp_rc_in_50_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[45] = ms_riscv32_mp_rc_in_50_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[46] = ms_riscv32_mp_rc_in_50_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[47] = ms_riscv32_mp_rc_in_50_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[48] = ms_riscv32_mp_rc_in_50_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[49] = ms_riscv32_mp_rc_in_50_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[51] = ms_riscv32_mp_rc_in_50_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[52] = ms_riscv32_mp_rc_in_50_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[53] = ms_riscv32_mp_rc_in_50_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[54] = ms_riscv32_mp_rc_in_50_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[55] = ms_riscv32_mp_rc_in_50_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[56] = ms_riscv32_mp_rc_in_50_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[57] = ms_riscv32_mp_rc_in_50_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[58] = ms_riscv32_mp_rc_in_50_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[59] = ms_riscv32_mp_rc_in_50_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[60] = ms_riscv32_mp_rc_in_50_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[61] = ms_riscv32_mp_rc_in_50_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[62] = ms_riscv32_mp_rc_in_50_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_51_toCore_ts1[63] = ms_riscv32_mp_rc_in_50_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_49_toCore[0] = ms_riscv32_mp_rc_in_49_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_49_toCore[1] = ms_riscv32_mp_rc_in_49_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_49_toCore[2] = ms_riscv32_mp_rc_in_49_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_49_toCore[3] = ms_riscv32_mp_rc_in_49_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_49_toCore[4] = ms_riscv32_mp_rc_in_49_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_49_toCore[5] = ms_riscv32_mp_rc_in_49_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_49_toCore[6] = ms_riscv32_mp_rc_in_49_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_49_toCore[7] = ms_riscv32_mp_rc_in_49_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_49_toCore[8] = ms_riscv32_mp_rc_in_49_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_49_toCore[9] = ms_riscv32_mp_rc_in_49_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_49_toCore[10] = ms_riscv32_mp_rc_in_49_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_49_toCore[11] = ms_riscv32_mp_rc_in_49_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_49_toCore[12] = ms_riscv32_mp_rc_in_49_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_49_toCore[13] = ms_riscv32_mp_rc_in_49_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_49_toCore[14] = ms_riscv32_mp_rc_in_49_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_49_toCore[15] = ms_riscv32_mp_rc_in_49_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_49_toCore[16] = ms_riscv32_mp_rc_in_49_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_49_toCore[17] = ms_riscv32_mp_rc_in_49_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_49_toCore[18] = ms_riscv32_mp_rc_in_49_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_49_toCore[19] = ms_riscv32_mp_rc_in_49_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_49_toCore[20] = ms_riscv32_mp_rc_in_49_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_49_toCore[21] = ms_riscv32_mp_rc_in_49_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_49_toCore[22] = ms_riscv32_mp_rc_in_49_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_49_toCore[23] = ms_riscv32_mp_rc_in_49_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_49_toCore[24] = ms_riscv32_mp_rc_in_49_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_49_toCore[25] = ms_riscv32_mp_rc_in_49_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_49_toCore[26] = ms_riscv32_mp_rc_in_49_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_49_toCore[27] = ms_riscv32_mp_rc_in_49_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_49_toCore[28] = ms_riscv32_mp_rc_in_49_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_49_toCore[29] = ms_riscv32_mp_rc_in_49_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_49_toCore[30] = ms_riscv32_mp_rc_in_49_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_49_toCore[31] = ms_riscv32_mp_rc_in_49_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_49_toCore[32] = ms_riscv32_mp_rc_in_49_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_49_toCore[33] = ms_riscv32_mp_rc_in_49_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_49_toCore[34] = ms_riscv32_mp_rc_in_49_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_49_toCore[35] = ms_riscv32_mp_rc_in_49_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_49_toCore[36] = ms_riscv32_mp_rc_in_49_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_49_toCore[37] = ms_riscv32_mp_rc_in_49_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_49_toCore[38] = ms_riscv32_mp_rc_in_49_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_49_toCore[39] = ms_riscv32_mp_rc_in_49_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_49_toCore[40] = ms_riscv32_mp_rc_in_49_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_49_toCore[41] = ms_riscv32_mp_rc_in_49_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_49_toCore[42] = ms_riscv32_mp_rc_in_49_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_49_toCore[43] = ms_riscv32_mp_rc_in_49_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_49_toCore[44] = ms_riscv32_mp_rc_in_49_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_49_toCore[45] = ms_riscv32_mp_rc_in_49_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_49_toCore[46] = ms_riscv32_mp_rc_in_49_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_49_toCore[47] = ms_riscv32_mp_rc_in_49_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_49_toCore[48] = ms_riscv32_mp_rc_in_49_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_49_toCore[50] = ms_riscv32_mp_rc_in_49_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_49_toCore[51] = ms_riscv32_mp_rc_in_49_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_49_toCore[52] = ms_riscv32_mp_rc_in_49_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_49_toCore[53] = ms_riscv32_mp_rc_in_49_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_49_toCore[54] = ms_riscv32_mp_rc_in_49_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_49_toCore[55] = ms_riscv32_mp_rc_in_49_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_49_toCore[56] = ms_riscv32_mp_rc_in_49_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_49_toCore[57] = ms_riscv32_mp_rc_in_49_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_49_toCore[58] = ms_riscv32_mp_rc_in_49_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_49_toCore[59] = ms_riscv32_mp_rc_in_49_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_49_toCore[60] = ms_riscv32_mp_rc_in_49_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_49_toCore[61] = ms_riscv32_mp_rc_in_49_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_49_toCore[62] = ms_riscv32_mp_rc_in_49_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_49_toCore[63] = ms_riscv32_mp_rc_in_49_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[0] = ms_riscv32_mp_rc_in_48_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[1] = ms_riscv32_mp_rc_in_48_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[2] = ms_riscv32_mp_rc_in_48_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[3] = ms_riscv32_mp_rc_in_48_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[4] = ms_riscv32_mp_rc_in_48_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[5] = ms_riscv32_mp_rc_in_48_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[6] = ms_riscv32_mp_rc_in_48_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[7] = ms_riscv32_mp_rc_in_48_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[8] = ms_riscv32_mp_rc_in_48_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[9] = ms_riscv32_mp_rc_in_48_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[10] = ms_riscv32_mp_rc_in_48_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[11] = ms_riscv32_mp_rc_in_48_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[12] = ms_riscv32_mp_rc_in_48_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[13] = ms_riscv32_mp_rc_in_48_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[14] = ms_riscv32_mp_rc_in_48_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[15] = ms_riscv32_mp_rc_in_48_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[16] = ms_riscv32_mp_rc_in_48_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[17] = ms_riscv32_mp_rc_in_48_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[18] = ms_riscv32_mp_rc_in_48_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[19] = ms_riscv32_mp_rc_in_48_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[20] = ms_riscv32_mp_rc_in_48_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[21] = ms_riscv32_mp_rc_in_48_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[22] = ms_riscv32_mp_rc_in_48_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[23] = ms_riscv32_mp_rc_in_48_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[24] = ms_riscv32_mp_rc_in_48_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[25] = ms_riscv32_mp_rc_in_48_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[26] = ms_riscv32_mp_rc_in_48_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[27] = ms_riscv32_mp_rc_in_48_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[28] = ms_riscv32_mp_rc_in_48_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[29] = ms_riscv32_mp_rc_in_48_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[30] = ms_riscv32_mp_rc_in_48_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[31] = ms_riscv32_mp_rc_in_48_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[32] = ms_riscv32_mp_rc_in_48_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[33] = ms_riscv32_mp_rc_in_48_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[34] = ms_riscv32_mp_rc_in_48_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[35] = ms_riscv32_mp_rc_in_48_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[36] = ms_riscv32_mp_rc_in_48_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[37] = ms_riscv32_mp_rc_in_48_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[38] = ms_riscv32_mp_rc_in_48_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[39] = ms_riscv32_mp_rc_in_48_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[40] = ms_riscv32_mp_rc_in_48_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[41] = ms_riscv32_mp_rc_in_48_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[42] = ms_riscv32_mp_rc_in_48_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[43] = ms_riscv32_mp_rc_in_48_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[44] = ms_riscv32_mp_rc_in_48_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[45] = ms_riscv32_mp_rc_in_48_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[46] = ms_riscv32_mp_rc_in_48_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[47] = ms_riscv32_mp_rc_in_48_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[49] = ms_riscv32_mp_rc_in_48_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[50] = ms_riscv32_mp_rc_in_48_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[51] = ms_riscv32_mp_rc_in_48_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[52] = ms_riscv32_mp_rc_in_48_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[53] = ms_riscv32_mp_rc_in_48_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[54] = ms_riscv32_mp_rc_in_48_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[55] = ms_riscv32_mp_rc_in_48_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[56] = ms_riscv32_mp_rc_in_48_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[57] = ms_riscv32_mp_rc_in_48_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[58] = ms_riscv32_mp_rc_in_48_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[59] = ms_riscv32_mp_rc_in_48_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[60] = ms_riscv32_mp_rc_in_48_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[61] = ms_riscv32_mp_rc_in_48_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[62] = ms_riscv32_mp_rc_in_48_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_49_toCore_ts1[63] = ms_riscv32_mp_rc_in_48_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_47_toCore[0] = ms_riscv32_mp_rc_in_47_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_47_toCore[1] = ms_riscv32_mp_rc_in_47_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_47_toCore[2] = ms_riscv32_mp_rc_in_47_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_47_toCore[3] = ms_riscv32_mp_rc_in_47_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_47_toCore[4] = ms_riscv32_mp_rc_in_47_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_47_toCore[5] = ms_riscv32_mp_rc_in_47_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_47_toCore[6] = ms_riscv32_mp_rc_in_47_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_47_toCore[7] = ms_riscv32_mp_rc_in_47_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_47_toCore[8] = ms_riscv32_mp_rc_in_47_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_47_toCore[9] = ms_riscv32_mp_rc_in_47_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_47_toCore[10] = ms_riscv32_mp_rc_in_47_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_47_toCore[11] = ms_riscv32_mp_rc_in_47_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_47_toCore[12] = ms_riscv32_mp_rc_in_47_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_47_toCore[13] = ms_riscv32_mp_rc_in_47_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_47_toCore[14] = ms_riscv32_mp_rc_in_47_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_47_toCore[15] = ms_riscv32_mp_rc_in_47_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_47_toCore[16] = ms_riscv32_mp_rc_in_47_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_47_toCore[17] = ms_riscv32_mp_rc_in_47_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_47_toCore[18] = ms_riscv32_mp_rc_in_47_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_47_toCore[19] = ms_riscv32_mp_rc_in_47_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_47_toCore[20] = ms_riscv32_mp_rc_in_47_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_47_toCore[21] = ms_riscv32_mp_rc_in_47_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_47_toCore[22] = ms_riscv32_mp_rc_in_47_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_47_toCore[23] = ms_riscv32_mp_rc_in_47_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_47_toCore[24] = ms_riscv32_mp_rc_in_47_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_47_toCore[25] = ms_riscv32_mp_rc_in_47_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_47_toCore[26] = ms_riscv32_mp_rc_in_47_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_47_toCore[27] = ms_riscv32_mp_rc_in_47_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_47_toCore[28] = ms_riscv32_mp_rc_in_47_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_47_toCore[29] = ms_riscv32_mp_rc_in_47_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_47_toCore[30] = ms_riscv32_mp_rc_in_47_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_47_toCore[31] = ms_riscv32_mp_rc_in_47_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_47_toCore[32] = ms_riscv32_mp_rc_in_47_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_47_toCore[33] = ms_riscv32_mp_rc_in_47_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_47_toCore[34] = ms_riscv32_mp_rc_in_47_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_47_toCore[35] = ms_riscv32_mp_rc_in_47_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_47_toCore[36] = ms_riscv32_mp_rc_in_47_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_47_toCore[37] = ms_riscv32_mp_rc_in_47_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_47_toCore[38] = ms_riscv32_mp_rc_in_47_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_47_toCore[39] = ms_riscv32_mp_rc_in_47_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_47_toCore[40] = ms_riscv32_mp_rc_in_47_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_47_toCore[41] = ms_riscv32_mp_rc_in_47_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_47_toCore[42] = ms_riscv32_mp_rc_in_47_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_47_toCore[43] = ms_riscv32_mp_rc_in_47_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_47_toCore[44] = ms_riscv32_mp_rc_in_47_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_47_toCore[45] = ms_riscv32_mp_rc_in_47_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_47_toCore[46] = ms_riscv32_mp_rc_in_47_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_47_toCore[48] = ms_riscv32_mp_rc_in_47_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_47_toCore[49] = ms_riscv32_mp_rc_in_47_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_47_toCore[50] = ms_riscv32_mp_rc_in_47_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_47_toCore[51] = ms_riscv32_mp_rc_in_47_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_47_toCore[52] = ms_riscv32_mp_rc_in_47_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_47_toCore[53] = ms_riscv32_mp_rc_in_47_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_47_toCore[54] = ms_riscv32_mp_rc_in_47_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_47_toCore[55] = ms_riscv32_mp_rc_in_47_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_47_toCore[56] = ms_riscv32_mp_rc_in_47_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_47_toCore[57] = ms_riscv32_mp_rc_in_47_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_47_toCore[58] = ms_riscv32_mp_rc_in_47_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_47_toCore[59] = ms_riscv32_mp_rc_in_47_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_47_toCore[60] = ms_riscv32_mp_rc_in_47_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_47_toCore[61] = ms_riscv32_mp_rc_in_47_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_47_toCore[62] = ms_riscv32_mp_rc_in_47_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_47_toCore[63] = ms_riscv32_mp_rc_in_47_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[0] = ms_riscv32_mp_rc_in_46_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[1] = ms_riscv32_mp_rc_in_46_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[2] = ms_riscv32_mp_rc_in_46_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[3] = ms_riscv32_mp_rc_in_46_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[4] = ms_riscv32_mp_rc_in_46_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[5] = ms_riscv32_mp_rc_in_46_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[6] = ms_riscv32_mp_rc_in_46_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[7] = ms_riscv32_mp_rc_in_46_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[8] = ms_riscv32_mp_rc_in_46_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[9] = ms_riscv32_mp_rc_in_46_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[10] = ms_riscv32_mp_rc_in_46_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[11] = ms_riscv32_mp_rc_in_46_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[12] = ms_riscv32_mp_rc_in_46_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[13] = ms_riscv32_mp_rc_in_46_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[14] = ms_riscv32_mp_rc_in_46_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[15] = ms_riscv32_mp_rc_in_46_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[16] = ms_riscv32_mp_rc_in_46_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[17] = ms_riscv32_mp_rc_in_46_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[18] = ms_riscv32_mp_rc_in_46_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[19] = ms_riscv32_mp_rc_in_46_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[20] = ms_riscv32_mp_rc_in_46_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[21] = ms_riscv32_mp_rc_in_46_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[22] = ms_riscv32_mp_rc_in_46_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[23] = ms_riscv32_mp_rc_in_46_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[24] = ms_riscv32_mp_rc_in_46_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[25] = ms_riscv32_mp_rc_in_46_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[26] = ms_riscv32_mp_rc_in_46_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[27] = ms_riscv32_mp_rc_in_46_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[28] = ms_riscv32_mp_rc_in_46_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[29] = ms_riscv32_mp_rc_in_46_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[30] = ms_riscv32_mp_rc_in_46_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[31] = ms_riscv32_mp_rc_in_46_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[32] = ms_riscv32_mp_rc_in_46_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[33] = ms_riscv32_mp_rc_in_46_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[34] = ms_riscv32_mp_rc_in_46_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[35] = ms_riscv32_mp_rc_in_46_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[36] = ms_riscv32_mp_rc_in_46_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[37] = ms_riscv32_mp_rc_in_46_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[38] = ms_riscv32_mp_rc_in_46_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[39] = ms_riscv32_mp_rc_in_46_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[40] = ms_riscv32_mp_rc_in_46_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[41] = ms_riscv32_mp_rc_in_46_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[42] = ms_riscv32_mp_rc_in_46_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[43] = ms_riscv32_mp_rc_in_46_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[44] = ms_riscv32_mp_rc_in_46_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[45] = ms_riscv32_mp_rc_in_46_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[47] = ms_riscv32_mp_rc_in_46_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[48] = ms_riscv32_mp_rc_in_46_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[49] = ms_riscv32_mp_rc_in_46_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[50] = ms_riscv32_mp_rc_in_46_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[51] = ms_riscv32_mp_rc_in_46_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[52] = ms_riscv32_mp_rc_in_46_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[53] = ms_riscv32_mp_rc_in_46_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[54] = ms_riscv32_mp_rc_in_46_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[55] = ms_riscv32_mp_rc_in_46_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[56] = ms_riscv32_mp_rc_in_46_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[57] = ms_riscv32_mp_rc_in_46_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[58] = ms_riscv32_mp_rc_in_46_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[59] = ms_riscv32_mp_rc_in_46_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[60] = ms_riscv32_mp_rc_in_46_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[61] = ms_riscv32_mp_rc_in_46_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[62] = ms_riscv32_mp_rc_in_46_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_47_toCore_ts1[63] = ms_riscv32_mp_rc_in_46_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_45_toCore[0] = ms_riscv32_mp_rc_in_45_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_45_toCore[1] = ms_riscv32_mp_rc_in_45_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_45_toCore[2] = ms_riscv32_mp_rc_in_45_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_45_toCore[3] = ms_riscv32_mp_rc_in_45_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_45_toCore[4] = ms_riscv32_mp_rc_in_45_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_45_toCore[5] = ms_riscv32_mp_rc_in_45_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_45_toCore[6] = ms_riscv32_mp_rc_in_45_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_45_toCore[7] = ms_riscv32_mp_rc_in_45_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_45_toCore[8] = ms_riscv32_mp_rc_in_45_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_45_toCore[9] = ms_riscv32_mp_rc_in_45_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_45_toCore[10] = ms_riscv32_mp_rc_in_45_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_45_toCore[11] = ms_riscv32_mp_rc_in_45_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_45_toCore[12] = ms_riscv32_mp_rc_in_45_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_45_toCore[13] = ms_riscv32_mp_rc_in_45_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_45_toCore[14] = ms_riscv32_mp_rc_in_45_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_45_toCore[15] = ms_riscv32_mp_rc_in_45_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_45_toCore[16] = ms_riscv32_mp_rc_in_45_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_45_toCore[17] = ms_riscv32_mp_rc_in_45_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_45_toCore[18] = ms_riscv32_mp_rc_in_45_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_45_toCore[19] = ms_riscv32_mp_rc_in_45_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_45_toCore[20] = ms_riscv32_mp_rc_in_45_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_45_toCore[21] = ms_riscv32_mp_rc_in_45_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_45_toCore[22] = ms_riscv32_mp_rc_in_45_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_45_toCore[23] = ms_riscv32_mp_rc_in_45_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_45_toCore[24] = ms_riscv32_mp_rc_in_45_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_45_toCore[25] = ms_riscv32_mp_rc_in_45_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_45_toCore[26] = ms_riscv32_mp_rc_in_45_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_45_toCore[27] = ms_riscv32_mp_rc_in_45_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_45_toCore[28] = ms_riscv32_mp_rc_in_45_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_45_toCore[29] = ms_riscv32_mp_rc_in_45_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_45_toCore[30] = ms_riscv32_mp_rc_in_45_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_45_toCore[31] = ms_riscv32_mp_rc_in_45_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_45_toCore[32] = ms_riscv32_mp_rc_in_45_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_45_toCore[33] = ms_riscv32_mp_rc_in_45_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_45_toCore[34] = ms_riscv32_mp_rc_in_45_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_45_toCore[35] = ms_riscv32_mp_rc_in_45_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_45_toCore[36] = ms_riscv32_mp_rc_in_45_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_45_toCore[37] = ms_riscv32_mp_rc_in_45_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_45_toCore[38] = ms_riscv32_mp_rc_in_45_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_45_toCore[39] = ms_riscv32_mp_rc_in_45_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_45_toCore[40] = ms_riscv32_mp_rc_in_45_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_45_toCore[41] = ms_riscv32_mp_rc_in_45_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_45_toCore[42] = ms_riscv32_mp_rc_in_45_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_45_toCore[43] = ms_riscv32_mp_rc_in_45_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_45_toCore[44] = ms_riscv32_mp_rc_in_45_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_45_toCore[46] = ms_riscv32_mp_rc_in_45_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_45_toCore[47] = ms_riscv32_mp_rc_in_45_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_45_toCore[48] = ms_riscv32_mp_rc_in_45_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_45_toCore[49] = ms_riscv32_mp_rc_in_45_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_45_toCore[50] = ms_riscv32_mp_rc_in_45_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_45_toCore[51] = ms_riscv32_mp_rc_in_45_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_45_toCore[52] = ms_riscv32_mp_rc_in_45_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_45_toCore[53] = ms_riscv32_mp_rc_in_45_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_45_toCore[54] = ms_riscv32_mp_rc_in_45_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_45_toCore[55] = ms_riscv32_mp_rc_in_45_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_45_toCore[56] = ms_riscv32_mp_rc_in_45_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_45_toCore[57] = ms_riscv32_mp_rc_in_45_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_45_toCore[58] = ms_riscv32_mp_rc_in_45_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_45_toCore[59] = ms_riscv32_mp_rc_in_45_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_45_toCore[60] = ms_riscv32_mp_rc_in_45_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_45_toCore[61] = ms_riscv32_mp_rc_in_45_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_45_toCore[62] = ms_riscv32_mp_rc_in_45_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_45_toCore[63] = ms_riscv32_mp_rc_in_45_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[0] = ms_riscv32_mp_rc_in_44_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[1] = ms_riscv32_mp_rc_in_44_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[2] = ms_riscv32_mp_rc_in_44_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[3] = ms_riscv32_mp_rc_in_44_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[4] = ms_riscv32_mp_rc_in_44_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[5] = ms_riscv32_mp_rc_in_44_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[6] = ms_riscv32_mp_rc_in_44_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[7] = ms_riscv32_mp_rc_in_44_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[8] = ms_riscv32_mp_rc_in_44_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[9] = ms_riscv32_mp_rc_in_44_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[10] = ms_riscv32_mp_rc_in_44_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[11] = ms_riscv32_mp_rc_in_44_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[12] = ms_riscv32_mp_rc_in_44_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[13] = ms_riscv32_mp_rc_in_44_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[14] = ms_riscv32_mp_rc_in_44_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[15] = ms_riscv32_mp_rc_in_44_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[16] = ms_riscv32_mp_rc_in_44_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[17] = ms_riscv32_mp_rc_in_44_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[18] = ms_riscv32_mp_rc_in_44_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[19] = ms_riscv32_mp_rc_in_44_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[20] = ms_riscv32_mp_rc_in_44_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[21] = ms_riscv32_mp_rc_in_44_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[22] = ms_riscv32_mp_rc_in_44_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[23] = ms_riscv32_mp_rc_in_44_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[24] = ms_riscv32_mp_rc_in_44_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[25] = ms_riscv32_mp_rc_in_44_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[26] = ms_riscv32_mp_rc_in_44_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[27] = ms_riscv32_mp_rc_in_44_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[28] = ms_riscv32_mp_rc_in_44_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[29] = ms_riscv32_mp_rc_in_44_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[30] = ms_riscv32_mp_rc_in_44_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[31] = ms_riscv32_mp_rc_in_44_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[32] = ms_riscv32_mp_rc_in_44_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[33] = ms_riscv32_mp_rc_in_44_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[34] = ms_riscv32_mp_rc_in_44_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[35] = ms_riscv32_mp_rc_in_44_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[36] = ms_riscv32_mp_rc_in_44_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[37] = ms_riscv32_mp_rc_in_44_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[38] = ms_riscv32_mp_rc_in_44_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[39] = ms_riscv32_mp_rc_in_44_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[40] = ms_riscv32_mp_rc_in_44_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[41] = ms_riscv32_mp_rc_in_44_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[42] = ms_riscv32_mp_rc_in_44_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[43] = ms_riscv32_mp_rc_in_44_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[45] = ms_riscv32_mp_rc_in_44_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[46] = ms_riscv32_mp_rc_in_44_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[47] = ms_riscv32_mp_rc_in_44_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[48] = ms_riscv32_mp_rc_in_44_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[49] = ms_riscv32_mp_rc_in_44_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[50] = ms_riscv32_mp_rc_in_44_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[51] = ms_riscv32_mp_rc_in_44_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[52] = ms_riscv32_mp_rc_in_44_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[53] = ms_riscv32_mp_rc_in_44_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[54] = ms_riscv32_mp_rc_in_44_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[55] = ms_riscv32_mp_rc_in_44_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[56] = ms_riscv32_mp_rc_in_44_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[57] = ms_riscv32_mp_rc_in_44_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[58] = ms_riscv32_mp_rc_in_44_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[59] = ms_riscv32_mp_rc_in_44_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[60] = ms_riscv32_mp_rc_in_44_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[61] = ms_riscv32_mp_rc_in_44_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[62] = ms_riscv32_mp_rc_in_44_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_45_toCore_ts1[63] = ms_riscv32_mp_rc_in_44_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_43_toCore[0] = ms_riscv32_mp_rc_in_43_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_43_toCore[1] = ms_riscv32_mp_rc_in_43_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_43_toCore[2] = ms_riscv32_mp_rc_in_43_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_43_toCore[3] = ms_riscv32_mp_rc_in_43_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_43_toCore[4] = ms_riscv32_mp_rc_in_43_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_43_toCore[5] = ms_riscv32_mp_rc_in_43_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_43_toCore[6] = ms_riscv32_mp_rc_in_43_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_43_toCore[7] = ms_riscv32_mp_rc_in_43_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_43_toCore[8] = ms_riscv32_mp_rc_in_43_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_43_toCore[9] = ms_riscv32_mp_rc_in_43_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_43_toCore[10] = ms_riscv32_mp_rc_in_43_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_43_toCore[11] = ms_riscv32_mp_rc_in_43_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_43_toCore[12] = ms_riscv32_mp_rc_in_43_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_43_toCore[13] = ms_riscv32_mp_rc_in_43_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_43_toCore[14] = ms_riscv32_mp_rc_in_43_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_43_toCore[15] = ms_riscv32_mp_rc_in_43_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_43_toCore[16] = ms_riscv32_mp_rc_in_43_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_43_toCore[17] = ms_riscv32_mp_rc_in_43_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_43_toCore[18] = ms_riscv32_mp_rc_in_43_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_43_toCore[19] = ms_riscv32_mp_rc_in_43_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_43_toCore[20] = ms_riscv32_mp_rc_in_43_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_43_toCore[21] = ms_riscv32_mp_rc_in_43_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_43_toCore[22] = ms_riscv32_mp_rc_in_43_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_43_toCore[23] = ms_riscv32_mp_rc_in_43_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_43_toCore[24] = ms_riscv32_mp_rc_in_43_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_43_toCore[25] = ms_riscv32_mp_rc_in_43_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_43_toCore[26] = ms_riscv32_mp_rc_in_43_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_43_toCore[27] = ms_riscv32_mp_rc_in_43_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_43_toCore[28] = ms_riscv32_mp_rc_in_43_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_43_toCore[29] = ms_riscv32_mp_rc_in_43_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_43_toCore[30] = ms_riscv32_mp_rc_in_43_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_43_toCore[31] = ms_riscv32_mp_rc_in_43_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_43_toCore[32] = ms_riscv32_mp_rc_in_43_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_43_toCore[33] = ms_riscv32_mp_rc_in_43_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_43_toCore[34] = ms_riscv32_mp_rc_in_43_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_43_toCore[35] = ms_riscv32_mp_rc_in_43_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_43_toCore[36] = ms_riscv32_mp_rc_in_43_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_43_toCore[37] = ms_riscv32_mp_rc_in_43_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_43_toCore[38] = ms_riscv32_mp_rc_in_43_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_43_toCore[39] = ms_riscv32_mp_rc_in_43_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_43_toCore[40] = ms_riscv32_mp_rc_in_43_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_43_toCore[41] = ms_riscv32_mp_rc_in_43_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_43_toCore[42] = ms_riscv32_mp_rc_in_43_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_43_toCore[44] = ms_riscv32_mp_rc_in_43_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_43_toCore[45] = ms_riscv32_mp_rc_in_43_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_43_toCore[46] = ms_riscv32_mp_rc_in_43_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_43_toCore[47] = ms_riscv32_mp_rc_in_43_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_43_toCore[48] = ms_riscv32_mp_rc_in_43_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_43_toCore[49] = ms_riscv32_mp_rc_in_43_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_43_toCore[50] = ms_riscv32_mp_rc_in_43_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_43_toCore[51] = ms_riscv32_mp_rc_in_43_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_43_toCore[52] = ms_riscv32_mp_rc_in_43_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_43_toCore[53] = ms_riscv32_mp_rc_in_43_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_43_toCore[54] = ms_riscv32_mp_rc_in_43_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_43_toCore[55] = ms_riscv32_mp_rc_in_43_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_43_toCore[56] = ms_riscv32_mp_rc_in_43_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_43_toCore[57] = ms_riscv32_mp_rc_in_43_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_43_toCore[58] = ms_riscv32_mp_rc_in_43_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_43_toCore[59] = ms_riscv32_mp_rc_in_43_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_43_toCore[60] = ms_riscv32_mp_rc_in_43_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_43_toCore[61] = ms_riscv32_mp_rc_in_43_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_43_toCore[62] = ms_riscv32_mp_rc_in_43_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_43_toCore[63] = ms_riscv32_mp_rc_in_43_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[0] = ms_riscv32_mp_rc_in_42_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[1] = ms_riscv32_mp_rc_in_42_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[2] = ms_riscv32_mp_rc_in_42_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[3] = ms_riscv32_mp_rc_in_42_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[4] = ms_riscv32_mp_rc_in_42_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[5] = ms_riscv32_mp_rc_in_42_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[6] = ms_riscv32_mp_rc_in_42_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[7] = ms_riscv32_mp_rc_in_42_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[8] = ms_riscv32_mp_rc_in_42_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[9] = ms_riscv32_mp_rc_in_42_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[10] = ms_riscv32_mp_rc_in_42_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[11] = ms_riscv32_mp_rc_in_42_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[12] = ms_riscv32_mp_rc_in_42_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[13] = ms_riscv32_mp_rc_in_42_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[14] = ms_riscv32_mp_rc_in_42_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[15] = ms_riscv32_mp_rc_in_42_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[16] = ms_riscv32_mp_rc_in_42_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[17] = ms_riscv32_mp_rc_in_42_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[18] = ms_riscv32_mp_rc_in_42_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[19] = ms_riscv32_mp_rc_in_42_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[20] = ms_riscv32_mp_rc_in_42_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[21] = ms_riscv32_mp_rc_in_42_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[22] = ms_riscv32_mp_rc_in_42_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[23] = ms_riscv32_mp_rc_in_42_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[24] = ms_riscv32_mp_rc_in_42_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[25] = ms_riscv32_mp_rc_in_42_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[26] = ms_riscv32_mp_rc_in_42_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[27] = ms_riscv32_mp_rc_in_42_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[28] = ms_riscv32_mp_rc_in_42_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[29] = ms_riscv32_mp_rc_in_42_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[30] = ms_riscv32_mp_rc_in_42_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[31] = ms_riscv32_mp_rc_in_42_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[32] = ms_riscv32_mp_rc_in_42_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[33] = ms_riscv32_mp_rc_in_42_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[34] = ms_riscv32_mp_rc_in_42_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[35] = ms_riscv32_mp_rc_in_42_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[36] = ms_riscv32_mp_rc_in_42_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[37] = ms_riscv32_mp_rc_in_42_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[38] = ms_riscv32_mp_rc_in_42_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[39] = ms_riscv32_mp_rc_in_42_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[40] = ms_riscv32_mp_rc_in_42_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[41] = ms_riscv32_mp_rc_in_42_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[43] = ms_riscv32_mp_rc_in_42_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[44] = ms_riscv32_mp_rc_in_42_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[45] = ms_riscv32_mp_rc_in_42_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[46] = ms_riscv32_mp_rc_in_42_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[47] = ms_riscv32_mp_rc_in_42_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[48] = ms_riscv32_mp_rc_in_42_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[49] = ms_riscv32_mp_rc_in_42_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[50] = ms_riscv32_mp_rc_in_42_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[51] = ms_riscv32_mp_rc_in_42_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[52] = ms_riscv32_mp_rc_in_42_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[53] = ms_riscv32_mp_rc_in_42_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[54] = ms_riscv32_mp_rc_in_42_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[55] = ms_riscv32_mp_rc_in_42_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[56] = ms_riscv32_mp_rc_in_42_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[57] = ms_riscv32_mp_rc_in_42_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[58] = ms_riscv32_mp_rc_in_42_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[59] = ms_riscv32_mp_rc_in_42_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[60] = ms_riscv32_mp_rc_in_42_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[61] = ms_riscv32_mp_rc_in_42_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[62] = ms_riscv32_mp_rc_in_42_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_43_toCore_ts1[63] = ms_riscv32_mp_rc_in_42_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_41_toCore[0] = ms_riscv32_mp_rc_in_41_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_41_toCore[1] = ms_riscv32_mp_rc_in_41_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_41_toCore[2] = ms_riscv32_mp_rc_in_41_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_41_toCore[3] = ms_riscv32_mp_rc_in_41_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_41_toCore[4] = ms_riscv32_mp_rc_in_41_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_41_toCore[5] = ms_riscv32_mp_rc_in_41_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_41_toCore[6] = ms_riscv32_mp_rc_in_41_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_41_toCore[7] = ms_riscv32_mp_rc_in_41_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_41_toCore[8] = ms_riscv32_mp_rc_in_41_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_41_toCore[9] = ms_riscv32_mp_rc_in_41_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_41_toCore[10] = ms_riscv32_mp_rc_in_41_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_41_toCore[11] = ms_riscv32_mp_rc_in_41_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_41_toCore[12] = ms_riscv32_mp_rc_in_41_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_41_toCore[13] = ms_riscv32_mp_rc_in_41_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_41_toCore[14] = ms_riscv32_mp_rc_in_41_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_41_toCore[15] = ms_riscv32_mp_rc_in_41_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_41_toCore[16] = ms_riscv32_mp_rc_in_41_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_41_toCore[17] = ms_riscv32_mp_rc_in_41_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_41_toCore[18] = ms_riscv32_mp_rc_in_41_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_41_toCore[19] = ms_riscv32_mp_rc_in_41_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_41_toCore[20] = ms_riscv32_mp_rc_in_41_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_41_toCore[21] = ms_riscv32_mp_rc_in_41_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_41_toCore[22] = ms_riscv32_mp_rc_in_41_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_41_toCore[23] = ms_riscv32_mp_rc_in_41_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_41_toCore[24] = ms_riscv32_mp_rc_in_41_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_41_toCore[25] = ms_riscv32_mp_rc_in_41_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_41_toCore[26] = ms_riscv32_mp_rc_in_41_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_41_toCore[27] = ms_riscv32_mp_rc_in_41_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_41_toCore[28] = ms_riscv32_mp_rc_in_41_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_41_toCore[29] = ms_riscv32_mp_rc_in_41_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_41_toCore[30] = ms_riscv32_mp_rc_in_41_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_41_toCore[31] = ms_riscv32_mp_rc_in_41_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_41_toCore[32] = ms_riscv32_mp_rc_in_41_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_41_toCore[33] = ms_riscv32_mp_rc_in_41_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_41_toCore[34] = ms_riscv32_mp_rc_in_41_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_41_toCore[35] = ms_riscv32_mp_rc_in_41_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_41_toCore[36] = ms_riscv32_mp_rc_in_41_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_41_toCore[37] = ms_riscv32_mp_rc_in_41_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_41_toCore[38] = ms_riscv32_mp_rc_in_41_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_41_toCore[39] = ms_riscv32_mp_rc_in_41_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_41_toCore[40] = ms_riscv32_mp_rc_in_41_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_41_toCore[42] = ms_riscv32_mp_rc_in_41_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_41_toCore[43] = ms_riscv32_mp_rc_in_41_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_41_toCore[44] = ms_riscv32_mp_rc_in_41_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_41_toCore[45] = ms_riscv32_mp_rc_in_41_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_41_toCore[46] = ms_riscv32_mp_rc_in_41_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_41_toCore[47] = ms_riscv32_mp_rc_in_41_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_41_toCore[48] = ms_riscv32_mp_rc_in_41_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_41_toCore[49] = ms_riscv32_mp_rc_in_41_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_41_toCore[50] = ms_riscv32_mp_rc_in_41_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_41_toCore[51] = ms_riscv32_mp_rc_in_41_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_41_toCore[52] = ms_riscv32_mp_rc_in_41_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_41_toCore[53] = ms_riscv32_mp_rc_in_41_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_41_toCore[54] = ms_riscv32_mp_rc_in_41_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_41_toCore[55] = ms_riscv32_mp_rc_in_41_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_41_toCore[56] = ms_riscv32_mp_rc_in_41_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_41_toCore[57] = ms_riscv32_mp_rc_in_41_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_41_toCore[58] = ms_riscv32_mp_rc_in_41_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_41_toCore[59] = ms_riscv32_mp_rc_in_41_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_41_toCore[60] = ms_riscv32_mp_rc_in_41_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_41_toCore[61] = ms_riscv32_mp_rc_in_41_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_41_toCore[62] = ms_riscv32_mp_rc_in_41_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_41_toCore[63] = ms_riscv32_mp_rc_in_41_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[0] = ms_riscv32_mp_rc_in_40_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[1] = ms_riscv32_mp_rc_in_40_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[2] = ms_riscv32_mp_rc_in_40_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[3] = ms_riscv32_mp_rc_in_40_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[4] = ms_riscv32_mp_rc_in_40_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[5] = ms_riscv32_mp_rc_in_40_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[6] = ms_riscv32_mp_rc_in_40_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[7] = ms_riscv32_mp_rc_in_40_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[8] = ms_riscv32_mp_rc_in_40_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[9] = ms_riscv32_mp_rc_in_40_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[10] = ms_riscv32_mp_rc_in_40_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[11] = ms_riscv32_mp_rc_in_40_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[12] = ms_riscv32_mp_rc_in_40_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[13] = ms_riscv32_mp_rc_in_40_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[14] = ms_riscv32_mp_rc_in_40_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[15] = ms_riscv32_mp_rc_in_40_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[16] = ms_riscv32_mp_rc_in_40_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[17] = ms_riscv32_mp_rc_in_40_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[18] = ms_riscv32_mp_rc_in_40_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[19] = ms_riscv32_mp_rc_in_40_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[20] = ms_riscv32_mp_rc_in_40_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[21] = ms_riscv32_mp_rc_in_40_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[22] = ms_riscv32_mp_rc_in_40_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[23] = ms_riscv32_mp_rc_in_40_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[24] = ms_riscv32_mp_rc_in_40_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[25] = ms_riscv32_mp_rc_in_40_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[26] = ms_riscv32_mp_rc_in_40_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[27] = ms_riscv32_mp_rc_in_40_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[28] = ms_riscv32_mp_rc_in_40_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[29] = ms_riscv32_mp_rc_in_40_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[30] = ms_riscv32_mp_rc_in_40_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[31] = ms_riscv32_mp_rc_in_40_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[32] = ms_riscv32_mp_rc_in_40_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[33] = ms_riscv32_mp_rc_in_40_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[34] = ms_riscv32_mp_rc_in_40_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[35] = ms_riscv32_mp_rc_in_40_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[36] = ms_riscv32_mp_rc_in_40_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[37] = ms_riscv32_mp_rc_in_40_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[38] = ms_riscv32_mp_rc_in_40_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[39] = ms_riscv32_mp_rc_in_40_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[41] = ms_riscv32_mp_rc_in_40_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[42] = ms_riscv32_mp_rc_in_40_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[43] = ms_riscv32_mp_rc_in_40_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[44] = ms_riscv32_mp_rc_in_40_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[45] = ms_riscv32_mp_rc_in_40_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[46] = ms_riscv32_mp_rc_in_40_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[47] = ms_riscv32_mp_rc_in_40_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[48] = ms_riscv32_mp_rc_in_40_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[49] = ms_riscv32_mp_rc_in_40_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[50] = ms_riscv32_mp_rc_in_40_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[51] = ms_riscv32_mp_rc_in_40_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[52] = ms_riscv32_mp_rc_in_40_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[53] = ms_riscv32_mp_rc_in_40_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[54] = ms_riscv32_mp_rc_in_40_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[55] = ms_riscv32_mp_rc_in_40_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[56] = ms_riscv32_mp_rc_in_40_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[57] = ms_riscv32_mp_rc_in_40_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[58] = ms_riscv32_mp_rc_in_40_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[59] = ms_riscv32_mp_rc_in_40_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[60] = ms_riscv32_mp_rc_in_40_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[61] = ms_riscv32_mp_rc_in_40_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[62] = ms_riscv32_mp_rc_in_40_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_41_toCore_ts1[63] = ms_riscv32_mp_rc_in_40_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_39_toCore[0] = ms_riscv32_mp_rc_in_39_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_39_toCore[1] = ms_riscv32_mp_rc_in_39_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_39_toCore[2] = ms_riscv32_mp_rc_in_39_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_39_toCore[3] = ms_riscv32_mp_rc_in_39_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_39_toCore[4] = ms_riscv32_mp_rc_in_39_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_39_toCore[5] = ms_riscv32_mp_rc_in_39_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_39_toCore[6] = ms_riscv32_mp_rc_in_39_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_39_toCore[7] = ms_riscv32_mp_rc_in_39_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_39_toCore[8] = ms_riscv32_mp_rc_in_39_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_39_toCore[9] = ms_riscv32_mp_rc_in_39_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_39_toCore[10] = ms_riscv32_mp_rc_in_39_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_39_toCore[11] = ms_riscv32_mp_rc_in_39_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_39_toCore[12] = ms_riscv32_mp_rc_in_39_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_39_toCore[13] = ms_riscv32_mp_rc_in_39_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_39_toCore[14] = ms_riscv32_mp_rc_in_39_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_39_toCore[15] = ms_riscv32_mp_rc_in_39_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_39_toCore[16] = ms_riscv32_mp_rc_in_39_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_39_toCore[17] = ms_riscv32_mp_rc_in_39_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_39_toCore[18] = ms_riscv32_mp_rc_in_39_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_39_toCore[19] = ms_riscv32_mp_rc_in_39_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_39_toCore[20] = ms_riscv32_mp_rc_in_39_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_39_toCore[21] = ms_riscv32_mp_rc_in_39_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_39_toCore[22] = ms_riscv32_mp_rc_in_39_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_39_toCore[23] = ms_riscv32_mp_rc_in_39_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_39_toCore[24] = ms_riscv32_mp_rc_in_39_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_39_toCore[25] = ms_riscv32_mp_rc_in_39_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_39_toCore[26] = ms_riscv32_mp_rc_in_39_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_39_toCore[27] = ms_riscv32_mp_rc_in_39_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_39_toCore[28] = ms_riscv32_mp_rc_in_39_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_39_toCore[29] = ms_riscv32_mp_rc_in_39_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_39_toCore[30] = ms_riscv32_mp_rc_in_39_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_39_toCore[31] = ms_riscv32_mp_rc_in_39_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_39_toCore[32] = ms_riscv32_mp_rc_in_39_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_39_toCore[33] = ms_riscv32_mp_rc_in_39_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_39_toCore[34] = ms_riscv32_mp_rc_in_39_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_39_toCore[35] = ms_riscv32_mp_rc_in_39_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_39_toCore[36] = ms_riscv32_mp_rc_in_39_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_39_toCore[37] = ms_riscv32_mp_rc_in_39_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_39_toCore[38] = ms_riscv32_mp_rc_in_39_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_39_toCore[40] = ms_riscv32_mp_rc_in_39_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_39_toCore[41] = ms_riscv32_mp_rc_in_39_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_39_toCore[42] = ms_riscv32_mp_rc_in_39_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_39_toCore[43] = ms_riscv32_mp_rc_in_39_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_39_toCore[44] = ms_riscv32_mp_rc_in_39_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_39_toCore[45] = ms_riscv32_mp_rc_in_39_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_39_toCore[46] = ms_riscv32_mp_rc_in_39_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_39_toCore[47] = ms_riscv32_mp_rc_in_39_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_39_toCore[48] = ms_riscv32_mp_rc_in_39_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_39_toCore[49] = ms_riscv32_mp_rc_in_39_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_39_toCore[50] = ms_riscv32_mp_rc_in_39_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_39_toCore[51] = ms_riscv32_mp_rc_in_39_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_39_toCore[52] = ms_riscv32_mp_rc_in_39_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_39_toCore[53] = ms_riscv32_mp_rc_in_39_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_39_toCore[54] = ms_riscv32_mp_rc_in_39_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_39_toCore[55] = ms_riscv32_mp_rc_in_39_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_39_toCore[56] = ms_riscv32_mp_rc_in_39_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_39_toCore[57] = ms_riscv32_mp_rc_in_39_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_39_toCore[58] = ms_riscv32_mp_rc_in_39_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_39_toCore[59] = ms_riscv32_mp_rc_in_39_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_39_toCore[60] = ms_riscv32_mp_rc_in_39_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_39_toCore[61] = ms_riscv32_mp_rc_in_39_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_39_toCore[62] = ms_riscv32_mp_rc_in_39_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_39_toCore[63] = ms_riscv32_mp_rc_in_39_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[0] = ms_riscv32_mp_rc_in_38_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[1] = ms_riscv32_mp_rc_in_38_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[2] = ms_riscv32_mp_rc_in_38_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[3] = ms_riscv32_mp_rc_in_38_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[4] = ms_riscv32_mp_rc_in_38_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[5] = ms_riscv32_mp_rc_in_38_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[6] = ms_riscv32_mp_rc_in_38_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[7] = ms_riscv32_mp_rc_in_38_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[8] = ms_riscv32_mp_rc_in_38_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[9] = ms_riscv32_mp_rc_in_38_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[10] = ms_riscv32_mp_rc_in_38_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[11] = ms_riscv32_mp_rc_in_38_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[12] = ms_riscv32_mp_rc_in_38_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[13] = ms_riscv32_mp_rc_in_38_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[14] = ms_riscv32_mp_rc_in_38_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[15] = ms_riscv32_mp_rc_in_38_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[16] = ms_riscv32_mp_rc_in_38_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[17] = ms_riscv32_mp_rc_in_38_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[18] = ms_riscv32_mp_rc_in_38_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[19] = ms_riscv32_mp_rc_in_38_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[20] = ms_riscv32_mp_rc_in_38_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[21] = ms_riscv32_mp_rc_in_38_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[22] = ms_riscv32_mp_rc_in_38_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[23] = ms_riscv32_mp_rc_in_38_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[24] = ms_riscv32_mp_rc_in_38_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[25] = ms_riscv32_mp_rc_in_38_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[26] = ms_riscv32_mp_rc_in_38_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[27] = ms_riscv32_mp_rc_in_38_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[28] = ms_riscv32_mp_rc_in_38_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[29] = ms_riscv32_mp_rc_in_38_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[30] = ms_riscv32_mp_rc_in_38_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[31] = ms_riscv32_mp_rc_in_38_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[32] = ms_riscv32_mp_rc_in_38_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[33] = ms_riscv32_mp_rc_in_38_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[34] = ms_riscv32_mp_rc_in_38_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[35] = ms_riscv32_mp_rc_in_38_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[36] = ms_riscv32_mp_rc_in_38_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[37] = ms_riscv32_mp_rc_in_38_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[39] = ms_riscv32_mp_rc_in_38_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[40] = ms_riscv32_mp_rc_in_38_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[41] = ms_riscv32_mp_rc_in_38_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[42] = ms_riscv32_mp_rc_in_38_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[43] = ms_riscv32_mp_rc_in_38_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[44] = ms_riscv32_mp_rc_in_38_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[45] = ms_riscv32_mp_rc_in_38_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[46] = ms_riscv32_mp_rc_in_38_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[47] = ms_riscv32_mp_rc_in_38_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[48] = ms_riscv32_mp_rc_in_38_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[49] = ms_riscv32_mp_rc_in_38_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[50] = ms_riscv32_mp_rc_in_38_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[51] = ms_riscv32_mp_rc_in_38_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[52] = ms_riscv32_mp_rc_in_38_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[53] = ms_riscv32_mp_rc_in_38_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[54] = ms_riscv32_mp_rc_in_38_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[55] = ms_riscv32_mp_rc_in_38_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[56] = ms_riscv32_mp_rc_in_38_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[57] = ms_riscv32_mp_rc_in_38_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[58] = ms_riscv32_mp_rc_in_38_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[59] = ms_riscv32_mp_rc_in_38_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[60] = ms_riscv32_mp_rc_in_38_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[61] = ms_riscv32_mp_rc_in_38_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[62] = ms_riscv32_mp_rc_in_38_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_39_toCore_ts1[63] = ms_riscv32_mp_rc_in_38_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_37_toCore[0] = ms_riscv32_mp_rc_in_37_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_37_toCore[1] = ms_riscv32_mp_rc_in_37_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_37_toCore[2] = ms_riscv32_mp_rc_in_37_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_37_toCore[3] = ms_riscv32_mp_rc_in_37_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_37_toCore[4] = ms_riscv32_mp_rc_in_37_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_37_toCore[5] = ms_riscv32_mp_rc_in_37_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_37_toCore[6] = ms_riscv32_mp_rc_in_37_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_37_toCore[7] = ms_riscv32_mp_rc_in_37_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_37_toCore[8] = ms_riscv32_mp_rc_in_37_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_37_toCore[9] = ms_riscv32_mp_rc_in_37_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_37_toCore[10] = ms_riscv32_mp_rc_in_37_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_37_toCore[11] = ms_riscv32_mp_rc_in_37_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_37_toCore[12] = ms_riscv32_mp_rc_in_37_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_37_toCore[13] = ms_riscv32_mp_rc_in_37_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_37_toCore[14] = ms_riscv32_mp_rc_in_37_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_37_toCore[15] = ms_riscv32_mp_rc_in_37_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_37_toCore[16] = ms_riscv32_mp_rc_in_37_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_37_toCore[17] = ms_riscv32_mp_rc_in_37_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_37_toCore[18] = ms_riscv32_mp_rc_in_37_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_37_toCore[19] = ms_riscv32_mp_rc_in_37_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_37_toCore[20] = ms_riscv32_mp_rc_in_37_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_37_toCore[21] = ms_riscv32_mp_rc_in_37_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_37_toCore[22] = ms_riscv32_mp_rc_in_37_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_37_toCore[23] = ms_riscv32_mp_rc_in_37_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_37_toCore[24] = ms_riscv32_mp_rc_in_37_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_37_toCore[25] = ms_riscv32_mp_rc_in_37_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_37_toCore[26] = ms_riscv32_mp_rc_in_37_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_37_toCore[27] = ms_riscv32_mp_rc_in_37_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_37_toCore[28] = ms_riscv32_mp_rc_in_37_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_37_toCore[29] = ms_riscv32_mp_rc_in_37_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_37_toCore[30] = ms_riscv32_mp_rc_in_37_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_37_toCore[31] = ms_riscv32_mp_rc_in_37_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_37_toCore[32] = ms_riscv32_mp_rc_in_37_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_37_toCore[33] = ms_riscv32_mp_rc_in_37_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_37_toCore[34] = ms_riscv32_mp_rc_in_37_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_37_toCore[35] = ms_riscv32_mp_rc_in_37_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_37_toCore[36] = ms_riscv32_mp_rc_in_37_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_37_toCore[38] = ms_riscv32_mp_rc_in_37_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_37_toCore[39] = ms_riscv32_mp_rc_in_37_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_37_toCore[40] = ms_riscv32_mp_rc_in_37_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_37_toCore[41] = ms_riscv32_mp_rc_in_37_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_37_toCore[42] = ms_riscv32_mp_rc_in_37_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_37_toCore[43] = ms_riscv32_mp_rc_in_37_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_37_toCore[44] = ms_riscv32_mp_rc_in_37_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_37_toCore[45] = ms_riscv32_mp_rc_in_37_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_37_toCore[46] = ms_riscv32_mp_rc_in_37_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_37_toCore[47] = ms_riscv32_mp_rc_in_37_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_37_toCore[48] = ms_riscv32_mp_rc_in_37_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_37_toCore[49] = ms_riscv32_mp_rc_in_37_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_37_toCore[50] = ms_riscv32_mp_rc_in_37_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_37_toCore[51] = ms_riscv32_mp_rc_in_37_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_37_toCore[52] = ms_riscv32_mp_rc_in_37_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_37_toCore[53] = ms_riscv32_mp_rc_in_37_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_37_toCore[54] = ms_riscv32_mp_rc_in_37_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_37_toCore[55] = ms_riscv32_mp_rc_in_37_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_37_toCore[56] = ms_riscv32_mp_rc_in_37_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_37_toCore[57] = ms_riscv32_mp_rc_in_37_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_37_toCore[58] = ms_riscv32_mp_rc_in_37_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_37_toCore[59] = ms_riscv32_mp_rc_in_37_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_37_toCore[60] = ms_riscv32_mp_rc_in_37_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_37_toCore[61] = ms_riscv32_mp_rc_in_37_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_37_toCore[62] = ms_riscv32_mp_rc_in_37_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_37_toCore[63] = ms_riscv32_mp_rc_in_37_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[0] = ms_riscv32_mp_rc_in_36_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[1] = ms_riscv32_mp_rc_in_36_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[2] = ms_riscv32_mp_rc_in_36_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[3] = ms_riscv32_mp_rc_in_36_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[4] = ms_riscv32_mp_rc_in_36_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[5] = ms_riscv32_mp_rc_in_36_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[6] = ms_riscv32_mp_rc_in_36_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[7] = ms_riscv32_mp_rc_in_36_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[8] = ms_riscv32_mp_rc_in_36_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[9] = ms_riscv32_mp_rc_in_36_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[10] = ms_riscv32_mp_rc_in_36_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[11] = ms_riscv32_mp_rc_in_36_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[12] = ms_riscv32_mp_rc_in_36_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[13] = ms_riscv32_mp_rc_in_36_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[14] = ms_riscv32_mp_rc_in_36_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[15] = ms_riscv32_mp_rc_in_36_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[16] = ms_riscv32_mp_rc_in_36_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[17] = ms_riscv32_mp_rc_in_36_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[18] = ms_riscv32_mp_rc_in_36_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[19] = ms_riscv32_mp_rc_in_36_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[20] = ms_riscv32_mp_rc_in_36_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[21] = ms_riscv32_mp_rc_in_36_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[22] = ms_riscv32_mp_rc_in_36_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[23] = ms_riscv32_mp_rc_in_36_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[24] = ms_riscv32_mp_rc_in_36_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[25] = ms_riscv32_mp_rc_in_36_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[26] = ms_riscv32_mp_rc_in_36_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[27] = ms_riscv32_mp_rc_in_36_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[28] = ms_riscv32_mp_rc_in_36_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[29] = ms_riscv32_mp_rc_in_36_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[30] = ms_riscv32_mp_rc_in_36_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[31] = ms_riscv32_mp_rc_in_36_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[32] = ms_riscv32_mp_rc_in_36_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[33] = ms_riscv32_mp_rc_in_36_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[34] = ms_riscv32_mp_rc_in_36_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[35] = ms_riscv32_mp_rc_in_36_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[37] = ms_riscv32_mp_rc_in_36_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[38] = ms_riscv32_mp_rc_in_36_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[39] = ms_riscv32_mp_rc_in_36_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[40] = ms_riscv32_mp_rc_in_36_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[41] = ms_riscv32_mp_rc_in_36_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[42] = ms_riscv32_mp_rc_in_36_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[43] = ms_riscv32_mp_rc_in_36_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[44] = ms_riscv32_mp_rc_in_36_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[45] = ms_riscv32_mp_rc_in_36_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[46] = ms_riscv32_mp_rc_in_36_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[47] = ms_riscv32_mp_rc_in_36_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[48] = ms_riscv32_mp_rc_in_36_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[49] = ms_riscv32_mp_rc_in_36_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[50] = ms_riscv32_mp_rc_in_36_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[51] = ms_riscv32_mp_rc_in_36_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[52] = ms_riscv32_mp_rc_in_36_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[53] = ms_riscv32_mp_rc_in_36_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[54] = ms_riscv32_mp_rc_in_36_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[55] = ms_riscv32_mp_rc_in_36_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[56] = ms_riscv32_mp_rc_in_36_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[57] = ms_riscv32_mp_rc_in_36_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[58] = ms_riscv32_mp_rc_in_36_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[59] = ms_riscv32_mp_rc_in_36_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[60] = ms_riscv32_mp_rc_in_36_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[61] = ms_riscv32_mp_rc_in_36_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[62] = ms_riscv32_mp_rc_in_36_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_37_toCore_ts1[63] = ms_riscv32_mp_rc_in_36_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_35_toCore[0] = ms_riscv32_mp_rc_in_35_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_35_toCore[1] = ms_riscv32_mp_rc_in_35_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_35_toCore[2] = ms_riscv32_mp_rc_in_35_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_35_toCore[3] = ms_riscv32_mp_rc_in_35_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_35_toCore[4] = ms_riscv32_mp_rc_in_35_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_35_toCore[5] = ms_riscv32_mp_rc_in_35_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_35_toCore[6] = ms_riscv32_mp_rc_in_35_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_35_toCore[7] = ms_riscv32_mp_rc_in_35_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_35_toCore[8] = ms_riscv32_mp_rc_in_35_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_35_toCore[9] = ms_riscv32_mp_rc_in_35_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_35_toCore[10] = ms_riscv32_mp_rc_in_35_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_35_toCore[11] = ms_riscv32_mp_rc_in_35_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_35_toCore[12] = ms_riscv32_mp_rc_in_35_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_35_toCore[13] = ms_riscv32_mp_rc_in_35_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_35_toCore[14] = ms_riscv32_mp_rc_in_35_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_35_toCore[15] = ms_riscv32_mp_rc_in_35_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_35_toCore[16] = ms_riscv32_mp_rc_in_35_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_35_toCore[17] = ms_riscv32_mp_rc_in_35_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_35_toCore[18] = ms_riscv32_mp_rc_in_35_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_35_toCore[19] = ms_riscv32_mp_rc_in_35_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_35_toCore[20] = ms_riscv32_mp_rc_in_35_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_35_toCore[21] = ms_riscv32_mp_rc_in_35_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_35_toCore[22] = ms_riscv32_mp_rc_in_35_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_35_toCore[23] = ms_riscv32_mp_rc_in_35_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_35_toCore[24] = ms_riscv32_mp_rc_in_35_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_35_toCore[25] = ms_riscv32_mp_rc_in_35_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_35_toCore[26] = ms_riscv32_mp_rc_in_35_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_35_toCore[27] = ms_riscv32_mp_rc_in_35_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_35_toCore[28] = ms_riscv32_mp_rc_in_35_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_35_toCore[29] = ms_riscv32_mp_rc_in_35_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_35_toCore[30] = ms_riscv32_mp_rc_in_35_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_35_toCore[31] = ms_riscv32_mp_rc_in_35_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_35_toCore[32] = ms_riscv32_mp_rc_in_35_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_35_toCore[33] = ms_riscv32_mp_rc_in_35_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_35_toCore[34] = ms_riscv32_mp_rc_in_35_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_35_toCore[36] = ms_riscv32_mp_rc_in_35_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_35_toCore[37] = ms_riscv32_mp_rc_in_35_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_35_toCore[38] = ms_riscv32_mp_rc_in_35_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_35_toCore[39] = ms_riscv32_mp_rc_in_35_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_35_toCore[40] = ms_riscv32_mp_rc_in_35_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_35_toCore[41] = ms_riscv32_mp_rc_in_35_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_35_toCore[42] = ms_riscv32_mp_rc_in_35_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_35_toCore[43] = ms_riscv32_mp_rc_in_35_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_35_toCore[44] = ms_riscv32_mp_rc_in_35_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_35_toCore[45] = ms_riscv32_mp_rc_in_35_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_35_toCore[46] = ms_riscv32_mp_rc_in_35_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_35_toCore[47] = ms_riscv32_mp_rc_in_35_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_35_toCore[48] = ms_riscv32_mp_rc_in_35_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_35_toCore[49] = ms_riscv32_mp_rc_in_35_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_35_toCore[50] = ms_riscv32_mp_rc_in_35_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_35_toCore[51] = ms_riscv32_mp_rc_in_35_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_35_toCore[52] = ms_riscv32_mp_rc_in_35_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_35_toCore[53] = ms_riscv32_mp_rc_in_35_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_35_toCore[54] = ms_riscv32_mp_rc_in_35_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_35_toCore[55] = ms_riscv32_mp_rc_in_35_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_35_toCore[56] = ms_riscv32_mp_rc_in_35_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_35_toCore[57] = ms_riscv32_mp_rc_in_35_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_35_toCore[58] = ms_riscv32_mp_rc_in_35_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_35_toCore[59] = ms_riscv32_mp_rc_in_35_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_35_toCore[60] = ms_riscv32_mp_rc_in_35_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_35_toCore[61] = ms_riscv32_mp_rc_in_35_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_35_toCore[62] = ms_riscv32_mp_rc_in_35_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_35_toCore[63] = ms_riscv32_mp_rc_in_35_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[0] = ms_riscv32_mp_rc_in_34_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[1] = ms_riscv32_mp_rc_in_34_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[2] = ms_riscv32_mp_rc_in_34_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[3] = ms_riscv32_mp_rc_in_34_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[4] = ms_riscv32_mp_rc_in_34_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[5] = ms_riscv32_mp_rc_in_34_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[6] = ms_riscv32_mp_rc_in_34_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[7] = ms_riscv32_mp_rc_in_34_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[8] = ms_riscv32_mp_rc_in_34_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[9] = ms_riscv32_mp_rc_in_34_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[10] = ms_riscv32_mp_rc_in_34_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[11] = ms_riscv32_mp_rc_in_34_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[12] = ms_riscv32_mp_rc_in_34_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[13] = ms_riscv32_mp_rc_in_34_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[14] = ms_riscv32_mp_rc_in_34_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[15] = ms_riscv32_mp_rc_in_34_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[16] = ms_riscv32_mp_rc_in_34_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[17] = ms_riscv32_mp_rc_in_34_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[18] = ms_riscv32_mp_rc_in_34_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[19] = ms_riscv32_mp_rc_in_34_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[20] = ms_riscv32_mp_rc_in_34_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[21] = ms_riscv32_mp_rc_in_34_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[22] = ms_riscv32_mp_rc_in_34_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[23] = ms_riscv32_mp_rc_in_34_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[24] = ms_riscv32_mp_rc_in_34_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[25] = ms_riscv32_mp_rc_in_34_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[26] = ms_riscv32_mp_rc_in_34_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[27] = ms_riscv32_mp_rc_in_34_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[28] = ms_riscv32_mp_rc_in_34_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[29] = ms_riscv32_mp_rc_in_34_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[30] = ms_riscv32_mp_rc_in_34_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[31] = ms_riscv32_mp_rc_in_34_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[32] = ms_riscv32_mp_rc_in_34_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[33] = ms_riscv32_mp_rc_in_34_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[35] = ms_riscv32_mp_rc_in_34_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[36] = ms_riscv32_mp_rc_in_34_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[37] = ms_riscv32_mp_rc_in_34_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[38] = ms_riscv32_mp_rc_in_34_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[39] = ms_riscv32_mp_rc_in_34_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[40] = ms_riscv32_mp_rc_in_34_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[41] = ms_riscv32_mp_rc_in_34_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[42] = ms_riscv32_mp_rc_in_34_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[43] = ms_riscv32_mp_rc_in_34_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[44] = ms_riscv32_mp_rc_in_34_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[45] = ms_riscv32_mp_rc_in_34_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[46] = ms_riscv32_mp_rc_in_34_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[47] = ms_riscv32_mp_rc_in_34_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[48] = ms_riscv32_mp_rc_in_34_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[49] = ms_riscv32_mp_rc_in_34_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[50] = ms_riscv32_mp_rc_in_34_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[51] = ms_riscv32_mp_rc_in_34_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[52] = ms_riscv32_mp_rc_in_34_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[53] = ms_riscv32_mp_rc_in_34_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[54] = ms_riscv32_mp_rc_in_34_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[55] = ms_riscv32_mp_rc_in_34_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[56] = ms_riscv32_mp_rc_in_34_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[57] = ms_riscv32_mp_rc_in_34_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[58] = ms_riscv32_mp_rc_in_34_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[59] = ms_riscv32_mp_rc_in_34_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[60] = ms_riscv32_mp_rc_in_34_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[61] = ms_riscv32_mp_rc_in_34_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[62] = ms_riscv32_mp_rc_in_34_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_35_toCore_ts1[63] = ms_riscv32_mp_rc_in_34_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_33_toCore[0] = ms_riscv32_mp_rc_in_33_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_33_toCore[1] = ms_riscv32_mp_rc_in_33_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_33_toCore[2] = ms_riscv32_mp_rc_in_33_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_33_toCore[3] = ms_riscv32_mp_rc_in_33_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_33_toCore[4] = ms_riscv32_mp_rc_in_33_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_33_toCore[5] = ms_riscv32_mp_rc_in_33_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_33_toCore[6] = ms_riscv32_mp_rc_in_33_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_33_toCore[7] = ms_riscv32_mp_rc_in_33_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_33_toCore[8] = ms_riscv32_mp_rc_in_33_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_33_toCore[9] = ms_riscv32_mp_rc_in_33_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_33_toCore[10] = ms_riscv32_mp_rc_in_33_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_33_toCore[11] = ms_riscv32_mp_rc_in_33_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_33_toCore[12] = ms_riscv32_mp_rc_in_33_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_33_toCore[13] = ms_riscv32_mp_rc_in_33_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_33_toCore[14] = ms_riscv32_mp_rc_in_33_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_33_toCore[15] = ms_riscv32_mp_rc_in_33_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_33_toCore[16] = ms_riscv32_mp_rc_in_33_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_33_toCore[17] = ms_riscv32_mp_rc_in_33_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_33_toCore[18] = ms_riscv32_mp_rc_in_33_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_33_toCore[19] = ms_riscv32_mp_rc_in_33_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_33_toCore[20] = ms_riscv32_mp_rc_in_33_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_33_toCore[21] = ms_riscv32_mp_rc_in_33_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_33_toCore[22] = ms_riscv32_mp_rc_in_33_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_33_toCore[23] = ms_riscv32_mp_rc_in_33_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_33_toCore[24] = ms_riscv32_mp_rc_in_33_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_33_toCore[25] = ms_riscv32_mp_rc_in_33_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_33_toCore[26] = ms_riscv32_mp_rc_in_33_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_33_toCore[27] = ms_riscv32_mp_rc_in_33_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_33_toCore[28] = ms_riscv32_mp_rc_in_33_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_33_toCore[29] = ms_riscv32_mp_rc_in_33_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_33_toCore[30] = ms_riscv32_mp_rc_in_33_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_33_toCore[31] = ms_riscv32_mp_rc_in_33_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_33_toCore[32] = ms_riscv32_mp_rc_in_33_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_33_toCore[34] = ms_riscv32_mp_rc_in_33_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_33_toCore[35] = ms_riscv32_mp_rc_in_33_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_33_toCore[36] = ms_riscv32_mp_rc_in_33_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_33_toCore[37] = ms_riscv32_mp_rc_in_33_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_33_toCore[38] = ms_riscv32_mp_rc_in_33_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_33_toCore[39] = ms_riscv32_mp_rc_in_33_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_33_toCore[40] = ms_riscv32_mp_rc_in_33_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_33_toCore[41] = ms_riscv32_mp_rc_in_33_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_33_toCore[42] = ms_riscv32_mp_rc_in_33_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_33_toCore[43] = ms_riscv32_mp_rc_in_33_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_33_toCore[44] = ms_riscv32_mp_rc_in_33_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_33_toCore[45] = ms_riscv32_mp_rc_in_33_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_33_toCore[46] = ms_riscv32_mp_rc_in_33_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_33_toCore[47] = ms_riscv32_mp_rc_in_33_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_33_toCore[48] = ms_riscv32_mp_rc_in_33_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_33_toCore[49] = ms_riscv32_mp_rc_in_33_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_33_toCore[50] = ms_riscv32_mp_rc_in_33_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_33_toCore[51] = ms_riscv32_mp_rc_in_33_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_33_toCore[52] = ms_riscv32_mp_rc_in_33_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_33_toCore[53] = ms_riscv32_mp_rc_in_33_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_33_toCore[54] = ms_riscv32_mp_rc_in_33_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_33_toCore[55] = ms_riscv32_mp_rc_in_33_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_33_toCore[56] = ms_riscv32_mp_rc_in_33_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_33_toCore[57] = ms_riscv32_mp_rc_in_33_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_33_toCore[58] = ms_riscv32_mp_rc_in_33_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_33_toCore[59] = ms_riscv32_mp_rc_in_33_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_33_toCore[60] = ms_riscv32_mp_rc_in_33_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_33_toCore[61] = ms_riscv32_mp_rc_in_33_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_33_toCore[62] = ms_riscv32_mp_rc_in_33_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_33_toCore[63] = ms_riscv32_mp_rc_in_33_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[0] = ms_riscv32_mp_rc_in_32_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[1] = ms_riscv32_mp_rc_in_32_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[2] = ms_riscv32_mp_rc_in_32_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[3] = ms_riscv32_mp_rc_in_32_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[4] = ms_riscv32_mp_rc_in_32_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[5] = ms_riscv32_mp_rc_in_32_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[6] = ms_riscv32_mp_rc_in_32_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[7] = ms_riscv32_mp_rc_in_32_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[8] = ms_riscv32_mp_rc_in_32_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[9] = ms_riscv32_mp_rc_in_32_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[10] = ms_riscv32_mp_rc_in_32_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[11] = ms_riscv32_mp_rc_in_32_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[12] = ms_riscv32_mp_rc_in_32_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[13] = ms_riscv32_mp_rc_in_32_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[14] = ms_riscv32_mp_rc_in_32_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[15] = ms_riscv32_mp_rc_in_32_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[16] = ms_riscv32_mp_rc_in_32_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[17] = ms_riscv32_mp_rc_in_32_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[18] = ms_riscv32_mp_rc_in_32_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[19] = ms_riscv32_mp_rc_in_32_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[20] = ms_riscv32_mp_rc_in_32_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[21] = ms_riscv32_mp_rc_in_32_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[22] = ms_riscv32_mp_rc_in_32_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[23] = ms_riscv32_mp_rc_in_32_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[24] = ms_riscv32_mp_rc_in_32_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[25] = ms_riscv32_mp_rc_in_32_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[26] = ms_riscv32_mp_rc_in_32_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[27] = ms_riscv32_mp_rc_in_32_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[28] = ms_riscv32_mp_rc_in_32_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[29] = ms_riscv32_mp_rc_in_32_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[30] = ms_riscv32_mp_rc_in_32_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[31] = ms_riscv32_mp_rc_in_32_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[33] = ms_riscv32_mp_rc_in_32_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[34] = ms_riscv32_mp_rc_in_32_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[35] = ms_riscv32_mp_rc_in_32_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[36] = ms_riscv32_mp_rc_in_32_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[37] = ms_riscv32_mp_rc_in_32_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[38] = ms_riscv32_mp_rc_in_32_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[39] = ms_riscv32_mp_rc_in_32_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[40] = ms_riscv32_mp_rc_in_32_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[41] = ms_riscv32_mp_rc_in_32_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[42] = ms_riscv32_mp_rc_in_32_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[43] = ms_riscv32_mp_rc_in_32_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[44] = ms_riscv32_mp_rc_in_32_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[45] = ms_riscv32_mp_rc_in_32_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[46] = ms_riscv32_mp_rc_in_32_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[47] = ms_riscv32_mp_rc_in_32_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[48] = ms_riscv32_mp_rc_in_32_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[49] = ms_riscv32_mp_rc_in_32_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[50] = ms_riscv32_mp_rc_in_32_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[51] = ms_riscv32_mp_rc_in_32_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[52] = ms_riscv32_mp_rc_in_32_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[53] = ms_riscv32_mp_rc_in_32_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[54] = ms_riscv32_mp_rc_in_32_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[55] = ms_riscv32_mp_rc_in_32_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[56] = ms_riscv32_mp_rc_in_32_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[57] = ms_riscv32_mp_rc_in_32_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[58] = ms_riscv32_mp_rc_in_32_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[59] = ms_riscv32_mp_rc_in_32_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[60] = ms_riscv32_mp_rc_in_32_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[61] = ms_riscv32_mp_rc_in_32_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[62] = ms_riscv32_mp_rc_in_32_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_33_toCore_ts1[63] = ms_riscv32_mp_rc_in_32_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_31_toCore[0] = ms_riscv32_mp_rc_in_31_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_31_toCore[1] = ms_riscv32_mp_rc_in_31_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_31_toCore[2] = ms_riscv32_mp_rc_in_31_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_31_toCore[3] = ms_riscv32_mp_rc_in_31_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_31_toCore[4] = ms_riscv32_mp_rc_in_31_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_31_toCore[5] = ms_riscv32_mp_rc_in_31_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_31_toCore[6] = ms_riscv32_mp_rc_in_31_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_31_toCore[7] = ms_riscv32_mp_rc_in_31_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_31_toCore[8] = ms_riscv32_mp_rc_in_31_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_31_toCore[9] = ms_riscv32_mp_rc_in_31_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_31_toCore[10] = ms_riscv32_mp_rc_in_31_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_31_toCore[11] = ms_riscv32_mp_rc_in_31_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_31_toCore[12] = ms_riscv32_mp_rc_in_31_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_31_toCore[13] = ms_riscv32_mp_rc_in_31_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_31_toCore[14] = ms_riscv32_mp_rc_in_31_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_31_toCore[15] = ms_riscv32_mp_rc_in_31_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_31_toCore[16] = ms_riscv32_mp_rc_in_31_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_31_toCore[17] = ms_riscv32_mp_rc_in_31_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_31_toCore[18] = ms_riscv32_mp_rc_in_31_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_31_toCore[19] = ms_riscv32_mp_rc_in_31_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_31_toCore[20] = ms_riscv32_mp_rc_in_31_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_31_toCore[21] = ms_riscv32_mp_rc_in_31_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_31_toCore[22] = ms_riscv32_mp_rc_in_31_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_31_toCore[23] = ms_riscv32_mp_rc_in_31_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_31_toCore[24] = ms_riscv32_mp_rc_in_31_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_31_toCore[25] = ms_riscv32_mp_rc_in_31_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_31_toCore[26] = ms_riscv32_mp_rc_in_31_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_31_toCore[27] = ms_riscv32_mp_rc_in_31_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_31_toCore[28] = ms_riscv32_mp_rc_in_31_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_31_toCore[29] = ms_riscv32_mp_rc_in_31_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_31_toCore[30] = ms_riscv32_mp_rc_in_31_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_31_toCore[32] = ms_riscv32_mp_rc_in_31_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_31_toCore[33] = ms_riscv32_mp_rc_in_31_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_31_toCore[34] = ms_riscv32_mp_rc_in_31_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_31_toCore[35] = ms_riscv32_mp_rc_in_31_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_31_toCore[36] = ms_riscv32_mp_rc_in_31_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_31_toCore[37] = ms_riscv32_mp_rc_in_31_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_31_toCore[38] = ms_riscv32_mp_rc_in_31_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_31_toCore[39] = ms_riscv32_mp_rc_in_31_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_31_toCore[40] = ms_riscv32_mp_rc_in_31_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_31_toCore[41] = ms_riscv32_mp_rc_in_31_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_31_toCore[42] = ms_riscv32_mp_rc_in_31_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_31_toCore[43] = ms_riscv32_mp_rc_in_31_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_31_toCore[44] = ms_riscv32_mp_rc_in_31_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_31_toCore[45] = ms_riscv32_mp_rc_in_31_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_31_toCore[46] = ms_riscv32_mp_rc_in_31_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_31_toCore[47] = ms_riscv32_mp_rc_in_31_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_31_toCore[48] = ms_riscv32_mp_rc_in_31_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_31_toCore[49] = ms_riscv32_mp_rc_in_31_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_31_toCore[50] = ms_riscv32_mp_rc_in_31_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_31_toCore[51] = ms_riscv32_mp_rc_in_31_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_31_toCore[52] = ms_riscv32_mp_rc_in_31_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_31_toCore[53] = ms_riscv32_mp_rc_in_31_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_31_toCore[54] = ms_riscv32_mp_rc_in_31_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_31_toCore[55] = ms_riscv32_mp_rc_in_31_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_31_toCore[56] = ms_riscv32_mp_rc_in_31_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_31_toCore[57] = ms_riscv32_mp_rc_in_31_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_31_toCore[58] = ms_riscv32_mp_rc_in_31_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_31_toCore[59] = ms_riscv32_mp_rc_in_31_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_31_toCore[60] = ms_riscv32_mp_rc_in_31_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_31_toCore[61] = ms_riscv32_mp_rc_in_31_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_31_toCore[62] = ms_riscv32_mp_rc_in_31_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_31_toCore[63] = ms_riscv32_mp_rc_in_31_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[0] = ms_riscv32_mp_rc_in_30_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[1] = ms_riscv32_mp_rc_in_30_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[2] = ms_riscv32_mp_rc_in_30_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[3] = ms_riscv32_mp_rc_in_30_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[4] = ms_riscv32_mp_rc_in_30_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[5] = ms_riscv32_mp_rc_in_30_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[6] = ms_riscv32_mp_rc_in_30_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[7] = ms_riscv32_mp_rc_in_30_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[8] = ms_riscv32_mp_rc_in_30_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[9] = ms_riscv32_mp_rc_in_30_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[10] = ms_riscv32_mp_rc_in_30_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[11] = ms_riscv32_mp_rc_in_30_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[12] = ms_riscv32_mp_rc_in_30_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[13] = ms_riscv32_mp_rc_in_30_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[14] = ms_riscv32_mp_rc_in_30_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[15] = ms_riscv32_mp_rc_in_30_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[16] = ms_riscv32_mp_rc_in_30_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[17] = ms_riscv32_mp_rc_in_30_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[18] = ms_riscv32_mp_rc_in_30_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[19] = ms_riscv32_mp_rc_in_30_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[20] = ms_riscv32_mp_rc_in_30_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[21] = ms_riscv32_mp_rc_in_30_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[22] = ms_riscv32_mp_rc_in_30_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[23] = ms_riscv32_mp_rc_in_30_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[24] = ms_riscv32_mp_rc_in_30_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[25] = ms_riscv32_mp_rc_in_30_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[26] = ms_riscv32_mp_rc_in_30_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[27] = ms_riscv32_mp_rc_in_30_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[28] = ms_riscv32_mp_rc_in_30_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[29] = ms_riscv32_mp_rc_in_30_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[31] = ms_riscv32_mp_rc_in_30_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[32] = ms_riscv32_mp_rc_in_30_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[33] = ms_riscv32_mp_rc_in_30_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[34] = ms_riscv32_mp_rc_in_30_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[35] = ms_riscv32_mp_rc_in_30_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[36] = ms_riscv32_mp_rc_in_30_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[37] = ms_riscv32_mp_rc_in_30_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[38] = ms_riscv32_mp_rc_in_30_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[39] = ms_riscv32_mp_rc_in_30_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[40] = ms_riscv32_mp_rc_in_30_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[41] = ms_riscv32_mp_rc_in_30_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[42] = ms_riscv32_mp_rc_in_30_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[43] = ms_riscv32_mp_rc_in_30_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[44] = ms_riscv32_mp_rc_in_30_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[45] = ms_riscv32_mp_rc_in_30_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[46] = ms_riscv32_mp_rc_in_30_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[47] = ms_riscv32_mp_rc_in_30_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[48] = ms_riscv32_mp_rc_in_30_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[49] = ms_riscv32_mp_rc_in_30_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[50] = ms_riscv32_mp_rc_in_30_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[51] = ms_riscv32_mp_rc_in_30_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[52] = ms_riscv32_mp_rc_in_30_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[53] = ms_riscv32_mp_rc_in_30_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[54] = ms_riscv32_mp_rc_in_30_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[55] = ms_riscv32_mp_rc_in_30_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[56] = ms_riscv32_mp_rc_in_30_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[57] = ms_riscv32_mp_rc_in_30_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[58] = ms_riscv32_mp_rc_in_30_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[59] = ms_riscv32_mp_rc_in_30_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[60] = ms_riscv32_mp_rc_in_30_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[61] = ms_riscv32_mp_rc_in_30_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[62] = ms_riscv32_mp_rc_in_30_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_31_toCore_ts1[63] = ms_riscv32_mp_rc_in_30_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_29_toCore[0] = ms_riscv32_mp_rc_in_29_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_29_toCore[1] = ms_riscv32_mp_rc_in_29_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_29_toCore[2] = ms_riscv32_mp_rc_in_29_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_29_toCore[3] = ms_riscv32_mp_rc_in_29_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_29_toCore[4] = ms_riscv32_mp_rc_in_29_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_29_toCore[5] = ms_riscv32_mp_rc_in_29_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_29_toCore[6] = ms_riscv32_mp_rc_in_29_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_29_toCore[7] = ms_riscv32_mp_rc_in_29_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_29_toCore[8] = ms_riscv32_mp_rc_in_29_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_29_toCore[9] = ms_riscv32_mp_rc_in_29_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_29_toCore[10] = ms_riscv32_mp_rc_in_29_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_29_toCore[11] = ms_riscv32_mp_rc_in_29_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_29_toCore[12] = ms_riscv32_mp_rc_in_29_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_29_toCore[13] = ms_riscv32_mp_rc_in_29_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_29_toCore[14] = ms_riscv32_mp_rc_in_29_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_29_toCore[15] = ms_riscv32_mp_rc_in_29_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_29_toCore[16] = ms_riscv32_mp_rc_in_29_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_29_toCore[17] = ms_riscv32_mp_rc_in_29_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_29_toCore[18] = ms_riscv32_mp_rc_in_29_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_29_toCore[19] = ms_riscv32_mp_rc_in_29_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_29_toCore[20] = ms_riscv32_mp_rc_in_29_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_29_toCore[21] = ms_riscv32_mp_rc_in_29_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_29_toCore[22] = ms_riscv32_mp_rc_in_29_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_29_toCore[23] = ms_riscv32_mp_rc_in_29_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_29_toCore[24] = ms_riscv32_mp_rc_in_29_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_29_toCore[25] = ms_riscv32_mp_rc_in_29_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_29_toCore[26] = ms_riscv32_mp_rc_in_29_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_29_toCore[27] = ms_riscv32_mp_rc_in_29_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_29_toCore[28] = ms_riscv32_mp_rc_in_29_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_29_toCore[30] = ms_riscv32_mp_rc_in_29_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_29_toCore[31] = ms_riscv32_mp_rc_in_29_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_29_toCore[32] = ms_riscv32_mp_rc_in_29_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_29_toCore[33] = ms_riscv32_mp_rc_in_29_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_29_toCore[34] = ms_riscv32_mp_rc_in_29_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_29_toCore[35] = ms_riscv32_mp_rc_in_29_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_29_toCore[36] = ms_riscv32_mp_rc_in_29_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_29_toCore[37] = ms_riscv32_mp_rc_in_29_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_29_toCore[38] = ms_riscv32_mp_rc_in_29_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_29_toCore[39] = ms_riscv32_mp_rc_in_29_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_29_toCore[40] = ms_riscv32_mp_rc_in_29_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_29_toCore[41] = ms_riscv32_mp_rc_in_29_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_29_toCore[42] = ms_riscv32_mp_rc_in_29_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_29_toCore[43] = ms_riscv32_mp_rc_in_29_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_29_toCore[44] = ms_riscv32_mp_rc_in_29_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_29_toCore[45] = ms_riscv32_mp_rc_in_29_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_29_toCore[46] = ms_riscv32_mp_rc_in_29_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_29_toCore[47] = ms_riscv32_mp_rc_in_29_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_29_toCore[48] = ms_riscv32_mp_rc_in_29_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_29_toCore[49] = ms_riscv32_mp_rc_in_29_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_29_toCore[50] = ms_riscv32_mp_rc_in_29_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_29_toCore[51] = ms_riscv32_mp_rc_in_29_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_29_toCore[52] = ms_riscv32_mp_rc_in_29_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_29_toCore[53] = ms_riscv32_mp_rc_in_29_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_29_toCore[54] = ms_riscv32_mp_rc_in_29_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_29_toCore[55] = ms_riscv32_mp_rc_in_29_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_29_toCore[56] = ms_riscv32_mp_rc_in_29_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_29_toCore[57] = ms_riscv32_mp_rc_in_29_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_29_toCore[58] = ms_riscv32_mp_rc_in_29_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_29_toCore[59] = ms_riscv32_mp_rc_in_29_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_29_toCore[60] = ms_riscv32_mp_rc_in_29_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_29_toCore[61] = ms_riscv32_mp_rc_in_29_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_29_toCore[62] = ms_riscv32_mp_rc_in_29_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_29_toCore[63] = ms_riscv32_mp_rc_in_29_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[0] = ms_riscv32_mp_rc_in_28_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[1] = ms_riscv32_mp_rc_in_28_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[2] = ms_riscv32_mp_rc_in_28_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[3] = ms_riscv32_mp_rc_in_28_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[4] = ms_riscv32_mp_rc_in_28_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[5] = ms_riscv32_mp_rc_in_28_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[6] = ms_riscv32_mp_rc_in_28_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[7] = ms_riscv32_mp_rc_in_28_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[8] = ms_riscv32_mp_rc_in_28_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[9] = ms_riscv32_mp_rc_in_28_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[10] = ms_riscv32_mp_rc_in_28_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[11] = ms_riscv32_mp_rc_in_28_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[12] = ms_riscv32_mp_rc_in_28_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[13] = ms_riscv32_mp_rc_in_28_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[14] = ms_riscv32_mp_rc_in_28_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[15] = ms_riscv32_mp_rc_in_28_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[16] = ms_riscv32_mp_rc_in_28_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[17] = ms_riscv32_mp_rc_in_28_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[18] = ms_riscv32_mp_rc_in_28_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[19] = ms_riscv32_mp_rc_in_28_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[20] = ms_riscv32_mp_rc_in_28_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[21] = ms_riscv32_mp_rc_in_28_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[22] = ms_riscv32_mp_rc_in_28_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[23] = ms_riscv32_mp_rc_in_28_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[24] = ms_riscv32_mp_rc_in_28_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[25] = ms_riscv32_mp_rc_in_28_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[26] = ms_riscv32_mp_rc_in_28_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[27] = ms_riscv32_mp_rc_in_28_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[29] = ms_riscv32_mp_rc_in_28_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[30] = ms_riscv32_mp_rc_in_28_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[31] = ms_riscv32_mp_rc_in_28_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[32] = ms_riscv32_mp_rc_in_28_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[33] = ms_riscv32_mp_rc_in_28_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[34] = ms_riscv32_mp_rc_in_28_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[35] = ms_riscv32_mp_rc_in_28_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[36] = ms_riscv32_mp_rc_in_28_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[37] = ms_riscv32_mp_rc_in_28_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[38] = ms_riscv32_mp_rc_in_28_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[39] = ms_riscv32_mp_rc_in_28_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[40] = ms_riscv32_mp_rc_in_28_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[41] = ms_riscv32_mp_rc_in_28_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[42] = ms_riscv32_mp_rc_in_28_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[43] = ms_riscv32_mp_rc_in_28_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[44] = ms_riscv32_mp_rc_in_28_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[45] = ms_riscv32_mp_rc_in_28_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[46] = ms_riscv32_mp_rc_in_28_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[47] = ms_riscv32_mp_rc_in_28_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[48] = ms_riscv32_mp_rc_in_28_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[49] = ms_riscv32_mp_rc_in_28_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[50] = ms_riscv32_mp_rc_in_28_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[51] = ms_riscv32_mp_rc_in_28_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[52] = ms_riscv32_mp_rc_in_28_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[53] = ms_riscv32_mp_rc_in_28_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[54] = ms_riscv32_mp_rc_in_28_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[55] = ms_riscv32_mp_rc_in_28_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[56] = ms_riscv32_mp_rc_in_28_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[57] = ms_riscv32_mp_rc_in_28_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[58] = ms_riscv32_mp_rc_in_28_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[59] = ms_riscv32_mp_rc_in_28_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[60] = ms_riscv32_mp_rc_in_28_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[61] = ms_riscv32_mp_rc_in_28_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[62] = ms_riscv32_mp_rc_in_28_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_29_toCore_ts1[63] = ms_riscv32_mp_rc_in_28_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_27_toCore[0] = ms_riscv32_mp_rc_in_27_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_27_toCore[1] = ms_riscv32_mp_rc_in_27_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_27_toCore[2] = ms_riscv32_mp_rc_in_27_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_27_toCore[3] = ms_riscv32_mp_rc_in_27_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_27_toCore[4] = ms_riscv32_mp_rc_in_27_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_27_toCore[5] = ms_riscv32_mp_rc_in_27_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_27_toCore[6] = ms_riscv32_mp_rc_in_27_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_27_toCore[7] = ms_riscv32_mp_rc_in_27_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_27_toCore[8] = ms_riscv32_mp_rc_in_27_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_27_toCore[9] = ms_riscv32_mp_rc_in_27_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_27_toCore[10] = ms_riscv32_mp_rc_in_27_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_27_toCore[11] = ms_riscv32_mp_rc_in_27_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_27_toCore[12] = ms_riscv32_mp_rc_in_27_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_27_toCore[13] = ms_riscv32_mp_rc_in_27_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_27_toCore[14] = ms_riscv32_mp_rc_in_27_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_27_toCore[15] = ms_riscv32_mp_rc_in_27_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_27_toCore[16] = ms_riscv32_mp_rc_in_27_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_27_toCore[17] = ms_riscv32_mp_rc_in_27_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_27_toCore[18] = ms_riscv32_mp_rc_in_27_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_27_toCore[19] = ms_riscv32_mp_rc_in_27_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_27_toCore[20] = ms_riscv32_mp_rc_in_27_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_27_toCore[21] = ms_riscv32_mp_rc_in_27_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_27_toCore[22] = ms_riscv32_mp_rc_in_27_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_27_toCore[23] = ms_riscv32_mp_rc_in_27_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_27_toCore[24] = ms_riscv32_mp_rc_in_27_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_27_toCore[25] = ms_riscv32_mp_rc_in_27_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_27_toCore[26] = ms_riscv32_mp_rc_in_27_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_27_toCore[28] = ms_riscv32_mp_rc_in_27_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_27_toCore[29] = ms_riscv32_mp_rc_in_27_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_27_toCore[30] = ms_riscv32_mp_rc_in_27_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_27_toCore[31] = ms_riscv32_mp_rc_in_27_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_27_toCore[32] = ms_riscv32_mp_rc_in_27_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_27_toCore[33] = ms_riscv32_mp_rc_in_27_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_27_toCore[34] = ms_riscv32_mp_rc_in_27_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_27_toCore[35] = ms_riscv32_mp_rc_in_27_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_27_toCore[36] = ms_riscv32_mp_rc_in_27_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_27_toCore[37] = ms_riscv32_mp_rc_in_27_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_27_toCore[38] = ms_riscv32_mp_rc_in_27_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_27_toCore[39] = ms_riscv32_mp_rc_in_27_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_27_toCore[40] = ms_riscv32_mp_rc_in_27_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_27_toCore[41] = ms_riscv32_mp_rc_in_27_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_27_toCore[42] = ms_riscv32_mp_rc_in_27_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_27_toCore[43] = ms_riscv32_mp_rc_in_27_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_27_toCore[44] = ms_riscv32_mp_rc_in_27_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_27_toCore[45] = ms_riscv32_mp_rc_in_27_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_27_toCore[46] = ms_riscv32_mp_rc_in_27_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_27_toCore[47] = ms_riscv32_mp_rc_in_27_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_27_toCore[48] = ms_riscv32_mp_rc_in_27_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_27_toCore[49] = ms_riscv32_mp_rc_in_27_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_27_toCore[50] = ms_riscv32_mp_rc_in_27_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_27_toCore[51] = ms_riscv32_mp_rc_in_27_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_27_toCore[52] = ms_riscv32_mp_rc_in_27_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_27_toCore[53] = ms_riscv32_mp_rc_in_27_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_27_toCore[54] = ms_riscv32_mp_rc_in_27_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_27_toCore[55] = ms_riscv32_mp_rc_in_27_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_27_toCore[56] = ms_riscv32_mp_rc_in_27_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_27_toCore[57] = ms_riscv32_mp_rc_in_27_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_27_toCore[58] = ms_riscv32_mp_rc_in_27_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_27_toCore[59] = ms_riscv32_mp_rc_in_27_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_27_toCore[60] = ms_riscv32_mp_rc_in_27_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_27_toCore[61] = ms_riscv32_mp_rc_in_27_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_27_toCore[62] = ms_riscv32_mp_rc_in_27_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_27_toCore[63] = ms_riscv32_mp_rc_in_27_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[0] = ms_riscv32_mp_rc_in_26_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[1] = ms_riscv32_mp_rc_in_26_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[2] = ms_riscv32_mp_rc_in_26_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[3] = ms_riscv32_mp_rc_in_26_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[4] = ms_riscv32_mp_rc_in_26_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[5] = ms_riscv32_mp_rc_in_26_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[6] = ms_riscv32_mp_rc_in_26_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[7] = ms_riscv32_mp_rc_in_26_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[8] = ms_riscv32_mp_rc_in_26_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[9] = ms_riscv32_mp_rc_in_26_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[10] = ms_riscv32_mp_rc_in_26_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[11] = ms_riscv32_mp_rc_in_26_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[12] = ms_riscv32_mp_rc_in_26_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[13] = ms_riscv32_mp_rc_in_26_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[14] = ms_riscv32_mp_rc_in_26_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[15] = ms_riscv32_mp_rc_in_26_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[16] = ms_riscv32_mp_rc_in_26_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[17] = ms_riscv32_mp_rc_in_26_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[18] = ms_riscv32_mp_rc_in_26_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[19] = ms_riscv32_mp_rc_in_26_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[20] = ms_riscv32_mp_rc_in_26_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[21] = ms_riscv32_mp_rc_in_26_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[22] = ms_riscv32_mp_rc_in_26_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[23] = ms_riscv32_mp_rc_in_26_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[24] = ms_riscv32_mp_rc_in_26_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[25] = ms_riscv32_mp_rc_in_26_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[27] = ms_riscv32_mp_rc_in_26_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[28] = ms_riscv32_mp_rc_in_26_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[29] = ms_riscv32_mp_rc_in_26_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[30] = ms_riscv32_mp_rc_in_26_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[31] = ms_riscv32_mp_rc_in_26_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[32] = ms_riscv32_mp_rc_in_26_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[33] = ms_riscv32_mp_rc_in_26_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[34] = ms_riscv32_mp_rc_in_26_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[35] = ms_riscv32_mp_rc_in_26_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[36] = ms_riscv32_mp_rc_in_26_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[37] = ms_riscv32_mp_rc_in_26_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[38] = ms_riscv32_mp_rc_in_26_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[39] = ms_riscv32_mp_rc_in_26_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[40] = ms_riscv32_mp_rc_in_26_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[41] = ms_riscv32_mp_rc_in_26_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[42] = ms_riscv32_mp_rc_in_26_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[43] = ms_riscv32_mp_rc_in_26_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[44] = ms_riscv32_mp_rc_in_26_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[45] = ms_riscv32_mp_rc_in_26_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[46] = ms_riscv32_mp_rc_in_26_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[47] = ms_riscv32_mp_rc_in_26_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[48] = ms_riscv32_mp_rc_in_26_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[49] = ms_riscv32_mp_rc_in_26_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[50] = ms_riscv32_mp_rc_in_26_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[51] = ms_riscv32_mp_rc_in_26_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[52] = ms_riscv32_mp_rc_in_26_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[53] = ms_riscv32_mp_rc_in_26_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[54] = ms_riscv32_mp_rc_in_26_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[55] = ms_riscv32_mp_rc_in_26_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[56] = ms_riscv32_mp_rc_in_26_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[57] = ms_riscv32_mp_rc_in_26_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[58] = ms_riscv32_mp_rc_in_26_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[59] = ms_riscv32_mp_rc_in_26_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[60] = ms_riscv32_mp_rc_in_26_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[61] = ms_riscv32_mp_rc_in_26_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[62] = ms_riscv32_mp_rc_in_26_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_27_toCore_ts1[63] = ms_riscv32_mp_rc_in_26_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_25_toCore[0] = ms_riscv32_mp_rc_in_25_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_25_toCore[1] = ms_riscv32_mp_rc_in_25_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_25_toCore[2] = ms_riscv32_mp_rc_in_25_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_25_toCore[3] = ms_riscv32_mp_rc_in_25_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_25_toCore[4] = ms_riscv32_mp_rc_in_25_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_25_toCore[5] = ms_riscv32_mp_rc_in_25_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_25_toCore[6] = ms_riscv32_mp_rc_in_25_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_25_toCore[7] = ms_riscv32_mp_rc_in_25_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_25_toCore[8] = ms_riscv32_mp_rc_in_25_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_25_toCore[9] = ms_riscv32_mp_rc_in_25_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_25_toCore[10] = ms_riscv32_mp_rc_in_25_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_25_toCore[11] = ms_riscv32_mp_rc_in_25_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_25_toCore[12] = ms_riscv32_mp_rc_in_25_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_25_toCore[13] = ms_riscv32_mp_rc_in_25_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_25_toCore[14] = ms_riscv32_mp_rc_in_25_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_25_toCore[15] = ms_riscv32_mp_rc_in_25_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_25_toCore[16] = ms_riscv32_mp_rc_in_25_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_25_toCore[17] = ms_riscv32_mp_rc_in_25_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_25_toCore[18] = ms_riscv32_mp_rc_in_25_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_25_toCore[19] = ms_riscv32_mp_rc_in_25_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_25_toCore[20] = ms_riscv32_mp_rc_in_25_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_25_toCore[21] = ms_riscv32_mp_rc_in_25_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_25_toCore[22] = ms_riscv32_mp_rc_in_25_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_25_toCore[23] = ms_riscv32_mp_rc_in_25_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_25_toCore[24] = ms_riscv32_mp_rc_in_25_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_25_toCore[26] = ms_riscv32_mp_rc_in_25_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_25_toCore[27] = ms_riscv32_mp_rc_in_25_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_25_toCore[28] = ms_riscv32_mp_rc_in_25_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_25_toCore[29] = ms_riscv32_mp_rc_in_25_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_25_toCore[30] = ms_riscv32_mp_rc_in_25_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_25_toCore[31] = ms_riscv32_mp_rc_in_25_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_25_toCore[32] = ms_riscv32_mp_rc_in_25_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_25_toCore[33] = ms_riscv32_mp_rc_in_25_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_25_toCore[34] = ms_riscv32_mp_rc_in_25_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_25_toCore[35] = ms_riscv32_mp_rc_in_25_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_25_toCore[36] = ms_riscv32_mp_rc_in_25_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_25_toCore[37] = ms_riscv32_mp_rc_in_25_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_25_toCore[38] = ms_riscv32_mp_rc_in_25_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_25_toCore[39] = ms_riscv32_mp_rc_in_25_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_25_toCore[40] = ms_riscv32_mp_rc_in_25_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_25_toCore[41] = ms_riscv32_mp_rc_in_25_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_25_toCore[42] = ms_riscv32_mp_rc_in_25_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_25_toCore[43] = ms_riscv32_mp_rc_in_25_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_25_toCore[44] = ms_riscv32_mp_rc_in_25_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_25_toCore[45] = ms_riscv32_mp_rc_in_25_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_25_toCore[46] = ms_riscv32_mp_rc_in_25_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_25_toCore[47] = ms_riscv32_mp_rc_in_25_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_25_toCore[48] = ms_riscv32_mp_rc_in_25_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_25_toCore[49] = ms_riscv32_mp_rc_in_25_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_25_toCore[50] = ms_riscv32_mp_rc_in_25_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_25_toCore[51] = ms_riscv32_mp_rc_in_25_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_25_toCore[52] = ms_riscv32_mp_rc_in_25_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_25_toCore[53] = ms_riscv32_mp_rc_in_25_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_25_toCore[54] = ms_riscv32_mp_rc_in_25_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_25_toCore[55] = ms_riscv32_mp_rc_in_25_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_25_toCore[56] = ms_riscv32_mp_rc_in_25_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_25_toCore[57] = ms_riscv32_mp_rc_in_25_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_25_toCore[58] = ms_riscv32_mp_rc_in_25_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_25_toCore[59] = ms_riscv32_mp_rc_in_25_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_25_toCore[60] = ms_riscv32_mp_rc_in_25_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_25_toCore[61] = ms_riscv32_mp_rc_in_25_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_25_toCore[62] = ms_riscv32_mp_rc_in_25_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_25_toCore[63] = ms_riscv32_mp_rc_in_25_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[0] = ms_riscv32_mp_rc_in_24_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[1] = ms_riscv32_mp_rc_in_24_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[2] = ms_riscv32_mp_rc_in_24_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[3] = ms_riscv32_mp_rc_in_24_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[4] = ms_riscv32_mp_rc_in_24_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[5] = ms_riscv32_mp_rc_in_24_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[6] = ms_riscv32_mp_rc_in_24_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[7] = ms_riscv32_mp_rc_in_24_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[8] = ms_riscv32_mp_rc_in_24_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[9] = ms_riscv32_mp_rc_in_24_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[10] = ms_riscv32_mp_rc_in_24_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[11] = ms_riscv32_mp_rc_in_24_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[12] = ms_riscv32_mp_rc_in_24_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[13] = ms_riscv32_mp_rc_in_24_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[14] = ms_riscv32_mp_rc_in_24_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[15] = ms_riscv32_mp_rc_in_24_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[16] = ms_riscv32_mp_rc_in_24_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[17] = ms_riscv32_mp_rc_in_24_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[18] = ms_riscv32_mp_rc_in_24_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[19] = ms_riscv32_mp_rc_in_24_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[20] = ms_riscv32_mp_rc_in_24_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[21] = ms_riscv32_mp_rc_in_24_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[22] = ms_riscv32_mp_rc_in_24_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[23] = ms_riscv32_mp_rc_in_24_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[25] = ms_riscv32_mp_rc_in_24_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[26] = ms_riscv32_mp_rc_in_24_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[27] = ms_riscv32_mp_rc_in_24_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[28] = ms_riscv32_mp_rc_in_24_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[29] = ms_riscv32_mp_rc_in_24_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[30] = ms_riscv32_mp_rc_in_24_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[31] = ms_riscv32_mp_rc_in_24_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[32] = ms_riscv32_mp_rc_in_24_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[33] = ms_riscv32_mp_rc_in_24_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[34] = ms_riscv32_mp_rc_in_24_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[35] = ms_riscv32_mp_rc_in_24_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[36] = ms_riscv32_mp_rc_in_24_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[37] = ms_riscv32_mp_rc_in_24_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[38] = ms_riscv32_mp_rc_in_24_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[39] = ms_riscv32_mp_rc_in_24_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[40] = ms_riscv32_mp_rc_in_24_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[41] = ms_riscv32_mp_rc_in_24_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[42] = ms_riscv32_mp_rc_in_24_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[43] = ms_riscv32_mp_rc_in_24_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[44] = ms_riscv32_mp_rc_in_24_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[45] = ms_riscv32_mp_rc_in_24_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[46] = ms_riscv32_mp_rc_in_24_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[47] = ms_riscv32_mp_rc_in_24_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[48] = ms_riscv32_mp_rc_in_24_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[49] = ms_riscv32_mp_rc_in_24_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[50] = ms_riscv32_mp_rc_in_24_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[51] = ms_riscv32_mp_rc_in_24_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[52] = ms_riscv32_mp_rc_in_24_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[53] = ms_riscv32_mp_rc_in_24_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[54] = ms_riscv32_mp_rc_in_24_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[55] = ms_riscv32_mp_rc_in_24_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[56] = ms_riscv32_mp_rc_in_24_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[57] = ms_riscv32_mp_rc_in_24_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[58] = ms_riscv32_mp_rc_in_24_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[59] = ms_riscv32_mp_rc_in_24_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[60] = ms_riscv32_mp_rc_in_24_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[61] = ms_riscv32_mp_rc_in_24_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[62] = ms_riscv32_mp_rc_in_24_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_25_toCore_ts1[63] = ms_riscv32_mp_rc_in_24_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_23_toCore[0] = ms_riscv32_mp_rc_in_23_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_23_toCore[1] = ms_riscv32_mp_rc_in_23_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_23_toCore[2] = ms_riscv32_mp_rc_in_23_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_23_toCore[3] = ms_riscv32_mp_rc_in_23_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_23_toCore[4] = ms_riscv32_mp_rc_in_23_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_23_toCore[5] = ms_riscv32_mp_rc_in_23_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_23_toCore[6] = ms_riscv32_mp_rc_in_23_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_23_toCore[7] = ms_riscv32_mp_rc_in_23_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_23_toCore[8] = ms_riscv32_mp_rc_in_23_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_23_toCore[9] = ms_riscv32_mp_rc_in_23_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_23_toCore[10] = ms_riscv32_mp_rc_in_23_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_23_toCore[11] = ms_riscv32_mp_rc_in_23_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_23_toCore[12] = ms_riscv32_mp_rc_in_23_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_23_toCore[13] = ms_riscv32_mp_rc_in_23_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_23_toCore[14] = ms_riscv32_mp_rc_in_23_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_23_toCore[15] = ms_riscv32_mp_rc_in_23_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_23_toCore[16] = ms_riscv32_mp_rc_in_23_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_23_toCore[17] = ms_riscv32_mp_rc_in_23_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_23_toCore[18] = ms_riscv32_mp_rc_in_23_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_23_toCore[19] = ms_riscv32_mp_rc_in_23_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_23_toCore[20] = ms_riscv32_mp_rc_in_23_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_23_toCore[21] = ms_riscv32_mp_rc_in_23_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_23_toCore[22] = ms_riscv32_mp_rc_in_23_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_23_toCore[24] = ms_riscv32_mp_rc_in_23_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_23_toCore[25] = ms_riscv32_mp_rc_in_23_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_23_toCore[26] = ms_riscv32_mp_rc_in_23_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_23_toCore[27] = ms_riscv32_mp_rc_in_23_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_23_toCore[28] = ms_riscv32_mp_rc_in_23_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_23_toCore[29] = ms_riscv32_mp_rc_in_23_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_23_toCore[30] = ms_riscv32_mp_rc_in_23_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_23_toCore[31] = ms_riscv32_mp_rc_in_23_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_23_toCore[32] = ms_riscv32_mp_rc_in_23_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_23_toCore[33] = ms_riscv32_mp_rc_in_23_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_23_toCore[34] = ms_riscv32_mp_rc_in_23_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_23_toCore[35] = ms_riscv32_mp_rc_in_23_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_23_toCore[36] = ms_riscv32_mp_rc_in_23_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_23_toCore[37] = ms_riscv32_mp_rc_in_23_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_23_toCore[38] = ms_riscv32_mp_rc_in_23_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_23_toCore[39] = ms_riscv32_mp_rc_in_23_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_23_toCore[40] = ms_riscv32_mp_rc_in_23_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_23_toCore[41] = ms_riscv32_mp_rc_in_23_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_23_toCore[42] = ms_riscv32_mp_rc_in_23_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_23_toCore[43] = ms_riscv32_mp_rc_in_23_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_23_toCore[44] = ms_riscv32_mp_rc_in_23_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_23_toCore[45] = ms_riscv32_mp_rc_in_23_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_23_toCore[46] = ms_riscv32_mp_rc_in_23_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_23_toCore[47] = ms_riscv32_mp_rc_in_23_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_23_toCore[48] = ms_riscv32_mp_rc_in_23_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_23_toCore[49] = ms_riscv32_mp_rc_in_23_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_23_toCore[50] = ms_riscv32_mp_rc_in_23_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_23_toCore[51] = ms_riscv32_mp_rc_in_23_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_23_toCore[52] = ms_riscv32_mp_rc_in_23_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_23_toCore[53] = ms_riscv32_mp_rc_in_23_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_23_toCore[54] = ms_riscv32_mp_rc_in_23_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_23_toCore[55] = ms_riscv32_mp_rc_in_23_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_23_toCore[56] = ms_riscv32_mp_rc_in_23_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_23_toCore[57] = ms_riscv32_mp_rc_in_23_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_23_toCore[58] = ms_riscv32_mp_rc_in_23_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_23_toCore[59] = ms_riscv32_mp_rc_in_23_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_23_toCore[60] = ms_riscv32_mp_rc_in_23_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_23_toCore[61] = ms_riscv32_mp_rc_in_23_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_23_toCore[62] = ms_riscv32_mp_rc_in_23_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_23_toCore[63] = ms_riscv32_mp_rc_in_23_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[0] = ms_riscv32_mp_rc_in_22_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[1] = ms_riscv32_mp_rc_in_22_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[2] = ms_riscv32_mp_rc_in_22_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[3] = ms_riscv32_mp_rc_in_22_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[4] = ms_riscv32_mp_rc_in_22_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[5] = ms_riscv32_mp_rc_in_22_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[6] = ms_riscv32_mp_rc_in_22_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[7] = ms_riscv32_mp_rc_in_22_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[8] = ms_riscv32_mp_rc_in_22_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[9] = ms_riscv32_mp_rc_in_22_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[10] = ms_riscv32_mp_rc_in_22_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[11] = ms_riscv32_mp_rc_in_22_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[12] = ms_riscv32_mp_rc_in_22_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[13] = ms_riscv32_mp_rc_in_22_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[14] = ms_riscv32_mp_rc_in_22_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[15] = ms_riscv32_mp_rc_in_22_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[16] = ms_riscv32_mp_rc_in_22_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[17] = ms_riscv32_mp_rc_in_22_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[18] = ms_riscv32_mp_rc_in_22_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[19] = ms_riscv32_mp_rc_in_22_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[20] = ms_riscv32_mp_rc_in_22_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[21] = ms_riscv32_mp_rc_in_22_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[23] = ms_riscv32_mp_rc_in_22_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[24] = ms_riscv32_mp_rc_in_22_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[25] = ms_riscv32_mp_rc_in_22_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[26] = ms_riscv32_mp_rc_in_22_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[27] = ms_riscv32_mp_rc_in_22_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[28] = ms_riscv32_mp_rc_in_22_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[29] = ms_riscv32_mp_rc_in_22_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[30] = ms_riscv32_mp_rc_in_22_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[31] = ms_riscv32_mp_rc_in_22_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[32] = ms_riscv32_mp_rc_in_22_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[33] = ms_riscv32_mp_rc_in_22_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[34] = ms_riscv32_mp_rc_in_22_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[35] = ms_riscv32_mp_rc_in_22_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[36] = ms_riscv32_mp_rc_in_22_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[37] = ms_riscv32_mp_rc_in_22_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[38] = ms_riscv32_mp_rc_in_22_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[39] = ms_riscv32_mp_rc_in_22_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[40] = ms_riscv32_mp_rc_in_22_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[41] = ms_riscv32_mp_rc_in_22_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[42] = ms_riscv32_mp_rc_in_22_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[43] = ms_riscv32_mp_rc_in_22_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[44] = ms_riscv32_mp_rc_in_22_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[45] = ms_riscv32_mp_rc_in_22_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[46] = ms_riscv32_mp_rc_in_22_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[47] = ms_riscv32_mp_rc_in_22_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[48] = ms_riscv32_mp_rc_in_22_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[49] = ms_riscv32_mp_rc_in_22_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[50] = ms_riscv32_mp_rc_in_22_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[51] = ms_riscv32_mp_rc_in_22_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[52] = ms_riscv32_mp_rc_in_22_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[53] = ms_riscv32_mp_rc_in_22_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[54] = ms_riscv32_mp_rc_in_22_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[55] = ms_riscv32_mp_rc_in_22_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[56] = ms_riscv32_mp_rc_in_22_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[57] = ms_riscv32_mp_rc_in_22_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[58] = ms_riscv32_mp_rc_in_22_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[59] = ms_riscv32_mp_rc_in_22_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[60] = ms_riscv32_mp_rc_in_22_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[61] = ms_riscv32_mp_rc_in_22_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[62] = ms_riscv32_mp_rc_in_22_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_23_toCore_ts1[63] = ms_riscv32_mp_rc_in_22_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_21_toCore[0] = ms_riscv32_mp_rc_in_21_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_21_toCore[1] = ms_riscv32_mp_rc_in_21_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_21_toCore[2] = ms_riscv32_mp_rc_in_21_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_21_toCore[3] = ms_riscv32_mp_rc_in_21_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_21_toCore[4] = ms_riscv32_mp_rc_in_21_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_21_toCore[5] = ms_riscv32_mp_rc_in_21_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_21_toCore[6] = ms_riscv32_mp_rc_in_21_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_21_toCore[7] = ms_riscv32_mp_rc_in_21_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_21_toCore[8] = ms_riscv32_mp_rc_in_21_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_21_toCore[9] = ms_riscv32_mp_rc_in_21_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_21_toCore[10] = ms_riscv32_mp_rc_in_21_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_21_toCore[11] = ms_riscv32_mp_rc_in_21_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_21_toCore[12] = ms_riscv32_mp_rc_in_21_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_21_toCore[13] = ms_riscv32_mp_rc_in_21_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_21_toCore[14] = ms_riscv32_mp_rc_in_21_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_21_toCore[15] = ms_riscv32_mp_rc_in_21_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_21_toCore[16] = ms_riscv32_mp_rc_in_21_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_21_toCore[17] = ms_riscv32_mp_rc_in_21_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_21_toCore[18] = ms_riscv32_mp_rc_in_21_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_21_toCore[19] = ms_riscv32_mp_rc_in_21_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_21_toCore[20] = ms_riscv32_mp_rc_in_21_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_21_toCore[22] = ms_riscv32_mp_rc_in_21_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_21_toCore[23] = ms_riscv32_mp_rc_in_21_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_21_toCore[24] = ms_riscv32_mp_rc_in_21_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_21_toCore[25] = ms_riscv32_mp_rc_in_21_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_21_toCore[26] = ms_riscv32_mp_rc_in_21_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_21_toCore[27] = ms_riscv32_mp_rc_in_21_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_21_toCore[28] = ms_riscv32_mp_rc_in_21_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_21_toCore[29] = ms_riscv32_mp_rc_in_21_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_21_toCore[30] = ms_riscv32_mp_rc_in_21_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_21_toCore[31] = ms_riscv32_mp_rc_in_21_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_21_toCore[32] = ms_riscv32_mp_rc_in_21_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_21_toCore[33] = ms_riscv32_mp_rc_in_21_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_21_toCore[34] = ms_riscv32_mp_rc_in_21_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_21_toCore[35] = ms_riscv32_mp_rc_in_21_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_21_toCore[36] = ms_riscv32_mp_rc_in_21_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_21_toCore[37] = ms_riscv32_mp_rc_in_21_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_21_toCore[38] = ms_riscv32_mp_rc_in_21_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_21_toCore[39] = ms_riscv32_mp_rc_in_21_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_21_toCore[40] = ms_riscv32_mp_rc_in_21_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_21_toCore[41] = ms_riscv32_mp_rc_in_21_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_21_toCore[42] = ms_riscv32_mp_rc_in_21_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_21_toCore[43] = ms_riscv32_mp_rc_in_21_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_21_toCore[44] = ms_riscv32_mp_rc_in_21_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_21_toCore[45] = ms_riscv32_mp_rc_in_21_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_21_toCore[46] = ms_riscv32_mp_rc_in_21_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_21_toCore[47] = ms_riscv32_mp_rc_in_21_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_21_toCore[48] = ms_riscv32_mp_rc_in_21_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_21_toCore[49] = ms_riscv32_mp_rc_in_21_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_21_toCore[50] = ms_riscv32_mp_rc_in_21_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_21_toCore[51] = ms_riscv32_mp_rc_in_21_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_21_toCore[52] = ms_riscv32_mp_rc_in_21_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_21_toCore[53] = ms_riscv32_mp_rc_in_21_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_21_toCore[54] = ms_riscv32_mp_rc_in_21_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_21_toCore[55] = ms_riscv32_mp_rc_in_21_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_21_toCore[56] = ms_riscv32_mp_rc_in_21_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_21_toCore[57] = ms_riscv32_mp_rc_in_21_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_21_toCore[58] = ms_riscv32_mp_rc_in_21_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_21_toCore[59] = ms_riscv32_mp_rc_in_21_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_21_toCore[60] = ms_riscv32_mp_rc_in_21_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_21_toCore[61] = ms_riscv32_mp_rc_in_21_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_21_toCore[62] = ms_riscv32_mp_rc_in_21_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_21_toCore[63] = ms_riscv32_mp_rc_in_21_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[0] = ms_riscv32_mp_rc_in_20_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[1] = ms_riscv32_mp_rc_in_20_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[2] = ms_riscv32_mp_rc_in_20_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[3] = ms_riscv32_mp_rc_in_20_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[4] = ms_riscv32_mp_rc_in_20_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[5] = ms_riscv32_mp_rc_in_20_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[6] = ms_riscv32_mp_rc_in_20_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[7] = ms_riscv32_mp_rc_in_20_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[8] = ms_riscv32_mp_rc_in_20_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[9] = ms_riscv32_mp_rc_in_20_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[10] = ms_riscv32_mp_rc_in_20_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[11] = ms_riscv32_mp_rc_in_20_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[12] = ms_riscv32_mp_rc_in_20_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[13] = ms_riscv32_mp_rc_in_20_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[14] = ms_riscv32_mp_rc_in_20_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[15] = ms_riscv32_mp_rc_in_20_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[16] = ms_riscv32_mp_rc_in_20_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[17] = ms_riscv32_mp_rc_in_20_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[18] = ms_riscv32_mp_rc_in_20_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[19] = ms_riscv32_mp_rc_in_20_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[21] = ms_riscv32_mp_rc_in_20_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[22] = ms_riscv32_mp_rc_in_20_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[23] = ms_riscv32_mp_rc_in_20_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[24] = ms_riscv32_mp_rc_in_20_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[25] = ms_riscv32_mp_rc_in_20_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[26] = ms_riscv32_mp_rc_in_20_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[27] = ms_riscv32_mp_rc_in_20_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[28] = ms_riscv32_mp_rc_in_20_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[29] = ms_riscv32_mp_rc_in_20_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[30] = ms_riscv32_mp_rc_in_20_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[31] = ms_riscv32_mp_rc_in_20_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[32] = ms_riscv32_mp_rc_in_20_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[33] = ms_riscv32_mp_rc_in_20_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[34] = ms_riscv32_mp_rc_in_20_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[35] = ms_riscv32_mp_rc_in_20_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[36] = ms_riscv32_mp_rc_in_20_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[37] = ms_riscv32_mp_rc_in_20_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[38] = ms_riscv32_mp_rc_in_20_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[39] = ms_riscv32_mp_rc_in_20_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[40] = ms_riscv32_mp_rc_in_20_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[41] = ms_riscv32_mp_rc_in_20_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[42] = ms_riscv32_mp_rc_in_20_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[43] = ms_riscv32_mp_rc_in_20_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[44] = ms_riscv32_mp_rc_in_20_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[45] = ms_riscv32_mp_rc_in_20_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[46] = ms_riscv32_mp_rc_in_20_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[47] = ms_riscv32_mp_rc_in_20_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[48] = ms_riscv32_mp_rc_in_20_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[49] = ms_riscv32_mp_rc_in_20_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[50] = ms_riscv32_mp_rc_in_20_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[51] = ms_riscv32_mp_rc_in_20_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[52] = ms_riscv32_mp_rc_in_20_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[53] = ms_riscv32_mp_rc_in_20_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[54] = ms_riscv32_mp_rc_in_20_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[55] = ms_riscv32_mp_rc_in_20_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[56] = ms_riscv32_mp_rc_in_20_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[57] = ms_riscv32_mp_rc_in_20_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[58] = ms_riscv32_mp_rc_in_20_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[59] = ms_riscv32_mp_rc_in_20_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[60] = ms_riscv32_mp_rc_in_20_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[61] = ms_riscv32_mp_rc_in_20_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[62] = ms_riscv32_mp_rc_in_20_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_21_toCore_ts1[63] = ms_riscv32_mp_rc_in_20_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_19_toCore[0] = ms_riscv32_mp_rc_in_19_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_19_toCore[1] = ms_riscv32_mp_rc_in_19_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_19_toCore[2] = ms_riscv32_mp_rc_in_19_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_19_toCore[3] = ms_riscv32_mp_rc_in_19_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_19_toCore[4] = ms_riscv32_mp_rc_in_19_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_19_toCore[5] = ms_riscv32_mp_rc_in_19_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_19_toCore[6] = ms_riscv32_mp_rc_in_19_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_19_toCore[7] = ms_riscv32_mp_rc_in_19_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_19_toCore[8] = ms_riscv32_mp_rc_in_19_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_19_toCore[9] = ms_riscv32_mp_rc_in_19_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_19_toCore[10] = ms_riscv32_mp_rc_in_19_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_19_toCore[11] = ms_riscv32_mp_rc_in_19_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_19_toCore[12] = ms_riscv32_mp_rc_in_19_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_19_toCore[13] = ms_riscv32_mp_rc_in_19_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_19_toCore[14] = ms_riscv32_mp_rc_in_19_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_19_toCore[15] = ms_riscv32_mp_rc_in_19_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_19_toCore[16] = ms_riscv32_mp_rc_in_19_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_19_toCore[17] = ms_riscv32_mp_rc_in_19_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_19_toCore[18] = ms_riscv32_mp_rc_in_19_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_19_toCore[20] = ms_riscv32_mp_rc_in_19_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_19_toCore[21] = ms_riscv32_mp_rc_in_19_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_19_toCore[22] = ms_riscv32_mp_rc_in_19_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_19_toCore[23] = ms_riscv32_mp_rc_in_19_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_19_toCore[24] = ms_riscv32_mp_rc_in_19_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_19_toCore[25] = ms_riscv32_mp_rc_in_19_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_19_toCore[26] = ms_riscv32_mp_rc_in_19_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_19_toCore[27] = ms_riscv32_mp_rc_in_19_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_19_toCore[28] = ms_riscv32_mp_rc_in_19_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_19_toCore[29] = ms_riscv32_mp_rc_in_19_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_19_toCore[30] = ms_riscv32_mp_rc_in_19_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_19_toCore[31] = ms_riscv32_mp_rc_in_19_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_19_toCore[32] = ms_riscv32_mp_rc_in_19_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_19_toCore[33] = ms_riscv32_mp_rc_in_19_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_19_toCore[34] = ms_riscv32_mp_rc_in_19_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_19_toCore[35] = ms_riscv32_mp_rc_in_19_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_19_toCore[36] = ms_riscv32_mp_rc_in_19_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_19_toCore[37] = ms_riscv32_mp_rc_in_19_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_19_toCore[38] = ms_riscv32_mp_rc_in_19_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_19_toCore[39] = ms_riscv32_mp_rc_in_19_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_19_toCore[40] = ms_riscv32_mp_rc_in_19_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_19_toCore[41] = ms_riscv32_mp_rc_in_19_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_19_toCore[42] = ms_riscv32_mp_rc_in_19_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_19_toCore[43] = ms_riscv32_mp_rc_in_19_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_19_toCore[44] = ms_riscv32_mp_rc_in_19_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_19_toCore[45] = ms_riscv32_mp_rc_in_19_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_19_toCore[46] = ms_riscv32_mp_rc_in_19_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_19_toCore[47] = ms_riscv32_mp_rc_in_19_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_19_toCore[48] = ms_riscv32_mp_rc_in_19_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_19_toCore[49] = ms_riscv32_mp_rc_in_19_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_19_toCore[50] = ms_riscv32_mp_rc_in_19_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_19_toCore[51] = ms_riscv32_mp_rc_in_19_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_19_toCore[52] = ms_riscv32_mp_rc_in_19_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_19_toCore[53] = ms_riscv32_mp_rc_in_19_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_19_toCore[54] = ms_riscv32_mp_rc_in_19_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_19_toCore[55] = ms_riscv32_mp_rc_in_19_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_19_toCore[56] = ms_riscv32_mp_rc_in_19_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_19_toCore[57] = ms_riscv32_mp_rc_in_19_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_19_toCore[58] = ms_riscv32_mp_rc_in_19_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_19_toCore[59] = ms_riscv32_mp_rc_in_19_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_19_toCore[60] = ms_riscv32_mp_rc_in_19_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_19_toCore[61] = ms_riscv32_mp_rc_in_19_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_19_toCore[62] = ms_riscv32_mp_rc_in_19_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_19_toCore[63] = ms_riscv32_mp_rc_in_19_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[0] = ms_riscv32_mp_rc_in_18_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[1] = ms_riscv32_mp_rc_in_18_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[2] = ms_riscv32_mp_rc_in_18_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[3] = ms_riscv32_mp_rc_in_18_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[4] = ms_riscv32_mp_rc_in_18_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[5] = ms_riscv32_mp_rc_in_18_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[6] = ms_riscv32_mp_rc_in_18_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[7] = ms_riscv32_mp_rc_in_18_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[8] = ms_riscv32_mp_rc_in_18_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[9] = ms_riscv32_mp_rc_in_18_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[10] = ms_riscv32_mp_rc_in_18_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[11] = ms_riscv32_mp_rc_in_18_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[12] = ms_riscv32_mp_rc_in_18_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[13] = ms_riscv32_mp_rc_in_18_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[14] = ms_riscv32_mp_rc_in_18_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[15] = ms_riscv32_mp_rc_in_18_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[16] = ms_riscv32_mp_rc_in_18_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[17] = ms_riscv32_mp_rc_in_18_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[19] = ms_riscv32_mp_rc_in_18_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[20] = ms_riscv32_mp_rc_in_18_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[21] = ms_riscv32_mp_rc_in_18_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[22] = ms_riscv32_mp_rc_in_18_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[23] = ms_riscv32_mp_rc_in_18_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[24] = ms_riscv32_mp_rc_in_18_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[25] = ms_riscv32_mp_rc_in_18_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[26] = ms_riscv32_mp_rc_in_18_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[27] = ms_riscv32_mp_rc_in_18_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[28] = ms_riscv32_mp_rc_in_18_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[29] = ms_riscv32_mp_rc_in_18_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[30] = ms_riscv32_mp_rc_in_18_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[31] = ms_riscv32_mp_rc_in_18_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[32] = ms_riscv32_mp_rc_in_18_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[33] = ms_riscv32_mp_rc_in_18_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[34] = ms_riscv32_mp_rc_in_18_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[35] = ms_riscv32_mp_rc_in_18_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[36] = ms_riscv32_mp_rc_in_18_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[37] = ms_riscv32_mp_rc_in_18_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[38] = ms_riscv32_mp_rc_in_18_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[39] = ms_riscv32_mp_rc_in_18_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[40] = ms_riscv32_mp_rc_in_18_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[41] = ms_riscv32_mp_rc_in_18_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[42] = ms_riscv32_mp_rc_in_18_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[43] = ms_riscv32_mp_rc_in_18_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[44] = ms_riscv32_mp_rc_in_18_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[45] = ms_riscv32_mp_rc_in_18_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[46] = ms_riscv32_mp_rc_in_18_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[47] = ms_riscv32_mp_rc_in_18_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[48] = ms_riscv32_mp_rc_in_18_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[49] = ms_riscv32_mp_rc_in_18_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[50] = ms_riscv32_mp_rc_in_18_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[51] = ms_riscv32_mp_rc_in_18_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[52] = ms_riscv32_mp_rc_in_18_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[53] = ms_riscv32_mp_rc_in_18_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[54] = ms_riscv32_mp_rc_in_18_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[55] = ms_riscv32_mp_rc_in_18_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[56] = ms_riscv32_mp_rc_in_18_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[57] = ms_riscv32_mp_rc_in_18_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[58] = ms_riscv32_mp_rc_in_18_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[59] = ms_riscv32_mp_rc_in_18_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[60] = ms_riscv32_mp_rc_in_18_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[61] = ms_riscv32_mp_rc_in_18_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[62] = ms_riscv32_mp_rc_in_18_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_19_toCore_ts1[63] = ms_riscv32_mp_rc_in_18_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_17_toCore[0] = ms_riscv32_mp_rc_in_17_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_17_toCore[1] = ms_riscv32_mp_rc_in_17_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_17_toCore[2] = ms_riscv32_mp_rc_in_17_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_17_toCore[3] = ms_riscv32_mp_rc_in_17_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_17_toCore[4] = ms_riscv32_mp_rc_in_17_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_17_toCore[5] = ms_riscv32_mp_rc_in_17_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_17_toCore[6] = ms_riscv32_mp_rc_in_17_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_17_toCore[7] = ms_riscv32_mp_rc_in_17_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_17_toCore[8] = ms_riscv32_mp_rc_in_17_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_17_toCore[9] = ms_riscv32_mp_rc_in_17_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_17_toCore[10] = ms_riscv32_mp_rc_in_17_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_17_toCore[11] = ms_riscv32_mp_rc_in_17_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_17_toCore[12] = ms_riscv32_mp_rc_in_17_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_17_toCore[13] = ms_riscv32_mp_rc_in_17_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_17_toCore[14] = ms_riscv32_mp_rc_in_17_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_17_toCore[15] = ms_riscv32_mp_rc_in_17_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_17_toCore[16] = ms_riscv32_mp_rc_in_17_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_17_toCore[18] = ms_riscv32_mp_rc_in_17_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_17_toCore[19] = ms_riscv32_mp_rc_in_17_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_17_toCore[20] = ms_riscv32_mp_rc_in_17_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_17_toCore[21] = ms_riscv32_mp_rc_in_17_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_17_toCore[22] = ms_riscv32_mp_rc_in_17_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_17_toCore[23] = ms_riscv32_mp_rc_in_17_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_17_toCore[24] = ms_riscv32_mp_rc_in_17_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_17_toCore[25] = ms_riscv32_mp_rc_in_17_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_17_toCore[26] = ms_riscv32_mp_rc_in_17_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_17_toCore[27] = ms_riscv32_mp_rc_in_17_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_17_toCore[28] = ms_riscv32_mp_rc_in_17_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_17_toCore[29] = ms_riscv32_mp_rc_in_17_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_17_toCore[30] = ms_riscv32_mp_rc_in_17_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_17_toCore[31] = ms_riscv32_mp_rc_in_17_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_17_toCore[32] = ms_riscv32_mp_rc_in_17_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_17_toCore[33] = ms_riscv32_mp_rc_in_17_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_17_toCore[34] = ms_riscv32_mp_rc_in_17_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_17_toCore[35] = ms_riscv32_mp_rc_in_17_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_17_toCore[36] = ms_riscv32_mp_rc_in_17_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_17_toCore[37] = ms_riscv32_mp_rc_in_17_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_17_toCore[38] = ms_riscv32_mp_rc_in_17_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_17_toCore[39] = ms_riscv32_mp_rc_in_17_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_17_toCore[40] = ms_riscv32_mp_rc_in_17_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_17_toCore[41] = ms_riscv32_mp_rc_in_17_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_17_toCore[42] = ms_riscv32_mp_rc_in_17_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_17_toCore[43] = ms_riscv32_mp_rc_in_17_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_17_toCore[44] = ms_riscv32_mp_rc_in_17_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_17_toCore[45] = ms_riscv32_mp_rc_in_17_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_17_toCore[46] = ms_riscv32_mp_rc_in_17_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_17_toCore[47] = ms_riscv32_mp_rc_in_17_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_17_toCore[48] = ms_riscv32_mp_rc_in_17_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_17_toCore[49] = ms_riscv32_mp_rc_in_17_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_17_toCore[50] = ms_riscv32_mp_rc_in_17_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_17_toCore[51] = ms_riscv32_mp_rc_in_17_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_17_toCore[52] = ms_riscv32_mp_rc_in_17_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_17_toCore[53] = ms_riscv32_mp_rc_in_17_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_17_toCore[54] = ms_riscv32_mp_rc_in_17_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_17_toCore[55] = ms_riscv32_mp_rc_in_17_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_17_toCore[56] = ms_riscv32_mp_rc_in_17_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_17_toCore[57] = ms_riscv32_mp_rc_in_17_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_17_toCore[58] = ms_riscv32_mp_rc_in_17_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_17_toCore[59] = ms_riscv32_mp_rc_in_17_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_17_toCore[60] = ms_riscv32_mp_rc_in_17_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_17_toCore[61] = ms_riscv32_mp_rc_in_17_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_17_toCore[62] = ms_riscv32_mp_rc_in_17_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_17_toCore[63] = ms_riscv32_mp_rc_in_17_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[0] = ms_riscv32_mp_rc_in_16_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[1] = ms_riscv32_mp_rc_in_16_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[2] = ms_riscv32_mp_rc_in_16_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[3] = ms_riscv32_mp_rc_in_16_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[4] = ms_riscv32_mp_rc_in_16_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[5] = ms_riscv32_mp_rc_in_16_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[6] = ms_riscv32_mp_rc_in_16_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[7] = ms_riscv32_mp_rc_in_16_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[8] = ms_riscv32_mp_rc_in_16_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[9] = ms_riscv32_mp_rc_in_16_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[10] = ms_riscv32_mp_rc_in_16_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[11] = ms_riscv32_mp_rc_in_16_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[12] = ms_riscv32_mp_rc_in_16_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[13] = ms_riscv32_mp_rc_in_16_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[14] = ms_riscv32_mp_rc_in_16_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[15] = ms_riscv32_mp_rc_in_16_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[17] = ms_riscv32_mp_rc_in_16_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[18] = ms_riscv32_mp_rc_in_16_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[19] = ms_riscv32_mp_rc_in_16_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[20] = ms_riscv32_mp_rc_in_16_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[21] = ms_riscv32_mp_rc_in_16_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[22] = ms_riscv32_mp_rc_in_16_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[23] = ms_riscv32_mp_rc_in_16_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[24] = ms_riscv32_mp_rc_in_16_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[25] = ms_riscv32_mp_rc_in_16_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[26] = ms_riscv32_mp_rc_in_16_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[27] = ms_riscv32_mp_rc_in_16_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[28] = ms_riscv32_mp_rc_in_16_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[29] = ms_riscv32_mp_rc_in_16_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[30] = ms_riscv32_mp_rc_in_16_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[31] = ms_riscv32_mp_rc_in_16_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[32] = ms_riscv32_mp_rc_in_16_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[33] = ms_riscv32_mp_rc_in_16_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[34] = ms_riscv32_mp_rc_in_16_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[35] = ms_riscv32_mp_rc_in_16_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[36] = ms_riscv32_mp_rc_in_16_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[37] = ms_riscv32_mp_rc_in_16_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[38] = ms_riscv32_mp_rc_in_16_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[39] = ms_riscv32_mp_rc_in_16_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[40] = ms_riscv32_mp_rc_in_16_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[41] = ms_riscv32_mp_rc_in_16_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[42] = ms_riscv32_mp_rc_in_16_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[43] = ms_riscv32_mp_rc_in_16_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[44] = ms_riscv32_mp_rc_in_16_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[45] = ms_riscv32_mp_rc_in_16_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[46] = ms_riscv32_mp_rc_in_16_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[47] = ms_riscv32_mp_rc_in_16_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[48] = ms_riscv32_mp_rc_in_16_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[49] = ms_riscv32_mp_rc_in_16_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[50] = ms_riscv32_mp_rc_in_16_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[51] = ms_riscv32_mp_rc_in_16_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[52] = ms_riscv32_mp_rc_in_16_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[53] = ms_riscv32_mp_rc_in_16_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[54] = ms_riscv32_mp_rc_in_16_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[55] = ms_riscv32_mp_rc_in_16_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[56] = ms_riscv32_mp_rc_in_16_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[57] = ms_riscv32_mp_rc_in_16_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[58] = ms_riscv32_mp_rc_in_16_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[59] = ms_riscv32_mp_rc_in_16_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[60] = ms_riscv32_mp_rc_in_16_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[61] = ms_riscv32_mp_rc_in_16_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[62] = ms_riscv32_mp_rc_in_16_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_17_toCore_ts1[63] = ms_riscv32_mp_rc_in_16_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_15_toCore[0] = ms_riscv32_mp_rc_in_15_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_15_toCore[1] = ms_riscv32_mp_rc_in_15_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_15_toCore[2] = ms_riscv32_mp_rc_in_15_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_15_toCore[3] = ms_riscv32_mp_rc_in_15_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_15_toCore[4] = ms_riscv32_mp_rc_in_15_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_15_toCore[5] = ms_riscv32_mp_rc_in_15_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_15_toCore[6] = ms_riscv32_mp_rc_in_15_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_15_toCore[7] = ms_riscv32_mp_rc_in_15_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_15_toCore[8] = ms_riscv32_mp_rc_in_15_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_15_toCore[9] = ms_riscv32_mp_rc_in_15_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_15_toCore[10] = ms_riscv32_mp_rc_in_15_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_15_toCore[11] = ms_riscv32_mp_rc_in_15_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_15_toCore[12] = ms_riscv32_mp_rc_in_15_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_15_toCore[13] = ms_riscv32_mp_rc_in_15_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_15_toCore[14] = ms_riscv32_mp_rc_in_15_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_15_toCore[16] = ms_riscv32_mp_rc_in_15_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_15_toCore[17] = ms_riscv32_mp_rc_in_15_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_15_toCore[18] = ms_riscv32_mp_rc_in_15_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_15_toCore[19] = ms_riscv32_mp_rc_in_15_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_15_toCore[20] = ms_riscv32_mp_rc_in_15_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_15_toCore[21] = ms_riscv32_mp_rc_in_15_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_15_toCore[22] = ms_riscv32_mp_rc_in_15_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_15_toCore[23] = ms_riscv32_mp_rc_in_15_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_15_toCore[24] = ms_riscv32_mp_rc_in_15_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_15_toCore[25] = ms_riscv32_mp_rc_in_15_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_15_toCore[26] = ms_riscv32_mp_rc_in_15_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_15_toCore[27] = ms_riscv32_mp_rc_in_15_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_15_toCore[28] = ms_riscv32_mp_rc_in_15_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_15_toCore[29] = ms_riscv32_mp_rc_in_15_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_15_toCore[30] = ms_riscv32_mp_rc_in_15_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_15_toCore[31] = ms_riscv32_mp_rc_in_15_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_15_toCore[32] = ms_riscv32_mp_rc_in_15_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_15_toCore[33] = ms_riscv32_mp_rc_in_15_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_15_toCore[34] = ms_riscv32_mp_rc_in_15_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_15_toCore[35] = ms_riscv32_mp_rc_in_15_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_15_toCore[36] = ms_riscv32_mp_rc_in_15_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_15_toCore[37] = ms_riscv32_mp_rc_in_15_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_15_toCore[38] = ms_riscv32_mp_rc_in_15_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_15_toCore[39] = ms_riscv32_mp_rc_in_15_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_15_toCore[40] = ms_riscv32_mp_rc_in_15_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_15_toCore[41] = ms_riscv32_mp_rc_in_15_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_15_toCore[42] = ms_riscv32_mp_rc_in_15_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_15_toCore[43] = ms_riscv32_mp_rc_in_15_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_15_toCore[44] = ms_riscv32_mp_rc_in_15_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_15_toCore[45] = ms_riscv32_mp_rc_in_15_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_15_toCore[46] = ms_riscv32_mp_rc_in_15_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_15_toCore[47] = ms_riscv32_mp_rc_in_15_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_15_toCore[48] = ms_riscv32_mp_rc_in_15_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_15_toCore[49] = ms_riscv32_mp_rc_in_15_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_15_toCore[50] = ms_riscv32_mp_rc_in_15_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_15_toCore[51] = ms_riscv32_mp_rc_in_15_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_15_toCore[52] = ms_riscv32_mp_rc_in_15_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_15_toCore[53] = ms_riscv32_mp_rc_in_15_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_15_toCore[54] = ms_riscv32_mp_rc_in_15_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_15_toCore[55] = ms_riscv32_mp_rc_in_15_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_15_toCore[56] = ms_riscv32_mp_rc_in_15_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_15_toCore[57] = ms_riscv32_mp_rc_in_15_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_15_toCore[58] = ms_riscv32_mp_rc_in_15_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_15_toCore[59] = ms_riscv32_mp_rc_in_15_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_15_toCore[60] = ms_riscv32_mp_rc_in_15_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_15_toCore[61] = ms_riscv32_mp_rc_in_15_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_15_toCore[62] = ms_riscv32_mp_rc_in_15_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_15_toCore[63] = ms_riscv32_mp_rc_in_15_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[0] = ms_riscv32_mp_rc_in_14_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[1] = ms_riscv32_mp_rc_in_14_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[2] = ms_riscv32_mp_rc_in_14_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[3] = ms_riscv32_mp_rc_in_14_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[4] = ms_riscv32_mp_rc_in_14_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[5] = ms_riscv32_mp_rc_in_14_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[6] = ms_riscv32_mp_rc_in_14_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[7] = ms_riscv32_mp_rc_in_14_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[8] = ms_riscv32_mp_rc_in_14_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[9] = ms_riscv32_mp_rc_in_14_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[10] = ms_riscv32_mp_rc_in_14_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[11] = ms_riscv32_mp_rc_in_14_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[12] = ms_riscv32_mp_rc_in_14_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[13] = ms_riscv32_mp_rc_in_14_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[15] = ms_riscv32_mp_rc_in_14_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[16] = ms_riscv32_mp_rc_in_14_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[17] = ms_riscv32_mp_rc_in_14_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[18] = ms_riscv32_mp_rc_in_14_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[19] = ms_riscv32_mp_rc_in_14_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[20] = ms_riscv32_mp_rc_in_14_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[21] = ms_riscv32_mp_rc_in_14_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[22] = ms_riscv32_mp_rc_in_14_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[23] = ms_riscv32_mp_rc_in_14_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[24] = ms_riscv32_mp_rc_in_14_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[25] = ms_riscv32_mp_rc_in_14_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[26] = ms_riscv32_mp_rc_in_14_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[27] = ms_riscv32_mp_rc_in_14_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[28] = ms_riscv32_mp_rc_in_14_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[29] = ms_riscv32_mp_rc_in_14_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[30] = ms_riscv32_mp_rc_in_14_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[31] = ms_riscv32_mp_rc_in_14_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[32] = ms_riscv32_mp_rc_in_14_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[33] = ms_riscv32_mp_rc_in_14_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[34] = ms_riscv32_mp_rc_in_14_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[35] = ms_riscv32_mp_rc_in_14_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[36] = ms_riscv32_mp_rc_in_14_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[37] = ms_riscv32_mp_rc_in_14_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[38] = ms_riscv32_mp_rc_in_14_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[39] = ms_riscv32_mp_rc_in_14_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[40] = ms_riscv32_mp_rc_in_14_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[41] = ms_riscv32_mp_rc_in_14_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[42] = ms_riscv32_mp_rc_in_14_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[43] = ms_riscv32_mp_rc_in_14_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[44] = ms_riscv32_mp_rc_in_14_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[45] = ms_riscv32_mp_rc_in_14_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[46] = ms_riscv32_mp_rc_in_14_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[47] = ms_riscv32_mp_rc_in_14_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[48] = ms_riscv32_mp_rc_in_14_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[49] = ms_riscv32_mp_rc_in_14_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[50] = ms_riscv32_mp_rc_in_14_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[51] = ms_riscv32_mp_rc_in_14_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[52] = ms_riscv32_mp_rc_in_14_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[53] = ms_riscv32_mp_rc_in_14_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[54] = ms_riscv32_mp_rc_in_14_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[55] = ms_riscv32_mp_rc_in_14_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[56] = ms_riscv32_mp_rc_in_14_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[57] = ms_riscv32_mp_rc_in_14_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[58] = ms_riscv32_mp_rc_in_14_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[59] = ms_riscv32_mp_rc_in_14_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[60] = ms_riscv32_mp_rc_in_14_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[61] = ms_riscv32_mp_rc_in_14_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[62] = ms_riscv32_mp_rc_in_14_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_15_toCore_ts1[63] = ms_riscv32_mp_rc_in_14_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_13_toCore[0] = ms_riscv32_mp_rc_in_13_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_13_toCore[1] = ms_riscv32_mp_rc_in_13_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_13_toCore[2] = ms_riscv32_mp_rc_in_13_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_13_toCore[3] = ms_riscv32_mp_rc_in_13_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_13_toCore[4] = ms_riscv32_mp_rc_in_13_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_13_toCore[5] = ms_riscv32_mp_rc_in_13_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_13_toCore[6] = ms_riscv32_mp_rc_in_13_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_13_toCore[7] = ms_riscv32_mp_rc_in_13_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_13_toCore[8] = ms_riscv32_mp_rc_in_13_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_13_toCore[9] = ms_riscv32_mp_rc_in_13_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_13_toCore[10] = ms_riscv32_mp_rc_in_13_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_13_toCore[11] = ms_riscv32_mp_rc_in_13_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_13_toCore[12] = ms_riscv32_mp_rc_in_13_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_13_toCore[14] = ms_riscv32_mp_rc_in_13_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_13_toCore[15] = ms_riscv32_mp_rc_in_13_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_13_toCore[16] = ms_riscv32_mp_rc_in_13_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_13_toCore[17] = ms_riscv32_mp_rc_in_13_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_13_toCore[18] = ms_riscv32_mp_rc_in_13_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_13_toCore[19] = ms_riscv32_mp_rc_in_13_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_13_toCore[20] = ms_riscv32_mp_rc_in_13_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_13_toCore[21] = ms_riscv32_mp_rc_in_13_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_13_toCore[22] = ms_riscv32_mp_rc_in_13_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_13_toCore[23] = ms_riscv32_mp_rc_in_13_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_13_toCore[24] = ms_riscv32_mp_rc_in_13_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_13_toCore[25] = ms_riscv32_mp_rc_in_13_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_13_toCore[26] = ms_riscv32_mp_rc_in_13_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_13_toCore[27] = ms_riscv32_mp_rc_in_13_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_13_toCore[28] = ms_riscv32_mp_rc_in_13_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_13_toCore[29] = ms_riscv32_mp_rc_in_13_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_13_toCore[30] = ms_riscv32_mp_rc_in_13_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_13_toCore[31] = ms_riscv32_mp_rc_in_13_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_13_toCore[32] = ms_riscv32_mp_rc_in_13_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_13_toCore[33] = ms_riscv32_mp_rc_in_13_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_13_toCore[34] = ms_riscv32_mp_rc_in_13_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_13_toCore[35] = ms_riscv32_mp_rc_in_13_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_13_toCore[36] = ms_riscv32_mp_rc_in_13_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_13_toCore[37] = ms_riscv32_mp_rc_in_13_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_13_toCore[38] = ms_riscv32_mp_rc_in_13_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_13_toCore[39] = ms_riscv32_mp_rc_in_13_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_13_toCore[40] = ms_riscv32_mp_rc_in_13_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_13_toCore[41] = ms_riscv32_mp_rc_in_13_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_13_toCore[42] = ms_riscv32_mp_rc_in_13_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_13_toCore[43] = ms_riscv32_mp_rc_in_13_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_13_toCore[44] = ms_riscv32_mp_rc_in_13_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_13_toCore[45] = ms_riscv32_mp_rc_in_13_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_13_toCore[46] = ms_riscv32_mp_rc_in_13_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_13_toCore[47] = ms_riscv32_mp_rc_in_13_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_13_toCore[48] = ms_riscv32_mp_rc_in_13_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_13_toCore[49] = ms_riscv32_mp_rc_in_13_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_13_toCore[50] = ms_riscv32_mp_rc_in_13_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_13_toCore[51] = ms_riscv32_mp_rc_in_13_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_13_toCore[52] = ms_riscv32_mp_rc_in_13_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_13_toCore[53] = ms_riscv32_mp_rc_in_13_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_13_toCore[54] = ms_riscv32_mp_rc_in_13_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_13_toCore[55] = ms_riscv32_mp_rc_in_13_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_13_toCore[56] = ms_riscv32_mp_rc_in_13_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_13_toCore[57] = ms_riscv32_mp_rc_in_13_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_13_toCore[58] = ms_riscv32_mp_rc_in_13_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_13_toCore[59] = ms_riscv32_mp_rc_in_13_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_13_toCore[60] = ms_riscv32_mp_rc_in_13_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_13_toCore[61] = ms_riscv32_mp_rc_in_13_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_13_toCore[62] = ms_riscv32_mp_rc_in_13_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_13_toCore[63] = ms_riscv32_mp_rc_in_13_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[0] = ms_riscv32_mp_rc_in_12_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[1] = ms_riscv32_mp_rc_in_12_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[2] = ms_riscv32_mp_rc_in_12_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[3] = ms_riscv32_mp_rc_in_12_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[4] = ms_riscv32_mp_rc_in_12_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[5] = ms_riscv32_mp_rc_in_12_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[6] = ms_riscv32_mp_rc_in_12_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[7] = ms_riscv32_mp_rc_in_12_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[8] = ms_riscv32_mp_rc_in_12_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[9] = ms_riscv32_mp_rc_in_12_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[10] = ms_riscv32_mp_rc_in_12_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[11] = ms_riscv32_mp_rc_in_12_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[13] = ms_riscv32_mp_rc_in_12_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[14] = ms_riscv32_mp_rc_in_12_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[15] = ms_riscv32_mp_rc_in_12_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[16] = ms_riscv32_mp_rc_in_12_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[17] = ms_riscv32_mp_rc_in_12_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[18] = ms_riscv32_mp_rc_in_12_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[19] = ms_riscv32_mp_rc_in_12_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[20] = ms_riscv32_mp_rc_in_12_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[21] = ms_riscv32_mp_rc_in_12_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[22] = ms_riscv32_mp_rc_in_12_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[23] = ms_riscv32_mp_rc_in_12_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[24] = ms_riscv32_mp_rc_in_12_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[25] = ms_riscv32_mp_rc_in_12_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[26] = ms_riscv32_mp_rc_in_12_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[27] = ms_riscv32_mp_rc_in_12_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[28] = ms_riscv32_mp_rc_in_12_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[29] = ms_riscv32_mp_rc_in_12_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[30] = ms_riscv32_mp_rc_in_12_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[31] = ms_riscv32_mp_rc_in_12_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[32] = ms_riscv32_mp_rc_in_12_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[33] = ms_riscv32_mp_rc_in_12_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[34] = ms_riscv32_mp_rc_in_12_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[35] = ms_riscv32_mp_rc_in_12_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[36] = ms_riscv32_mp_rc_in_12_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[37] = ms_riscv32_mp_rc_in_12_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[38] = ms_riscv32_mp_rc_in_12_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[39] = ms_riscv32_mp_rc_in_12_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[40] = ms_riscv32_mp_rc_in_12_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[41] = ms_riscv32_mp_rc_in_12_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[42] = ms_riscv32_mp_rc_in_12_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[43] = ms_riscv32_mp_rc_in_12_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[44] = ms_riscv32_mp_rc_in_12_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[45] = ms_riscv32_mp_rc_in_12_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[46] = ms_riscv32_mp_rc_in_12_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[47] = ms_riscv32_mp_rc_in_12_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[48] = ms_riscv32_mp_rc_in_12_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[49] = ms_riscv32_mp_rc_in_12_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[50] = ms_riscv32_mp_rc_in_12_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[51] = ms_riscv32_mp_rc_in_12_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[52] = ms_riscv32_mp_rc_in_12_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[53] = ms_riscv32_mp_rc_in_12_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[54] = ms_riscv32_mp_rc_in_12_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[55] = ms_riscv32_mp_rc_in_12_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[56] = ms_riscv32_mp_rc_in_12_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[57] = ms_riscv32_mp_rc_in_12_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[58] = ms_riscv32_mp_rc_in_12_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[59] = ms_riscv32_mp_rc_in_12_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[60] = ms_riscv32_mp_rc_in_12_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[61] = ms_riscv32_mp_rc_in_12_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[62] = ms_riscv32_mp_rc_in_12_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_13_toCore_ts1[63] = ms_riscv32_mp_rc_in_12_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_11_toCore[0] = ms_riscv32_mp_rc_in_11_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_11_toCore[1] = ms_riscv32_mp_rc_in_11_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_11_toCore[2] = ms_riscv32_mp_rc_in_11_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_11_toCore[3] = ms_riscv32_mp_rc_in_11_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_11_toCore[4] = ms_riscv32_mp_rc_in_11_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_11_toCore[5] = ms_riscv32_mp_rc_in_11_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_11_toCore[6] = ms_riscv32_mp_rc_in_11_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_11_toCore[7] = ms_riscv32_mp_rc_in_11_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_11_toCore[8] = ms_riscv32_mp_rc_in_11_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_11_toCore[9] = ms_riscv32_mp_rc_in_11_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_11_toCore[10] = ms_riscv32_mp_rc_in_11_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_11_toCore[12] = ms_riscv32_mp_rc_in_11_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_11_toCore[13] = ms_riscv32_mp_rc_in_11_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_11_toCore[14] = ms_riscv32_mp_rc_in_11_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_11_toCore[15] = ms_riscv32_mp_rc_in_11_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_11_toCore[16] = ms_riscv32_mp_rc_in_11_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_11_toCore[17] = ms_riscv32_mp_rc_in_11_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_11_toCore[18] = ms_riscv32_mp_rc_in_11_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_11_toCore[19] = ms_riscv32_mp_rc_in_11_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_11_toCore[20] = ms_riscv32_mp_rc_in_11_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_11_toCore[21] = ms_riscv32_mp_rc_in_11_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_11_toCore[22] = ms_riscv32_mp_rc_in_11_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_11_toCore[23] = ms_riscv32_mp_rc_in_11_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_11_toCore[24] = ms_riscv32_mp_rc_in_11_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_11_toCore[25] = ms_riscv32_mp_rc_in_11_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_11_toCore[26] = ms_riscv32_mp_rc_in_11_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_11_toCore[27] = ms_riscv32_mp_rc_in_11_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_11_toCore[28] = ms_riscv32_mp_rc_in_11_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_11_toCore[29] = ms_riscv32_mp_rc_in_11_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_11_toCore[30] = ms_riscv32_mp_rc_in_11_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_11_toCore[31] = ms_riscv32_mp_rc_in_11_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_11_toCore[32] = ms_riscv32_mp_rc_in_11_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_11_toCore[33] = ms_riscv32_mp_rc_in_11_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_11_toCore[34] = ms_riscv32_mp_rc_in_11_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_11_toCore[35] = ms_riscv32_mp_rc_in_11_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_11_toCore[36] = ms_riscv32_mp_rc_in_11_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_11_toCore[37] = ms_riscv32_mp_rc_in_11_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_11_toCore[38] = ms_riscv32_mp_rc_in_11_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_11_toCore[39] = ms_riscv32_mp_rc_in_11_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_11_toCore[40] = ms_riscv32_mp_rc_in_11_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_11_toCore[41] = ms_riscv32_mp_rc_in_11_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_11_toCore[42] = ms_riscv32_mp_rc_in_11_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_11_toCore[43] = ms_riscv32_mp_rc_in_11_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_11_toCore[44] = ms_riscv32_mp_rc_in_11_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_11_toCore[45] = ms_riscv32_mp_rc_in_11_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_11_toCore[46] = ms_riscv32_mp_rc_in_11_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_11_toCore[47] = ms_riscv32_mp_rc_in_11_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_11_toCore[48] = ms_riscv32_mp_rc_in_11_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_11_toCore[49] = ms_riscv32_mp_rc_in_11_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_11_toCore[50] = ms_riscv32_mp_rc_in_11_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_11_toCore[51] = ms_riscv32_mp_rc_in_11_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_11_toCore[52] = ms_riscv32_mp_rc_in_11_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_11_toCore[53] = ms_riscv32_mp_rc_in_11_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_11_toCore[54] = ms_riscv32_mp_rc_in_11_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_11_toCore[55] = ms_riscv32_mp_rc_in_11_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_11_toCore[56] = ms_riscv32_mp_rc_in_11_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_11_toCore[57] = ms_riscv32_mp_rc_in_11_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_11_toCore[58] = ms_riscv32_mp_rc_in_11_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_11_toCore[59] = ms_riscv32_mp_rc_in_11_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_11_toCore[60] = ms_riscv32_mp_rc_in_11_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_11_toCore[61] = ms_riscv32_mp_rc_in_11_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_11_toCore[62] = ms_riscv32_mp_rc_in_11_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_11_toCore[63] = ms_riscv32_mp_rc_in_11_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[0] = ms_riscv32_mp_rc_in_10_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[1] = ms_riscv32_mp_rc_in_10_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[2] = ms_riscv32_mp_rc_in_10_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[3] = ms_riscv32_mp_rc_in_10_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[4] = ms_riscv32_mp_rc_in_10_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[5] = ms_riscv32_mp_rc_in_10_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[6] = ms_riscv32_mp_rc_in_10_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[7] = ms_riscv32_mp_rc_in_10_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[8] = ms_riscv32_mp_rc_in_10_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[9] = ms_riscv32_mp_rc_in_10_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[11] = ms_riscv32_mp_rc_in_10_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[12] = ms_riscv32_mp_rc_in_10_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[13] = ms_riscv32_mp_rc_in_10_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[14] = ms_riscv32_mp_rc_in_10_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[15] = ms_riscv32_mp_rc_in_10_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[16] = ms_riscv32_mp_rc_in_10_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[17] = ms_riscv32_mp_rc_in_10_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[18] = ms_riscv32_mp_rc_in_10_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[19] = ms_riscv32_mp_rc_in_10_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[20] = ms_riscv32_mp_rc_in_10_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[21] = ms_riscv32_mp_rc_in_10_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[22] = ms_riscv32_mp_rc_in_10_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[23] = ms_riscv32_mp_rc_in_10_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[24] = ms_riscv32_mp_rc_in_10_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[25] = ms_riscv32_mp_rc_in_10_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[26] = ms_riscv32_mp_rc_in_10_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[27] = ms_riscv32_mp_rc_in_10_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[28] = ms_riscv32_mp_rc_in_10_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[29] = ms_riscv32_mp_rc_in_10_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[30] = ms_riscv32_mp_rc_in_10_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[31] = ms_riscv32_mp_rc_in_10_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[32] = ms_riscv32_mp_rc_in_10_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[33] = ms_riscv32_mp_rc_in_10_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[34] = ms_riscv32_mp_rc_in_10_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[35] = ms_riscv32_mp_rc_in_10_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[36] = ms_riscv32_mp_rc_in_10_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[37] = ms_riscv32_mp_rc_in_10_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[38] = ms_riscv32_mp_rc_in_10_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[39] = ms_riscv32_mp_rc_in_10_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[40] = ms_riscv32_mp_rc_in_10_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[41] = ms_riscv32_mp_rc_in_10_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[42] = ms_riscv32_mp_rc_in_10_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[43] = ms_riscv32_mp_rc_in_10_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[44] = ms_riscv32_mp_rc_in_10_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[45] = ms_riscv32_mp_rc_in_10_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[46] = ms_riscv32_mp_rc_in_10_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[47] = ms_riscv32_mp_rc_in_10_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[48] = ms_riscv32_mp_rc_in_10_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[49] = ms_riscv32_mp_rc_in_10_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[50] = ms_riscv32_mp_rc_in_10_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[51] = ms_riscv32_mp_rc_in_10_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[52] = ms_riscv32_mp_rc_in_10_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[53] = ms_riscv32_mp_rc_in_10_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[54] = ms_riscv32_mp_rc_in_10_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[55] = ms_riscv32_mp_rc_in_10_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[56] = ms_riscv32_mp_rc_in_10_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[57] = ms_riscv32_mp_rc_in_10_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[58] = ms_riscv32_mp_rc_in_10_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[59] = ms_riscv32_mp_rc_in_10_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[60] = ms_riscv32_mp_rc_in_10_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[61] = ms_riscv32_mp_rc_in_10_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[62] = ms_riscv32_mp_rc_in_10_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_11_toCore_ts1[63] = ms_riscv32_mp_rc_in_10_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_9_toCore[0] = ms_riscv32_mp_rc_in_9_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_9_toCore[1] = ms_riscv32_mp_rc_in_9_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_9_toCore[2] = ms_riscv32_mp_rc_in_9_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_9_toCore[3] = ms_riscv32_mp_rc_in_9_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_9_toCore[4] = ms_riscv32_mp_rc_in_9_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_9_toCore[5] = ms_riscv32_mp_rc_in_9_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_9_toCore[6] = ms_riscv32_mp_rc_in_9_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_9_toCore[7] = ms_riscv32_mp_rc_in_9_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_9_toCore[8] = ms_riscv32_mp_rc_in_9_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_9_toCore[10] = ms_riscv32_mp_rc_in_9_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_9_toCore[11] = ms_riscv32_mp_rc_in_9_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_9_toCore[12] = ms_riscv32_mp_rc_in_9_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_9_toCore[13] = ms_riscv32_mp_rc_in_9_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_9_toCore[14] = ms_riscv32_mp_rc_in_9_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_9_toCore[15] = ms_riscv32_mp_rc_in_9_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_9_toCore[16] = ms_riscv32_mp_rc_in_9_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_9_toCore[17] = ms_riscv32_mp_rc_in_9_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_9_toCore[18] = ms_riscv32_mp_rc_in_9_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_9_toCore[19] = ms_riscv32_mp_rc_in_9_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_9_toCore[20] = ms_riscv32_mp_rc_in_9_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_9_toCore[21] = ms_riscv32_mp_rc_in_9_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_9_toCore[22] = ms_riscv32_mp_rc_in_9_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_9_toCore[23] = ms_riscv32_mp_rc_in_9_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_9_toCore[24] = ms_riscv32_mp_rc_in_9_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_9_toCore[25] = ms_riscv32_mp_rc_in_9_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_9_toCore[26] = ms_riscv32_mp_rc_in_9_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_9_toCore[27] = ms_riscv32_mp_rc_in_9_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_9_toCore[28] = ms_riscv32_mp_rc_in_9_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_9_toCore[29] = ms_riscv32_mp_rc_in_9_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_9_toCore[30] = ms_riscv32_mp_rc_in_9_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_9_toCore[31] = ms_riscv32_mp_rc_in_9_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_9_toCore[32] = ms_riscv32_mp_rc_in_9_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_9_toCore[33] = ms_riscv32_mp_rc_in_9_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_9_toCore[34] = ms_riscv32_mp_rc_in_9_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_9_toCore[35] = ms_riscv32_mp_rc_in_9_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_9_toCore[36] = ms_riscv32_mp_rc_in_9_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_9_toCore[37] = ms_riscv32_mp_rc_in_9_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_9_toCore[38] = ms_riscv32_mp_rc_in_9_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_9_toCore[39] = ms_riscv32_mp_rc_in_9_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_9_toCore[40] = ms_riscv32_mp_rc_in_9_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_9_toCore[41] = ms_riscv32_mp_rc_in_9_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_9_toCore[42] = ms_riscv32_mp_rc_in_9_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_9_toCore[43] = ms_riscv32_mp_rc_in_9_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_9_toCore[44] = ms_riscv32_mp_rc_in_9_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_9_toCore[45] = ms_riscv32_mp_rc_in_9_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_9_toCore[46] = ms_riscv32_mp_rc_in_9_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_9_toCore[47] = ms_riscv32_mp_rc_in_9_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_9_toCore[48] = ms_riscv32_mp_rc_in_9_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_9_toCore[49] = ms_riscv32_mp_rc_in_9_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_9_toCore[50] = ms_riscv32_mp_rc_in_9_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_9_toCore[51] = ms_riscv32_mp_rc_in_9_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_9_toCore[52] = ms_riscv32_mp_rc_in_9_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_9_toCore[53] = ms_riscv32_mp_rc_in_9_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_9_toCore[54] = ms_riscv32_mp_rc_in_9_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_9_toCore[55] = ms_riscv32_mp_rc_in_9_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_9_toCore[56] = ms_riscv32_mp_rc_in_9_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_9_toCore[57] = ms_riscv32_mp_rc_in_9_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_9_toCore[58] = ms_riscv32_mp_rc_in_9_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_9_toCore[59] = ms_riscv32_mp_rc_in_9_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_9_toCore[60] = ms_riscv32_mp_rc_in_9_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_9_toCore[61] = ms_riscv32_mp_rc_in_9_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_9_toCore[62] = ms_riscv32_mp_rc_in_9_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_9_toCore[63] = ms_riscv32_mp_rc_in_9_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[0] = ms_riscv32_mp_rc_in_8_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[1] = ms_riscv32_mp_rc_in_8_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[2] = ms_riscv32_mp_rc_in_8_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[3] = ms_riscv32_mp_rc_in_8_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[4] = ms_riscv32_mp_rc_in_8_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[5] = ms_riscv32_mp_rc_in_8_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[6] = ms_riscv32_mp_rc_in_8_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[7] = ms_riscv32_mp_rc_in_8_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[9] = ms_riscv32_mp_rc_in_8_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[10] = ms_riscv32_mp_rc_in_8_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[11] = ms_riscv32_mp_rc_in_8_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[12] = ms_riscv32_mp_rc_in_8_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[13] = ms_riscv32_mp_rc_in_8_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[14] = ms_riscv32_mp_rc_in_8_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[15] = ms_riscv32_mp_rc_in_8_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[16] = ms_riscv32_mp_rc_in_8_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[17] = ms_riscv32_mp_rc_in_8_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[18] = ms_riscv32_mp_rc_in_8_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[19] = ms_riscv32_mp_rc_in_8_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[20] = ms_riscv32_mp_rc_in_8_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[21] = ms_riscv32_mp_rc_in_8_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[22] = ms_riscv32_mp_rc_in_8_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[23] = ms_riscv32_mp_rc_in_8_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[24] = ms_riscv32_mp_rc_in_8_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[25] = ms_riscv32_mp_rc_in_8_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[26] = ms_riscv32_mp_rc_in_8_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[27] = ms_riscv32_mp_rc_in_8_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[28] = ms_riscv32_mp_rc_in_8_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[29] = ms_riscv32_mp_rc_in_8_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[30] = ms_riscv32_mp_rc_in_8_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[31] = ms_riscv32_mp_rc_in_8_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[32] = ms_riscv32_mp_rc_in_8_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[33] = ms_riscv32_mp_rc_in_8_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[34] = ms_riscv32_mp_rc_in_8_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[35] = ms_riscv32_mp_rc_in_8_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[36] = ms_riscv32_mp_rc_in_8_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[37] = ms_riscv32_mp_rc_in_8_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[38] = ms_riscv32_mp_rc_in_8_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[39] = ms_riscv32_mp_rc_in_8_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[40] = ms_riscv32_mp_rc_in_8_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[41] = ms_riscv32_mp_rc_in_8_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[42] = ms_riscv32_mp_rc_in_8_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[43] = ms_riscv32_mp_rc_in_8_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[44] = ms_riscv32_mp_rc_in_8_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[45] = ms_riscv32_mp_rc_in_8_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[46] = ms_riscv32_mp_rc_in_8_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[47] = ms_riscv32_mp_rc_in_8_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[48] = ms_riscv32_mp_rc_in_8_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[49] = ms_riscv32_mp_rc_in_8_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[50] = ms_riscv32_mp_rc_in_8_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[51] = ms_riscv32_mp_rc_in_8_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[52] = ms_riscv32_mp_rc_in_8_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[53] = ms_riscv32_mp_rc_in_8_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[54] = ms_riscv32_mp_rc_in_8_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[55] = ms_riscv32_mp_rc_in_8_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[56] = ms_riscv32_mp_rc_in_8_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[57] = ms_riscv32_mp_rc_in_8_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[58] = ms_riscv32_mp_rc_in_8_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[59] = ms_riscv32_mp_rc_in_8_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[60] = ms_riscv32_mp_rc_in_8_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[61] = ms_riscv32_mp_rc_in_8_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[62] = ms_riscv32_mp_rc_in_8_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_9_toCore_ts1[63] = ms_riscv32_mp_rc_in_8_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_7_toCore[0] = ms_riscv32_mp_rc_in_7_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_7_toCore[1] = ms_riscv32_mp_rc_in_7_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_7_toCore[2] = ms_riscv32_mp_rc_in_7_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_7_toCore[3] = ms_riscv32_mp_rc_in_7_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_7_toCore[4] = ms_riscv32_mp_rc_in_7_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_7_toCore[5] = ms_riscv32_mp_rc_in_7_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_7_toCore[6] = ms_riscv32_mp_rc_in_7_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_7_toCore[8] = ms_riscv32_mp_rc_in_7_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_7_toCore[9] = ms_riscv32_mp_rc_in_7_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_7_toCore[10] = ms_riscv32_mp_rc_in_7_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_7_toCore[11] = ms_riscv32_mp_rc_in_7_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_7_toCore[12] = ms_riscv32_mp_rc_in_7_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_7_toCore[13] = ms_riscv32_mp_rc_in_7_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_7_toCore[14] = ms_riscv32_mp_rc_in_7_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_7_toCore[15] = ms_riscv32_mp_rc_in_7_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_7_toCore[16] = ms_riscv32_mp_rc_in_7_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_7_toCore[17] = ms_riscv32_mp_rc_in_7_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_7_toCore[18] = ms_riscv32_mp_rc_in_7_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_7_toCore[19] = ms_riscv32_mp_rc_in_7_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_7_toCore[20] = ms_riscv32_mp_rc_in_7_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_7_toCore[21] = ms_riscv32_mp_rc_in_7_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_7_toCore[22] = ms_riscv32_mp_rc_in_7_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_7_toCore[23] = ms_riscv32_mp_rc_in_7_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_7_toCore[24] = ms_riscv32_mp_rc_in_7_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_7_toCore[25] = ms_riscv32_mp_rc_in_7_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_7_toCore[26] = ms_riscv32_mp_rc_in_7_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_7_toCore[27] = ms_riscv32_mp_rc_in_7_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_7_toCore[28] = ms_riscv32_mp_rc_in_7_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_7_toCore[29] = ms_riscv32_mp_rc_in_7_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_7_toCore[30] = ms_riscv32_mp_rc_in_7_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_7_toCore[31] = ms_riscv32_mp_rc_in_7_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_7_toCore[32] = ms_riscv32_mp_rc_in_7_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_7_toCore[33] = ms_riscv32_mp_rc_in_7_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_7_toCore[34] = ms_riscv32_mp_rc_in_7_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_7_toCore[35] = ms_riscv32_mp_rc_in_7_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_7_toCore[36] = ms_riscv32_mp_rc_in_7_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_7_toCore[37] = ms_riscv32_mp_rc_in_7_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_7_toCore[38] = ms_riscv32_mp_rc_in_7_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_7_toCore[39] = ms_riscv32_mp_rc_in_7_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_7_toCore[40] = ms_riscv32_mp_rc_in_7_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_7_toCore[41] = ms_riscv32_mp_rc_in_7_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_7_toCore[42] = ms_riscv32_mp_rc_in_7_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_7_toCore[43] = ms_riscv32_mp_rc_in_7_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_7_toCore[44] = ms_riscv32_mp_rc_in_7_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_7_toCore[45] = ms_riscv32_mp_rc_in_7_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_7_toCore[46] = ms_riscv32_mp_rc_in_7_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_7_toCore[47] = ms_riscv32_mp_rc_in_7_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_7_toCore[48] = ms_riscv32_mp_rc_in_7_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_7_toCore[49] = ms_riscv32_mp_rc_in_7_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_7_toCore[50] = ms_riscv32_mp_rc_in_7_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_7_toCore[51] = ms_riscv32_mp_rc_in_7_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_7_toCore[52] = ms_riscv32_mp_rc_in_7_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_7_toCore[53] = ms_riscv32_mp_rc_in_7_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_7_toCore[54] = ms_riscv32_mp_rc_in_7_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_7_toCore[55] = ms_riscv32_mp_rc_in_7_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_7_toCore[56] = ms_riscv32_mp_rc_in_7_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_7_toCore[57] = ms_riscv32_mp_rc_in_7_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_7_toCore[58] = ms_riscv32_mp_rc_in_7_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_7_toCore[59] = ms_riscv32_mp_rc_in_7_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_7_toCore[60] = ms_riscv32_mp_rc_in_7_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_7_toCore[61] = ms_riscv32_mp_rc_in_7_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_7_toCore[62] = ms_riscv32_mp_rc_in_7_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_7_toCore[63] = ms_riscv32_mp_rc_in_7_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[0] = ms_riscv32_mp_rc_in_6_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[1] = ms_riscv32_mp_rc_in_6_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[2] = ms_riscv32_mp_rc_in_6_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[3] = ms_riscv32_mp_rc_in_6_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[4] = ms_riscv32_mp_rc_in_6_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[5] = ms_riscv32_mp_rc_in_6_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[7] = ms_riscv32_mp_rc_in_6_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[8] = ms_riscv32_mp_rc_in_6_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[9] = ms_riscv32_mp_rc_in_6_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[10] = ms_riscv32_mp_rc_in_6_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[11] = ms_riscv32_mp_rc_in_6_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[12] = ms_riscv32_mp_rc_in_6_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[13] = ms_riscv32_mp_rc_in_6_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[14] = ms_riscv32_mp_rc_in_6_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[15] = ms_riscv32_mp_rc_in_6_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[16] = ms_riscv32_mp_rc_in_6_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[17] = ms_riscv32_mp_rc_in_6_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[18] = ms_riscv32_mp_rc_in_6_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[19] = ms_riscv32_mp_rc_in_6_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[20] = ms_riscv32_mp_rc_in_6_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[21] = ms_riscv32_mp_rc_in_6_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[22] = ms_riscv32_mp_rc_in_6_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[23] = ms_riscv32_mp_rc_in_6_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[24] = ms_riscv32_mp_rc_in_6_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[25] = ms_riscv32_mp_rc_in_6_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[26] = ms_riscv32_mp_rc_in_6_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[27] = ms_riscv32_mp_rc_in_6_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[28] = ms_riscv32_mp_rc_in_6_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[29] = ms_riscv32_mp_rc_in_6_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[30] = ms_riscv32_mp_rc_in_6_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[31] = ms_riscv32_mp_rc_in_6_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[32] = ms_riscv32_mp_rc_in_6_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[33] = ms_riscv32_mp_rc_in_6_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[34] = ms_riscv32_mp_rc_in_6_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[35] = ms_riscv32_mp_rc_in_6_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[36] = ms_riscv32_mp_rc_in_6_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[37] = ms_riscv32_mp_rc_in_6_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[38] = ms_riscv32_mp_rc_in_6_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[39] = ms_riscv32_mp_rc_in_6_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[40] = ms_riscv32_mp_rc_in_6_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[41] = ms_riscv32_mp_rc_in_6_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[42] = ms_riscv32_mp_rc_in_6_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[43] = ms_riscv32_mp_rc_in_6_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[44] = ms_riscv32_mp_rc_in_6_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[45] = ms_riscv32_mp_rc_in_6_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[46] = ms_riscv32_mp_rc_in_6_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[47] = ms_riscv32_mp_rc_in_6_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[48] = ms_riscv32_mp_rc_in_6_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[49] = ms_riscv32_mp_rc_in_6_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[50] = ms_riscv32_mp_rc_in_6_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[51] = ms_riscv32_mp_rc_in_6_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[52] = ms_riscv32_mp_rc_in_6_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[53] = ms_riscv32_mp_rc_in_6_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[54] = ms_riscv32_mp_rc_in_6_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[55] = ms_riscv32_mp_rc_in_6_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[56] = ms_riscv32_mp_rc_in_6_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[57] = ms_riscv32_mp_rc_in_6_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[58] = ms_riscv32_mp_rc_in_6_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[59] = ms_riscv32_mp_rc_in_6_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[60] = ms_riscv32_mp_rc_in_6_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[61] = ms_riscv32_mp_rc_in_6_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[62] = ms_riscv32_mp_rc_in_6_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_7_toCore_ts1[63] = ms_riscv32_mp_rc_in_6_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_5_toCore[0] = ms_riscv32_mp_rc_in_5_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_5_toCore[1] = ms_riscv32_mp_rc_in_5_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_5_toCore[2] = ms_riscv32_mp_rc_in_5_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_5_toCore[3] = ms_riscv32_mp_rc_in_5_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_5_toCore[4] = ms_riscv32_mp_rc_in_5_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_5_toCore[6] = ms_riscv32_mp_rc_in_5_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_5_toCore[7] = ms_riscv32_mp_rc_in_5_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_5_toCore[8] = ms_riscv32_mp_rc_in_5_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_5_toCore[9] = ms_riscv32_mp_rc_in_5_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_5_toCore[10] = ms_riscv32_mp_rc_in_5_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_5_toCore[11] = ms_riscv32_mp_rc_in_5_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_5_toCore[12] = ms_riscv32_mp_rc_in_5_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_5_toCore[13] = ms_riscv32_mp_rc_in_5_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_5_toCore[14] = ms_riscv32_mp_rc_in_5_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_5_toCore[15] = ms_riscv32_mp_rc_in_5_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_5_toCore[16] = ms_riscv32_mp_rc_in_5_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_5_toCore[17] = ms_riscv32_mp_rc_in_5_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_5_toCore[18] = ms_riscv32_mp_rc_in_5_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_5_toCore[19] = ms_riscv32_mp_rc_in_5_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_5_toCore[20] = ms_riscv32_mp_rc_in_5_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_5_toCore[21] = ms_riscv32_mp_rc_in_5_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_5_toCore[22] = ms_riscv32_mp_rc_in_5_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_5_toCore[23] = ms_riscv32_mp_rc_in_5_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_5_toCore[24] = ms_riscv32_mp_rc_in_5_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_5_toCore[25] = ms_riscv32_mp_rc_in_5_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_5_toCore[26] = ms_riscv32_mp_rc_in_5_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_5_toCore[27] = ms_riscv32_mp_rc_in_5_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_5_toCore[28] = ms_riscv32_mp_rc_in_5_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_5_toCore[29] = ms_riscv32_mp_rc_in_5_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_5_toCore[30] = ms_riscv32_mp_rc_in_5_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_5_toCore[31] = ms_riscv32_mp_rc_in_5_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_5_toCore[32] = ms_riscv32_mp_rc_in_5_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_5_toCore[33] = ms_riscv32_mp_rc_in_5_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_5_toCore[34] = ms_riscv32_mp_rc_in_5_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_5_toCore[35] = ms_riscv32_mp_rc_in_5_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_5_toCore[36] = ms_riscv32_mp_rc_in_5_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_5_toCore[37] = ms_riscv32_mp_rc_in_5_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_5_toCore[38] = ms_riscv32_mp_rc_in_5_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_5_toCore[39] = ms_riscv32_mp_rc_in_5_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_5_toCore[40] = ms_riscv32_mp_rc_in_5_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_5_toCore[41] = ms_riscv32_mp_rc_in_5_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_5_toCore[42] = ms_riscv32_mp_rc_in_5_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_5_toCore[43] = ms_riscv32_mp_rc_in_5_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_5_toCore[44] = ms_riscv32_mp_rc_in_5_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_5_toCore[45] = ms_riscv32_mp_rc_in_5_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_5_toCore[46] = ms_riscv32_mp_rc_in_5_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_5_toCore[47] = ms_riscv32_mp_rc_in_5_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_5_toCore[48] = ms_riscv32_mp_rc_in_5_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_5_toCore[49] = ms_riscv32_mp_rc_in_5_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_5_toCore[50] = ms_riscv32_mp_rc_in_5_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_5_toCore[51] = ms_riscv32_mp_rc_in_5_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_5_toCore[52] = ms_riscv32_mp_rc_in_5_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_5_toCore[53] = ms_riscv32_mp_rc_in_5_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_5_toCore[54] = ms_riscv32_mp_rc_in_5_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_5_toCore[55] = ms_riscv32_mp_rc_in_5_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_5_toCore[56] = ms_riscv32_mp_rc_in_5_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_5_toCore[57] = ms_riscv32_mp_rc_in_5_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_5_toCore[58] = ms_riscv32_mp_rc_in_5_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_5_toCore[59] = ms_riscv32_mp_rc_in_5_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_5_toCore[60] = ms_riscv32_mp_rc_in_5_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_5_toCore[61] = ms_riscv32_mp_rc_in_5_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_5_toCore[62] = ms_riscv32_mp_rc_in_5_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_5_toCore[63] = ms_riscv32_mp_rc_in_5_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[0] = ms_riscv32_mp_rc_in_4_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[1] = ms_riscv32_mp_rc_in_4_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[2] = ms_riscv32_mp_rc_in_4_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[3] = ms_riscv32_mp_rc_in_4_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[5] = ms_riscv32_mp_rc_in_4_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[6] = ms_riscv32_mp_rc_in_4_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[7] = ms_riscv32_mp_rc_in_4_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[8] = ms_riscv32_mp_rc_in_4_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[9] = ms_riscv32_mp_rc_in_4_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[10] = ms_riscv32_mp_rc_in_4_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[11] = ms_riscv32_mp_rc_in_4_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[12] = ms_riscv32_mp_rc_in_4_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[13] = ms_riscv32_mp_rc_in_4_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[14] = ms_riscv32_mp_rc_in_4_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[15] = ms_riscv32_mp_rc_in_4_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[16] = ms_riscv32_mp_rc_in_4_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[17] = ms_riscv32_mp_rc_in_4_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[18] = ms_riscv32_mp_rc_in_4_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[19] = ms_riscv32_mp_rc_in_4_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[20] = ms_riscv32_mp_rc_in_4_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[21] = ms_riscv32_mp_rc_in_4_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[22] = ms_riscv32_mp_rc_in_4_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[23] = ms_riscv32_mp_rc_in_4_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[24] = ms_riscv32_mp_rc_in_4_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[25] = ms_riscv32_mp_rc_in_4_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[26] = ms_riscv32_mp_rc_in_4_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[27] = ms_riscv32_mp_rc_in_4_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[28] = ms_riscv32_mp_rc_in_4_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[29] = ms_riscv32_mp_rc_in_4_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[30] = ms_riscv32_mp_rc_in_4_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[31] = ms_riscv32_mp_rc_in_4_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[32] = ms_riscv32_mp_rc_in_4_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[33] = ms_riscv32_mp_rc_in_4_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[34] = ms_riscv32_mp_rc_in_4_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[35] = ms_riscv32_mp_rc_in_4_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[36] = ms_riscv32_mp_rc_in_4_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[37] = ms_riscv32_mp_rc_in_4_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[38] = ms_riscv32_mp_rc_in_4_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[39] = ms_riscv32_mp_rc_in_4_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[40] = ms_riscv32_mp_rc_in_4_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[41] = ms_riscv32_mp_rc_in_4_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[42] = ms_riscv32_mp_rc_in_4_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[43] = ms_riscv32_mp_rc_in_4_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[44] = ms_riscv32_mp_rc_in_4_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[45] = ms_riscv32_mp_rc_in_4_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[46] = ms_riscv32_mp_rc_in_4_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[47] = ms_riscv32_mp_rc_in_4_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[48] = ms_riscv32_mp_rc_in_4_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[49] = ms_riscv32_mp_rc_in_4_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[50] = ms_riscv32_mp_rc_in_4_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[51] = ms_riscv32_mp_rc_in_4_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[52] = ms_riscv32_mp_rc_in_4_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[53] = ms_riscv32_mp_rc_in_4_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[54] = ms_riscv32_mp_rc_in_4_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[55] = ms_riscv32_mp_rc_in_4_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[56] = ms_riscv32_mp_rc_in_4_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[57] = ms_riscv32_mp_rc_in_4_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[58] = ms_riscv32_mp_rc_in_4_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[59] = ms_riscv32_mp_rc_in_4_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[60] = ms_riscv32_mp_rc_in_4_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[61] = ms_riscv32_mp_rc_in_4_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[62] = ms_riscv32_mp_rc_in_4_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_5_toCore_ts1[63] = ms_riscv32_mp_rc_in_4_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_3_toCore[0] = ms_riscv32_mp_rc_in_3_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_3_toCore[1] = ms_riscv32_mp_rc_in_3_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_3_toCore[2] = ms_riscv32_mp_rc_in_3_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_3_toCore[4] = ms_riscv32_mp_rc_in_3_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_3_toCore[5] = ms_riscv32_mp_rc_in_3_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_3_toCore[6] = ms_riscv32_mp_rc_in_3_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_3_toCore[7] = ms_riscv32_mp_rc_in_3_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_3_toCore[8] = ms_riscv32_mp_rc_in_3_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_3_toCore[9] = ms_riscv32_mp_rc_in_3_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_3_toCore[10] = ms_riscv32_mp_rc_in_3_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_3_toCore[11] = ms_riscv32_mp_rc_in_3_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_3_toCore[12] = ms_riscv32_mp_rc_in_3_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_3_toCore[13] = ms_riscv32_mp_rc_in_3_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_3_toCore[14] = ms_riscv32_mp_rc_in_3_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_3_toCore[15] = ms_riscv32_mp_rc_in_3_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_3_toCore[16] = ms_riscv32_mp_rc_in_3_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_3_toCore[17] = ms_riscv32_mp_rc_in_3_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_3_toCore[18] = ms_riscv32_mp_rc_in_3_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_3_toCore[19] = ms_riscv32_mp_rc_in_3_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_3_toCore[20] = ms_riscv32_mp_rc_in_3_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_3_toCore[21] = ms_riscv32_mp_rc_in_3_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_3_toCore[22] = ms_riscv32_mp_rc_in_3_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_3_toCore[23] = ms_riscv32_mp_rc_in_3_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_3_toCore[24] = ms_riscv32_mp_rc_in_3_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_3_toCore[25] = ms_riscv32_mp_rc_in_3_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_3_toCore[26] = ms_riscv32_mp_rc_in_3_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_3_toCore[27] = ms_riscv32_mp_rc_in_3_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_3_toCore[28] = ms_riscv32_mp_rc_in_3_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_3_toCore[29] = ms_riscv32_mp_rc_in_3_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_3_toCore[30] = ms_riscv32_mp_rc_in_3_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_3_toCore[31] = ms_riscv32_mp_rc_in_3_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_3_toCore[32] = ms_riscv32_mp_rc_in_3_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_3_toCore[33] = ms_riscv32_mp_rc_in_3_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_3_toCore[34] = ms_riscv32_mp_rc_in_3_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_3_toCore[35] = ms_riscv32_mp_rc_in_3_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_3_toCore[36] = ms_riscv32_mp_rc_in_3_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_3_toCore[37] = ms_riscv32_mp_rc_in_3_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_3_toCore[38] = ms_riscv32_mp_rc_in_3_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_3_toCore[39] = ms_riscv32_mp_rc_in_3_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_3_toCore[40] = ms_riscv32_mp_rc_in_3_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_3_toCore[41] = ms_riscv32_mp_rc_in_3_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_3_toCore[42] = ms_riscv32_mp_rc_in_3_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_3_toCore[43] = ms_riscv32_mp_rc_in_3_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_3_toCore[44] = ms_riscv32_mp_rc_in_3_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_3_toCore[45] = ms_riscv32_mp_rc_in_3_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_3_toCore[46] = ms_riscv32_mp_rc_in_3_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_3_toCore[47] = ms_riscv32_mp_rc_in_3_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_3_toCore[48] = ms_riscv32_mp_rc_in_3_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_3_toCore[49] = ms_riscv32_mp_rc_in_3_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_3_toCore[50] = ms_riscv32_mp_rc_in_3_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_3_toCore[51] = ms_riscv32_mp_rc_in_3_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_3_toCore[52] = ms_riscv32_mp_rc_in_3_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_3_toCore[53] = ms_riscv32_mp_rc_in_3_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_3_toCore[54] = ms_riscv32_mp_rc_in_3_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_3_toCore[55] = ms_riscv32_mp_rc_in_3_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_3_toCore[56] = ms_riscv32_mp_rc_in_3_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_3_toCore[57] = ms_riscv32_mp_rc_in_3_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_3_toCore[58] = ms_riscv32_mp_rc_in_3_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_3_toCore[59] = ms_riscv32_mp_rc_in_3_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_3_toCore[60] = ms_riscv32_mp_rc_in_3_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_3_toCore[61] = ms_riscv32_mp_rc_in_3_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_3_toCore[62] = ms_riscv32_mp_rc_in_3_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_3_toCore[63] = ms_riscv32_mp_rc_in_3_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[0] = ms_riscv32_mp_rc_in_2_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[1] = ms_riscv32_mp_rc_in_2_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[3] = ms_riscv32_mp_rc_in_2_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[4] = ms_riscv32_mp_rc_in_2_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[5] = ms_riscv32_mp_rc_in_2_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[6] = ms_riscv32_mp_rc_in_2_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[7] = ms_riscv32_mp_rc_in_2_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[8] = ms_riscv32_mp_rc_in_2_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[9] = ms_riscv32_mp_rc_in_2_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[10] = ms_riscv32_mp_rc_in_2_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[11] = ms_riscv32_mp_rc_in_2_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[12] = ms_riscv32_mp_rc_in_2_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[13] = ms_riscv32_mp_rc_in_2_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[14] = ms_riscv32_mp_rc_in_2_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[15] = ms_riscv32_mp_rc_in_2_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[16] = ms_riscv32_mp_rc_in_2_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[17] = ms_riscv32_mp_rc_in_2_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[18] = ms_riscv32_mp_rc_in_2_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[19] = ms_riscv32_mp_rc_in_2_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[20] = ms_riscv32_mp_rc_in_2_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[21] = ms_riscv32_mp_rc_in_2_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[22] = ms_riscv32_mp_rc_in_2_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[23] = ms_riscv32_mp_rc_in_2_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[24] = ms_riscv32_mp_rc_in_2_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[25] = ms_riscv32_mp_rc_in_2_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[26] = ms_riscv32_mp_rc_in_2_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[27] = ms_riscv32_mp_rc_in_2_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[28] = ms_riscv32_mp_rc_in_2_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[29] = ms_riscv32_mp_rc_in_2_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[30] = ms_riscv32_mp_rc_in_2_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[31] = ms_riscv32_mp_rc_in_2_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[32] = ms_riscv32_mp_rc_in_2_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[33] = ms_riscv32_mp_rc_in_2_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[34] = ms_riscv32_mp_rc_in_2_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[35] = ms_riscv32_mp_rc_in_2_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[36] = ms_riscv32_mp_rc_in_2_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[37] = ms_riscv32_mp_rc_in_2_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[38] = ms_riscv32_mp_rc_in_2_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[39] = ms_riscv32_mp_rc_in_2_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[40] = ms_riscv32_mp_rc_in_2_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[41] = ms_riscv32_mp_rc_in_2_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[42] = ms_riscv32_mp_rc_in_2_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[43] = ms_riscv32_mp_rc_in_2_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[44] = ms_riscv32_mp_rc_in_2_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[45] = ms_riscv32_mp_rc_in_2_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[46] = ms_riscv32_mp_rc_in_2_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[47] = ms_riscv32_mp_rc_in_2_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[48] = ms_riscv32_mp_rc_in_2_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[49] = ms_riscv32_mp_rc_in_2_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[50] = ms_riscv32_mp_rc_in_2_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[51] = ms_riscv32_mp_rc_in_2_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[52] = ms_riscv32_mp_rc_in_2_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[53] = ms_riscv32_mp_rc_in_2_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[54] = ms_riscv32_mp_rc_in_2_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[55] = ms_riscv32_mp_rc_in_2_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[56] = ms_riscv32_mp_rc_in_2_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[57] = ms_riscv32_mp_rc_in_2_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[58] = ms_riscv32_mp_rc_in_2_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[59] = ms_riscv32_mp_rc_in_2_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[60] = ms_riscv32_mp_rc_in_2_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[61] = ms_riscv32_mp_rc_in_2_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[62] = ms_riscv32_mp_rc_in_2_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_3_toCore_ts1[63] = ms_riscv32_mp_rc_in_2_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_1_toCore[0] = ms_riscv32_mp_rc_in_1_toCore_ts1[0];

  assign ms_riscv32_mp_rc_in_1_toCore[2] = ms_riscv32_mp_rc_in_1_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_1_toCore[3] = ms_riscv32_mp_rc_in_1_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_1_toCore[4] = ms_riscv32_mp_rc_in_1_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_1_toCore[5] = ms_riscv32_mp_rc_in_1_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_1_toCore[6] = ms_riscv32_mp_rc_in_1_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_1_toCore[7] = ms_riscv32_mp_rc_in_1_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_1_toCore[8] = ms_riscv32_mp_rc_in_1_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_1_toCore[9] = ms_riscv32_mp_rc_in_1_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_1_toCore[10] = ms_riscv32_mp_rc_in_1_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_1_toCore[11] = ms_riscv32_mp_rc_in_1_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_1_toCore[12] = ms_riscv32_mp_rc_in_1_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_1_toCore[13] = ms_riscv32_mp_rc_in_1_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_1_toCore[14] = ms_riscv32_mp_rc_in_1_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_1_toCore[15] = ms_riscv32_mp_rc_in_1_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_1_toCore[16] = ms_riscv32_mp_rc_in_1_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_1_toCore[17] = ms_riscv32_mp_rc_in_1_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_1_toCore[18] = ms_riscv32_mp_rc_in_1_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_1_toCore[19] = ms_riscv32_mp_rc_in_1_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_1_toCore[20] = ms_riscv32_mp_rc_in_1_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_1_toCore[21] = ms_riscv32_mp_rc_in_1_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_1_toCore[22] = ms_riscv32_mp_rc_in_1_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_1_toCore[23] = ms_riscv32_mp_rc_in_1_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_1_toCore[24] = ms_riscv32_mp_rc_in_1_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_1_toCore[25] = ms_riscv32_mp_rc_in_1_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_1_toCore[26] = ms_riscv32_mp_rc_in_1_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_1_toCore[27] = ms_riscv32_mp_rc_in_1_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_1_toCore[28] = ms_riscv32_mp_rc_in_1_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_1_toCore[29] = ms_riscv32_mp_rc_in_1_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_1_toCore[30] = ms_riscv32_mp_rc_in_1_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_1_toCore[31] = ms_riscv32_mp_rc_in_1_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_1_toCore[32] = ms_riscv32_mp_rc_in_1_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_1_toCore[33] = ms_riscv32_mp_rc_in_1_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_1_toCore[34] = ms_riscv32_mp_rc_in_1_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_1_toCore[35] = ms_riscv32_mp_rc_in_1_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_1_toCore[36] = ms_riscv32_mp_rc_in_1_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_1_toCore[37] = ms_riscv32_mp_rc_in_1_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_1_toCore[38] = ms_riscv32_mp_rc_in_1_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_1_toCore[39] = ms_riscv32_mp_rc_in_1_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_1_toCore[40] = ms_riscv32_mp_rc_in_1_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_1_toCore[41] = ms_riscv32_mp_rc_in_1_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_1_toCore[42] = ms_riscv32_mp_rc_in_1_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_1_toCore[43] = ms_riscv32_mp_rc_in_1_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_1_toCore[44] = ms_riscv32_mp_rc_in_1_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_1_toCore[45] = ms_riscv32_mp_rc_in_1_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_1_toCore[46] = ms_riscv32_mp_rc_in_1_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_1_toCore[47] = ms_riscv32_mp_rc_in_1_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_1_toCore[48] = ms_riscv32_mp_rc_in_1_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_1_toCore[49] = ms_riscv32_mp_rc_in_1_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_1_toCore[50] = ms_riscv32_mp_rc_in_1_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_1_toCore[51] = ms_riscv32_mp_rc_in_1_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_1_toCore[52] = ms_riscv32_mp_rc_in_1_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_1_toCore[53] = ms_riscv32_mp_rc_in_1_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_1_toCore[54] = ms_riscv32_mp_rc_in_1_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_1_toCore[55] = ms_riscv32_mp_rc_in_1_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_1_toCore[56] = ms_riscv32_mp_rc_in_1_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_1_toCore[57] = ms_riscv32_mp_rc_in_1_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_1_toCore[58] = ms_riscv32_mp_rc_in_1_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_1_toCore[59] = ms_riscv32_mp_rc_in_1_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_1_toCore[60] = ms_riscv32_mp_rc_in_1_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_1_toCore[61] = ms_riscv32_mp_rc_in_1_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_1_toCore[62] = ms_riscv32_mp_rc_in_1_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_1_toCore[63] = ms_riscv32_mp_rc_in_1_toCore_ts1[63];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[1] = ms_riscv32_mp_rc_in_0_toCore_ts1[1];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[2] = ms_riscv32_mp_rc_in_0_toCore_ts1[2];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[3] = ms_riscv32_mp_rc_in_0_toCore_ts1[3];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[4] = ms_riscv32_mp_rc_in_0_toCore_ts1[4];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[5] = ms_riscv32_mp_rc_in_0_toCore_ts1[5];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[6] = ms_riscv32_mp_rc_in_0_toCore_ts1[6];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[7] = ms_riscv32_mp_rc_in_0_toCore_ts1[7];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[8] = ms_riscv32_mp_rc_in_0_toCore_ts1[8];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[9] = ms_riscv32_mp_rc_in_0_toCore_ts1[9];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[10] = ms_riscv32_mp_rc_in_0_toCore_ts1[10];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[11] = ms_riscv32_mp_rc_in_0_toCore_ts1[11];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[12] = ms_riscv32_mp_rc_in_0_toCore_ts1[12];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[13] = ms_riscv32_mp_rc_in_0_toCore_ts1[13];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[14] = ms_riscv32_mp_rc_in_0_toCore_ts1[14];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[15] = ms_riscv32_mp_rc_in_0_toCore_ts1[15];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[16] = ms_riscv32_mp_rc_in_0_toCore_ts1[16];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[17] = ms_riscv32_mp_rc_in_0_toCore_ts1[17];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[18] = ms_riscv32_mp_rc_in_0_toCore_ts1[18];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[19] = ms_riscv32_mp_rc_in_0_toCore_ts1[19];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[20] = ms_riscv32_mp_rc_in_0_toCore_ts1[20];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[21] = ms_riscv32_mp_rc_in_0_toCore_ts1[21];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[22] = ms_riscv32_mp_rc_in_0_toCore_ts1[22];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[23] = ms_riscv32_mp_rc_in_0_toCore_ts1[23];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[24] = ms_riscv32_mp_rc_in_0_toCore_ts1[24];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[25] = ms_riscv32_mp_rc_in_0_toCore_ts1[25];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[26] = ms_riscv32_mp_rc_in_0_toCore_ts1[26];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[27] = ms_riscv32_mp_rc_in_0_toCore_ts1[27];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[28] = ms_riscv32_mp_rc_in_0_toCore_ts1[28];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[29] = ms_riscv32_mp_rc_in_0_toCore_ts1[29];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[30] = ms_riscv32_mp_rc_in_0_toCore_ts1[30];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[31] = ms_riscv32_mp_rc_in_0_toCore_ts1[31];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[32] = ms_riscv32_mp_rc_in_0_toCore_ts1[32];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[33] = ms_riscv32_mp_rc_in_0_toCore_ts1[33];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[34] = ms_riscv32_mp_rc_in_0_toCore_ts1[34];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[35] = ms_riscv32_mp_rc_in_0_toCore_ts1[35];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[36] = ms_riscv32_mp_rc_in_0_toCore_ts1[36];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[37] = ms_riscv32_mp_rc_in_0_toCore_ts1[37];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[38] = ms_riscv32_mp_rc_in_0_toCore_ts1[38];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[39] = ms_riscv32_mp_rc_in_0_toCore_ts1[39];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[40] = ms_riscv32_mp_rc_in_0_toCore_ts1[40];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[41] = ms_riscv32_mp_rc_in_0_toCore_ts1[41];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[42] = ms_riscv32_mp_rc_in_0_toCore_ts1[42];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[43] = ms_riscv32_mp_rc_in_0_toCore_ts1[43];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[44] = ms_riscv32_mp_rc_in_0_toCore_ts1[44];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[45] = ms_riscv32_mp_rc_in_0_toCore_ts1[45];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[46] = ms_riscv32_mp_rc_in_0_toCore_ts1[46];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[47] = ms_riscv32_mp_rc_in_0_toCore_ts1[47];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[48] = ms_riscv32_mp_rc_in_0_toCore_ts1[48];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[49] = ms_riscv32_mp_rc_in_0_toCore_ts1[49];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[50] = ms_riscv32_mp_rc_in_0_toCore_ts1[50];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[51] = ms_riscv32_mp_rc_in_0_toCore_ts1[51];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[52] = ms_riscv32_mp_rc_in_0_toCore_ts1[52];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[53] = ms_riscv32_mp_rc_in_0_toCore_ts1[53];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[54] = ms_riscv32_mp_rc_in_0_toCore_ts1[54];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[55] = ms_riscv32_mp_rc_in_0_toCore_ts1[55];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[56] = ms_riscv32_mp_rc_in_0_toCore_ts1[56];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[57] = ms_riscv32_mp_rc_in_0_toCore_ts1[57];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[58] = ms_riscv32_mp_rc_in_0_toCore_ts1[58];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[59] = ms_riscv32_mp_rc_in_0_toCore_ts1[59];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[60] = ms_riscv32_mp_rc_in_0_toCore_ts1[60];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[61] = ms_riscv32_mp_rc_in_0_toCore_ts1[61];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[62] = ms_riscv32_mp_rc_in_0_toCore_ts1[62];

  assign ms_riscv32_mp_rc_in_1_toCore_ts1[63] = ms_riscv32_mp_rc_in_0_toCore_ts1[63];

  assign ms_riscv32_mp_instr_in_31_fromPad = ms_riscv32_mp_instr_in_31_fromPad_ts1[31];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[0] = ms_riscv32_mp_instr_in_30_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[1] = ms_riscv32_mp_instr_in_30_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[2] = ms_riscv32_mp_instr_in_30_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[3] = ms_riscv32_mp_instr_in_30_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[4] = ms_riscv32_mp_instr_in_30_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[5] = ms_riscv32_mp_instr_in_30_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[6] = ms_riscv32_mp_instr_in_30_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[7] = ms_riscv32_mp_instr_in_30_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[8] = ms_riscv32_mp_instr_in_30_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[9] = ms_riscv32_mp_instr_in_30_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[10] = ms_riscv32_mp_instr_in_30_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[11] = ms_riscv32_mp_instr_in_30_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[12] = ms_riscv32_mp_instr_in_30_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[13] = ms_riscv32_mp_instr_in_30_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[14] = ms_riscv32_mp_instr_in_30_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[15] = ms_riscv32_mp_instr_in_30_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[16] = ms_riscv32_mp_instr_in_30_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[17] = ms_riscv32_mp_instr_in_30_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[18] = ms_riscv32_mp_instr_in_30_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[19] = ms_riscv32_mp_instr_in_30_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[20] = ms_riscv32_mp_instr_in_30_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[21] = ms_riscv32_mp_instr_in_30_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[22] = ms_riscv32_mp_instr_in_30_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[23] = ms_riscv32_mp_instr_in_30_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[24] = ms_riscv32_mp_instr_in_30_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[25] = ms_riscv32_mp_instr_in_30_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[26] = ms_riscv32_mp_instr_in_30_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[27] = ms_riscv32_mp_instr_in_30_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[28] = ms_riscv32_mp_instr_in_30_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[29] = ms_riscv32_mp_instr_in_30_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_31_fromPad_ts1[31] = ms_riscv32_mp_instr_in_30_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_29_toCore[0] = ms_riscv32_mp_instr_in_29_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_29_toCore[1] = ms_riscv32_mp_instr_in_29_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_29_toCore[2] = ms_riscv32_mp_instr_in_29_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_29_toCore[3] = ms_riscv32_mp_instr_in_29_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_29_toCore[4] = ms_riscv32_mp_instr_in_29_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_29_toCore[5] = ms_riscv32_mp_instr_in_29_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_29_toCore[6] = ms_riscv32_mp_instr_in_29_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_29_toCore[7] = ms_riscv32_mp_instr_in_29_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_29_toCore[8] = ms_riscv32_mp_instr_in_29_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_29_toCore[9] = ms_riscv32_mp_instr_in_29_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_29_toCore[10] = ms_riscv32_mp_instr_in_29_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_29_toCore[11] = ms_riscv32_mp_instr_in_29_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_29_toCore[12] = ms_riscv32_mp_instr_in_29_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_29_toCore[13] = ms_riscv32_mp_instr_in_29_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_29_toCore[14] = ms_riscv32_mp_instr_in_29_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_29_toCore[15] = ms_riscv32_mp_instr_in_29_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_29_toCore[16] = ms_riscv32_mp_instr_in_29_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_29_toCore[17] = ms_riscv32_mp_instr_in_29_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_29_toCore[18] = ms_riscv32_mp_instr_in_29_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_29_toCore[19] = ms_riscv32_mp_instr_in_29_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_29_toCore[20] = ms_riscv32_mp_instr_in_29_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_29_toCore[21] = ms_riscv32_mp_instr_in_29_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_29_toCore[22] = ms_riscv32_mp_instr_in_29_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_29_toCore[23] = ms_riscv32_mp_instr_in_29_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_29_toCore[24] = ms_riscv32_mp_instr_in_29_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_29_toCore[25] = ms_riscv32_mp_instr_in_29_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_29_toCore[26] = ms_riscv32_mp_instr_in_29_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_29_toCore[27] = ms_riscv32_mp_instr_in_29_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_29_toCore[28] = ms_riscv32_mp_instr_in_29_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_29_toCore[30] = ms_riscv32_mp_instr_in_29_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_29_toCore[31] = ms_riscv32_mp_instr_in_29_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[0] = ms_riscv32_mp_instr_in_28_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[1] = ms_riscv32_mp_instr_in_28_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[2] = ms_riscv32_mp_instr_in_28_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[3] = ms_riscv32_mp_instr_in_28_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[4] = ms_riscv32_mp_instr_in_28_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[5] = ms_riscv32_mp_instr_in_28_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[6] = ms_riscv32_mp_instr_in_28_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[7] = ms_riscv32_mp_instr_in_28_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[8] = ms_riscv32_mp_instr_in_28_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[9] = ms_riscv32_mp_instr_in_28_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[10] = ms_riscv32_mp_instr_in_28_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[11] = ms_riscv32_mp_instr_in_28_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[12] = ms_riscv32_mp_instr_in_28_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[13] = ms_riscv32_mp_instr_in_28_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[14] = ms_riscv32_mp_instr_in_28_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[15] = ms_riscv32_mp_instr_in_28_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[16] = ms_riscv32_mp_instr_in_28_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[17] = ms_riscv32_mp_instr_in_28_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[18] = ms_riscv32_mp_instr_in_28_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[19] = ms_riscv32_mp_instr_in_28_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[20] = ms_riscv32_mp_instr_in_28_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[21] = ms_riscv32_mp_instr_in_28_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[22] = ms_riscv32_mp_instr_in_28_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[23] = ms_riscv32_mp_instr_in_28_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[24] = ms_riscv32_mp_instr_in_28_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[25] = ms_riscv32_mp_instr_in_28_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[26] = ms_riscv32_mp_instr_in_28_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[27] = ms_riscv32_mp_instr_in_28_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[29] = ms_riscv32_mp_instr_in_28_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[30] = ms_riscv32_mp_instr_in_28_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_29_toCore_ts1[31] = ms_riscv32_mp_instr_in_28_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_27_toCore[0] = ms_riscv32_mp_instr_in_27_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_27_toCore[1] = ms_riscv32_mp_instr_in_27_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_27_toCore[2] = ms_riscv32_mp_instr_in_27_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_27_toCore[3] = ms_riscv32_mp_instr_in_27_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_27_toCore[4] = ms_riscv32_mp_instr_in_27_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_27_toCore[5] = ms_riscv32_mp_instr_in_27_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_27_toCore[6] = ms_riscv32_mp_instr_in_27_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_27_toCore[7] = ms_riscv32_mp_instr_in_27_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_27_toCore[8] = ms_riscv32_mp_instr_in_27_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_27_toCore[9] = ms_riscv32_mp_instr_in_27_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_27_toCore[10] = ms_riscv32_mp_instr_in_27_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_27_toCore[11] = ms_riscv32_mp_instr_in_27_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_27_toCore[12] = ms_riscv32_mp_instr_in_27_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_27_toCore[13] = ms_riscv32_mp_instr_in_27_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_27_toCore[14] = ms_riscv32_mp_instr_in_27_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_27_toCore[15] = ms_riscv32_mp_instr_in_27_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_27_toCore[16] = ms_riscv32_mp_instr_in_27_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_27_toCore[17] = ms_riscv32_mp_instr_in_27_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_27_toCore[18] = ms_riscv32_mp_instr_in_27_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_27_toCore[19] = ms_riscv32_mp_instr_in_27_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_27_toCore[20] = ms_riscv32_mp_instr_in_27_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_27_toCore[21] = ms_riscv32_mp_instr_in_27_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_27_toCore[22] = ms_riscv32_mp_instr_in_27_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_27_toCore[23] = ms_riscv32_mp_instr_in_27_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_27_toCore[24] = ms_riscv32_mp_instr_in_27_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_27_toCore[25] = ms_riscv32_mp_instr_in_27_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_27_toCore[26] = ms_riscv32_mp_instr_in_27_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_27_toCore[28] = ms_riscv32_mp_instr_in_27_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_27_toCore[29] = ms_riscv32_mp_instr_in_27_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_27_toCore[30] = ms_riscv32_mp_instr_in_27_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_27_toCore[31] = ms_riscv32_mp_instr_in_27_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[0] = ms_riscv32_mp_instr_in_26_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[1] = ms_riscv32_mp_instr_in_26_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[2] = ms_riscv32_mp_instr_in_26_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[3] = ms_riscv32_mp_instr_in_26_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[4] = ms_riscv32_mp_instr_in_26_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[5] = ms_riscv32_mp_instr_in_26_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[6] = ms_riscv32_mp_instr_in_26_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[7] = ms_riscv32_mp_instr_in_26_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[8] = ms_riscv32_mp_instr_in_26_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[9] = ms_riscv32_mp_instr_in_26_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[10] = ms_riscv32_mp_instr_in_26_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[11] = ms_riscv32_mp_instr_in_26_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[12] = ms_riscv32_mp_instr_in_26_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[13] = ms_riscv32_mp_instr_in_26_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[14] = ms_riscv32_mp_instr_in_26_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[15] = ms_riscv32_mp_instr_in_26_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[16] = ms_riscv32_mp_instr_in_26_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[17] = ms_riscv32_mp_instr_in_26_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[18] = ms_riscv32_mp_instr_in_26_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[19] = ms_riscv32_mp_instr_in_26_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[20] = ms_riscv32_mp_instr_in_26_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[21] = ms_riscv32_mp_instr_in_26_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[22] = ms_riscv32_mp_instr_in_26_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[23] = ms_riscv32_mp_instr_in_26_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[24] = ms_riscv32_mp_instr_in_26_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[25] = ms_riscv32_mp_instr_in_26_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[27] = ms_riscv32_mp_instr_in_26_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[28] = ms_riscv32_mp_instr_in_26_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[29] = ms_riscv32_mp_instr_in_26_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[30] = ms_riscv32_mp_instr_in_26_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_27_toCore_ts1[31] = ms_riscv32_mp_instr_in_26_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_25_toCore[0] = ms_riscv32_mp_instr_in_25_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_25_toCore[1] = ms_riscv32_mp_instr_in_25_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_25_toCore[2] = ms_riscv32_mp_instr_in_25_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_25_toCore[3] = ms_riscv32_mp_instr_in_25_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_25_toCore[4] = ms_riscv32_mp_instr_in_25_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_25_toCore[5] = ms_riscv32_mp_instr_in_25_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_25_toCore[6] = ms_riscv32_mp_instr_in_25_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_25_toCore[7] = ms_riscv32_mp_instr_in_25_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_25_toCore[8] = ms_riscv32_mp_instr_in_25_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_25_toCore[9] = ms_riscv32_mp_instr_in_25_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_25_toCore[10] = ms_riscv32_mp_instr_in_25_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_25_toCore[11] = ms_riscv32_mp_instr_in_25_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_25_toCore[12] = ms_riscv32_mp_instr_in_25_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_25_toCore[13] = ms_riscv32_mp_instr_in_25_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_25_toCore[14] = ms_riscv32_mp_instr_in_25_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_25_toCore[15] = ms_riscv32_mp_instr_in_25_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_25_toCore[16] = ms_riscv32_mp_instr_in_25_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_25_toCore[17] = ms_riscv32_mp_instr_in_25_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_25_toCore[18] = ms_riscv32_mp_instr_in_25_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_25_toCore[19] = ms_riscv32_mp_instr_in_25_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_25_toCore[20] = ms_riscv32_mp_instr_in_25_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_25_toCore[21] = ms_riscv32_mp_instr_in_25_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_25_toCore[22] = ms_riscv32_mp_instr_in_25_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_25_toCore[23] = ms_riscv32_mp_instr_in_25_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_25_toCore[24] = ms_riscv32_mp_instr_in_25_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_25_toCore[26] = ms_riscv32_mp_instr_in_25_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_25_toCore[27] = ms_riscv32_mp_instr_in_25_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_25_toCore[28] = ms_riscv32_mp_instr_in_25_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_25_toCore[29] = ms_riscv32_mp_instr_in_25_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_25_toCore[30] = ms_riscv32_mp_instr_in_25_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_25_toCore[31] = ms_riscv32_mp_instr_in_25_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[0] = ms_riscv32_mp_instr_in_24_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[1] = ms_riscv32_mp_instr_in_24_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[2] = ms_riscv32_mp_instr_in_24_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[3] = ms_riscv32_mp_instr_in_24_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[4] = ms_riscv32_mp_instr_in_24_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[5] = ms_riscv32_mp_instr_in_24_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[6] = ms_riscv32_mp_instr_in_24_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[7] = ms_riscv32_mp_instr_in_24_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[8] = ms_riscv32_mp_instr_in_24_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[9] = ms_riscv32_mp_instr_in_24_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[10] = ms_riscv32_mp_instr_in_24_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[11] = ms_riscv32_mp_instr_in_24_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[12] = ms_riscv32_mp_instr_in_24_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[13] = ms_riscv32_mp_instr_in_24_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[14] = ms_riscv32_mp_instr_in_24_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[15] = ms_riscv32_mp_instr_in_24_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[16] = ms_riscv32_mp_instr_in_24_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[17] = ms_riscv32_mp_instr_in_24_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[18] = ms_riscv32_mp_instr_in_24_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[19] = ms_riscv32_mp_instr_in_24_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[20] = ms_riscv32_mp_instr_in_24_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[21] = ms_riscv32_mp_instr_in_24_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[22] = ms_riscv32_mp_instr_in_24_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[23] = ms_riscv32_mp_instr_in_24_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[25] = ms_riscv32_mp_instr_in_24_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[26] = ms_riscv32_mp_instr_in_24_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[27] = ms_riscv32_mp_instr_in_24_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[28] = ms_riscv32_mp_instr_in_24_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[29] = ms_riscv32_mp_instr_in_24_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[30] = ms_riscv32_mp_instr_in_24_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_25_toCore_ts1[31] = ms_riscv32_mp_instr_in_24_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_23_toCore[0] = ms_riscv32_mp_instr_in_23_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_23_toCore[1] = ms_riscv32_mp_instr_in_23_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_23_toCore[2] = ms_riscv32_mp_instr_in_23_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_23_toCore[3] = ms_riscv32_mp_instr_in_23_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_23_toCore[4] = ms_riscv32_mp_instr_in_23_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_23_toCore[5] = ms_riscv32_mp_instr_in_23_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_23_toCore[6] = ms_riscv32_mp_instr_in_23_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_23_toCore[7] = ms_riscv32_mp_instr_in_23_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_23_toCore[8] = ms_riscv32_mp_instr_in_23_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_23_toCore[9] = ms_riscv32_mp_instr_in_23_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_23_toCore[10] = ms_riscv32_mp_instr_in_23_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_23_toCore[11] = ms_riscv32_mp_instr_in_23_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_23_toCore[12] = ms_riscv32_mp_instr_in_23_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_23_toCore[13] = ms_riscv32_mp_instr_in_23_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_23_toCore[14] = ms_riscv32_mp_instr_in_23_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_23_toCore[15] = ms_riscv32_mp_instr_in_23_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_23_toCore[16] = ms_riscv32_mp_instr_in_23_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_23_toCore[17] = ms_riscv32_mp_instr_in_23_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_23_toCore[18] = ms_riscv32_mp_instr_in_23_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_23_toCore[19] = ms_riscv32_mp_instr_in_23_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_23_toCore[20] = ms_riscv32_mp_instr_in_23_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_23_toCore[21] = ms_riscv32_mp_instr_in_23_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_23_toCore[22] = ms_riscv32_mp_instr_in_23_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_23_toCore[24] = ms_riscv32_mp_instr_in_23_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_23_toCore[25] = ms_riscv32_mp_instr_in_23_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_23_toCore[26] = ms_riscv32_mp_instr_in_23_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_23_toCore[27] = ms_riscv32_mp_instr_in_23_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_23_toCore[28] = ms_riscv32_mp_instr_in_23_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_23_toCore[29] = ms_riscv32_mp_instr_in_23_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_23_toCore[30] = ms_riscv32_mp_instr_in_23_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_23_toCore[31] = ms_riscv32_mp_instr_in_23_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[0] = ms_riscv32_mp_instr_in_22_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[1] = ms_riscv32_mp_instr_in_22_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[2] = ms_riscv32_mp_instr_in_22_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[3] = ms_riscv32_mp_instr_in_22_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[4] = ms_riscv32_mp_instr_in_22_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[5] = ms_riscv32_mp_instr_in_22_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[6] = ms_riscv32_mp_instr_in_22_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[7] = ms_riscv32_mp_instr_in_22_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[8] = ms_riscv32_mp_instr_in_22_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[9] = ms_riscv32_mp_instr_in_22_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[10] = ms_riscv32_mp_instr_in_22_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[11] = ms_riscv32_mp_instr_in_22_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[12] = ms_riscv32_mp_instr_in_22_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[13] = ms_riscv32_mp_instr_in_22_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[14] = ms_riscv32_mp_instr_in_22_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[15] = ms_riscv32_mp_instr_in_22_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[16] = ms_riscv32_mp_instr_in_22_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[17] = ms_riscv32_mp_instr_in_22_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[18] = ms_riscv32_mp_instr_in_22_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[19] = ms_riscv32_mp_instr_in_22_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[20] = ms_riscv32_mp_instr_in_22_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[21] = ms_riscv32_mp_instr_in_22_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[23] = ms_riscv32_mp_instr_in_22_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[24] = ms_riscv32_mp_instr_in_22_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[25] = ms_riscv32_mp_instr_in_22_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[26] = ms_riscv32_mp_instr_in_22_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[27] = ms_riscv32_mp_instr_in_22_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[28] = ms_riscv32_mp_instr_in_22_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[29] = ms_riscv32_mp_instr_in_22_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[30] = ms_riscv32_mp_instr_in_22_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_23_toCore_ts1[31] = ms_riscv32_mp_instr_in_22_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_21_toCore[0] = ms_riscv32_mp_instr_in_21_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_21_toCore[1] = ms_riscv32_mp_instr_in_21_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_21_toCore[2] = ms_riscv32_mp_instr_in_21_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_21_toCore[3] = ms_riscv32_mp_instr_in_21_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_21_toCore[4] = ms_riscv32_mp_instr_in_21_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_21_toCore[5] = ms_riscv32_mp_instr_in_21_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_21_toCore[6] = ms_riscv32_mp_instr_in_21_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_21_toCore[7] = ms_riscv32_mp_instr_in_21_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_21_toCore[8] = ms_riscv32_mp_instr_in_21_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_21_toCore[9] = ms_riscv32_mp_instr_in_21_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_21_toCore[10] = ms_riscv32_mp_instr_in_21_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_21_toCore[11] = ms_riscv32_mp_instr_in_21_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_21_toCore[12] = ms_riscv32_mp_instr_in_21_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_21_toCore[13] = ms_riscv32_mp_instr_in_21_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_21_toCore[14] = ms_riscv32_mp_instr_in_21_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_21_toCore[15] = ms_riscv32_mp_instr_in_21_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_21_toCore[16] = ms_riscv32_mp_instr_in_21_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_21_toCore[17] = ms_riscv32_mp_instr_in_21_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_21_toCore[18] = ms_riscv32_mp_instr_in_21_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_21_toCore[19] = ms_riscv32_mp_instr_in_21_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_21_toCore[20] = ms_riscv32_mp_instr_in_21_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_21_toCore[22] = ms_riscv32_mp_instr_in_21_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_21_toCore[23] = ms_riscv32_mp_instr_in_21_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_21_toCore[24] = ms_riscv32_mp_instr_in_21_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_21_toCore[25] = ms_riscv32_mp_instr_in_21_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_21_toCore[26] = ms_riscv32_mp_instr_in_21_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_21_toCore[27] = ms_riscv32_mp_instr_in_21_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_21_toCore[28] = ms_riscv32_mp_instr_in_21_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_21_toCore[29] = ms_riscv32_mp_instr_in_21_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_21_toCore[30] = ms_riscv32_mp_instr_in_21_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_21_toCore[31] = ms_riscv32_mp_instr_in_21_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[0] = ms_riscv32_mp_instr_in_20_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[1] = ms_riscv32_mp_instr_in_20_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[2] = ms_riscv32_mp_instr_in_20_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[3] = ms_riscv32_mp_instr_in_20_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[4] = ms_riscv32_mp_instr_in_20_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[5] = ms_riscv32_mp_instr_in_20_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[6] = ms_riscv32_mp_instr_in_20_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[7] = ms_riscv32_mp_instr_in_20_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[8] = ms_riscv32_mp_instr_in_20_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[9] = ms_riscv32_mp_instr_in_20_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[10] = ms_riscv32_mp_instr_in_20_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[11] = ms_riscv32_mp_instr_in_20_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[12] = ms_riscv32_mp_instr_in_20_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[13] = ms_riscv32_mp_instr_in_20_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[14] = ms_riscv32_mp_instr_in_20_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[15] = ms_riscv32_mp_instr_in_20_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[16] = ms_riscv32_mp_instr_in_20_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[17] = ms_riscv32_mp_instr_in_20_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[18] = ms_riscv32_mp_instr_in_20_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[19] = ms_riscv32_mp_instr_in_20_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[21] = ms_riscv32_mp_instr_in_20_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[22] = ms_riscv32_mp_instr_in_20_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[23] = ms_riscv32_mp_instr_in_20_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[24] = ms_riscv32_mp_instr_in_20_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[25] = ms_riscv32_mp_instr_in_20_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[26] = ms_riscv32_mp_instr_in_20_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[27] = ms_riscv32_mp_instr_in_20_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[28] = ms_riscv32_mp_instr_in_20_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[29] = ms_riscv32_mp_instr_in_20_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[30] = ms_riscv32_mp_instr_in_20_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_21_toCore_ts1[31] = ms_riscv32_mp_instr_in_20_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_19_toCore[0] = ms_riscv32_mp_instr_in_19_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_19_toCore[1] = ms_riscv32_mp_instr_in_19_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_19_toCore[2] = ms_riscv32_mp_instr_in_19_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_19_toCore[3] = ms_riscv32_mp_instr_in_19_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_19_toCore[4] = ms_riscv32_mp_instr_in_19_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_19_toCore[5] = ms_riscv32_mp_instr_in_19_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_19_toCore[6] = ms_riscv32_mp_instr_in_19_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_19_toCore[7] = ms_riscv32_mp_instr_in_19_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_19_toCore[8] = ms_riscv32_mp_instr_in_19_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_19_toCore[9] = ms_riscv32_mp_instr_in_19_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_19_toCore[10] = ms_riscv32_mp_instr_in_19_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_19_toCore[11] = ms_riscv32_mp_instr_in_19_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_19_toCore[12] = ms_riscv32_mp_instr_in_19_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_19_toCore[13] = ms_riscv32_mp_instr_in_19_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_19_toCore[14] = ms_riscv32_mp_instr_in_19_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_19_toCore[15] = ms_riscv32_mp_instr_in_19_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_19_toCore[16] = ms_riscv32_mp_instr_in_19_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_19_toCore[17] = ms_riscv32_mp_instr_in_19_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_19_toCore[18] = ms_riscv32_mp_instr_in_19_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_19_toCore[20] = ms_riscv32_mp_instr_in_19_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_19_toCore[21] = ms_riscv32_mp_instr_in_19_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_19_toCore[22] = ms_riscv32_mp_instr_in_19_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_19_toCore[23] = ms_riscv32_mp_instr_in_19_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_19_toCore[24] = ms_riscv32_mp_instr_in_19_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_19_toCore[25] = ms_riscv32_mp_instr_in_19_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_19_toCore[26] = ms_riscv32_mp_instr_in_19_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_19_toCore[27] = ms_riscv32_mp_instr_in_19_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_19_toCore[28] = ms_riscv32_mp_instr_in_19_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_19_toCore[29] = ms_riscv32_mp_instr_in_19_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_19_toCore[30] = ms_riscv32_mp_instr_in_19_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_19_toCore[31] = ms_riscv32_mp_instr_in_19_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[0] = ms_riscv32_mp_instr_in_18_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[1] = ms_riscv32_mp_instr_in_18_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[2] = ms_riscv32_mp_instr_in_18_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[3] = ms_riscv32_mp_instr_in_18_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[4] = ms_riscv32_mp_instr_in_18_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[5] = ms_riscv32_mp_instr_in_18_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[6] = ms_riscv32_mp_instr_in_18_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[7] = ms_riscv32_mp_instr_in_18_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[8] = ms_riscv32_mp_instr_in_18_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[9] = ms_riscv32_mp_instr_in_18_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[10] = ms_riscv32_mp_instr_in_18_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[11] = ms_riscv32_mp_instr_in_18_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[12] = ms_riscv32_mp_instr_in_18_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[13] = ms_riscv32_mp_instr_in_18_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[14] = ms_riscv32_mp_instr_in_18_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[15] = ms_riscv32_mp_instr_in_18_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[16] = ms_riscv32_mp_instr_in_18_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[17] = ms_riscv32_mp_instr_in_18_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[19] = ms_riscv32_mp_instr_in_18_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[20] = ms_riscv32_mp_instr_in_18_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[21] = ms_riscv32_mp_instr_in_18_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[22] = ms_riscv32_mp_instr_in_18_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[23] = ms_riscv32_mp_instr_in_18_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[24] = ms_riscv32_mp_instr_in_18_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[25] = ms_riscv32_mp_instr_in_18_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[26] = ms_riscv32_mp_instr_in_18_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[27] = ms_riscv32_mp_instr_in_18_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[28] = ms_riscv32_mp_instr_in_18_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[29] = ms_riscv32_mp_instr_in_18_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[30] = ms_riscv32_mp_instr_in_18_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_19_toCore_ts1[31] = ms_riscv32_mp_instr_in_18_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_17_toCore[0] = ms_riscv32_mp_instr_in_17_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_17_toCore[1] = ms_riscv32_mp_instr_in_17_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_17_toCore[2] = ms_riscv32_mp_instr_in_17_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_17_toCore[3] = ms_riscv32_mp_instr_in_17_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_17_toCore[4] = ms_riscv32_mp_instr_in_17_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_17_toCore[5] = ms_riscv32_mp_instr_in_17_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_17_toCore[6] = ms_riscv32_mp_instr_in_17_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_17_toCore[7] = ms_riscv32_mp_instr_in_17_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_17_toCore[8] = ms_riscv32_mp_instr_in_17_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_17_toCore[9] = ms_riscv32_mp_instr_in_17_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_17_toCore[10] = ms_riscv32_mp_instr_in_17_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_17_toCore[11] = ms_riscv32_mp_instr_in_17_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_17_toCore[12] = ms_riscv32_mp_instr_in_17_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_17_toCore[13] = ms_riscv32_mp_instr_in_17_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_17_toCore[14] = ms_riscv32_mp_instr_in_17_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_17_toCore[15] = ms_riscv32_mp_instr_in_17_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_17_toCore[16] = ms_riscv32_mp_instr_in_17_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_17_toCore[18] = ms_riscv32_mp_instr_in_17_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_17_toCore[19] = ms_riscv32_mp_instr_in_17_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_17_toCore[20] = ms_riscv32_mp_instr_in_17_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_17_toCore[21] = ms_riscv32_mp_instr_in_17_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_17_toCore[22] = ms_riscv32_mp_instr_in_17_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_17_toCore[23] = ms_riscv32_mp_instr_in_17_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_17_toCore[24] = ms_riscv32_mp_instr_in_17_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_17_toCore[25] = ms_riscv32_mp_instr_in_17_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_17_toCore[26] = ms_riscv32_mp_instr_in_17_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_17_toCore[27] = ms_riscv32_mp_instr_in_17_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_17_toCore[28] = ms_riscv32_mp_instr_in_17_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_17_toCore[29] = ms_riscv32_mp_instr_in_17_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_17_toCore[30] = ms_riscv32_mp_instr_in_17_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_17_toCore[31] = ms_riscv32_mp_instr_in_17_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[0] = ms_riscv32_mp_instr_in_16_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[1] = ms_riscv32_mp_instr_in_16_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[2] = ms_riscv32_mp_instr_in_16_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[3] = ms_riscv32_mp_instr_in_16_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[4] = ms_riscv32_mp_instr_in_16_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[5] = ms_riscv32_mp_instr_in_16_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[6] = ms_riscv32_mp_instr_in_16_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[7] = ms_riscv32_mp_instr_in_16_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[8] = ms_riscv32_mp_instr_in_16_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[9] = ms_riscv32_mp_instr_in_16_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[10] = ms_riscv32_mp_instr_in_16_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[11] = ms_riscv32_mp_instr_in_16_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[12] = ms_riscv32_mp_instr_in_16_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[13] = ms_riscv32_mp_instr_in_16_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[14] = ms_riscv32_mp_instr_in_16_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[15] = ms_riscv32_mp_instr_in_16_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[17] = ms_riscv32_mp_instr_in_16_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[18] = ms_riscv32_mp_instr_in_16_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[19] = ms_riscv32_mp_instr_in_16_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[20] = ms_riscv32_mp_instr_in_16_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[21] = ms_riscv32_mp_instr_in_16_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[22] = ms_riscv32_mp_instr_in_16_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[23] = ms_riscv32_mp_instr_in_16_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[24] = ms_riscv32_mp_instr_in_16_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[25] = ms_riscv32_mp_instr_in_16_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[26] = ms_riscv32_mp_instr_in_16_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[27] = ms_riscv32_mp_instr_in_16_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[28] = ms_riscv32_mp_instr_in_16_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[29] = ms_riscv32_mp_instr_in_16_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[30] = ms_riscv32_mp_instr_in_16_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_17_toCore_ts1[31] = ms_riscv32_mp_instr_in_16_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_15_toCore[0] = ms_riscv32_mp_instr_in_15_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_15_toCore[1] = ms_riscv32_mp_instr_in_15_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_15_toCore[2] = ms_riscv32_mp_instr_in_15_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_15_toCore[3] = ms_riscv32_mp_instr_in_15_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_15_toCore[4] = ms_riscv32_mp_instr_in_15_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_15_toCore[5] = ms_riscv32_mp_instr_in_15_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_15_toCore[6] = ms_riscv32_mp_instr_in_15_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_15_toCore[7] = ms_riscv32_mp_instr_in_15_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_15_toCore[8] = ms_riscv32_mp_instr_in_15_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_15_toCore[9] = ms_riscv32_mp_instr_in_15_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_15_toCore[10] = ms_riscv32_mp_instr_in_15_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_15_toCore[11] = ms_riscv32_mp_instr_in_15_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_15_toCore[12] = ms_riscv32_mp_instr_in_15_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_15_toCore[13] = ms_riscv32_mp_instr_in_15_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_15_toCore[14] = ms_riscv32_mp_instr_in_15_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_15_toCore[16] = ms_riscv32_mp_instr_in_15_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_15_toCore[17] = ms_riscv32_mp_instr_in_15_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_15_toCore[18] = ms_riscv32_mp_instr_in_15_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_15_toCore[19] = ms_riscv32_mp_instr_in_15_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_15_toCore[20] = ms_riscv32_mp_instr_in_15_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_15_toCore[21] = ms_riscv32_mp_instr_in_15_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_15_toCore[22] = ms_riscv32_mp_instr_in_15_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_15_toCore[23] = ms_riscv32_mp_instr_in_15_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_15_toCore[24] = ms_riscv32_mp_instr_in_15_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_15_toCore[25] = ms_riscv32_mp_instr_in_15_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_15_toCore[26] = ms_riscv32_mp_instr_in_15_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_15_toCore[27] = ms_riscv32_mp_instr_in_15_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_15_toCore[28] = ms_riscv32_mp_instr_in_15_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_15_toCore[29] = ms_riscv32_mp_instr_in_15_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_15_toCore[30] = ms_riscv32_mp_instr_in_15_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_15_toCore[31] = ms_riscv32_mp_instr_in_15_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[0] = ms_riscv32_mp_instr_in_14_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[1] = ms_riscv32_mp_instr_in_14_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[2] = ms_riscv32_mp_instr_in_14_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[3] = ms_riscv32_mp_instr_in_14_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[4] = ms_riscv32_mp_instr_in_14_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[5] = ms_riscv32_mp_instr_in_14_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[6] = ms_riscv32_mp_instr_in_14_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[7] = ms_riscv32_mp_instr_in_14_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[8] = ms_riscv32_mp_instr_in_14_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[9] = ms_riscv32_mp_instr_in_14_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[10] = ms_riscv32_mp_instr_in_14_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[11] = ms_riscv32_mp_instr_in_14_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[12] = ms_riscv32_mp_instr_in_14_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[13] = ms_riscv32_mp_instr_in_14_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[15] = ms_riscv32_mp_instr_in_14_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[16] = ms_riscv32_mp_instr_in_14_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[17] = ms_riscv32_mp_instr_in_14_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[18] = ms_riscv32_mp_instr_in_14_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[19] = ms_riscv32_mp_instr_in_14_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[20] = ms_riscv32_mp_instr_in_14_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[21] = ms_riscv32_mp_instr_in_14_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[22] = ms_riscv32_mp_instr_in_14_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[23] = ms_riscv32_mp_instr_in_14_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[24] = ms_riscv32_mp_instr_in_14_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[25] = ms_riscv32_mp_instr_in_14_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[26] = ms_riscv32_mp_instr_in_14_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[27] = ms_riscv32_mp_instr_in_14_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[28] = ms_riscv32_mp_instr_in_14_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[29] = ms_riscv32_mp_instr_in_14_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[30] = ms_riscv32_mp_instr_in_14_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_15_toCore_ts1[31] = ms_riscv32_mp_instr_in_14_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_13_toCore[0] = ms_riscv32_mp_instr_in_13_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_13_toCore[1] = ms_riscv32_mp_instr_in_13_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_13_toCore[2] = ms_riscv32_mp_instr_in_13_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_13_toCore[3] = ms_riscv32_mp_instr_in_13_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_13_toCore[4] = ms_riscv32_mp_instr_in_13_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_13_toCore[5] = ms_riscv32_mp_instr_in_13_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_13_toCore[6] = ms_riscv32_mp_instr_in_13_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_13_toCore[7] = ms_riscv32_mp_instr_in_13_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_13_toCore[8] = ms_riscv32_mp_instr_in_13_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_13_toCore[9] = ms_riscv32_mp_instr_in_13_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_13_toCore[10] = ms_riscv32_mp_instr_in_13_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_13_toCore[11] = ms_riscv32_mp_instr_in_13_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_13_toCore[12] = ms_riscv32_mp_instr_in_13_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_13_toCore[14] = ms_riscv32_mp_instr_in_13_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_13_toCore[15] = ms_riscv32_mp_instr_in_13_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_13_toCore[16] = ms_riscv32_mp_instr_in_13_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_13_toCore[17] = ms_riscv32_mp_instr_in_13_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_13_toCore[18] = ms_riscv32_mp_instr_in_13_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_13_toCore[19] = ms_riscv32_mp_instr_in_13_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_13_toCore[20] = ms_riscv32_mp_instr_in_13_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_13_toCore[21] = ms_riscv32_mp_instr_in_13_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_13_toCore[22] = ms_riscv32_mp_instr_in_13_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_13_toCore[23] = ms_riscv32_mp_instr_in_13_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_13_toCore[24] = ms_riscv32_mp_instr_in_13_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_13_toCore[25] = ms_riscv32_mp_instr_in_13_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_13_toCore[26] = ms_riscv32_mp_instr_in_13_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_13_toCore[27] = ms_riscv32_mp_instr_in_13_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_13_toCore[28] = ms_riscv32_mp_instr_in_13_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_13_toCore[29] = ms_riscv32_mp_instr_in_13_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_13_toCore[30] = ms_riscv32_mp_instr_in_13_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_13_toCore[31] = ms_riscv32_mp_instr_in_13_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[0] = ms_riscv32_mp_instr_in_12_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[1] = ms_riscv32_mp_instr_in_12_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[2] = ms_riscv32_mp_instr_in_12_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[3] = ms_riscv32_mp_instr_in_12_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[4] = ms_riscv32_mp_instr_in_12_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[5] = ms_riscv32_mp_instr_in_12_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[6] = ms_riscv32_mp_instr_in_12_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[7] = ms_riscv32_mp_instr_in_12_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[8] = ms_riscv32_mp_instr_in_12_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[9] = ms_riscv32_mp_instr_in_12_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[10] = ms_riscv32_mp_instr_in_12_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[11] = ms_riscv32_mp_instr_in_12_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[13] = ms_riscv32_mp_instr_in_12_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[14] = ms_riscv32_mp_instr_in_12_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[15] = ms_riscv32_mp_instr_in_12_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[16] = ms_riscv32_mp_instr_in_12_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[17] = ms_riscv32_mp_instr_in_12_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[18] = ms_riscv32_mp_instr_in_12_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[19] = ms_riscv32_mp_instr_in_12_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[20] = ms_riscv32_mp_instr_in_12_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[21] = ms_riscv32_mp_instr_in_12_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[22] = ms_riscv32_mp_instr_in_12_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[23] = ms_riscv32_mp_instr_in_12_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[24] = ms_riscv32_mp_instr_in_12_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[25] = ms_riscv32_mp_instr_in_12_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[26] = ms_riscv32_mp_instr_in_12_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[27] = ms_riscv32_mp_instr_in_12_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[28] = ms_riscv32_mp_instr_in_12_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[29] = ms_riscv32_mp_instr_in_12_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[30] = ms_riscv32_mp_instr_in_12_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_13_toCore_ts1[31] = ms_riscv32_mp_instr_in_12_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_11_toCore[0] = ms_riscv32_mp_instr_in_11_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_11_toCore[1] = ms_riscv32_mp_instr_in_11_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_11_toCore[2] = ms_riscv32_mp_instr_in_11_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_11_toCore[3] = ms_riscv32_mp_instr_in_11_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_11_toCore[4] = ms_riscv32_mp_instr_in_11_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_11_toCore[5] = ms_riscv32_mp_instr_in_11_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_11_toCore[6] = ms_riscv32_mp_instr_in_11_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_11_toCore[7] = ms_riscv32_mp_instr_in_11_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_11_toCore[8] = ms_riscv32_mp_instr_in_11_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_11_toCore[9] = ms_riscv32_mp_instr_in_11_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_11_toCore[10] = ms_riscv32_mp_instr_in_11_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_11_toCore[12] = ms_riscv32_mp_instr_in_11_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_11_toCore[13] = ms_riscv32_mp_instr_in_11_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_11_toCore[14] = ms_riscv32_mp_instr_in_11_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_11_toCore[15] = ms_riscv32_mp_instr_in_11_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_11_toCore[16] = ms_riscv32_mp_instr_in_11_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_11_toCore[17] = ms_riscv32_mp_instr_in_11_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_11_toCore[18] = ms_riscv32_mp_instr_in_11_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_11_toCore[19] = ms_riscv32_mp_instr_in_11_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_11_toCore[20] = ms_riscv32_mp_instr_in_11_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_11_toCore[21] = ms_riscv32_mp_instr_in_11_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_11_toCore[22] = ms_riscv32_mp_instr_in_11_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_11_toCore[23] = ms_riscv32_mp_instr_in_11_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_11_toCore[24] = ms_riscv32_mp_instr_in_11_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_11_toCore[25] = ms_riscv32_mp_instr_in_11_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_11_toCore[26] = ms_riscv32_mp_instr_in_11_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_11_toCore[27] = ms_riscv32_mp_instr_in_11_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_11_toCore[28] = ms_riscv32_mp_instr_in_11_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_11_toCore[29] = ms_riscv32_mp_instr_in_11_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_11_toCore[30] = ms_riscv32_mp_instr_in_11_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_11_toCore[31] = ms_riscv32_mp_instr_in_11_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[0] = ms_riscv32_mp_instr_in_10_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[1] = ms_riscv32_mp_instr_in_10_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[2] = ms_riscv32_mp_instr_in_10_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[3] = ms_riscv32_mp_instr_in_10_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[4] = ms_riscv32_mp_instr_in_10_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[5] = ms_riscv32_mp_instr_in_10_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[6] = ms_riscv32_mp_instr_in_10_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[7] = ms_riscv32_mp_instr_in_10_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[8] = ms_riscv32_mp_instr_in_10_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[9] = ms_riscv32_mp_instr_in_10_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[11] = ms_riscv32_mp_instr_in_10_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[12] = ms_riscv32_mp_instr_in_10_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[13] = ms_riscv32_mp_instr_in_10_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[14] = ms_riscv32_mp_instr_in_10_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[15] = ms_riscv32_mp_instr_in_10_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[16] = ms_riscv32_mp_instr_in_10_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[17] = ms_riscv32_mp_instr_in_10_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[18] = ms_riscv32_mp_instr_in_10_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[19] = ms_riscv32_mp_instr_in_10_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[20] = ms_riscv32_mp_instr_in_10_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[21] = ms_riscv32_mp_instr_in_10_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[22] = ms_riscv32_mp_instr_in_10_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[23] = ms_riscv32_mp_instr_in_10_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[24] = ms_riscv32_mp_instr_in_10_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[25] = ms_riscv32_mp_instr_in_10_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[26] = ms_riscv32_mp_instr_in_10_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[27] = ms_riscv32_mp_instr_in_10_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[28] = ms_riscv32_mp_instr_in_10_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[29] = ms_riscv32_mp_instr_in_10_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[30] = ms_riscv32_mp_instr_in_10_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_11_toCore_ts1[31] = ms_riscv32_mp_instr_in_10_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_9_toCore[0] = ms_riscv32_mp_instr_in_9_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_9_toCore[1] = ms_riscv32_mp_instr_in_9_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_9_toCore[2] = ms_riscv32_mp_instr_in_9_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_9_toCore[3] = ms_riscv32_mp_instr_in_9_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_9_toCore[4] = ms_riscv32_mp_instr_in_9_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_9_toCore[5] = ms_riscv32_mp_instr_in_9_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_9_toCore[6] = ms_riscv32_mp_instr_in_9_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_9_toCore[7] = ms_riscv32_mp_instr_in_9_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_9_toCore[8] = ms_riscv32_mp_instr_in_9_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_9_toCore[10] = ms_riscv32_mp_instr_in_9_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_9_toCore[11] = ms_riscv32_mp_instr_in_9_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_9_toCore[12] = ms_riscv32_mp_instr_in_9_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_9_toCore[13] = ms_riscv32_mp_instr_in_9_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_9_toCore[14] = ms_riscv32_mp_instr_in_9_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_9_toCore[15] = ms_riscv32_mp_instr_in_9_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_9_toCore[16] = ms_riscv32_mp_instr_in_9_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_9_toCore[17] = ms_riscv32_mp_instr_in_9_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_9_toCore[18] = ms_riscv32_mp_instr_in_9_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_9_toCore[19] = ms_riscv32_mp_instr_in_9_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_9_toCore[20] = ms_riscv32_mp_instr_in_9_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_9_toCore[21] = ms_riscv32_mp_instr_in_9_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_9_toCore[22] = ms_riscv32_mp_instr_in_9_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_9_toCore[23] = ms_riscv32_mp_instr_in_9_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_9_toCore[24] = ms_riscv32_mp_instr_in_9_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_9_toCore[25] = ms_riscv32_mp_instr_in_9_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_9_toCore[26] = ms_riscv32_mp_instr_in_9_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_9_toCore[27] = ms_riscv32_mp_instr_in_9_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_9_toCore[28] = ms_riscv32_mp_instr_in_9_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_9_toCore[29] = ms_riscv32_mp_instr_in_9_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_9_toCore[30] = ms_riscv32_mp_instr_in_9_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_9_toCore[31] = ms_riscv32_mp_instr_in_9_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[0] = ms_riscv32_mp_instr_in_8_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[1] = ms_riscv32_mp_instr_in_8_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[2] = ms_riscv32_mp_instr_in_8_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[3] = ms_riscv32_mp_instr_in_8_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[4] = ms_riscv32_mp_instr_in_8_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[5] = ms_riscv32_mp_instr_in_8_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[6] = ms_riscv32_mp_instr_in_8_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[7] = ms_riscv32_mp_instr_in_8_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[9] = ms_riscv32_mp_instr_in_8_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[10] = ms_riscv32_mp_instr_in_8_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[11] = ms_riscv32_mp_instr_in_8_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[12] = ms_riscv32_mp_instr_in_8_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[13] = ms_riscv32_mp_instr_in_8_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[14] = ms_riscv32_mp_instr_in_8_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[15] = ms_riscv32_mp_instr_in_8_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[16] = ms_riscv32_mp_instr_in_8_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[17] = ms_riscv32_mp_instr_in_8_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[18] = ms_riscv32_mp_instr_in_8_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[19] = ms_riscv32_mp_instr_in_8_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[20] = ms_riscv32_mp_instr_in_8_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[21] = ms_riscv32_mp_instr_in_8_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[22] = ms_riscv32_mp_instr_in_8_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[23] = ms_riscv32_mp_instr_in_8_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[24] = ms_riscv32_mp_instr_in_8_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[25] = ms_riscv32_mp_instr_in_8_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[26] = ms_riscv32_mp_instr_in_8_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[27] = ms_riscv32_mp_instr_in_8_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[28] = ms_riscv32_mp_instr_in_8_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[29] = ms_riscv32_mp_instr_in_8_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[30] = ms_riscv32_mp_instr_in_8_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_9_toCore_ts1[31] = ms_riscv32_mp_instr_in_8_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_7_toCore[0] = ms_riscv32_mp_instr_in_7_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_7_toCore[1] = ms_riscv32_mp_instr_in_7_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_7_toCore[2] = ms_riscv32_mp_instr_in_7_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_7_toCore[3] = ms_riscv32_mp_instr_in_7_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_7_toCore[4] = ms_riscv32_mp_instr_in_7_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_7_toCore[5] = ms_riscv32_mp_instr_in_7_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_7_toCore[6] = ms_riscv32_mp_instr_in_7_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_7_toCore[8] = ms_riscv32_mp_instr_in_7_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_7_toCore[9] = ms_riscv32_mp_instr_in_7_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_7_toCore[10] = ms_riscv32_mp_instr_in_7_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_7_toCore[11] = ms_riscv32_mp_instr_in_7_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_7_toCore[12] = ms_riscv32_mp_instr_in_7_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_7_toCore[13] = ms_riscv32_mp_instr_in_7_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_7_toCore[14] = ms_riscv32_mp_instr_in_7_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_7_toCore[15] = ms_riscv32_mp_instr_in_7_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_7_toCore[16] = ms_riscv32_mp_instr_in_7_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_7_toCore[17] = ms_riscv32_mp_instr_in_7_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_7_toCore[18] = ms_riscv32_mp_instr_in_7_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_7_toCore[19] = ms_riscv32_mp_instr_in_7_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_7_toCore[20] = ms_riscv32_mp_instr_in_7_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_7_toCore[21] = ms_riscv32_mp_instr_in_7_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_7_toCore[22] = ms_riscv32_mp_instr_in_7_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_7_toCore[23] = ms_riscv32_mp_instr_in_7_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_7_toCore[24] = ms_riscv32_mp_instr_in_7_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_7_toCore[25] = ms_riscv32_mp_instr_in_7_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_7_toCore[26] = ms_riscv32_mp_instr_in_7_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_7_toCore[27] = ms_riscv32_mp_instr_in_7_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_7_toCore[28] = ms_riscv32_mp_instr_in_7_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_7_toCore[29] = ms_riscv32_mp_instr_in_7_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_7_toCore[30] = ms_riscv32_mp_instr_in_7_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_7_toCore[31] = ms_riscv32_mp_instr_in_7_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[0] = ms_riscv32_mp_instr_in_6_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[1] = ms_riscv32_mp_instr_in_6_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[2] = ms_riscv32_mp_instr_in_6_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[3] = ms_riscv32_mp_instr_in_6_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[4] = ms_riscv32_mp_instr_in_6_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[5] = ms_riscv32_mp_instr_in_6_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[7] = ms_riscv32_mp_instr_in_6_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[8] = ms_riscv32_mp_instr_in_6_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[9] = ms_riscv32_mp_instr_in_6_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[10] = ms_riscv32_mp_instr_in_6_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[11] = ms_riscv32_mp_instr_in_6_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[12] = ms_riscv32_mp_instr_in_6_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[13] = ms_riscv32_mp_instr_in_6_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[14] = ms_riscv32_mp_instr_in_6_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[15] = ms_riscv32_mp_instr_in_6_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[16] = ms_riscv32_mp_instr_in_6_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[17] = ms_riscv32_mp_instr_in_6_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[18] = ms_riscv32_mp_instr_in_6_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[19] = ms_riscv32_mp_instr_in_6_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[20] = ms_riscv32_mp_instr_in_6_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[21] = ms_riscv32_mp_instr_in_6_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[22] = ms_riscv32_mp_instr_in_6_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[23] = ms_riscv32_mp_instr_in_6_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[24] = ms_riscv32_mp_instr_in_6_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[25] = ms_riscv32_mp_instr_in_6_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[26] = ms_riscv32_mp_instr_in_6_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[27] = ms_riscv32_mp_instr_in_6_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[28] = ms_riscv32_mp_instr_in_6_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[29] = ms_riscv32_mp_instr_in_6_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[30] = ms_riscv32_mp_instr_in_6_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_7_toCore_ts1[31] = ms_riscv32_mp_instr_in_6_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_5_toCore[0] = ms_riscv32_mp_instr_in_5_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_5_toCore[1] = ms_riscv32_mp_instr_in_5_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_5_toCore[2] = ms_riscv32_mp_instr_in_5_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_5_toCore[3] = ms_riscv32_mp_instr_in_5_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_5_toCore[4] = ms_riscv32_mp_instr_in_5_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_5_toCore[6] = ms_riscv32_mp_instr_in_5_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_5_toCore[7] = ms_riscv32_mp_instr_in_5_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_5_toCore[8] = ms_riscv32_mp_instr_in_5_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_5_toCore[9] = ms_riscv32_mp_instr_in_5_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_5_toCore[10] = ms_riscv32_mp_instr_in_5_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_5_toCore[11] = ms_riscv32_mp_instr_in_5_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_5_toCore[12] = ms_riscv32_mp_instr_in_5_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_5_toCore[13] = ms_riscv32_mp_instr_in_5_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_5_toCore[14] = ms_riscv32_mp_instr_in_5_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_5_toCore[15] = ms_riscv32_mp_instr_in_5_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_5_toCore[16] = ms_riscv32_mp_instr_in_5_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_5_toCore[17] = ms_riscv32_mp_instr_in_5_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_5_toCore[18] = ms_riscv32_mp_instr_in_5_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_5_toCore[19] = ms_riscv32_mp_instr_in_5_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_5_toCore[20] = ms_riscv32_mp_instr_in_5_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_5_toCore[21] = ms_riscv32_mp_instr_in_5_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_5_toCore[22] = ms_riscv32_mp_instr_in_5_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_5_toCore[23] = ms_riscv32_mp_instr_in_5_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_5_toCore[24] = ms_riscv32_mp_instr_in_5_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_5_toCore[25] = ms_riscv32_mp_instr_in_5_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_5_toCore[26] = ms_riscv32_mp_instr_in_5_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_5_toCore[27] = ms_riscv32_mp_instr_in_5_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_5_toCore[28] = ms_riscv32_mp_instr_in_5_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_5_toCore[29] = ms_riscv32_mp_instr_in_5_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_5_toCore[30] = ms_riscv32_mp_instr_in_5_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_5_toCore[31] = ms_riscv32_mp_instr_in_5_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[0] = ms_riscv32_mp_instr_in_4_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[1] = ms_riscv32_mp_instr_in_4_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[2] = ms_riscv32_mp_instr_in_4_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[3] = ms_riscv32_mp_instr_in_4_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[5] = ms_riscv32_mp_instr_in_4_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[6] = ms_riscv32_mp_instr_in_4_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[7] = ms_riscv32_mp_instr_in_4_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[8] = ms_riscv32_mp_instr_in_4_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[9] = ms_riscv32_mp_instr_in_4_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[10] = ms_riscv32_mp_instr_in_4_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[11] = ms_riscv32_mp_instr_in_4_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[12] = ms_riscv32_mp_instr_in_4_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[13] = ms_riscv32_mp_instr_in_4_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[14] = ms_riscv32_mp_instr_in_4_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[15] = ms_riscv32_mp_instr_in_4_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[16] = ms_riscv32_mp_instr_in_4_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[17] = ms_riscv32_mp_instr_in_4_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[18] = ms_riscv32_mp_instr_in_4_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[19] = ms_riscv32_mp_instr_in_4_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[20] = ms_riscv32_mp_instr_in_4_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[21] = ms_riscv32_mp_instr_in_4_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[22] = ms_riscv32_mp_instr_in_4_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[23] = ms_riscv32_mp_instr_in_4_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[24] = ms_riscv32_mp_instr_in_4_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[25] = ms_riscv32_mp_instr_in_4_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[26] = ms_riscv32_mp_instr_in_4_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[27] = ms_riscv32_mp_instr_in_4_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[28] = ms_riscv32_mp_instr_in_4_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[29] = ms_riscv32_mp_instr_in_4_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[30] = ms_riscv32_mp_instr_in_4_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_5_toCore_ts1[31] = ms_riscv32_mp_instr_in_4_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_3_toCore[0] = ms_riscv32_mp_instr_in_3_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_3_toCore[1] = ms_riscv32_mp_instr_in_3_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_3_toCore[2] = ms_riscv32_mp_instr_in_3_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_3_toCore[4] = ms_riscv32_mp_instr_in_3_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_3_toCore[5] = ms_riscv32_mp_instr_in_3_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_3_toCore[6] = ms_riscv32_mp_instr_in_3_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_3_toCore[7] = ms_riscv32_mp_instr_in_3_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_3_toCore[8] = ms_riscv32_mp_instr_in_3_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_3_toCore[9] = ms_riscv32_mp_instr_in_3_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_3_toCore[10] = ms_riscv32_mp_instr_in_3_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_3_toCore[11] = ms_riscv32_mp_instr_in_3_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_3_toCore[12] = ms_riscv32_mp_instr_in_3_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_3_toCore[13] = ms_riscv32_mp_instr_in_3_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_3_toCore[14] = ms_riscv32_mp_instr_in_3_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_3_toCore[15] = ms_riscv32_mp_instr_in_3_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_3_toCore[16] = ms_riscv32_mp_instr_in_3_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_3_toCore[17] = ms_riscv32_mp_instr_in_3_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_3_toCore[18] = ms_riscv32_mp_instr_in_3_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_3_toCore[19] = ms_riscv32_mp_instr_in_3_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_3_toCore[20] = ms_riscv32_mp_instr_in_3_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_3_toCore[21] = ms_riscv32_mp_instr_in_3_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_3_toCore[22] = ms_riscv32_mp_instr_in_3_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_3_toCore[23] = ms_riscv32_mp_instr_in_3_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_3_toCore[24] = ms_riscv32_mp_instr_in_3_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_3_toCore[25] = ms_riscv32_mp_instr_in_3_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_3_toCore[26] = ms_riscv32_mp_instr_in_3_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_3_toCore[27] = ms_riscv32_mp_instr_in_3_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_3_toCore[28] = ms_riscv32_mp_instr_in_3_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_3_toCore[29] = ms_riscv32_mp_instr_in_3_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_3_toCore[30] = ms_riscv32_mp_instr_in_3_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_3_toCore[31] = ms_riscv32_mp_instr_in_3_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[0] = ms_riscv32_mp_instr_in_2_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[1] = ms_riscv32_mp_instr_in_2_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[3] = ms_riscv32_mp_instr_in_2_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[4] = ms_riscv32_mp_instr_in_2_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[5] = ms_riscv32_mp_instr_in_2_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[6] = ms_riscv32_mp_instr_in_2_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[7] = ms_riscv32_mp_instr_in_2_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[8] = ms_riscv32_mp_instr_in_2_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[9] = ms_riscv32_mp_instr_in_2_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[10] = ms_riscv32_mp_instr_in_2_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[11] = ms_riscv32_mp_instr_in_2_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[12] = ms_riscv32_mp_instr_in_2_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[13] = ms_riscv32_mp_instr_in_2_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[14] = ms_riscv32_mp_instr_in_2_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[15] = ms_riscv32_mp_instr_in_2_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[16] = ms_riscv32_mp_instr_in_2_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[17] = ms_riscv32_mp_instr_in_2_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[18] = ms_riscv32_mp_instr_in_2_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[19] = ms_riscv32_mp_instr_in_2_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[20] = ms_riscv32_mp_instr_in_2_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[21] = ms_riscv32_mp_instr_in_2_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[22] = ms_riscv32_mp_instr_in_2_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[23] = ms_riscv32_mp_instr_in_2_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[24] = ms_riscv32_mp_instr_in_2_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[25] = ms_riscv32_mp_instr_in_2_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[26] = ms_riscv32_mp_instr_in_2_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[27] = ms_riscv32_mp_instr_in_2_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[28] = ms_riscv32_mp_instr_in_2_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[29] = ms_riscv32_mp_instr_in_2_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[30] = ms_riscv32_mp_instr_in_2_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_3_toCore_ts1[31] = ms_riscv32_mp_instr_in_2_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_1_toCore[0] = ms_riscv32_mp_instr_in_1_toCore_ts1[0];

  assign ms_riscv32_mp_instr_in_1_toCore[2] = ms_riscv32_mp_instr_in_1_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_1_toCore[3] = ms_riscv32_mp_instr_in_1_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_1_toCore[4] = ms_riscv32_mp_instr_in_1_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_1_toCore[5] = ms_riscv32_mp_instr_in_1_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_1_toCore[6] = ms_riscv32_mp_instr_in_1_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_1_toCore[7] = ms_riscv32_mp_instr_in_1_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_1_toCore[8] = ms_riscv32_mp_instr_in_1_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_1_toCore[9] = ms_riscv32_mp_instr_in_1_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_1_toCore[10] = ms_riscv32_mp_instr_in_1_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_1_toCore[11] = ms_riscv32_mp_instr_in_1_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_1_toCore[12] = ms_riscv32_mp_instr_in_1_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_1_toCore[13] = ms_riscv32_mp_instr_in_1_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_1_toCore[14] = ms_riscv32_mp_instr_in_1_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_1_toCore[15] = ms_riscv32_mp_instr_in_1_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_1_toCore[16] = ms_riscv32_mp_instr_in_1_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_1_toCore[17] = ms_riscv32_mp_instr_in_1_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_1_toCore[18] = ms_riscv32_mp_instr_in_1_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_1_toCore[19] = ms_riscv32_mp_instr_in_1_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_1_toCore[20] = ms_riscv32_mp_instr_in_1_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_1_toCore[21] = ms_riscv32_mp_instr_in_1_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_1_toCore[22] = ms_riscv32_mp_instr_in_1_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_1_toCore[23] = ms_riscv32_mp_instr_in_1_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_1_toCore[24] = ms_riscv32_mp_instr_in_1_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_1_toCore[25] = ms_riscv32_mp_instr_in_1_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_1_toCore[26] = ms_riscv32_mp_instr_in_1_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_1_toCore[27] = ms_riscv32_mp_instr_in_1_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_1_toCore[28] = ms_riscv32_mp_instr_in_1_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_1_toCore[29] = ms_riscv32_mp_instr_in_1_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_1_toCore[30] = ms_riscv32_mp_instr_in_1_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_1_toCore[31] = ms_riscv32_mp_instr_in_1_toCore_ts1[31];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[1] = ms_riscv32_mp_instr_in_0_toCore_ts1[1];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[2] = ms_riscv32_mp_instr_in_0_toCore_ts1[2];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[3] = ms_riscv32_mp_instr_in_0_toCore_ts1[3];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[4] = ms_riscv32_mp_instr_in_0_toCore_ts1[4];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[5] = ms_riscv32_mp_instr_in_0_toCore_ts1[5];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[6] = ms_riscv32_mp_instr_in_0_toCore_ts1[6];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[7] = ms_riscv32_mp_instr_in_0_toCore_ts1[7];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[8] = ms_riscv32_mp_instr_in_0_toCore_ts1[8];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[9] = ms_riscv32_mp_instr_in_0_toCore_ts1[9];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[10] = ms_riscv32_mp_instr_in_0_toCore_ts1[10];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[11] = ms_riscv32_mp_instr_in_0_toCore_ts1[11];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[12] = ms_riscv32_mp_instr_in_0_toCore_ts1[12];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[13] = ms_riscv32_mp_instr_in_0_toCore_ts1[13];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[14] = ms_riscv32_mp_instr_in_0_toCore_ts1[14];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[15] = ms_riscv32_mp_instr_in_0_toCore_ts1[15];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[16] = ms_riscv32_mp_instr_in_0_toCore_ts1[16];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[17] = ms_riscv32_mp_instr_in_0_toCore_ts1[17];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[18] = ms_riscv32_mp_instr_in_0_toCore_ts1[18];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[19] = ms_riscv32_mp_instr_in_0_toCore_ts1[19];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[20] = ms_riscv32_mp_instr_in_0_toCore_ts1[20];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[21] = ms_riscv32_mp_instr_in_0_toCore_ts1[21];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[22] = ms_riscv32_mp_instr_in_0_toCore_ts1[22];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[23] = ms_riscv32_mp_instr_in_0_toCore_ts1[23];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[24] = ms_riscv32_mp_instr_in_0_toCore_ts1[24];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[25] = ms_riscv32_mp_instr_in_0_toCore_ts1[25];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[26] = ms_riscv32_mp_instr_in_0_toCore_ts1[26];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[27] = ms_riscv32_mp_instr_in_0_toCore_ts1[27];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[28] = ms_riscv32_mp_instr_in_0_toCore_ts1[28];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[29] = ms_riscv32_mp_instr_in_0_toCore_ts1[29];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[30] = ms_riscv32_mp_instr_in_0_toCore_ts1[30];

  assign ms_riscv32_mp_instr_in_1_toCore_ts1[31] = ms_riscv32_mp_instr_in_0_toCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_31_toPad_ts1[31] = ms_riscv32_mp_dmaddr_out_31_toPad;

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_30_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_31_toPad_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_29_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_29_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_29_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_29_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_29_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_29_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_29_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_29_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_29_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_29_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_29_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_29_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_29_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_29_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_29_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_29_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_29_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_29_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_29_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_29_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_29_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_29_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_29_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_29_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_29_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_29_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_29_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_29_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_29_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_29_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_29_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_28_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_29_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_27_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_27_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_27_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_27_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_27_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_27_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_27_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_27_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_27_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_27_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_27_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_27_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_27_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_27_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_27_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_27_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_27_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_27_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_27_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_27_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_27_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_27_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_27_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_27_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_27_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_27_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_27_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_27_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_27_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_27_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_27_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_26_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_27_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_25_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_25_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_25_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_25_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_25_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_25_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_25_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_25_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_25_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_25_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_25_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_25_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_25_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_25_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_25_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_25_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_25_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_25_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_25_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_25_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_25_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_25_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_25_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_25_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_25_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_25_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_25_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_25_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_25_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_25_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_25_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_24_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_25_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_23_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_23_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_23_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_23_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_23_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_23_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_23_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_23_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_23_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_23_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_23_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_23_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_23_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_23_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_23_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_23_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_23_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_23_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_23_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_23_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_23_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_23_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_23_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_23_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_23_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_23_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_23_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_23_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_23_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_23_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_23_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_22_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_23_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_21_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_21_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_21_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_21_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_21_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_21_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_21_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_21_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_21_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_21_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_21_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_21_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_21_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_21_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_21_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_21_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_21_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_21_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_21_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_21_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_21_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_21_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_21_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_21_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_21_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_21_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_21_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_21_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_21_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_21_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_21_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_20_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_21_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_19_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_19_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_19_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_19_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_19_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_19_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_19_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_19_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_19_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_19_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_19_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_19_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_19_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_19_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_19_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_19_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_19_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_19_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_19_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_19_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_19_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_19_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_19_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_19_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_19_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_19_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_19_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_19_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_19_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_19_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_19_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_18_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_19_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_17_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_17_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_17_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_17_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_17_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_17_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_17_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_17_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_17_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_17_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_17_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_17_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_17_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_17_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_17_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_17_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_17_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_17_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_17_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_17_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_17_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_17_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_17_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_17_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_17_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_17_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_17_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_17_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_17_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_17_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_17_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_16_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_17_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_15_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_15_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_15_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_15_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_15_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_15_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_15_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_15_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_15_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_15_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_15_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_15_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_15_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_15_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_15_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_15_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_15_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_15_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_15_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_15_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_15_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_15_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_15_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_15_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_15_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_15_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_15_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_15_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_15_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_15_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_15_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_14_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_15_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_13_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_13_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_13_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_13_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_13_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_13_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_13_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_13_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_13_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_13_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_13_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_13_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_13_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_13_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_13_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_13_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_13_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_13_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_13_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_13_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_13_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_13_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_13_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_13_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_13_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_13_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_13_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_13_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_13_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_13_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_13_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_12_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_13_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_11_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_11_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_11_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_11_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_11_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_11_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_11_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_11_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_11_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_11_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_11_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_11_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_11_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_11_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_11_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_11_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_11_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_11_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_11_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_11_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_11_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_11_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_11_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_11_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_11_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_11_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_11_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_11_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_11_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_11_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_11_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_10_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_11_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_9_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_9_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_9_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_9_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_9_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_9_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_9_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_9_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_9_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_9_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_9_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_9_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_9_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_9_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_9_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_9_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_9_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_9_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_9_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_9_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_9_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_9_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_9_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_9_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_9_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_9_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_9_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_9_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_9_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_9_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_9_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_8_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_9_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_7_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_7_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_7_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_7_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_7_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_7_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_7_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_7_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_7_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_7_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_7_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_7_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_7_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_7_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_7_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_7_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_7_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_7_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_7_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_7_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_7_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_7_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_7_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_7_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_7_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_7_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_7_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_7_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_7_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_7_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_7_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_6_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_7_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_5_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_5_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_5_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_5_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_5_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_5_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_5_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_5_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_5_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_5_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_5_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_5_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_5_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_5_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_5_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_5_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_5_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_5_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_5_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_5_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_5_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_5_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_5_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_5_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_5_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_5_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_5_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_5_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_5_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_5_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_5_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_4_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_5_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_3_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_3_fromCore[1];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_3_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_3_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_3_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_3_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_3_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_3_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_3_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_3_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_3_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_3_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_3_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_3_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_3_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_3_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_3_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_3_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_3_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_3_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_3_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_3_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_3_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_3_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_3_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_3_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_3_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_3_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_3_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_3_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_3_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[0];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_2_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_3_fromCore_ts1[31];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[0] = ms_riscv32_mp_dmaddr_out_1_fromCore[0];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_1_fromCore[2];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_1_fromCore[3];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_1_fromCore[4];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_1_fromCore[5];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_1_fromCore[6];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_1_fromCore[7];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_1_fromCore[8];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_1_fromCore[9];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_1_fromCore[10];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_1_fromCore[11];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_1_fromCore[12];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_1_fromCore[13];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_1_fromCore[14];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_1_fromCore[15];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_1_fromCore[16];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_1_fromCore[17];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_1_fromCore[18];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_1_fromCore[19];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_1_fromCore[20];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_1_fromCore[21];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_1_fromCore[22];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_1_fromCore[23];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_1_fromCore[24];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_1_fromCore[25];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_1_fromCore[26];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_1_fromCore[27];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_1_fromCore[28];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_1_fromCore[29];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_1_fromCore[30];

  assign ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_1_fromCore[31];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[1] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[1];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[2] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[2];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[3] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[3];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[4] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[4];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[5] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[5];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[6] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[6];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[7] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[7];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[8] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[8];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[9] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[9];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[10] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[10];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[11] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[11];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[12] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[12];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[13] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[13];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[14] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[14];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[15] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[15];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[16] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[16];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[17] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[17];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[18] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[18];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[19] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[19];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[20] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[20];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[21] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[21];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[22] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[22];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[23] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[23];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[24] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[24];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[25] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[25];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[26] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[26];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[27] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[27];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[28] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[28];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[29] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[29];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[30] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[30];

  assign ms_riscv32_mp_dmaddr_out_0_fromCore_ts1[31] = ms_riscv32_mp_dmaddr_out_1_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_31_toPad_ts1[31] = ms_riscv32_mp_dmdata_out_31_toPad;

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[0];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[1];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[2];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[3];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[4];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[5];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[6];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[7];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[8];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[9];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[10];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[11];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[12];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[13];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[14];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[15];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[16];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[17];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[18];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[19];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[20];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[21];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[22];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[23];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[24];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[25];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[26];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[27];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[28];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[29];

  assign ms_riscv32_mp_dmdata_out_30_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_31_toPad_ts1[31];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_29_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_29_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_29_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_29_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_29_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_29_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_29_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_29_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_29_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_29_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_29_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_29_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_29_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_29_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_29_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_29_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_29_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_29_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_29_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_29_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_29_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_29_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_29_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_29_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_29_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_29_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_29_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_29_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_29_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_29_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_29_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_29_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_28_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_29_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_27_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_27_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_27_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_27_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_27_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_27_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_27_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_27_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_27_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_27_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_27_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_27_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_27_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_27_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_27_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_27_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_27_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_27_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_27_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_27_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_27_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_27_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_27_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_27_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_27_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_27_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_27_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_27_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_27_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_27_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_27_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_27_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_26_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_27_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_25_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_25_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_25_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_25_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_25_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_25_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_25_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_25_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_25_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_25_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_25_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_25_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_25_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_25_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_25_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_25_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_25_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_25_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_25_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_25_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_25_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_25_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_25_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_25_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_25_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_25_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_25_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_25_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_25_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_25_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_25_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_25_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_24_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_25_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_23_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_23_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_23_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_23_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_23_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_23_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_23_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_23_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_23_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_23_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_23_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_23_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_23_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_23_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_23_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_23_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_23_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_23_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_23_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_23_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_23_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_23_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_23_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_23_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_23_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_23_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_23_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_23_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_23_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_23_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_23_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_23_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_22_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_23_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_21_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_21_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_21_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_21_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_21_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_21_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_21_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_21_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_21_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_21_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_21_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_21_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_21_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_21_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_21_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_21_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_21_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_21_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_21_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_21_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_21_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_21_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_21_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_21_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_21_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_21_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_21_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_21_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_21_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_21_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_21_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_21_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_20_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_21_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_19_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_19_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_19_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_19_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_19_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_19_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_19_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_19_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_19_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_19_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_19_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_19_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_19_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_19_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_19_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_19_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_19_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_19_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_19_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_19_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_19_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_19_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_19_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_19_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_19_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_19_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_19_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_19_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_19_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_19_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_19_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_19_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_18_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_19_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_17_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_17_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_17_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_17_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_17_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_17_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_17_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_17_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_17_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_17_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_17_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_17_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_17_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_17_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_17_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_17_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_17_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_17_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_17_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_17_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_17_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_17_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_17_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_17_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_17_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_17_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_17_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_17_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_17_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_17_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_17_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_17_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_16_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_17_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_15_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_15_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_15_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_15_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_15_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_15_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_15_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_15_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_15_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_15_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_15_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_15_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_15_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_15_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_15_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_15_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_15_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_15_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_15_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_15_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_15_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_15_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_15_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_15_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_15_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_15_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_15_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_15_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_15_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_15_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_15_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_15_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_14_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_15_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_13_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_13_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_13_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_13_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_13_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_13_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_13_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_13_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_13_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_13_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_13_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_13_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_13_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_13_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_13_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_13_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_13_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_13_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_13_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_13_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_13_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_13_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_13_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_13_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_13_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_13_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_13_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_13_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_13_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_13_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_13_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_13_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_12_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_13_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_11_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_11_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_11_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_11_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_11_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_11_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_11_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_11_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_11_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_11_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_11_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_11_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_11_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_11_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_11_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_11_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_11_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_11_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_11_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_11_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_11_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_11_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_11_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_11_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_11_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_11_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_11_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_11_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_11_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_11_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_11_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_11_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_10_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_11_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_9_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_9_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_9_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_9_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_9_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_9_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_9_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_9_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_9_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_9_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_9_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_9_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_9_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_9_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_9_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_9_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_9_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_9_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_9_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_9_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_9_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_9_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_9_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_9_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_9_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_9_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_9_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_9_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_9_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_9_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_9_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_9_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_8_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_9_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_7_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_7_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_7_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_7_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_7_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_7_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_7_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_7_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_7_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_7_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_7_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_7_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_7_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_7_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_7_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_7_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_7_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_7_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_7_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_7_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_7_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_7_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_7_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_7_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_7_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_7_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_7_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_7_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_7_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_7_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_7_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_7_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_6_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_7_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_5_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_5_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_5_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_5_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_5_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_5_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_5_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_5_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_5_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_5_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_5_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_5_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_5_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_5_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_5_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_5_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_5_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_5_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_5_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_5_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_5_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_5_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_5_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_5_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_5_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_5_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_5_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_5_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_5_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_5_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_5_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_5_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_4_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_5_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_3_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_3_fromCore[1];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_3_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_3_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_3_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_3_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_3_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_3_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_3_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_3_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_3_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_3_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_3_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_3_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_3_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_3_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_3_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_3_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_3_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_3_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_3_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_3_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_3_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_3_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_3_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_3_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_3_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_3_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_3_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_3_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_3_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_3_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[0];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_2_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_3_fromCore_ts1[31];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[0] = ms_riscv32_mp_dmdata_out_1_fromCore[0];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_1_fromCore[2];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_1_fromCore[3];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_1_fromCore[4];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_1_fromCore[5];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_1_fromCore[6];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_1_fromCore[7];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_1_fromCore[8];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_1_fromCore[9];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_1_fromCore[10];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_1_fromCore[11];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_1_fromCore[12];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_1_fromCore[13];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_1_fromCore[14];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_1_fromCore[15];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_1_fromCore[16];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_1_fromCore[17];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_1_fromCore[18];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_1_fromCore[19];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_1_fromCore[20];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_1_fromCore[21];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_1_fromCore[22];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_1_fromCore[23];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_1_fromCore[24];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_1_fromCore[25];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_1_fromCore[26];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_1_fromCore[27];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_1_fromCore[28];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_1_fromCore[29];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_1_fromCore[30];

  assign ms_riscv32_mp_dmdata_out_1_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_1_fromCore[31];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[1] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[1];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[2] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[2];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[3] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[3];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[4] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[4];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[5] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[5];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[6] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[6];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[7] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[7];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[8] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[8];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[9] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[9];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[10] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[10];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[11] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[11];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[12] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[12];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[13] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[13];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[14] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[14];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[15] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[15];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[16] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[16];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[17] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[17];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[18] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[18];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[19] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[19];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[20] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[20];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[21] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[21];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[22] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[22];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[23] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[23];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[24] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[24];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[25] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[25];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[26] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[26];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[27] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[27];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[28] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[28];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[29] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[29];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[30] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[30];

  assign ms_riscv32_mp_dmdata_out_0_fromCore_ts1[31] = ms_riscv32_mp_dmdata_out_1_fromCore_ts1[31];

  assign ms_riscv32_mp_dmwr_mask_out_3_toPad_ts1[3] = ms_riscv32_mp_dmwr_mask_out_3_toPad;

  assign ms_riscv32_mp_dmwr_mask_out_2_fromCore_ts1[0] = ms_riscv32_mp_dmwr_mask_out_3_toPad_ts1[0];

  assign ms_riscv32_mp_dmwr_mask_out_2_fromCore_ts1[1] = ms_riscv32_mp_dmwr_mask_out_3_toPad_ts1[1];

  assign ms_riscv32_mp_dmwr_mask_out_2_fromCore_ts1[3] = ms_riscv32_mp_dmwr_mask_out_3_toPad_ts1[3];

  assign ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[0] = ms_riscv32_mp_dmwr_mask_out_1_fromCore[0];

  assign ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[2] = ms_riscv32_mp_dmwr_mask_out_1_fromCore[2];

  assign ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[3] = ms_riscv32_mp_dmwr_mask_out_1_fromCore[3];

  assign ms_riscv32_mp_dmwr_mask_out_0_fromCore_ts1[1] = ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[1];

  assign ms_riscv32_mp_dmwr_mask_out_0_fromCore_ts1[2] = ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[2];

  assign ms_riscv32_mp_dmwr_mask_out_0_fromCore_ts1[3] = ms_riscv32_mp_dmwr_mask_out_1_fromCore_ts1[3];

  assign ms_riscv32_mp_data_in_31_fromPad = ms_riscv32_mp_data_in_31_fromPad_ts1[31];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[0] = ms_riscv32_mp_data_in_30_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[1] = ms_riscv32_mp_data_in_30_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[2] = ms_riscv32_mp_data_in_30_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[3] = ms_riscv32_mp_data_in_30_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[4] = ms_riscv32_mp_data_in_30_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[5] = ms_riscv32_mp_data_in_30_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[6] = ms_riscv32_mp_data_in_30_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[7] = ms_riscv32_mp_data_in_30_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[8] = ms_riscv32_mp_data_in_30_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[9] = ms_riscv32_mp_data_in_30_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[10] = ms_riscv32_mp_data_in_30_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[11] = ms_riscv32_mp_data_in_30_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[12] = ms_riscv32_mp_data_in_30_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[13] = ms_riscv32_mp_data_in_30_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[14] = ms_riscv32_mp_data_in_30_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[15] = ms_riscv32_mp_data_in_30_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[16] = ms_riscv32_mp_data_in_30_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[17] = ms_riscv32_mp_data_in_30_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[18] = ms_riscv32_mp_data_in_30_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[19] = ms_riscv32_mp_data_in_30_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[20] = ms_riscv32_mp_data_in_30_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[21] = ms_riscv32_mp_data_in_30_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[22] = ms_riscv32_mp_data_in_30_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[23] = ms_riscv32_mp_data_in_30_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[24] = ms_riscv32_mp_data_in_30_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[25] = ms_riscv32_mp_data_in_30_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[26] = ms_riscv32_mp_data_in_30_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[27] = ms_riscv32_mp_data_in_30_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[28] = ms_riscv32_mp_data_in_30_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[29] = ms_riscv32_mp_data_in_30_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_31_fromPad_ts1[31] = ms_riscv32_mp_data_in_30_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_29_toCore[0] = ms_riscv32_mp_data_in_29_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_29_toCore[1] = ms_riscv32_mp_data_in_29_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_29_toCore[2] = ms_riscv32_mp_data_in_29_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_29_toCore[3] = ms_riscv32_mp_data_in_29_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_29_toCore[4] = ms_riscv32_mp_data_in_29_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_29_toCore[5] = ms_riscv32_mp_data_in_29_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_29_toCore[6] = ms_riscv32_mp_data_in_29_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_29_toCore[7] = ms_riscv32_mp_data_in_29_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_29_toCore[8] = ms_riscv32_mp_data_in_29_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_29_toCore[9] = ms_riscv32_mp_data_in_29_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_29_toCore[10] = ms_riscv32_mp_data_in_29_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_29_toCore[11] = ms_riscv32_mp_data_in_29_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_29_toCore[12] = ms_riscv32_mp_data_in_29_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_29_toCore[13] = ms_riscv32_mp_data_in_29_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_29_toCore[14] = ms_riscv32_mp_data_in_29_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_29_toCore[15] = ms_riscv32_mp_data_in_29_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_29_toCore[16] = ms_riscv32_mp_data_in_29_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_29_toCore[17] = ms_riscv32_mp_data_in_29_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_29_toCore[18] = ms_riscv32_mp_data_in_29_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_29_toCore[19] = ms_riscv32_mp_data_in_29_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_29_toCore[20] = ms_riscv32_mp_data_in_29_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_29_toCore[21] = ms_riscv32_mp_data_in_29_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_29_toCore[22] = ms_riscv32_mp_data_in_29_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_29_toCore[23] = ms_riscv32_mp_data_in_29_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_29_toCore[24] = ms_riscv32_mp_data_in_29_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_29_toCore[25] = ms_riscv32_mp_data_in_29_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_29_toCore[26] = ms_riscv32_mp_data_in_29_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_29_toCore[27] = ms_riscv32_mp_data_in_29_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_29_toCore[28] = ms_riscv32_mp_data_in_29_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_29_toCore[30] = ms_riscv32_mp_data_in_29_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_29_toCore[31] = ms_riscv32_mp_data_in_29_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[0] = ms_riscv32_mp_data_in_28_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[1] = ms_riscv32_mp_data_in_28_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[2] = ms_riscv32_mp_data_in_28_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[3] = ms_riscv32_mp_data_in_28_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[4] = ms_riscv32_mp_data_in_28_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[5] = ms_riscv32_mp_data_in_28_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[6] = ms_riscv32_mp_data_in_28_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[7] = ms_riscv32_mp_data_in_28_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[8] = ms_riscv32_mp_data_in_28_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[9] = ms_riscv32_mp_data_in_28_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[10] = ms_riscv32_mp_data_in_28_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[11] = ms_riscv32_mp_data_in_28_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[12] = ms_riscv32_mp_data_in_28_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[13] = ms_riscv32_mp_data_in_28_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[14] = ms_riscv32_mp_data_in_28_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[15] = ms_riscv32_mp_data_in_28_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[16] = ms_riscv32_mp_data_in_28_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[17] = ms_riscv32_mp_data_in_28_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[18] = ms_riscv32_mp_data_in_28_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[19] = ms_riscv32_mp_data_in_28_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[20] = ms_riscv32_mp_data_in_28_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[21] = ms_riscv32_mp_data_in_28_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[22] = ms_riscv32_mp_data_in_28_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[23] = ms_riscv32_mp_data_in_28_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[24] = ms_riscv32_mp_data_in_28_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[25] = ms_riscv32_mp_data_in_28_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[26] = ms_riscv32_mp_data_in_28_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[27] = ms_riscv32_mp_data_in_28_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[29] = ms_riscv32_mp_data_in_28_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[30] = ms_riscv32_mp_data_in_28_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_29_toCore_ts1[31] = ms_riscv32_mp_data_in_28_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_27_toCore[0] = ms_riscv32_mp_data_in_27_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_27_toCore[1] = ms_riscv32_mp_data_in_27_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_27_toCore[2] = ms_riscv32_mp_data_in_27_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_27_toCore[3] = ms_riscv32_mp_data_in_27_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_27_toCore[4] = ms_riscv32_mp_data_in_27_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_27_toCore[5] = ms_riscv32_mp_data_in_27_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_27_toCore[6] = ms_riscv32_mp_data_in_27_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_27_toCore[7] = ms_riscv32_mp_data_in_27_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_27_toCore[8] = ms_riscv32_mp_data_in_27_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_27_toCore[9] = ms_riscv32_mp_data_in_27_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_27_toCore[10] = ms_riscv32_mp_data_in_27_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_27_toCore[11] = ms_riscv32_mp_data_in_27_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_27_toCore[12] = ms_riscv32_mp_data_in_27_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_27_toCore[13] = ms_riscv32_mp_data_in_27_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_27_toCore[14] = ms_riscv32_mp_data_in_27_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_27_toCore[15] = ms_riscv32_mp_data_in_27_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_27_toCore[16] = ms_riscv32_mp_data_in_27_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_27_toCore[17] = ms_riscv32_mp_data_in_27_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_27_toCore[18] = ms_riscv32_mp_data_in_27_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_27_toCore[19] = ms_riscv32_mp_data_in_27_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_27_toCore[20] = ms_riscv32_mp_data_in_27_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_27_toCore[21] = ms_riscv32_mp_data_in_27_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_27_toCore[22] = ms_riscv32_mp_data_in_27_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_27_toCore[23] = ms_riscv32_mp_data_in_27_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_27_toCore[24] = ms_riscv32_mp_data_in_27_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_27_toCore[25] = ms_riscv32_mp_data_in_27_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_27_toCore[26] = ms_riscv32_mp_data_in_27_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_27_toCore[28] = ms_riscv32_mp_data_in_27_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_27_toCore[29] = ms_riscv32_mp_data_in_27_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_27_toCore[30] = ms_riscv32_mp_data_in_27_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_27_toCore[31] = ms_riscv32_mp_data_in_27_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[0] = ms_riscv32_mp_data_in_26_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[1] = ms_riscv32_mp_data_in_26_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[2] = ms_riscv32_mp_data_in_26_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[3] = ms_riscv32_mp_data_in_26_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[4] = ms_riscv32_mp_data_in_26_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[5] = ms_riscv32_mp_data_in_26_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[6] = ms_riscv32_mp_data_in_26_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[7] = ms_riscv32_mp_data_in_26_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[8] = ms_riscv32_mp_data_in_26_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[9] = ms_riscv32_mp_data_in_26_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[10] = ms_riscv32_mp_data_in_26_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[11] = ms_riscv32_mp_data_in_26_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[12] = ms_riscv32_mp_data_in_26_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[13] = ms_riscv32_mp_data_in_26_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[14] = ms_riscv32_mp_data_in_26_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[15] = ms_riscv32_mp_data_in_26_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[16] = ms_riscv32_mp_data_in_26_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[17] = ms_riscv32_mp_data_in_26_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[18] = ms_riscv32_mp_data_in_26_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[19] = ms_riscv32_mp_data_in_26_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[20] = ms_riscv32_mp_data_in_26_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[21] = ms_riscv32_mp_data_in_26_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[22] = ms_riscv32_mp_data_in_26_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[23] = ms_riscv32_mp_data_in_26_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[24] = ms_riscv32_mp_data_in_26_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[25] = ms_riscv32_mp_data_in_26_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[27] = ms_riscv32_mp_data_in_26_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[28] = ms_riscv32_mp_data_in_26_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[29] = ms_riscv32_mp_data_in_26_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[30] = ms_riscv32_mp_data_in_26_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_27_toCore_ts1[31] = ms_riscv32_mp_data_in_26_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_25_toCore[0] = ms_riscv32_mp_data_in_25_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_25_toCore[1] = ms_riscv32_mp_data_in_25_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_25_toCore[2] = ms_riscv32_mp_data_in_25_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_25_toCore[3] = ms_riscv32_mp_data_in_25_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_25_toCore[4] = ms_riscv32_mp_data_in_25_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_25_toCore[5] = ms_riscv32_mp_data_in_25_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_25_toCore[6] = ms_riscv32_mp_data_in_25_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_25_toCore[7] = ms_riscv32_mp_data_in_25_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_25_toCore[8] = ms_riscv32_mp_data_in_25_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_25_toCore[9] = ms_riscv32_mp_data_in_25_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_25_toCore[10] = ms_riscv32_mp_data_in_25_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_25_toCore[11] = ms_riscv32_mp_data_in_25_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_25_toCore[12] = ms_riscv32_mp_data_in_25_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_25_toCore[13] = ms_riscv32_mp_data_in_25_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_25_toCore[14] = ms_riscv32_mp_data_in_25_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_25_toCore[15] = ms_riscv32_mp_data_in_25_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_25_toCore[16] = ms_riscv32_mp_data_in_25_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_25_toCore[17] = ms_riscv32_mp_data_in_25_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_25_toCore[18] = ms_riscv32_mp_data_in_25_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_25_toCore[19] = ms_riscv32_mp_data_in_25_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_25_toCore[20] = ms_riscv32_mp_data_in_25_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_25_toCore[21] = ms_riscv32_mp_data_in_25_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_25_toCore[22] = ms_riscv32_mp_data_in_25_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_25_toCore[23] = ms_riscv32_mp_data_in_25_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_25_toCore[24] = ms_riscv32_mp_data_in_25_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_25_toCore[26] = ms_riscv32_mp_data_in_25_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_25_toCore[27] = ms_riscv32_mp_data_in_25_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_25_toCore[28] = ms_riscv32_mp_data_in_25_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_25_toCore[29] = ms_riscv32_mp_data_in_25_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_25_toCore[30] = ms_riscv32_mp_data_in_25_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_25_toCore[31] = ms_riscv32_mp_data_in_25_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[0] = ms_riscv32_mp_data_in_24_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[1] = ms_riscv32_mp_data_in_24_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[2] = ms_riscv32_mp_data_in_24_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[3] = ms_riscv32_mp_data_in_24_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[4] = ms_riscv32_mp_data_in_24_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[5] = ms_riscv32_mp_data_in_24_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[6] = ms_riscv32_mp_data_in_24_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[7] = ms_riscv32_mp_data_in_24_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[8] = ms_riscv32_mp_data_in_24_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[9] = ms_riscv32_mp_data_in_24_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[10] = ms_riscv32_mp_data_in_24_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[11] = ms_riscv32_mp_data_in_24_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[12] = ms_riscv32_mp_data_in_24_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[13] = ms_riscv32_mp_data_in_24_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[14] = ms_riscv32_mp_data_in_24_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[15] = ms_riscv32_mp_data_in_24_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[16] = ms_riscv32_mp_data_in_24_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[17] = ms_riscv32_mp_data_in_24_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[18] = ms_riscv32_mp_data_in_24_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[19] = ms_riscv32_mp_data_in_24_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[20] = ms_riscv32_mp_data_in_24_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[21] = ms_riscv32_mp_data_in_24_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[22] = ms_riscv32_mp_data_in_24_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[23] = ms_riscv32_mp_data_in_24_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[25] = ms_riscv32_mp_data_in_24_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[26] = ms_riscv32_mp_data_in_24_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[27] = ms_riscv32_mp_data_in_24_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[28] = ms_riscv32_mp_data_in_24_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[29] = ms_riscv32_mp_data_in_24_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[30] = ms_riscv32_mp_data_in_24_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_25_toCore_ts1[31] = ms_riscv32_mp_data_in_24_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_23_toCore[0] = ms_riscv32_mp_data_in_23_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_23_toCore[1] = ms_riscv32_mp_data_in_23_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_23_toCore[2] = ms_riscv32_mp_data_in_23_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_23_toCore[3] = ms_riscv32_mp_data_in_23_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_23_toCore[4] = ms_riscv32_mp_data_in_23_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_23_toCore[5] = ms_riscv32_mp_data_in_23_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_23_toCore[6] = ms_riscv32_mp_data_in_23_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_23_toCore[7] = ms_riscv32_mp_data_in_23_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_23_toCore[8] = ms_riscv32_mp_data_in_23_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_23_toCore[9] = ms_riscv32_mp_data_in_23_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_23_toCore[10] = ms_riscv32_mp_data_in_23_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_23_toCore[11] = ms_riscv32_mp_data_in_23_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_23_toCore[12] = ms_riscv32_mp_data_in_23_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_23_toCore[13] = ms_riscv32_mp_data_in_23_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_23_toCore[14] = ms_riscv32_mp_data_in_23_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_23_toCore[15] = ms_riscv32_mp_data_in_23_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_23_toCore[16] = ms_riscv32_mp_data_in_23_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_23_toCore[17] = ms_riscv32_mp_data_in_23_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_23_toCore[18] = ms_riscv32_mp_data_in_23_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_23_toCore[19] = ms_riscv32_mp_data_in_23_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_23_toCore[20] = ms_riscv32_mp_data_in_23_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_23_toCore[21] = ms_riscv32_mp_data_in_23_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_23_toCore[22] = ms_riscv32_mp_data_in_23_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_23_toCore[24] = ms_riscv32_mp_data_in_23_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_23_toCore[25] = ms_riscv32_mp_data_in_23_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_23_toCore[26] = ms_riscv32_mp_data_in_23_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_23_toCore[27] = ms_riscv32_mp_data_in_23_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_23_toCore[28] = ms_riscv32_mp_data_in_23_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_23_toCore[29] = ms_riscv32_mp_data_in_23_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_23_toCore[30] = ms_riscv32_mp_data_in_23_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_23_toCore[31] = ms_riscv32_mp_data_in_23_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[0] = ms_riscv32_mp_data_in_22_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[1] = ms_riscv32_mp_data_in_22_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[2] = ms_riscv32_mp_data_in_22_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[3] = ms_riscv32_mp_data_in_22_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[4] = ms_riscv32_mp_data_in_22_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[5] = ms_riscv32_mp_data_in_22_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[6] = ms_riscv32_mp_data_in_22_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[7] = ms_riscv32_mp_data_in_22_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[8] = ms_riscv32_mp_data_in_22_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[9] = ms_riscv32_mp_data_in_22_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[10] = ms_riscv32_mp_data_in_22_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[11] = ms_riscv32_mp_data_in_22_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[12] = ms_riscv32_mp_data_in_22_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[13] = ms_riscv32_mp_data_in_22_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[14] = ms_riscv32_mp_data_in_22_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[15] = ms_riscv32_mp_data_in_22_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[16] = ms_riscv32_mp_data_in_22_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[17] = ms_riscv32_mp_data_in_22_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[18] = ms_riscv32_mp_data_in_22_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[19] = ms_riscv32_mp_data_in_22_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[20] = ms_riscv32_mp_data_in_22_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[21] = ms_riscv32_mp_data_in_22_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[23] = ms_riscv32_mp_data_in_22_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[24] = ms_riscv32_mp_data_in_22_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[25] = ms_riscv32_mp_data_in_22_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[26] = ms_riscv32_mp_data_in_22_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[27] = ms_riscv32_mp_data_in_22_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[28] = ms_riscv32_mp_data_in_22_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[29] = ms_riscv32_mp_data_in_22_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[30] = ms_riscv32_mp_data_in_22_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_23_toCore_ts1[31] = ms_riscv32_mp_data_in_22_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_21_toCore[0] = ms_riscv32_mp_data_in_21_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_21_toCore[1] = ms_riscv32_mp_data_in_21_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_21_toCore[2] = ms_riscv32_mp_data_in_21_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_21_toCore[3] = ms_riscv32_mp_data_in_21_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_21_toCore[4] = ms_riscv32_mp_data_in_21_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_21_toCore[5] = ms_riscv32_mp_data_in_21_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_21_toCore[6] = ms_riscv32_mp_data_in_21_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_21_toCore[7] = ms_riscv32_mp_data_in_21_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_21_toCore[8] = ms_riscv32_mp_data_in_21_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_21_toCore[9] = ms_riscv32_mp_data_in_21_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_21_toCore[10] = ms_riscv32_mp_data_in_21_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_21_toCore[11] = ms_riscv32_mp_data_in_21_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_21_toCore[12] = ms_riscv32_mp_data_in_21_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_21_toCore[13] = ms_riscv32_mp_data_in_21_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_21_toCore[14] = ms_riscv32_mp_data_in_21_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_21_toCore[15] = ms_riscv32_mp_data_in_21_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_21_toCore[16] = ms_riscv32_mp_data_in_21_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_21_toCore[17] = ms_riscv32_mp_data_in_21_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_21_toCore[18] = ms_riscv32_mp_data_in_21_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_21_toCore[19] = ms_riscv32_mp_data_in_21_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_21_toCore[20] = ms_riscv32_mp_data_in_21_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_21_toCore[22] = ms_riscv32_mp_data_in_21_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_21_toCore[23] = ms_riscv32_mp_data_in_21_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_21_toCore[24] = ms_riscv32_mp_data_in_21_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_21_toCore[25] = ms_riscv32_mp_data_in_21_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_21_toCore[26] = ms_riscv32_mp_data_in_21_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_21_toCore[27] = ms_riscv32_mp_data_in_21_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_21_toCore[28] = ms_riscv32_mp_data_in_21_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_21_toCore[29] = ms_riscv32_mp_data_in_21_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_21_toCore[30] = ms_riscv32_mp_data_in_21_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_21_toCore[31] = ms_riscv32_mp_data_in_21_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[0] = ms_riscv32_mp_data_in_20_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[1] = ms_riscv32_mp_data_in_20_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[2] = ms_riscv32_mp_data_in_20_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[3] = ms_riscv32_mp_data_in_20_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[4] = ms_riscv32_mp_data_in_20_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[5] = ms_riscv32_mp_data_in_20_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[6] = ms_riscv32_mp_data_in_20_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[7] = ms_riscv32_mp_data_in_20_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[8] = ms_riscv32_mp_data_in_20_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[9] = ms_riscv32_mp_data_in_20_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[10] = ms_riscv32_mp_data_in_20_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[11] = ms_riscv32_mp_data_in_20_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[12] = ms_riscv32_mp_data_in_20_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[13] = ms_riscv32_mp_data_in_20_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[14] = ms_riscv32_mp_data_in_20_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[15] = ms_riscv32_mp_data_in_20_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[16] = ms_riscv32_mp_data_in_20_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[17] = ms_riscv32_mp_data_in_20_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[18] = ms_riscv32_mp_data_in_20_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[19] = ms_riscv32_mp_data_in_20_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[21] = ms_riscv32_mp_data_in_20_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[22] = ms_riscv32_mp_data_in_20_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[23] = ms_riscv32_mp_data_in_20_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[24] = ms_riscv32_mp_data_in_20_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[25] = ms_riscv32_mp_data_in_20_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[26] = ms_riscv32_mp_data_in_20_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[27] = ms_riscv32_mp_data_in_20_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[28] = ms_riscv32_mp_data_in_20_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[29] = ms_riscv32_mp_data_in_20_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[30] = ms_riscv32_mp_data_in_20_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_21_toCore_ts1[31] = ms_riscv32_mp_data_in_20_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_19_toCore[0] = ms_riscv32_mp_data_in_19_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_19_toCore[1] = ms_riscv32_mp_data_in_19_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_19_toCore[2] = ms_riscv32_mp_data_in_19_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_19_toCore[3] = ms_riscv32_mp_data_in_19_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_19_toCore[4] = ms_riscv32_mp_data_in_19_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_19_toCore[5] = ms_riscv32_mp_data_in_19_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_19_toCore[6] = ms_riscv32_mp_data_in_19_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_19_toCore[7] = ms_riscv32_mp_data_in_19_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_19_toCore[8] = ms_riscv32_mp_data_in_19_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_19_toCore[9] = ms_riscv32_mp_data_in_19_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_19_toCore[10] = ms_riscv32_mp_data_in_19_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_19_toCore[11] = ms_riscv32_mp_data_in_19_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_19_toCore[12] = ms_riscv32_mp_data_in_19_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_19_toCore[13] = ms_riscv32_mp_data_in_19_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_19_toCore[14] = ms_riscv32_mp_data_in_19_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_19_toCore[15] = ms_riscv32_mp_data_in_19_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_19_toCore[16] = ms_riscv32_mp_data_in_19_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_19_toCore[17] = ms_riscv32_mp_data_in_19_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_19_toCore[18] = ms_riscv32_mp_data_in_19_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_19_toCore[20] = ms_riscv32_mp_data_in_19_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_19_toCore[21] = ms_riscv32_mp_data_in_19_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_19_toCore[22] = ms_riscv32_mp_data_in_19_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_19_toCore[23] = ms_riscv32_mp_data_in_19_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_19_toCore[24] = ms_riscv32_mp_data_in_19_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_19_toCore[25] = ms_riscv32_mp_data_in_19_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_19_toCore[26] = ms_riscv32_mp_data_in_19_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_19_toCore[27] = ms_riscv32_mp_data_in_19_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_19_toCore[28] = ms_riscv32_mp_data_in_19_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_19_toCore[29] = ms_riscv32_mp_data_in_19_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_19_toCore[30] = ms_riscv32_mp_data_in_19_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_19_toCore[31] = ms_riscv32_mp_data_in_19_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[0] = ms_riscv32_mp_data_in_18_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[1] = ms_riscv32_mp_data_in_18_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[2] = ms_riscv32_mp_data_in_18_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[3] = ms_riscv32_mp_data_in_18_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[4] = ms_riscv32_mp_data_in_18_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[5] = ms_riscv32_mp_data_in_18_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[6] = ms_riscv32_mp_data_in_18_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[7] = ms_riscv32_mp_data_in_18_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[8] = ms_riscv32_mp_data_in_18_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[9] = ms_riscv32_mp_data_in_18_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[10] = ms_riscv32_mp_data_in_18_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[11] = ms_riscv32_mp_data_in_18_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[12] = ms_riscv32_mp_data_in_18_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[13] = ms_riscv32_mp_data_in_18_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[14] = ms_riscv32_mp_data_in_18_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[15] = ms_riscv32_mp_data_in_18_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[16] = ms_riscv32_mp_data_in_18_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[17] = ms_riscv32_mp_data_in_18_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[19] = ms_riscv32_mp_data_in_18_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[20] = ms_riscv32_mp_data_in_18_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[21] = ms_riscv32_mp_data_in_18_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[22] = ms_riscv32_mp_data_in_18_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[23] = ms_riscv32_mp_data_in_18_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[24] = ms_riscv32_mp_data_in_18_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[25] = ms_riscv32_mp_data_in_18_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[26] = ms_riscv32_mp_data_in_18_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[27] = ms_riscv32_mp_data_in_18_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[28] = ms_riscv32_mp_data_in_18_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[29] = ms_riscv32_mp_data_in_18_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[30] = ms_riscv32_mp_data_in_18_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_19_toCore_ts1[31] = ms_riscv32_mp_data_in_18_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_17_toCore[0] = ms_riscv32_mp_data_in_17_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_17_toCore[1] = ms_riscv32_mp_data_in_17_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_17_toCore[2] = ms_riscv32_mp_data_in_17_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_17_toCore[3] = ms_riscv32_mp_data_in_17_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_17_toCore[4] = ms_riscv32_mp_data_in_17_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_17_toCore[5] = ms_riscv32_mp_data_in_17_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_17_toCore[6] = ms_riscv32_mp_data_in_17_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_17_toCore[7] = ms_riscv32_mp_data_in_17_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_17_toCore[8] = ms_riscv32_mp_data_in_17_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_17_toCore[9] = ms_riscv32_mp_data_in_17_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_17_toCore[10] = ms_riscv32_mp_data_in_17_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_17_toCore[11] = ms_riscv32_mp_data_in_17_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_17_toCore[12] = ms_riscv32_mp_data_in_17_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_17_toCore[13] = ms_riscv32_mp_data_in_17_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_17_toCore[14] = ms_riscv32_mp_data_in_17_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_17_toCore[15] = ms_riscv32_mp_data_in_17_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_17_toCore[16] = ms_riscv32_mp_data_in_17_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_17_toCore[18] = ms_riscv32_mp_data_in_17_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_17_toCore[19] = ms_riscv32_mp_data_in_17_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_17_toCore[20] = ms_riscv32_mp_data_in_17_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_17_toCore[21] = ms_riscv32_mp_data_in_17_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_17_toCore[22] = ms_riscv32_mp_data_in_17_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_17_toCore[23] = ms_riscv32_mp_data_in_17_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_17_toCore[24] = ms_riscv32_mp_data_in_17_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_17_toCore[25] = ms_riscv32_mp_data_in_17_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_17_toCore[26] = ms_riscv32_mp_data_in_17_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_17_toCore[27] = ms_riscv32_mp_data_in_17_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_17_toCore[28] = ms_riscv32_mp_data_in_17_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_17_toCore[29] = ms_riscv32_mp_data_in_17_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_17_toCore[30] = ms_riscv32_mp_data_in_17_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_17_toCore[31] = ms_riscv32_mp_data_in_17_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[0] = ms_riscv32_mp_data_in_16_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[1] = ms_riscv32_mp_data_in_16_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[2] = ms_riscv32_mp_data_in_16_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[3] = ms_riscv32_mp_data_in_16_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[4] = ms_riscv32_mp_data_in_16_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[5] = ms_riscv32_mp_data_in_16_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[6] = ms_riscv32_mp_data_in_16_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[7] = ms_riscv32_mp_data_in_16_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[8] = ms_riscv32_mp_data_in_16_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[9] = ms_riscv32_mp_data_in_16_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[10] = ms_riscv32_mp_data_in_16_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[11] = ms_riscv32_mp_data_in_16_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[12] = ms_riscv32_mp_data_in_16_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[13] = ms_riscv32_mp_data_in_16_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[14] = ms_riscv32_mp_data_in_16_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[15] = ms_riscv32_mp_data_in_16_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[17] = ms_riscv32_mp_data_in_16_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[18] = ms_riscv32_mp_data_in_16_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[19] = ms_riscv32_mp_data_in_16_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[20] = ms_riscv32_mp_data_in_16_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[21] = ms_riscv32_mp_data_in_16_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[22] = ms_riscv32_mp_data_in_16_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[23] = ms_riscv32_mp_data_in_16_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[24] = ms_riscv32_mp_data_in_16_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[25] = ms_riscv32_mp_data_in_16_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[26] = ms_riscv32_mp_data_in_16_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[27] = ms_riscv32_mp_data_in_16_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[28] = ms_riscv32_mp_data_in_16_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[29] = ms_riscv32_mp_data_in_16_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[30] = ms_riscv32_mp_data_in_16_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_17_toCore_ts1[31] = ms_riscv32_mp_data_in_16_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_15_toCore[0] = ms_riscv32_mp_data_in_15_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_15_toCore[1] = ms_riscv32_mp_data_in_15_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_15_toCore[2] = ms_riscv32_mp_data_in_15_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_15_toCore[3] = ms_riscv32_mp_data_in_15_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_15_toCore[4] = ms_riscv32_mp_data_in_15_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_15_toCore[5] = ms_riscv32_mp_data_in_15_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_15_toCore[6] = ms_riscv32_mp_data_in_15_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_15_toCore[7] = ms_riscv32_mp_data_in_15_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_15_toCore[8] = ms_riscv32_mp_data_in_15_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_15_toCore[9] = ms_riscv32_mp_data_in_15_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_15_toCore[10] = ms_riscv32_mp_data_in_15_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_15_toCore[11] = ms_riscv32_mp_data_in_15_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_15_toCore[12] = ms_riscv32_mp_data_in_15_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_15_toCore[13] = ms_riscv32_mp_data_in_15_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_15_toCore[14] = ms_riscv32_mp_data_in_15_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_15_toCore[16] = ms_riscv32_mp_data_in_15_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_15_toCore[17] = ms_riscv32_mp_data_in_15_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_15_toCore[18] = ms_riscv32_mp_data_in_15_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_15_toCore[19] = ms_riscv32_mp_data_in_15_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_15_toCore[20] = ms_riscv32_mp_data_in_15_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_15_toCore[21] = ms_riscv32_mp_data_in_15_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_15_toCore[22] = ms_riscv32_mp_data_in_15_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_15_toCore[23] = ms_riscv32_mp_data_in_15_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_15_toCore[24] = ms_riscv32_mp_data_in_15_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_15_toCore[25] = ms_riscv32_mp_data_in_15_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_15_toCore[26] = ms_riscv32_mp_data_in_15_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_15_toCore[27] = ms_riscv32_mp_data_in_15_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_15_toCore[28] = ms_riscv32_mp_data_in_15_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_15_toCore[29] = ms_riscv32_mp_data_in_15_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_15_toCore[30] = ms_riscv32_mp_data_in_15_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_15_toCore[31] = ms_riscv32_mp_data_in_15_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[0] = ms_riscv32_mp_data_in_14_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[1] = ms_riscv32_mp_data_in_14_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[2] = ms_riscv32_mp_data_in_14_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[3] = ms_riscv32_mp_data_in_14_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[4] = ms_riscv32_mp_data_in_14_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[5] = ms_riscv32_mp_data_in_14_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[6] = ms_riscv32_mp_data_in_14_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[7] = ms_riscv32_mp_data_in_14_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[8] = ms_riscv32_mp_data_in_14_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[9] = ms_riscv32_mp_data_in_14_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[10] = ms_riscv32_mp_data_in_14_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[11] = ms_riscv32_mp_data_in_14_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[12] = ms_riscv32_mp_data_in_14_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[13] = ms_riscv32_mp_data_in_14_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[15] = ms_riscv32_mp_data_in_14_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[16] = ms_riscv32_mp_data_in_14_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[17] = ms_riscv32_mp_data_in_14_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[18] = ms_riscv32_mp_data_in_14_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[19] = ms_riscv32_mp_data_in_14_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[20] = ms_riscv32_mp_data_in_14_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[21] = ms_riscv32_mp_data_in_14_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[22] = ms_riscv32_mp_data_in_14_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[23] = ms_riscv32_mp_data_in_14_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[24] = ms_riscv32_mp_data_in_14_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[25] = ms_riscv32_mp_data_in_14_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[26] = ms_riscv32_mp_data_in_14_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[27] = ms_riscv32_mp_data_in_14_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[28] = ms_riscv32_mp_data_in_14_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[29] = ms_riscv32_mp_data_in_14_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[30] = ms_riscv32_mp_data_in_14_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_15_toCore_ts1[31] = ms_riscv32_mp_data_in_14_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_13_toCore[0] = ms_riscv32_mp_data_in_13_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_13_toCore[1] = ms_riscv32_mp_data_in_13_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_13_toCore[2] = ms_riscv32_mp_data_in_13_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_13_toCore[3] = ms_riscv32_mp_data_in_13_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_13_toCore[4] = ms_riscv32_mp_data_in_13_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_13_toCore[5] = ms_riscv32_mp_data_in_13_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_13_toCore[6] = ms_riscv32_mp_data_in_13_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_13_toCore[7] = ms_riscv32_mp_data_in_13_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_13_toCore[8] = ms_riscv32_mp_data_in_13_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_13_toCore[9] = ms_riscv32_mp_data_in_13_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_13_toCore[10] = ms_riscv32_mp_data_in_13_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_13_toCore[11] = ms_riscv32_mp_data_in_13_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_13_toCore[12] = ms_riscv32_mp_data_in_13_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_13_toCore[14] = ms_riscv32_mp_data_in_13_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_13_toCore[15] = ms_riscv32_mp_data_in_13_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_13_toCore[16] = ms_riscv32_mp_data_in_13_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_13_toCore[17] = ms_riscv32_mp_data_in_13_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_13_toCore[18] = ms_riscv32_mp_data_in_13_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_13_toCore[19] = ms_riscv32_mp_data_in_13_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_13_toCore[20] = ms_riscv32_mp_data_in_13_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_13_toCore[21] = ms_riscv32_mp_data_in_13_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_13_toCore[22] = ms_riscv32_mp_data_in_13_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_13_toCore[23] = ms_riscv32_mp_data_in_13_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_13_toCore[24] = ms_riscv32_mp_data_in_13_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_13_toCore[25] = ms_riscv32_mp_data_in_13_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_13_toCore[26] = ms_riscv32_mp_data_in_13_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_13_toCore[27] = ms_riscv32_mp_data_in_13_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_13_toCore[28] = ms_riscv32_mp_data_in_13_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_13_toCore[29] = ms_riscv32_mp_data_in_13_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_13_toCore[30] = ms_riscv32_mp_data_in_13_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_13_toCore[31] = ms_riscv32_mp_data_in_13_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[0] = ms_riscv32_mp_data_in_12_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[1] = ms_riscv32_mp_data_in_12_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[2] = ms_riscv32_mp_data_in_12_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[3] = ms_riscv32_mp_data_in_12_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[4] = ms_riscv32_mp_data_in_12_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[5] = ms_riscv32_mp_data_in_12_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[6] = ms_riscv32_mp_data_in_12_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[7] = ms_riscv32_mp_data_in_12_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[8] = ms_riscv32_mp_data_in_12_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[9] = ms_riscv32_mp_data_in_12_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[10] = ms_riscv32_mp_data_in_12_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[11] = ms_riscv32_mp_data_in_12_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[13] = ms_riscv32_mp_data_in_12_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[14] = ms_riscv32_mp_data_in_12_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[15] = ms_riscv32_mp_data_in_12_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[16] = ms_riscv32_mp_data_in_12_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[17] = ms_riscv32_mp_data_in_12_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[18] = ms_riscv32_mp_data_in_12_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[19] = ms_riscv32_mp_data_in_12_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[20] = ms_riscv32_mp_data_in_12_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[21] = ms_riscv32_mp_data_in_12_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[22] = ms_riscv32_mp_data_in_12_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[23] = ms_riscv32_mp_data_in_12_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[24] = ms_riscv32_mp_data_in_12_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[25] = ms_riscv32_mp_data_in_12_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[26] = ms_riscv32_mp_data_in_12_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[27] = ms_riscv32_mp_data_in_12_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[28] = ms_riscv32_mp_data_in_12_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[29] = ms_riscv32_mp_data_in_12_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[30] = ms_riscv32_mp_data_in_12_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_13_toCore_ts1[31] = ms_riscv32_mp_data_in_12_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_11_toCore[0] = ms_riscv32_mp_data_in_11_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_11_toCore[1] = ms_riscv32_mp_data_in_11_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_11_toCore[2] = ms_riscv32_mp_data_in_11_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_11_toCore[3] = ms_riscv32_mp_data_in_11_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_11_toCore[4] = ms_riscv32_mp_data_in_11_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_11_toCore[5] = ms_riscv32_mp_data_in_11_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_11_toCore[6] = ms_riscv32_mp_data_in_11_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_11_toCore[7] = ms_riscv32_mp_data_in_11_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_11_toCore[8] = ms_riscv32_mp_data_in_11_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_11_toCore[9] = ms_riscv32_mp_data_in_11_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_11_toCore[10] = ms_riscv32_mp_data_in_11_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_11_toCore[12] = ms_riscv32_mp_data_in_11_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_11_toCore[13] = ms_riscv32_mp_data_in_11_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_11_toCore[14] = ms_riscv32_mp_data_in_11_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_11_toCore[15] = ms_riscv32_mp_data_in_11_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_11_toCore[16] = ms_riscv32_mp_data_in_11_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_11_toCore[17] = ms_riscv32_mp_data_in_11_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_11_toCore[18] = ms_riscv32_mp_data_in_11_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_11_toCore[19] = ms_riscv32_mp_data_in_11_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_11_toCore[20] = ms_riscv32_mp_data_in_11_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_11_toCore[21] = ms_riscv32_mp_data_in_11_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_11_toCore[22] = ms_riscv32_mp_data_in_11_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_11_toCore[23] = ms_riscv32_mp_data_in_11_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_11_toCore[24] = ms_riscv32_mp_data_in_11_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_11_toCore[25] = ms_riscv32_mp_data_in_11_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_11_toCore[26] = ms_riscv32_mp_data_in_11_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_11_toCore[27] = ms_riscv32_mp_data_in_11_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_11_toCore[28] = ms_riscv32_mp_data_in_11_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_11_toCore[29] = ms_riscv32_mp_data_in_11_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_11_toCore[30] = ms_riscv32_mp_data_in_11_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_11_toCore[31] = ms_riscv32_mp_data_in_11_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[0] = ms_riscv32_mp_data_in_10_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[1] = ms_riscv32_mp_data_in_10_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[2] = ms_riscv32_mp_data_in_10_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[3] = ms_riscv32_mp_data_in_10_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[4] = ms_riscv32_mp_data_in_10_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[5] = ms_riscv32_mp_data_in_10_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[6] = ms_riscv32_mp_data_in_10_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[7] = ms_riscv32_mp_data_in_10_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[8] = ms_riscv32_mp_data_in_10_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[9] = ms_riscv32_mp_data_in_10_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[11] = ms_riscv32_mp_data_in_10_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[12] = ms_riscv32_mp_data_in_10_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[13] = ms_riscv32_mp_data_in_10_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[14] = ms_riscv32_mp_data_in_10_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[15] = ms_riscv32_mp_data_in_10_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[16] = ms_riscv32_mp_data_in_10_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[17] = ms_riscv32_mp_data_in_10_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[18] = ms_riscv32_mp_data_in_10_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[19] = ms_riscv32_mp_data_in_10_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[20] = ms_riscv32_mp_data_in_10_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[21] = ms_riscv32_mp_data_in_10_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[22] = ms_riscv32_mp_data_in_10_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[23] = ms_riscv32_mp_data_in_10_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[24] = ms_riscv32_mp_data_in_10_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[25] = ms_riscv32_mp_data_in_10_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[26] = ms_riscv32_mp_data_in_10_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[27] = ms_riscv32_mp_data_in_10_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[28] = ms_riscv32_mp_data_in_10_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[29] = ms_riscv32_mp_data_in_10_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[30] = ms_riscv32_mp_data_in_10_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_11_toCore_ts1[31] = ms_riscv32_mp_data_in_10_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_9_toCore[0] = ms_riscv32_mp_data_in_9_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_9_toCore[1] = ms_riscv32_mp_data_in_9_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_9_toCore[2] = ms_riscv32_mp_data_in_9_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_9_toCore[3] = ms_riscv32_mp_data_in_9_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_9_toCore[4] = ms_riscv32_mp_data_in_9_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_9_toCore[5] = ms_riscv32_mp_data_in_9_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_9_toCore[6] = ms_riscv32_mp_data_in_9_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_9_toCore[7] = ms_riscv32_mp_data_in_9_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_9_toCore[8] = ms_riscv32_mp_data_in_9_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_9_toCore[10] = ms_riscv32_mp_data_in_9_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_9_toCore[11] = ms_riscv32_mp_data_in_9_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_9_toCore[12] = ms_riscv32_mp_data_in_9_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_9_toCore[13] = ms_riscv32_mp_data_in_9_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_9_toCore[14] = ms_riscv32_mp_data_in_9_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_9_toCore[15] = ms_riscv32_mp_data_in_9_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_9_toCore[16] = ms_riscv32_mp_data_in_9_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_9_toCore[17] = ms_riscv32_mp_data_in_9_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_9_toCore[18] = ms_riscv32_mp_data_in_9_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_9_toCore[19] = ms_riscv32_mp_data_in_9_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_9_toCore[20] = ms_riscv32_mp_data_in_9_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_9_toCore[21] = ms_riscv32_mp_data_in_9_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_9_toCore[22] = ms_riscv32_mp_data_in_9_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_9_toCore[23] = ms_riscv32_mp_data_in_9_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_9_toCore[24] = ms_riscv32_mp_data_in_9_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_9_toCore[25] = ms_riscv32_mp_data_in_9_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_9_toCore[26] = ms_riscv32_mp_data_in_9_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_9_toCore[27] = ms_riscv32_mp_data_in_9_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_9_toCore[28] = ms_riscv32_mp_data_in_9_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_9_toCore[29] = ms_riscv32_mp_data_in_9_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_9_toCore[30] = ms_riscv32_mp_data_in_9_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_9_toCore[31] = ms_riscv32_mp_data_in_9_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[0] = ms_riscv32_mp_data_in_8_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[1] = ms_riscv32_mp_data_in_8_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[2] = ms_riscv32_mp_data_in_8_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[3] = ms_riscv32_mp_data_in_8_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[4] = ms_riscv32_mp_data_in_8_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[5] = ms_riscv32_mp_data_in_8_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[6] = ms_riscv32_mp_data_in_8_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[7] = ms_riscv32_mp_data_in_8_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[9] = ms_riscv32_mp_data_in_8_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[10] = ms_riscv32_mp_data_in_8_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[11] = ms_riscv32_mp_data_in_8_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[12] = ms_riscv32_mp_data_in_8_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[13] = ms_riscv32_mp_data_in_8_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[14] = ms_riscv32_mp_data_in_8_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[15] = ms_riscv32_mp_data_in_8_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[16] = ms_riscv32_mp_data_in_8_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[17] = ms_riscv32_mp_data_in_8_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[18] = ms_riscv32_mp_data_in_8_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[19] = ms_riscv32_mp_data_in_8_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[20] = ms_riscv32_mp_data_in_8_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[21] = ms_riscv32_mp_data_in_8_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[22] = ms_riscv32_mp_data_in_8_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[23] = ms_riscv32_mp_data_in_8_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[24] = ms_riscv32_mp_data_in_8_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[25] = ms_riscv32_mp_data_in_8_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[26] = ms_riscv32_mp_data_in_8_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[27] = ms_riscv32_mp_data_in_8_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[28] = ms_riscv32_mp_data_in_8_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[29] = ms_riscv32_mp_data_in_8_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[30] = ms_riscv32_mp_data_in_8_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_9_toCore_ts1[31] = ms_riscv32_mp_data_in_8_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_7_toCore[0] = ms_riscv32_mp_data_in_7_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_7_toCore[1] = ms_riscv32_mp_data_in_7_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_7_toCore[2] = ms_riscv32_mp_data_in_7_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_7_toCore[3] = ms_riscv32_mp_data_in_7_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_7_toCore[4] = ms_riscv32_mp_data_in_7_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_7_toCore[5] = ms_riscv32_mp_data_in_7_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_7_toCore[6] = ms_riscv32_mp_data_in_7_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_7_toCore[8] = ms_riscv32_mp_data_in_7_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_7_toCore[9] = ms_riscv32_mp_data_in_7_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_7_toCore[10] = ms_riscv32_mp_data_in_7_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_7_toCore[11] = ms_riscv32_mp_data_in_7_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_7_toCore[12] = ms_riscv32_mp_data_in_7_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_7_toCore[13] = ms_riscv32_mp_data_in_7_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_7_toCore[14] = ms_riscv32_mp_data_in_7_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_7_toCore[15] = ms_riscv32_mp_data_in_7_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_7_toCore[16] = ms_riscv32_mp_data_in_7_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_7_toCore[17] = ms_riscv32_mp_data_in_7_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_7_toCore[18] = ms_riscv32_mp_data_in_7_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_7_toCore[19] = ms_riscv32_mp_data_in_7_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_7_toCore[20] = ms_riscv32_mp_data_in_7_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_7_toCore[21] = ms_riscv32_mp_data_in_7_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_7_toCore[22] = ms_riscv32_mp_data_in_7_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_7_toCore[23] = ms_riscv32_mp_data_in_7_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_7_toCore[24] = ms_riscv32_mp_data_in_7_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_7_toCore[25] = ms_riscv32_mp_data_in_7_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_7_toCore[26] = ms_riscv32_mp_data_in_7_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_7_toCore[27] = ms_riscv32_mp_data_in_7_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_7_toCore[28] = ms_riscv32_mp_data_in_7_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_7_toCore[29] = ms_riscv32_mp_data_in_7_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_7_toCore[30] = ms_riscv32_mp_data_in_7_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_7_toCore[31] = ms_riscv32_mp_data_in_7_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[0] = ms_riscv32_mp_data_in_6_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[1] = ms_riscv32_mp_data_in_6_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[2] = ms_riscv32_mp_data_in_6_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[3] = ms_riscv32_mp_data_in_6_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[4] = ms_riscv32_mp_data_in_6_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[5] = ms_riscv32_mp_data_in_6_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[7] = ms_riscv32_mp_data_in_6_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[8] = ms_riscv32_mp_data_in_6_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[9] = ms_riscv32_mp_data_in_6_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[10] = ms_riscv32_mp_data_in_6_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[11] = ms_riscv32_mp_data_in_6_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[12] = ms_riscv32_mp_data_in_6_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[13] = ms_riscv32_mp_data_in_6_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[14] = ms_riscv32_mp_data_in_6_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[15] = ms_riscv32_mp_data_in_6_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[16] = ms_riscv32_mp_data_in_6_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[17] = ms_riscv32_mp_data_in_6_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[18] = ms_riscv32_mp_data_in_6_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[19] = ms_riscv32_mp_data_in_6_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[20] = ms_riscv32_mp_data_in_6_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[21] = ms_riscv32_mp_data_in_6_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[22] = ms_riscv32_mp_data_in_6_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[23] = ms_riscv32_mp_data_in_6_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[24] = ms_riscv32_mp_data_in_6_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[25] = ms_riscv32_mp_data_in_6_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[26] = ms_riscv32_mp_data_in_6_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[27] = ms_riscv32_mp_data_in_6_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[28] = ms_riscv32_mp_data_in_6_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[29] = ms_riscv32_mp_data_in_6_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[30] = ms_riscv32_mp_data_in_6_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_7_toCore_ts1[31] = ms_riscv32_mp_data_in_6_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_5_toCore[0] = ms_riscv32_mp_data_in_5_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_5_toCore[1] = ms_riscv32_mp_data_in_5_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_5_toCore[2] = ms_riscv32_mp_data_in_5_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_5_toCore[3] = ms_riscv32_mp_data_in_5_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_5_toCore[4] = ms_riscv32_mp_data_in_5_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_5_toCore[6] = ms_riscv32_mp_data_in_5_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_5_toCore[7] = ms_riscv32_mp_data_in_5_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_5_toCore[8] = ms_riscv32_mp_data_in_5_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_5_toCore[9] = ms_riscv32_mp_data_in_5_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_5_toCore[10] = ms_riscv32_mp_data_in_5_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_5_toCore[11] = ms_riscv32_mp_data_in_5_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_5_toCore[12] = ms_riscv32_mp_data_in_5_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_5_toCore[13] = ms_riscv32_mp_data_in_5_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_5_toCore[14] = ms_riscv32_mp_data_in_5_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_5_toCore[15] = ms_riscv32_mp_data_in_5_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_5_toCore[16] = ms_riscv32_mp_data_in_5_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_5_toCore[17] = ms_riscv32_mp_data_in_5_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_5_toCore[18] = ms_riscv32_mp_data_in_5_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_5_toCore[19] = ms_riscv32_mp_data_in_5_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_5_toCore[20] = ms_riscv32_mp_data_in_5_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_5_toCore[21] = ms_riscv32_mp_data_in_5_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_5_toCore[22] = ms_riscv32_mp_data_in_5_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_5_toCore[23] = ms_riscv32_mp_data_in_5_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_5_toCore[24] = ms_riscv32_mp_data_in_5_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_5_toCore[25] = ms_riscv32_mp_data_in_5_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_5_toCore[26] = ms_riscv32_mp_data_in_5_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_5_toCore[27] = ms_riscv32_mp_data_in_5_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_5_toCore[28] = ms_riscv32_mp_data_in_5_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_5_toCore[29] = ms_riscv32_mp_data_in_5_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_5_toCore[30] = ms_riscv32_mp_data_in_5_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_5_toCore[31] = ms_riscv32_mp_data_in_5_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[0] = ms_riscv32_mp_data_in_4_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[1] = ms_riscv32_mp_data_in_4_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[2] = ms_riscv32_mp_data_in_4_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[3] = ms_riscv32_mp_data_in_4_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[5] = ms_riscv32_mp_data_in_4_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[6] = ms_riscv32_mp_data_in_4_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[7] = ms_riscv32_mp_data_in_4_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[8] = ms_riscv32_mp_data_in_4_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[9] = ms_riscv32_mp_data_in_4_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[10] = ms_riscv32_mp_data_in_4_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[11] = ms_riscv32_mp_data_in_4_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[12] = ms_riscv32_mp_data_in_4_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[13] = ms_riscv32_mp_data_in_4_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[14] = ms_riscv32_mp_data_in_4_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[15] = ms_riscv32_mp_data_in_4_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[16] = ms_riscv32_mp_data_in_4_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[17] = ms_riscv32_mp_data_in_4_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[18] = ms_riscv32_mp_data_in_4_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[19] = ms_riscv32_mp_data_in_4_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[20] = ms_riscv32_mp_data_in_4_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[21] = ms_riscv32_mp_data_in_4_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[22] = ms_riscv32_mp_data_in_4_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[23] = ms_riscv32_mp_data_in_4_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[24] = ms_riscv32_mp_data_in_4_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[25] = ms_riscv32_mp_data_in_4_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[26] = ms_riscv32_mp_data_in_4_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[27] = ms_riscv32_mp_data_in_4_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[28] = ms_riscv32_mp_data_in_4_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[29] = ms_riscv32_mp_data_in_4_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[30] = ms_riscv32_mp_data_in_4_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_5_toCore_ts1[31] = ms_riscv32_mp_data_in_4_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_3_toCore[0] = ms_riscv32_mp_data_in_3_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_3_toCore[1] = ms_riscv32_mp_data_in_3_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_3_toCore[2] = ms_riscv32_mp_data_in_3_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_3_toCore[4] = ms_riscv32_mp_data_in_3_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_3_toCore[5] = ms_riscv32_mp_data_in_3_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_3_toCore[6] = ms_riscv32_mp_data_in_3_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_3_toCore[7] = ms_riscv32_mp_data_in_3_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_3_toCore[8] = ms_riscv32_mp_data_in_3_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_3_toCore[9] = ms_riscv32_mp_data_in_3_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_3_toCore[10] = ms_riscv32_mp_data_in_3_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_3_toCore[11] = ms_riscv32_mp_data_in_3_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_3_toCore[12] = ms_riscv32_mp_data_in_3_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_3_toCore[13] = ms_riscv32_mp_data_in_3_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_3_toCore[14] = ms_riscv32_mp_data_in_3_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_3_toCore[15] = ms_riscv32_mp_data_in_3_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_3_toCore[16] = ms_riscv32_mp_data_in_3_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_3_toCore[17] = ms_riscv32_mp_data_in_3_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_3_toCore[18] = ms_riscv32_mp_data_in_3_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_3_toCore[19] = ms_riscv32_mp_data_in_3_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_3_toCore[20] = ms_riscv32_mp_data_in_3_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_3_toCore[21] = ms_riscv32_mp_data_in_3_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_3_toCore[22] = ms_riscv32_mp_data_in_3_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_3_toCore[23] = ms_riscv32_mp_data_in_3_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_3_toCore[24] = ms_riscv32_mp_data_in_3_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_3_toCore[25] = ms_riscv32_mp_data_in_3_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_3_toCore[26] = ms_riscv32_mp_data_in_3_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_3_toCore[27] = ms_riscv32_mp_data_in_3_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_3_toCore[28] = ms_riscv32_mp_data_in_3_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_3_toCore[29] = ms_riscv32_mp_data_in_3_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_3_toCore[30] = ms_riscv32_mp_data_in_3_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_3_toCore[31] = ms_riscv32_mp_data_in_3_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[0] = ms_riscv32_mp_data_in_2_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[1] = ms_riscv32_mp_data_in_2_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[3] = ms_riscv32_mp_data_in_2_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[4] = ms_riscv32_mp_data_in_2_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[5] = ms_riscv32_mp_data_in_2_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[6] = ms_riscv32_mp_data_in_2_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[7] = ms_riscv32_mp_data_in_2_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[8] = ms_riscv32_mp_data_in_2_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[9] = ms_riscv32_mp_data_in_2_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[10] = ms_riscv32_mp_data_in_2_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[11] = ms_riscv32_mp_data_in_2_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[12] = ms_riscv32_mp_data_in_2_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[13] = ms_riscv32_mp_data_in_2_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[14] = ms_riscv32_mp_data_in_2_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[15] = ms_riscv32_mp_data_in_2_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[16] = ms_riscv32_mp_data_in_2_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[17] = ms_riscv32_mp_data_in_2_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[18] = ms_riscv32_mp_data_in_2_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[19] = ms_riscv32_mp_data_in_2_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[20] = ms_riscv32_mp_data_in_2_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[21] = ms_riscv32_mp_data_in_2_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[22] = ms_riscv32_mp_data_in_2_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[23] = ms_riscv32_mp_data_in_2_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[24] = ms_riscv32_mp_data_in_2_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[25] = ms_riscv32_mp_data_in_2_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[26] = ms_riscv32_mp_data_in_2_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[27] = ms_riscv32_mp_data_in_2_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[28] = ms_riscv32_mp_data_in_2_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[29] = ms_riscv32_mp_data_in_2_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[30] = ms_riscv32_mp_data_in_2_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_3_toCore_ts1[31] = ms_riscv32_mp_data_in_2_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_1_toCore[0] = ms_riscv32_mp_data_in_1_toCore_ts1[0];

  assign ms_riscv32_mp_data_in_1_toCore[2] = ms_riscv32_mp_data_in_1_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_1_toCore[3] = ms_riscv32_mp_data_in_1_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_1_toCore[4] = ms_riscv32_mp_data_in_1_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_1_toCore[5] = ms_riscv32_mp_data_in_1_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_1_toCore[6] = ms_riscv32_mp_data_in_1_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_1_toCore[7] = ms_riscv32_mp_data_in_1_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_1_toCore[8] = ms_riscv32_mp_data_in_1_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_1_toCore[9] = ms_riscv32_mp_data_in_1_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_1_toCore[10] = ms_riscv32_mp_data_in_1_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_1_toCore[11] = ms_riscv32_mp_data_in_1_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_1_toCore[12] = ms_riscv32_mp_data_in_1_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_1_toCore[13] = ms_riscv32_mp_data_in_1_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_1_toCore[14] = ms_riscv32_mp_data_in_1_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_1_toCore[15] = ms_riscv32_mp_data_in_1_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_1_toCore[16] = ms_riscv32_mp_data_in_1_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_1_toCore[17] = ms_riscv32_mp_data_in_1_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_1_toCore[18] = ms_riscv32_mp_data_in_1_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_1_toCore[19] = ms_riscv32_mp_data_in_1_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_1_toCore[20] = ms_riscv32_mp_data_in_1_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_1_toCore[21] = ms_riscv32_mp_data_in_1_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_1_toCore[22] = ms_riscv32_mp_data_in_1_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_1_toCore[23] = ms_riscv32_mp_data_in_1_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_1_toCore[24] = ms_riscv32_mp_data_in_1_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_1_toCore[25] = ms_riscv32_mp_data_in_1_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_1_toCore[26] = ms_riscv32_mp_data_in_1_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_1_toCore[27] = ms_riscv32_mp_data_in_1_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_1_toCore[28] = ms_riscv32_mp_data_in_1_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_1_toCore[29] = ms_riscv32_mp_data_in_1_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_1_toCore[30] = ms_riscv32_mp_data_in_1_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_1_toCore[31] = ms_riscv32_mp_data_in_1_toCore_ts1[31];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[1] = ms_riscv32_mp_data_in_0_toCore_ts1[1];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[2] = ms_riscv32_mp_data_in_0_toCore_ts1[2];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[3] = ms_riscv32_mp_data_in_0_toCore_ts1[3];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[4] = ms_riscv32_mp_data_in_0_toCore_ts1[4];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[5] = ms_riscv32_mp_data_in_0_toCore_ts1[5];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[6] = ms_riscv32_mp_data_in_0_toCore_ts1[6];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[7] = ms_riscv32_mp_data_in_0_toCore_ts1[7];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[8] = ms_riscv32_mp_data_in_0_toCore_ts1[8];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[9] = ms_riscv32_mp_data_in_0_toCore_ts1[9];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[10] = ms_riscv32_mp_data_in_0_toCore_ts1[10];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[11] = ms_riscv32_mp_data_in_0_toCore_ts1[11];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[12] = ms_riscv32_mp_data_in_0_toCore_ts1[12];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[13] = ms_riscv32_mp_data_in_0_toCore_ts1[13];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[14] = ms_riscv32_mp_data_in_0_toCore_ts1[14];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[15] = ms_riscv32_mp_data_in_0_toCore_ts1[15];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[16] = ms_riscv32_mp_data_in_0_toCore_ts1[16];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[17] = ms_riscv32_mp_data_in_0_toCore_ts1[17];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[18] = ms_riscv32_mp_data_in_0_toCore_ts1[18];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[19] = ms_riscv32_mp_data_in_0_toCore_ts1[19];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[20] = ms_riscv32_mp_data_in_0_toCore_ts1[20];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[21] = ms_riscv32_mp_data_in_0_toCore_ts1[21];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[22] = ms_riscv32_mp_data_in_0_toCore_ts1[22];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[23] = ms_riscv32_mp_data_in_0_toCore_ts1[23];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[24] = ms_riscv32_mp_data_in_0_toCore_ts1[24];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[25] = ms_riscv32_mp_data_in_0_toCore_ts1[25];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[26] = ms_riscv32_mp_data_in_0_toCore_ts1[26];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[27] = ms_riscv32_mp_data_in_0_toCore_ts1[27];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[28] = ms_riscv32_mp_data_in_0_toCore_ts1[28];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[29] = ms_riscv32_mp_data_in_0_toCore_ts1[29];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[30] = ms_riscv32_mp_data_in_0_toCore_ts1[30];

  assign ms_riscv32_mp_data_in_1_toCore_ts1[31] = ms_riscv32_mp_data_in_0_toCore_ts1[31];

  assign ms_riscv32_mp_data_htrans_out_1_toPad_ts1[1] = ms_riscv32_mp_data_htrans_out_1_toPad;

  assign ms_riscv32_mp_data_htrans_out_0_fromCore_ts1[1] = ms_riscv32_mp_data_htrans_out_1_toPad_ts1[1];
endmodule
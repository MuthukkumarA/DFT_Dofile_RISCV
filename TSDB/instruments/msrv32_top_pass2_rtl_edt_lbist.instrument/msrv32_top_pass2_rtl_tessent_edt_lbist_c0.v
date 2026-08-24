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
//
//       IP version: 8
//--------------------------------------------------------------------------------


module msrv32_top_pass2_rtl_tessent_edt_c0_sib (
   input  wire      ijtag_tck,
   input  wire      ijtag_reset,
   input  wire      ijtag_sel,
   input  wire      ijtag_ce,
   input  wire      ijtag_se,
   input  wire      ijtag_ue,
   input  wire      ijtag_si,
   input  wire      ijtag_from_so,
   input  wire      ccm_scan_en,
   input  wire      ccm_te_si,
   output wire      ccm_te_so,
   output wire      ijtag_so,
   output wire      ijtag_to_sel
);
   reg         sib;
   reg         sib_latch;
   reg         so_retime;
   reg         to_enable_int;
   reg         ijtag_from_so_retime;

   assign ijtag_to_sel = to_enable_int & ijtag_sel;

   always @(negedge ijtag_tck or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         sib_latch <= 1'b0;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            sib_latch <= ccm_te_si;
         end else if (ijtag_ue == 1'b1 && ijtag_sel == 1'b1) begin
            sib_latch <= sib;
         end
      end
   end

   always @(negedge ijtag_tck)
   begin 
      so_retime <= ccm_scan_en ? to_enable_int : sib;
      to_enable_int <= sib_latch;
   end

   assign ijtag_so = ccm_scan_en ? sib : so_retime;

   always @(negedge ijtag_tck)
   begin 
      ijtag_from_so_retime <= ccm_scan_en ? so_retime : ijtag_from_so;
   end

   assign ccm_te_so = ijtag_from_so_retime;

   always @(posedge ijtag_tck or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         sib <= 1'b0;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            sib <= ijtag_from_so;
         end
         else if (ijtag_ce == 1'b1 && ijtag_sel == 1'b1) begin
            sib <= 1'b0;
         end
         else if (ijtag_se == 1'b1 && ijtag_sel == 1'b1) begin
            if (sib_latch == 1'b1) begin
               sib <= ijtag_from_so_retime;
            end
            else begin
               sib <= ijtag_si;
            end
         end
      end
   end

endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_decompressor (
   input  wire       edt_clock,
   input  wire       edt_update,
   input  wire       edt_channels_in,
   output reg        edt_mask,
   output reg  [9:0] edt_scan_in,
   input  wire       lbist_reset,
   input  wire       lbist_en,
   input  wire       lbist_prpg_en,
   input  wire       lbist_low_power_shift_en,
   input  wire       ijtag_tck,
   input  wire       ijtag_reset,
   input  wire       ijtag_sel,
   input  wire       ijtag_ce,
   input  wire       ijtag_se,
   input  wire       ijtag_ue,
   input  wire       ccm_scan_en,
   input  wire       ccm_le_si,
   output wire       ccm_le_so,
   input  wire       ccm_te_si,
   output wire       ccm_te_so,
   input  wire       ijtag_si,
   output wire       ijtag_so
);
   reg    [30:0] lfsm_vec;
   reg    [30:0] lfsm_vec_lockup;
   wire          lfsm_inject;
   wire          lbist_scan_en;
   wire          ijtag_to_sel;
   wire          ijtag_so_int;
   wire          decompressor_sib_so;
   wire          lbist_lp_static_control_sib_so;
   wire          lbist_scan_en_lp_static_control;
   wire          ijtag_to_sel_lp_static_control;
   wire          lbist_scan_en_lp_mask_shift_reg;
   wire          ijtag_to_sel_lp_mask_shift_reg;
   wire          ccm_te_so_decompressor_sib;
   wire          ccm_te_so_lbist_lp_static_control_sib;
   wire          ijtag_si_int;
   reg    [ 3:0] lbist_lp_hold_reg;
   reg    [ 3:0] lbist_lp_toggle_reg;
   wire   [ 3:0] lbist_lp_ht_encoder_in;
   wire          lbist_lp_ht_encoder_prpg_c1;
   wire          lbist_lp_ht_encoder_prpg_c2;
   wire          lbist_lp_ht_encoder_prpg_c3;
   wire          lbist_lp_ht_encoder_prpg_c4;
   wire          lbist_lp_ht_encoder_out;
   reg           lbist_lp_T_reg;
   reg    [ 3:0] lbist_lp_switching_reg;
   wire          lbist_lp_switching_prpg_c1;
   wire          lbist_lp_switching_prpg_c2;
   wire          lbist_lp_switching_prpg_c3;
   wire          lbist_lp_switching_prpg_c4;
   wire          lbist_lp_switching_encoder_out;
   wire          lbist_lp_mask_shift_reg_in;
   reg    [30:0] lbist_lp_mask_shift_reg;
   reg    [30:0] lbist_lp_mask_hold_reg;
   wire          lbist_lp_mask_force_update;
   wire   [30:0] lbist_lp_mask;
   wire          lbist_reset_sync;
   wire          edt_update_sync;

   assign ijtag_si_int = ccm_scan_en ? ccm_le_si : ijtag_si;
   assign lfsm_inject = (lbist_en == 1'b1 || lbist_scan_en == 1'b1) ? 1'b0 : edt_channels_in;
   assign lbist_reset_sync = lbist_reset & lbist_en;
   assign lbist_scan_en = ccm_scan_en | (ijtag_to_sel & ijtag_se);
   assign lbist_scan_en_lp_static_control = ccm_scan_en | (ijtag_to_sel_lp_static_control & ijtag_se);
   assign lbist_scan_en_lp_mask_shift_reg = ccm_scan_en | (ijtag_to_sel_lp_mask_shift_reg & ijtag_se);
   assign edt_update_sync = edt_update & ~ccm_scan_en;

   // synopsys sync_set_reset "edt_update_sync, lbist_reset_sync"
   always @(posedge edt_clock)
   begin : lfsm
      if (edt_update_sync == 1'b1) begin
         lfsm_vec <= 31'b0000000000000000000000000000000;
      end
      else if (lbist_reset_sync == 1'b1) begin
         lfsm_vec <= 31'b0011110000011111110010111001001;
      end
      else if (lbist_en == 1'b0 || (lbist_en == 1'b1 && (lbist_prpg_en == 1'b1 || lbist_scan_en == 1'b1))) begin
         lfsm_vec[ 0] <= lfsm_vec[ 1];
         lfsm_vec[ 1] <= lfsm_vec[ 2] ^ lfsm_inject;
         lfsm_vec[ 2] <= lfsm_vec[ 3];
         lfsm_vec[ 3] <= lfsm_vec[ 4] ^ lfsm_inject;
         lfsm_vec[ 4] <= lfsm_vec[ 5];
         lfsm_vec[ 5] <= lfsm_vec[ 6] ^ lfsm_inject;
         lfsm_vec[ 6] <= lfsm_vec[ 7];
         lfsm_vec[ 7] <= lfsm_vec[ 8] ^ lfsm_inject;
         lfsm_vec[ 8] <= lfsm_vec[ 9];
         lfsm_vec[ 9] <= lfsm_vec[10] ^ lfsm_inject;
         lfsm_vec[10] <= lfsm_vec[11];
         lfsm_vec[11] <= lfsm_vec[12] ^ lfsm_inject;
         lfsm_vec[12] <= lfsm_vec[13];
         lfsm_vec[13] <= lfsm_vec[14];
         lfsm_vec[14] <= lfsm_vec[15] ^ lfsm_inject;
         lfsm_vec[15] <= lfsm_vec[16];
         lfsm_vec[16] <= lfsm_vec[17] ^ lfsm_inject;
         lfsm_vec[17] <= lfsm_vec[18] ^ (lfsm_vec[11] & ~lbist_scan_en);
         lfsm_vec[18] <= lfsm_vec[19] ^ lfsm_inject;
         lfsm_vec[19] <= lfsm_vec[20];
         lfsm_vec[20] <= lfsm_vec[21] ^ lfsm_inject;
         lfsm_vec[21] <= lfsm_vec[22] ^ (lfsm_vec[10] & ~lbist_scan_en);
         lfsm_vec[22] <= lfsm_vec[23] ^ lfsm_inject;
         lfsm_vec[23] <= lfsm_vec[24];
         lfsm_vec[24] <= lfsm_vec[25] ^ lfsm_inject;
         lfsm_vec[25] <= lfsm_vec[26] ^ (lfsm_vec[ 5] & ~lbist_scan_en);
         lfsm_vec[26] <= lfsm_vec[27] ^ lfsm_inject;
         lfsm_vec[27] <= lfsm_vec[28];
         lfsm_vec[28] <= lfsm_vec[29] ^ lfsm_inject;
         lfsm_vec[29] <= lfsm_vec[30];
         lfsm_vec[30] <= lbist_scan_en ? ijtag_si_int : (lfsm_vec[ 0] ^ lfsm_inject);
      end
   end

   assign ijtag_so_int = ccm_scan_en ? lbist_lp_mask_hold_reg[0] : lbist_lp_mask_shift_reg[0];

   always @(negedge edt_clock)
   begin : lockup_cells
      if (ccm_scan_en == 1'b1) begin
         lfsm_vec_lockup[30] <= ccm_te_si;
         lfsm_vec_lockup[29] <= lfsm_vec_lockup[30];
         lfsm_vec_lockup[28] <= lfsm_vec_lockup[29];
         lfsm_vec_lockup[26] <= lfsm_vec_lockup[28];
         lfsm_vec_lockup[25] <= lfsm_vec_lockup[26];
         lfsm_vec_lockup[24] <= lfsm_vec_lockup[25];
         lfsm_vec_lockup[23] <= lfsm_vec_lockup[24];
         lfsm_vec_lockup[22] <= lfsm_vec_lockup[23];
         lfsm_vec_lockup[21] <= lfsm_vec_lockup[22];
         lfsm_vec_lockup[20] <= lfsm_vec_lockup[21];
         lfsm_vec_lockup[19] <= lfsm_vec_lockup[20];
         lfsm_vec_lockup[18] <= lfsm_vec_lockup[19];
         lfsm_vec_lockup[17] <= lfsm_vec_lockup[18];
         lfsm_vec_lockup[16] <= lfsm_vec_lockup[17];
         lfsm_vec_lockup[15] <= lfsm_vec_lockup[16];
         lfsm_vec_lockup[14] <= lfsm_vec_lockup[15];
         lfsm_vec_lockup[13] <= lfsm_vec_lockup[14];
         lfsm_vec_lockup[12] <= lfsm_vec_lockup[13];
         lfsm_vec_lockup[11] <= lfsm_vec_lockup[12];
         lfsm_vec_lockup[10] <= lfsm_vec_lockup[11];
         lfsm_vec_lockup[ 9] <= lfsm_vec_lockup[10];
         lfsm_vec_lockup[ 8] <= lfsm_vec_lockup[ 9];
         lfsm_vec_lockup[ 7] <= lfsm_vec_lockup[ 8];
         lfsm_vec_lockup[ 6] <= lfsm_vec_lockup[ 7];
         lfsm_vec_lockup[ 5] <= lfsm_vec_lockup[ 6];
         lfsm_vec_lockup[ 4] <= lfsm_vec_lockup[ 5];
         lfsm_vec_lockup[ 3] <= lfsm_vec_lockup[ 4];
         lfsm_vec_lockup[ 2] <= lfsm_vec_lockup[ 3];
         lfsm_vec_lockup[ 1] <= lfsm_vec_lockup[ 2];
         lfsm_vec_lockup[ 0] <= lfsm_vec_lockup[ 1];
      end
      else begin
         if (lbist_en == 1'b0 || lbist_lp_mask[ 0] == 1'b1) begin
            lfsm_vec_lockup[ 0] <= lfsm_vec[ 0];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 1] == 1'b1) begin
            lfsm_vec_lockup[ 1] <= lfsm_vec[ 1];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 2] == 1'b1) begin
            lfsm_vec_lockup[ 2] <= lfsm_vec[ 2];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 3] == 1'b1) begin
            lfsm_vec_lockup[ 3] <= lfsm_vec[ 3];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 4] == 1'b1) begin
            lfsm_vec_lockup[ 4] <= lfsm_vec[ 4];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 5] == 1'b1) begin
            lfsm_vec_lockup[ 5] <= lfsm_vec[ 5];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 6] == 1'b1) begin
            lfsm_vec_lockup[ 6] <= lfsm_vec[ 6];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 7] == 1'b1) begin
            lfsm_vec_lockup[ 7] <= lfsm_vec[ 7];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 8] == 1'b1) begin
            lfsm_vec_lockup[ 8] <= lfsm_vec[ 8];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 9] == 1'b1) begin
            lfsm_vec_lockup[ 9] <= lfsm_vec[ 9];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[10] == 1'b1) begin
            lfsm_vec_lockup[10] <= lfsm_vec[10];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[11] == 1'b1) begin
            lfsm_vec_lockup[11] <= lfsm_vec[11];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[12] == 1'b1) begin
            lfsm_vec_lockup[12] <= lfsm_vec[12];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[13] == 1'b1) begin
            lfsm_vec_lockup[13] <= lfsm_vec[13];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[14] == 1'b1) begin
            lfsm_vec_lockup[14] <= lfsm_vec[14];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[15] == 1'b1) begin
            lfsm_vec_lockup[15] <= lfsm_vec[15];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[16] == 1'b1) begin
            lfsm_vec_lockup[16] <= lfsm_vec[16];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[17] == 1'b1) begin
            lfsm_vec_lockup[17] <= lfsm_vec[17];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[18] == 1'b1) begin
            lfsm_vec_lockup[18] <= lfsm_vec[18];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[19] == 1'b1) begin
            lfsm_vec_lockup[19] <= lfsm_vec[19];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[20] == 1'b1) begin
            lfsm_vec_lockup[20] <= lfsm_vec[20];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[21] == 1'b1) begin
            lfsm_vec_lockup[21] <= lfsm_vec[21];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[22] == 1'b1) begin
            lfsm_vec_lockup[22] <= lfsm_vec[22];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[23] == 1'b1) begin
            lfsm_vec_lockup[23] <= lfsm_vec[23];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[24] == 1'b1) begin
            lfsm_vec_lockup[24] <= lfsm_vec[24];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[25] == 1'b1) begin
            lfsm_vec_lockup[25] <= lfsm_vec[25];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[26] == 1'b1) begin
            lfsm_vec_lockup[26] <= lfsm_vec[26];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[28] == 1'b1) begin
            lfsm_vec_lockup[28] <= lfsm_vec[28];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[29] == 1'b1) begin
            lfsm_vec_lockup[29] <= lfsm_vec[29];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[30] == 1'b1) begin
            lfsm_vec_lockup[30] <= lfsm_vec[30];
         end
      end
   end

   always @(lfsm_vec_lockup)
   begin : phase_shifter
      edt_scan_in[ 0] = lfsm_vec_lockup[12] ^ lfsm_vec_lockup[15] ^ lfsm_vec_lockup[17];
      edt_scan_in[ 1] = lfsm_vec_lockup[13] ^ lfsm_vec_lockup[14] ^ lfsm_vec_lockup[26];
      edt_scan_in[ 2] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[30];
      edt_scan_in[ 3] = lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[ 9] ^ lfsm_vec_lockup[29];
      edt_scan_in[ 4] = lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[23];
      edt_scan_in[ 5] = lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[10] ^ lfsm_vec_lockup[25];
      edt_scan_in[ 6] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[19] ^ lfsm_vec_lockup[28];
      edt_scan_in[ 7] = lfsm_vec_lockup[11] ^ lfsm_vec_lockup[22] ^ lfsm_vec_lockup[24];
      edt_scan_in[ 8] = lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[18] ^ lfsm_vec_lockup[20];
      edt_scan_in[ 9] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[16] ^ lfsm_vec_lockup[21];
      edt_mask        = lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[24] ^ lfsm_vec_lockup[26];
   end

   msrv32_top_pass2_rtl_tessent_edt_c0_sib msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(ijtag_si),
      .ijtag_from_so(lfsm_vec[0]),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(lfsm_vec_lockup[0]),
      .ccm_te_so(ccm_te_so_decompressor_sib),
      .ijtag_so(decompressor_sib_so),
      .ijtag_to_sel(ijtag_to_sel));

   always @(posedge edt_clock)
   begin : lbist_low_power_hold_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_hold_reg <= 4'd15;
      end
      else if (lbist_scan_en_lp_static_control == 1'b1) begin
         lbist_lp_hold_reg <= {decompressor_sib_so, lbist_lp_hold_reg[3:1]};
      end
   end

   always @(posedge edt_clock)
   begin : lbist_low_power_toggle_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_toggle_reg <= 4'd11;
      end
      else if (lbist_scan_en_lp_static_control == 1'b1) begin
         lbist_lp_toggle_reg <= {lbist_lp_hold_reg[0], lbist_lp_toggle_reg[3:1]};
      end
   end

   assign lbist_lp_ht_encoder_in = lbist_lp_T_reg ? lbist_lp_toggle_reg : lbist_lp_hold_reg;

   assign lbist_lp_ht_encoder_prpg_c1 = lfsm_vec[0];
   assign lbist_lp_ht_encoder_prpg_c2 = lfsm_vec[3] & lfsm_vec[6];
   assign lbist_lp_ht_encoder_prpg_c3 = lfsm_vec[9] & lfsm_vec[12] & lfsm_vec[15];
   assign lbist_lp_ht_encoder_prpg_c4 = lfsm_vec[18] & lfsm_vec[21] & lfsm_vec[24] & lfsm_vec[27];

   assign lbist_lp_ht_encoder_out = (lbist_lp_ht_encoder_in[0] & lbist_lp_ht_encoder_prpg_c1) |
                                    (lbist_lp_ht_encoder_in[1] & lbist_lp_ht_encoder_prpg_c2) |
                                    (lbist_lp_ht_encoder_in[2] & lbist_lp_ht_encoder_prpg_c3) |
                                    (lbist_lp_ht_encoder_in[3] & lbist_lp_ht_encoder_prpg_c4);

   always @(posedge edt_clock)
   begin 
      if (ccm_scan_en == 1'b1) begin
         lbist_lp_T_reg <= lbist_lp_mask_shift_reg[0];
      end
      else if (lbist_reset == 1'b1 || lbist_prpg_en == 1'b0) begin
         lbist_lp_T_reg <= 1'b1;
      end
      else if (lbist_lp_ht_encoder_out == 1'b1) begin
         lbist_lp_T_reg <= ~lbist_lp_T_reg;
      end
   end

   always @(posedge edt_clock)
   begin : lbist_low_power_switching_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_switching_reg <= 4'd11;
      end
      else if (lbist_scan_en_lp_static_control == 1'b1) begin
         lbist_lp_switching_reg <= {lbist_lp_toggle_reg[0], lbist_lp_switching_reg[3:1]};
      end
   end

   assign lbist_lp_switching_prpg_c1 = lfsm_vec[1];
   assign lbist_lp_switching_prpg_c2 = lfsm_vec[4] & lfsm_vec[7];
   assign lbist_lp_switching_prpg_c3 = lfsm_vec[10] & lfsm_vec[13] & lfsm_vec[16];
   assign lbist_lp_switching_prpg_c4 = lfsm_vec[19] & lfsm_vec[22] & lfsm_vec[25] & lfsm_vec[28];

   assign lbist_lp_switching_encoder_out = (lbist_lp_switching_reg[0] & lbist_lp_switching_prpg_c1) |
                                           (lbist_lp_switching_reg[1] & lbist_lp_switching_prpg_c2) |
                                           (lbist_lp_switching_reg[2] & lbist_lp_switching_prpg_c3) |
                                           (lbist_lp_switching_reg[3] & lbist_lp_switching_prpg_c4);

   msrv32_top_pass2_rtl_tessent_edt_c0_sib msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(decompressor_sib_so),
      .ijtag_from_so(lbist_lp_switching_reg[0]),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_decompressor_sib),
      .ccm_te_so(ccm_te_so_lbist_lp_static_control_sib),
      .ijtag_so(lbist_lp_static_control_sib_so),
      .ijtag_to_sel(ijtag_to_sel_lp_static_control));

   assign lbist_lp_mask_shift_reg_in = lbist_scan_en_lp_mask_shift_reg ? lbist_lp_static_control_sib_so : lbist_lp_switching_encoder_out;

   always @(posedge edt_clock)
   begin : lbist_low_power_mask_shift_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_mask_shift_reg <= 31'b1001111101110110110111110110011;
      end
      else if (lbist_scan_en_lp_mask_shift_reg == 1'b1 || lbist_prpg_en == 1'b1) begin
         lbist_lp_mask_shift_reg <= {lbist_lp_mask_shift_reg_in, lbist_lp_mask_shift_reg[30:1]};
      end
   end

   always @(posedge edt_clock)
   begin 
      if (ccm_scan_en == 1'b1) begin
         lbist_lp_mask_hold_reg <= {lbist_lp_T_reg, lbist_lp_mask_hold_reg[30:1]};
      end
      else if (lbist_prpg_en == 1'b0) begin
         lbist_lp_mask_hold_reg <= lbist_lp_mask_shift_reg;
      end
   end

   assign lbist_lp_mask_force_update = (~|lbist_lp_switching_reg) | ~lbist_prpg_en | ~lbist_low_power_shift_en;

   assign lbist_lp_mask = ({31{lbist_lp_T_reg}} & lbist_lp_mask_hold_reg) | {31{lbist_lp_mask_force_update}};
   msrv32_top_pass2_rtl_tessent_edt_c0_sib msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(lbist_lp_static_control_sib_so),
      .ijtag_from_so(ijtag_so_int),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_lbist_lp_static_control_sib),
      .ccm_te_so(ccm_te_so),
      .ijtag_so(ijtag_so),
      .ijtag_to_sel(ijtag_to_sel_lp_mask_shift_reg));

   assign ccm_le_so = ijtag_so;
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_low_power_shift_decoder (
   input  wire [7:0] encoded_control,
   output wire [9:0] decoded_control
);
   assign decoded_control[0] = encoded_control[0];
   assign decoded_control[1] = encoded_control[0];
   assign decoded_control[2] = encoded_control[1];
   assign decoded_control[3] = encoded_control[1];
   assign decoded_control[4] = encoded_control[2];
   assign decoded_control[5] = encoded_control[3];
   assign decoded_control[6] = encoded_control[4];
   assign decoded_control[7] = encoded_control[5];
   assign decoded_control[8] = encoded_control[6];
   assign decoded_control[9] = encoded_control[7];
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_low_power_shift_controller (
   input  wire       edt_clock,
   input  wire       edt_update,
   input  wire       edt_low_power_shift_en,
   input  wire       edt_channels_in,
   input  wire [9:0] edt_decompressor_out,
   output wire       edt_channels_out_from_low_power_shift_control,
   output wire [9:0] edt_scan_in,
   input  wire [9:0] edt_chain_mask,
   input  wire       edt_chain_mask_load_en,
   input  wire       lbist_en,
   input  wire       ccm_scan_en,
   input  wire       ccm_le_si,
   output wire       ccm_le_so
);
   reg    [7:0] low_power_shift_reg_0;
   reg    [7:0] low_power_hold_reg_0;
   wire   [7:0] encoded_control;
   wire   [9:0] decoded_control;
   wire   [9:0] bias_inputs;
   wire         low_power_shift_reg_sync_reset;
   wire         low_power_hold_reg_sync_set;
   wire   [9:0] effective_chain_input_mask;

   assign low_power_shift_reg_sync_reset = edt_update & ~ccm_scan_en;

   // synopsys sync_set_reset low_power_shift_reg_sync_reset
   always @(posedge edt_clock)
   begin : shift_low_power_regs
      if (low_power_shift_reg_sync_reset == 1'b1) begin
         low_power_shift_reg_0 <= 8'b00000000;
      end
      else if (ccm_scan_en == 1'b1) begin
         low_power_shift_reg_0 <= {low_power_hold_reg_0[0], low_power_shift_reg_0[7:1]};
      end
      else begin
         low_power_shift_reg_0 <= {edt_channels_in, low_power_shift_reg_0[7:1]};
      end
   end

   assign ccm_le_so = low_power_shift_reg_0[0];

   assign low_power_hold_reg_sync_set = edt_update & ~edt_low_power_shift_en & ~ccm_scan_en;

   // synopsys sync_set_reset low_power_hold_reg_sync_set
   always @(posedge edt_clock)
   begin : update_low_power_regs
      if (low_power_hold_reg_sync_set == 1'b1) begin
         low_power_hold_reg_0 <= 8'b11111111;
      end
      else if (ccm_scan_en == 1'b1) begin
         low_power_hold_reg_0 <= {ccm_le_si, low_power_hold_reg_0[7:1]};
      end
      else begin
         if (edt_update == 1'b1) begin
            low_power_hold_reg_0 <= low_power_shift_reg_0;
         end
      end
   end

   assign edt_channels_out_from_low_power_shift_control = edt_low_power_shift_en ? low_power_shift_reg_0[0] : edt_channels_in;

   assign encoded_control = {low_power_hold_reg_0[7], low_power_hold_reg_0[6], low_power_hold_reg_0[5], 
                             low_power_hold_reg_0[4], low_power_hold_reg_0[3], low_power_hold_reg_0[2], 
                             low_power_hold_reg_0[1], low_power_hold_reg_0[0]};

   msrv32_top_pass2_rtl_tessent_edt_c0_low_power_shift_decoder decoder (
      .encoded_control(encoded_control),
      .decoded_control(decoded_control));

   assign bias_inputs = lbist_en ? 10'b1111111111 : decoded_control;

   assign effective_chain_input_mask = edt_chain_mask_load_en ? edt_chain_mask : 10'b1111111111;

   assign edt_scan_in[0] = edt_decompressor_out[0] & bias_inputs[0] & effective_chain_input_mask[0];
   assign edt_scan_in[1] = edt_decompressor_out[1] & bias_inputs[1] & effective_chain_input_mask[1];
   assign edt_scan_in[2] = edt_decompressor_out[2] & bias_inputs[2] & effective_chain_input_mask[2];
   assign edt_scan_in[3] = edt_decompressor_out[3] & bias_inputs[3] & effective_chain_input_mask[3];
   assign edt_scan_in[4] = edt_decompressor_out[4] & bias_inputs[4] & effective_chain_input_mask[4];
   assign edt_scan_in[5] = edt_decompressor_out[5] & bias_inputs[5] & effective_chain_input_mask[5];
   assign edt_scan_in[6] = edt_decompressor_out[6] & bias_inputs[6] & effective_chain_input_mask[6];
   assign edt_scan_in[7] = edt_decompressor_out[7] & bias_inputs[7] & effective_chain_input_mask[7];
   assign edt_scan_in[8] = edt_decompressor_out[8] & bias_inputs[8] & effective_chain_input_mask[8];
   assign edt_scan_in[9] = edt_decompressor_out[9] & bias_inputs[9] & effective_chain_input_mask[9];
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_spatial_compactor_10_w_output_lockup (
   input  wire       edt_clock,
   input  wire [9:0] multi_bit_input,
   output reg        single_bit_output,
   output wire [9:0] lbist_misr_in,
   input  wire       ccm_scan_en,
   input  wire       ccm_te_si,
   output wire       ccm_te_so,
   input  wire       ccm_le_si,
   output wire       ccm_le_so
);
   reg    [4:0] level1;
   reg    [2:0] level2;
   reg    [1:0] level3;
   reg          level4_pipelined;

   always @(multi_bit_input)
   begin : compact10_level1
      level1[0] = multi_bit_input[0] ^ multi_bit_input[1];
      level1[1] = multi_bit_input[2] ^ multi_bit_input[3];
      level1[2] = multi_bit_input[4] ^ multi_bit_input[5];
      level1[3] = multi_bit_input[6] ^ multi_bit_input[7];
      level1[4] = multi_bit_input[8] ^ multi_bit_input[9];
   end

   always @(level1)
   begin : compact10_level2
      level2[0] = level1[0] ^ level1[1];
      level2[1] = level1[2] ^ level1[3];
      level2[2] = level1[4];
   end

   always @(level2)
   begin : compact10_level3
      level3[0] = level2[0] ^ level2[1];
      level3[1] = level2[2];
   end

   always @(posedge edt_clock)
   begin : compact10_level4_pipelined
      if (ccm_scan_en == 1'b1) begin
         level4_pipelined <= ccm_le_si;
      end
      else begin
         level4_pipelined <= level3[0] ^ level3[1];
      end
   end

   always @(negedge edt_clock)
   begin : compact10_level4_lockup
      if (ccm_scan_en == 1'b1) begin
         single_bit_output <= ccm_te_si;
      end
      else begin
         single_bit_output <= level4_pipelined;
      end
   end

   assign lbist_misr_in = multi_bit_input;
   assign ccm_le_so = level4_pipelined;
   assign ccm_te_so = single_bit_output;
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_controlled_decoder_4_to_10 (
   input  wire       control_bit,
   input  wire [3:0] encoded_masks,
   output reg  [9:0] decoded_masks
);
   always @(control_bit or encoded_masks)
   begin
      if (control_bit == 1'b1) begin
         decoded_masks = 10'b1111111111;
      end
      else begin
         case (encoded_masks)
            4'b0000: decoded_masks = 10'b0000000000;
            4'b0001: decoded_masks = 10'b0000000001;
            4'b0010: decoded_masks = 10'b0000000010;
            4'b0011: decoded_masks = 10'b0000000100;
            4'b0100: decoded_masks = 10'b0000001000;
            4'b0101: decoded_masks = 10'b0000010000;
            4'b0110: decoded_masks = 10'b0000100000;
            4'b0111: decoded_masks = 10'b0001000000;
            4'b1000: decoded_masks = 10'b0010000000;
            4'b1001: decoded_masks = 10'b0100000000;
            4'b1010: decoded_masks = 10'b1000000000;
            default: decoded_masks = 10'b1111111111;
         endcase
      end
   end
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_compactor (
   input  wire       edt_clock,
   input  wire       edt_update,
   input  wire [9:0] edt_scan_out,
   input  wire       edt_mask,
   output wire       edt_channels_out,
   output reg  [9:0] edt_chain_mask,
   output reg        edt_chain_mask_load_en,
   input  wire       lbist_reset,
   input  wire       lbist_en,
   input  wire       ijtag_tck,
   input  wire       ijtag_reset,
   input  wire       ijtag_sel,
   input  wire       ijtag_ce,
   input  wire       ijtag_se,
   input  wire       ijtag_ue,
   input  wire       ccm_scan_en,
   input  wire       ccm_en,
   input  wire       ccm_le_si,
   output wire       ccm_le_so,
   input  wire       ccm_te_si,
   output wire       ccm_te_so,
   input  wire       ijtag_si,
   output wire       ijtag_so,
   output wire [9:0] lbist_misr_in
);
   reg    [ 4:0] masks_shift_reg;
   reg    [ 4:0] masks_hold_reg;
   wire          control_bit;
   wire   [ 3:0] encoded_masks1;
   wire          lbist_reset_sync;
   wire          ijtag_si_int;
   wire          lbist_scan_en;
   wire          ijtag_to_sel;
   wire          ijtag_so_int;
   wire   [ 9:0] edt_pp_decoded_masks1;
   wire   [ 9:0] effective_pp_decoded_masks1;
   wire          ccm_compactor_mask_override;
   wire          ccm_te_so_chain_mask_sib;
   wire          ijtag_so_masks_reg;
   wire   [ 9:0] decoded_masks1;
   wire   [ 9:0] masked_scan_outputs1;
   wire          ccm_te_so_compactor1;
   wire          ccm_le_so_compactor1;
   wire          ijtag_so_spcomp;

   always @(posedge edt_clock)
   begin : shift_masks_regs
      if (ccm_scan_en == 1'b1) begin
         masks_shift_reg <= {masks_hold_reg[0], masks_shift_reg[4:1]};
      end
      else begin
         masks_shift_reg <= {edt_mask, masks_shift_reg[4:1]};
      end
   end

   assign ijtag_so_masks_reg = masks_shift_reg[0];

   always @(posedge edt_clock)
   begin : update_masks_regs
      if (ccm_scan_en == 1'b1) begin
         masks_hold_reg <= {edt_chain_mask_load_en, masks_hold_reg[4:1]};
      end
      else begin
         if (edt_update == 1'b1) begin
            masks_hold_reg <= masks_shift_reg;
         end
      end
   end

   assign control_bit    = masks_hold_reg[4];
   assign encoded_masks1 = masks_hold_reg[3:0];

   msrv32_top_pass2_rtl_tessent_edt_c0_controlled_decoder_4_to_10 decoder1 (.control_bit(control_bit),
                                                                            .encoded_masks(encoded_masks1),
                                                                            .decoded_masks(edt_pp_decoded_masks1));
   assign lbist_scan_en = ccm_scan_en | (ijtag_to_sel & ijtag_se);

   assign ijtag_si_int = ccm_scan_en ? ccm_le_si : ijtag_si;

   assign lbist_reset_sync = lbist_reset & lbist_en;

   // synopsys sync_set_reset lbist_reset_sync
   always @(posedge edt_clock)
   begin : chain_mask_shift_register
      if (lbist_reset_sync == 1'b1) begin
         edt_chain_mask <= 10'b1111111111;
      end
      else if (lbist_scan_en == 1'b1) begin
         edt_chain_mask <= {ijtag_si_int, edt_chain_mask[9:1]};
      end
   end

   always @(posedge edt_clock)
   begin : chain_mask_load_en_register
      if (lbist_reset_sync == 1'b1) begin
         edt_chain_mask_load_en <= 1'b1;
      end
      else if (lbist_scan_en == 1'b1) begin
         edt_chain_mask_load_en <= edt_chain_mask[0];
      end
   end

   assign ijtag_so_int = ccm_scan_en ? ijtag_so_spcomp : edt_chain_mask_load_en;

   msrv32_top_pass2_rtl_tessent_edt_c0_sib msrv32_top_pass2_rtl_tessent_edt_c0_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(ijtag_si),
      .ijtag_from_so(ijtag_so_int),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_si),
      .ccm_te_so(ccm_te_so_chain_mask_sib),
      .ijtag_so(ijtag_so),
      .ijtag_to_sel(ijtag_to_sel));

   assign ccm_le_so = ijtag_so;

   assign effective_pp_decoded_masks1 = lbist_en ? 10'b1111111111 : edt_pp_decoded_masks1;

   assign ccm_compactor_mask_override = masks_hold_reg[0] & ccm_en;
   assign decoded_masks1 = (edt_chain_mask[9:0] & effective_pp_decoded_masks1) | {10{ccm_compactor_mask_override}};

   assign masked_scan_outputs1 = edt_scan_out[9:0] & decoded_masks1;

   msrv32_top_pass2_rtl_tessent_edt_c0_spatial_compactor_10_w_output_lockup compactor1 (.edt_clock(edt_clock),
                                                                                        .multi_bit_input(masked_scan_outputs1),
                                                                                        .single_bit_output(edt_channels_out),
                                                                                        .lbist_misr_in(lbist_misr_in[9:0]),
                                                                                        .ccm_scan_en(ccm_scan_en),
                                                                                        .ccm_te_si(ccm_te_so_chain_mask_sib),
                                                                                        .ccm_te_so(ccm_te_so_compactor1),
                                                                                        .ccm_le_si(ijtag_so_masks_reg),
                                                                                        .ccm_le_so(ccm_le_so_compactor1));

   assign ijtag_so_spcomp = ccm_le_so_compactor1;
   assign ccm_te_so = ccm_te_so_compactor1;
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_bypass_logic (
   input  wire       edt_bypass,
   input  wire       edt_single_bypass_chain,
   input  wire       lbist_en,
   input  wire       ccm_en,
   input  wire       edt_channels_in,
   output wire       edt_channels_out,
   output reg  [9:0] edt_scan_in,
   input  wire [9:0] edt_scan_out,
   output wire [9:0] edt_scan_out_lockup,
   input  wire [9:0] edt_bypass_in,
   input  wire       edt_bypass_out
);
   reg    [9:0] edt_scan_out_lockup_int;
   wire        bypass_on;

   always @(edt_scan_out)
   begin 
      edt_scan_out_lockup_int[ 0] = edt_scan_out[ 0];
      edt_scan_out_lockup_int[ 1] = edt_scan_out[ 1];
      edt_scan_out_lockup_int[ 2] = edt_scan_out[ 2];
      edt_scan_out_lockup_int[ 3] = edt_scan_out[ 3];
      edt_scan_out_lockup_int[ 4] = edt_scan_out[ 4];
      edt_scan_out_lockup_int[ 5] = edt_scan_out[ 5];
      edt_scan_out_lockup_int[ 6] = edt_scan_out[ 6];
      edt_scan_out_lockup_int[ 7] = edt_scan_out[ 7];
      edt_scan_out_lockup_int[ 8] = edt_scan_out[ 8];
      edt_scan_out_lockup_int[ 9] = edt_scan_out[ 9];
   end

   assign bypass_on = lbist_en ? edt_single_bypass_chain : (edt_bypass | edt_single_bypass_chain);

   always @(bypass_on or edt_channels_in or edt_scan_out_lockup_int or edt_bypass_in)
   begin 
      edt_scan_in[0] = bypass_on ? edt_channels_in : edt_bypass_in[0];
      edt_scan_in[1] = bypass_on ? edt_scan_out_lockup_int[0] : edt_bypass_in[1];
      edt_scan_in[2] = bypass_on ? edt_scan_out_lockup_int[1] : edt_bypass_in[2];
      edt_scan_in[3] = bypass_on ? edt_scan_out_lockup_int[2] : edt_bypass_in[3];
      edt_scan_in[4] = bypass_on ? edt_scan_out_lockup_int[3] : edt_bypass_in[4];
      edt_scan_in[5] = bypass_on ? edt_scan_out_lockup_int[4] : edt_bypass_in[5];
      edt_scan_in[6] = bypass_on ? edt_scan_out_lockup_int[5] : edt_bypass_in[6];
      edt_scan_in[7] = bypass_on ? edt_scan_out_lockup_int[6] : edt_bypass_in[7];
      edt_scan_in[8] = bypass_on ? edt_scan_out_lockup_int[7] : edt_bypass_in[8];
      edt_scan_in[9] = bypass_on ? edt_scan_out_lockup_int[8] : edt_bypass_in[9];
   end

   assign edt_channels_out = bypass_on ? edt_scan_out_lockup_int[9] : edt_bypass_out;

   assign edt_scan_out_lockup = ccm_en ? edt_scan_in : edt_scan_out_lockup_int;
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_misr_reg (
   input  wire        edt_clock,
   input  wire        clear,
   input  wire        scan_en,
   input  wire        scan_in,
   input  wire        ccm_scan_en,
   input  wire        ccm_le_si,
   output wire        ccm_le_so,
   input  wire [23:0] new_misr,
   output reg  [23:0] misr
);
   wire        scan_in_int;

   assign scan_in_int = ccm_scan_en ? ccm_le_si : scan_in;

   // synopsys sync_set_reset clear
   always @(posedge edt_clock)
   begin 
      if (clear == 1'b1) begin
         misr <= 24'b000000000000000000000000;
      end
      else begin
         if (scan_en == 1'b1) begin
            misr <= {scan_in_int, misr[23:1]};
         end
         else begin
            misr <= new_misr;
         end
      end
   end

   assign ccm_le_so = misr[0];
endmodule


module msrv32_top_pass2_rtl_tessent_edt_c0_misr (
   input  wire        edt_clock,
   input  wire        lbist_reset,
   input  wire        ccm_scan_en,
   input  wire        ccm_le_si,
   output wire        ccm_le_so,
   input  wire        ccm_te_si,
   output wire        ccm_te_so,
   input  wire        accumulate,
   input  wire [ 9:0] misr_in,
   output wire [23:0] misr,
   input  wire        ijtag_tck,
   input  wire        ijtag_reset,
   input  wire        ijtag_sel,
   input  wire        ijtag_ce,
   input  wire        ijtag_se,
   input  wire        ijtag_ue,
   input  wire        ijtag_si,
   output wire        ijtag_so
);
   wire          lbist_scan_en_int;
   wire          ijtag_to_sel;
   reg    [23:0] new_misr;
   wire   [23:0] misr_d;
   wire          clear;
   wire          ccm_le_so_misr_reg_int;
   wire          ijtag_from_so_int;

   assign lbist_scan_en_int = ccm_scan_en | (ijtag_to_sel & ijtag_se);
   assign misr_d = {14'd0, misr_in};
   assign clear = lbist_reset & ~lbist_scan_en_int;

   always @(accumulate or misr_d or misr)
   begin 
      if (accumulate == 1'b1) begin
         new_misr[0] = misr_d[0] ^ misr[1];
         new_misr[1] = misr_d[1] ^ misr[2];
         new_misr[2] = misr_d[2] ^ misr[3];
         new_misr[3] = misr_d[3] ^ misr[4];
         new_misr[4] = misr_d[4] ^ misr[5];
         new_misr[5] = misr_d[5] ^ misr[6];
         new_misr[6] = misr_d[6] ^ misr[7];
         new_misr[7] = misr_d[7] ^ misr[8];
         new_misr[8] = misr_d[8] ^ misr[9];
         new_misr[9] = misr_d[9] ^ misr[10];
         new_misr[10] = misr_d[10] ^ misr[11];
         new_misr[11] = misr_d[11] ^ misr[12];
         new_misr[12] = misr_d[12] ^ misr[13];
         new_misr[13] = misr_d[13] ^ misr[14];
         new_misr[14] = misr_d[14] ^ misr[15];
         new_misr[15] = misr_d[15] ^ misr[16];
         new_misr[16] = misr_d[16] ^ misr[17];
         new_misr[17] = misr_d[17] ^ misr[18];
         new_misr[18] = misr_d[18] ^ misr[19];
         new_misr[19] = misr_d[19] ^ misr[20] ^ misr[0];
         new_misr[20] = misr_d[20] ^ misr[21] ^ misr[0];
         new_misr[21] = misr_d[21] ^ misr[22];
         new_misr[22] = misr_d[22] ^ misr[23] ^ misr[0];
         new_misr[23] = misr_d[23] ^ misr[0];
      end
      else begin
         new_misr = misr;
      end
   end

   msrv32_top_pass2_rtl_tessent_edt_c0_misr_reg msrv32_top_pass2_rtl_tessent_edt_c0_misr_reg_i (
      .edt_clock(edt_clock),
      .clear(clear),
      .scan_en(lbist_scan_en_int),
      .scan_in(ijtag_si),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_le_si),
      .ccm_le_so(ccm_le_so_misr_reg_int),
      .new_misr(new_misr),
      .misr(misr));

   assign ijtag_from_so_int = ccm_scan_en ? ccm_le_so_misr_reg_int : misr[0];

   msrv32_top_pass2_rtl_tessent_edt_c0_sib msrv32_top_pass2_rtl_tessent_edt_c0_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(ijtag_si),
      .ijtag_from_so(ijtag_from_so_int),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_si),
      .ccm_te_so(ccm_te_so),
      .ijtag_so(ijtag_so),
      .ijtag_to_sel(ijtag_to_sel));

   assign ccm_le_so = ijtag_so;
endmodule


module msrv32_top_pass2_rtl_tessent_edt_lbist_c0 (
   input  wire        edt_clock,
   input  wire        edt_update,
   input  wire        edt_low_power_shift_en,
   input  wire        edt_bypass,
   input  wire        edt_single_bypass_chain,
   input  wire        edt_channels_in,
   output wire        edt_channels_out,
   output wire [ 9:0] edt_scan_in,
   input  wire [ 9:0] edt_scan_out,
   input  wire        lbist_reset,
   input  wire        lbist_en,
   input  wire        lbist_prpg_en,
   input  wire        misr_accumulate_en,
   input  wire        lbist_low_power_shift_en,
   input  wire        ijtag_tck,
   input  wire        ijtag_reset,
   input  wire        ijtag_sel,
   input  wire        ijtag_ce,
   input  wire        ijtag_se,
   input  wire        ijtag_ue,
   input  wire        ccm_en,
   input  wire        ccm_scan_en,
   input  wire        ijtag_si,
   output wire        ijtag_so,
   output wire [23:0] lbist_misr
);
   wire         edt_mask;
   wire         edt_channels_out_from_low_power_shift_control;
   wire   [9:0] edt_decompressor_out;
   wire   [9:0] edt_bypass_in;
   wire         edt_bypass_out;
   wire   [9:0] edt_scan_out_lockup;
   wire         ijtag_so_decompressor;
   wire         ijtag_so_compactor;
   wire         ijtag_so_misr;
   wire   [9:0] lbist_misr_in;
   wire   [9:0] edt_chain_mask;
   wire         edt_chain_mask_load_en;
   wire         edt_update_lbist_disabled;
   wire         edt_low_power_shift_en_lbist_disabled;
   reg    [2:0] ijtag_ccm_tdr;
   wire         ijtag_sel_ccm;
   wire         ijtag_ce_ccm;
   wire         ijtag_se_ccm;
   wire         ijtag_ue_ccm;
   wire         ccm_te_so_decompressor;
   wire         ccm_le_so_decompressor;
   wire         ccm_le_so_low_power_shift_controller;
   wire         ccm_te_so_compactor;
   wire         ccm_le_so_compactor;
   wire         ccm_te_so_misr;
   wire         ccm_le_so_misr;
   reg          ccm_te_si_lockup;
   wire         edt_update_ccm;
   wire         edt_low_power_shift_en_ccm;
   wire         edt_bypass_ccm;
   wire         edt_single_bypass_chain_ccm;
   wire         edt_clock_buf_out;
   wire         edt_update_buf_out;
   wire         edt_bypass_buf_out;
   wire         edt_single_bypass_chain_buf_out;
   wire         edt_low_power_shift_en_buf_out;
   wire         edt_channels_in_buf_out;
   wire         edt_channels_out_buf_in;
   wire   [9:0] edt_bypass_in_buf_out;
   wire   [9:0] edt_scan_out_lockup_buf_out;
   wire         ccm_en_buf_out;

   clock_buf02 tessent_persistent_cell_edt_clock_buf (.A(edt_clock),
                                                      .Y(edt_clock_buf_out));
   buf02 tessent_persistent_cell_edt_update_buf (.A(edt_update),
                                                 .Y(edt_update_buf_out));
   buf02 tessent_persistent_cell_edt_bypass_buf (.A(edt_bypass),
                                                 .Y(edt_bypass_buf_out));
   buf02 tessent_persistent_cell_edt_single_bypass_chain_buf (.A(edt_single_bypass_chain),
                                                              .Y(edt_single_bypass_chain_buf_out));
   buf02 tessent_persistent_cell_edt_low_power_shift_en_buf (.A(edt_low_power_shift_en),
                                                             .Y(edt_low_power_shift_en_buf_out));

   buf02 tessent_persistent_cell_edt_channels_in_0_buf (.A(edt_channels_in),
                                                        .Y(edt_channels_in_buf_out));

   buf02 tessent_persistent_cell_edt_channels_out_0_buf (.A(edt_channels_out_buf_in),
                                                         .Y(edt_channels_out));

   buf02 tessent_persistent_cell_edt_scan_in_0_buf (.A(edt_bypass_in[0]),
                                                    .Y(edt_bypass_in_buf_out[0]));
   buf02 tessent_persistent_cell_edt_scan_in_1_buf (.A(edt_bypass_in[1]),
                                                    .Y(edt_bypass_in_buf_out[1]));
   buf02 tessent_persistent_cell_edt_scan_in_2_buf (.A(edt_bypass_in[2]),
                                                    .Y(edt_bypass_in_buf_out[2]));
   buf02 tessent_persistent_cell_edt_scan_in_3_buf (.A(edt_bypass_in[3]),
                                                    .Y(edt_bypass_in_buf_out[3]));
   buf02 tessent_persistent_cell_edt_scan_in_4_buf (.A(edt_bypass_in[4]),
                                                    .Y(edt_bypass_in_buf_out[4]));
   buf02 tessent_persistent_cell_edt_scan_in_5_buf (.A(edt_bypass_in[5]),
                                                    .Y(edt_bypass_in_buf_out[5]));
   buf02 tessent_persistent_cell_edt_scan_in_6_buf (.A(edt_bypass_in[6]),
                                                    .Y(edt_bypass_in_buf_out[6]));
   buf02 tessent_persistent_cell_edt_scan_in_7_buf (.A(edt_bypass_in[7]),
                                                    .Y(edt_bypass_in_buf_out[7]));
   buf02 tessent_persistent_cell_edt_scan_in_8_buf (.A(edt_bypass_in[8]),
                                                    .Y(edt_bypass_in_buf_out[8]));
   buf02 tessent_persistent_cell_edt_scan_in_9_buf (.A(edt_bypass_in[9]),
                                                    .Y(edt_bypass_in_buf_out[9]));

   buf02 tessent_persistent_cell_edt_scan_out_0_buf (.A(edt_scan_out_lockup[0]),
                                                     .Y(edt_scan_out_lockup_buf_out[0]));
   buf02 tessent_persistent_cell_edt_scan_out_1_buf (.A(edt_scan_out_lockup[1]),
                                                     .Y(edt_scan_out_lockup_buf_out[1]));
   buf02 tessent_persistent_cell_edt_scan_out_2_buf (.A(edt_scan_out_lockup[2]),
                                                     .Y(edt_scan_out_lockup_buf_out[2]));
   buf02 tessent_persistent_cell_edt_scan_out_3_buf (.A(edt_scan_out_lockup[3]),
                                                     .Y(edt_scan_out_lockup_buf_out[3]));
   buf02 tessent_persistent_cell_edt_scan_out_4_buf (.A(edt_scan_out_lockup[4]),
                                                     .Y(edt_scan_out_lockup_buf_out[4]));
   buf02 tessent_persistent_cell_edt_scan_out_5_buf (.A(edt_scan_out_lockup[5]),
                                                     .Y(edt_scan_out_lockup_buf_out[5]));
   buf02 tessent_persistent_cell_edt_scan_out_6_buf (.A(edt_scan_out_lockup[6]),
                                                     .Y(edt_scan_out_lockup_buf_out[6]));
   buf02 tessent_persistent_cell_edt_scan_out_7_buf (.A(edt_scan_out_lockup[7]),
                                                     .Y(edt_scan_out_lockup_buf_out[7]));
   buf02 tessent_persistent_cell_edt_scan_out_8_buf (.A(edt_scan_out_lockup[8]),
                                                     .Y(edt_scan_out_lockup_buf_out[8]));
   buf02 tessent_persistent_cell_edt_scan_out_9_buf (.A(edt_scan_out_lockup[9]),
                                                     .Y(edt_scan_out_lockup_buf_out[9]));

   buf02 tessent_persistent_cell_ccm_en_buf (.A(ccm_en),
                                             .Y(ccm_en_buf_out));

   assign edt_update_lbist_disabled = edt_update_buf_out & ~lbist_en;
   assign edt_low_power_shift_en_lbist_disabled = edt_low_power_shift_en_buf_out & ~lbist_en;

   assign ijtag_so = ccm_scan_en ? ccm_te_so_misr : ijtag_so_misr;

   assign edt_update_ccm = ccm_en_buf_out ? lbist_misr[0] : edt_update_lbist_disabled;
   assign edt_low_power_shift_en_ccm = ccm_en_buf_out ? lbist_misr[1] : edt_low_power_shift_en_lbist_disabled;
   assign edt_bypass_ccm = ccm_en_buf_out ? (lbist_misr[2] & ~ccm_scan_en) : edt_bypass_buf_out;
   assign edt_single_bypass_chain_ccm = ccm_en_buf_out ? (lbist_misr[3] & ~ccm_scan_en) : edt_single_bypass_chain_buf_out;

   always @(posedge edt_clock_buf_out or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         ijtag_ccm_tdr <= 3'b000;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            ijtag_ccm_tdr <= {ccm_le_so_misr, ijtag_ccm_tdr[2:1]};
         end
      end
   end

   assign ijtag_sel_ccm = ccm_en_buf_out ? ijtag_ccm_tdr[0] : ijtag_sel;
   assign ijtag_ce_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b01) : ijtag_ce;
   assign ijtag_se_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b10) : ijtag_se;
   assign ijtag_ue_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b11) : ijtag_ue;

   always @(posedge edt_clock_buf_out)
   begin 
      ccm_te_si_lockup <= ijtag_ccm_tdr[0]; 
   end

   msrv32_top_pass2_rtl_tessent_edt_c0_decompressor msrv32_top_pass2_rtl_tessent_edt_c0_decompressor_i (
      .edt_clock(edt_clock_buf_out),
      .edt_update(edt_update_ccm),
      .edt_channels_in(edt_channels_out_from_low_power_shift_control),
      .edt_mask(edt_mask),
      .edt_scan_in(edt_decompressor_out),
      .lbist_reset(lbist_reset),
      .lbist_en(lbist_en),
      .lbist_prpg_en(lbist_prpg_en),
      .lbist_low_power_shift_en(lbist_low_power_shift_en),
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ijtag_si),
      .ccm_le_so(ccm_le_so_decompressor),
      .ccm_te_si(ccm_te_si_lockup),
      .ccm_te_so(ccm_te_so_decompressor),
      .ijtag_si(ijtag_si),
      .ijtag_so(ijtag_so_decompressor));

   msrv32_top_pass2_rtl_tessent_edt_c0_low_power_shift_controller low_power_shift_controller_i (
      .edt_clock(edt_clock_buf_out),
      .edt_update(edt_update_ccm),
      .edt_low_power_shift_en(edt_low_power_shift_en_ccm),
      .edt_channels_in(edt_channels_in_buf_out),
      .edt_decompressor_out(edt_decompressor_out),
      .edt_channels_out_from_low_power_shift_control(edt_channels_out_from_low_power_shift_control),
      .edt_scan_in(edt_bypass_in),
      .edt_chain_mask(edt_chain_mask),
      .edt_chain_mask_load_en(edt_chain_mask_load_en),
      .lbist_en(lbist_en),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_le_so_decompressor),
      .ccm_le_so(ccm_le_so_low_power_shift_controller));

   msrv32_top_pass2_rtl_tessent_edt_c0_compactor msrv32_top_pass2_rtl_tessent_edt_c0_compactor_i (
      .edt_clock(edt_clock_buf_out),
      .edt_update(edt_update_ccm),
      .edt_scan_out(edt_scan_out_lockup_buf_out),
      .edt_mask(edt_mask),
      .edt_channels_out(edt_bypass_out),
      .edt_chain_mask(edt_chain_mask),
      .edt_chain_mask_load_en(edt_chain_mask_load_en),
      .lbist_reset(lbist_reset),
      .lbist_en(lbist_en),
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ccm_scan_en(ccm_scan_en),
      .ccm_en(ccm_en_buf_out),
      .ccm_le_si(ccm_le_so_low_power_shift_controller),
      .ccm_le_so(ccm_le_so_compactor),
      .ccm_te_si(ccm_te_so_decompressor),
      .ccm_te_so(ccm_te_so_compactor),
      .ijtag_si(ijtag_so_decompressor),
      .ijtag_so(ijtag_so_compactor),
      .lbist_misr_in(lbist_misr_in));

   msrv32_top_pass2_rtl_tessent_edt_c0_bypass_logic msrv32_top_pass2_rtl_tessent_edt_c0_bypass_logic_i (
      .edt_bypass(edt_bypass_ccm),
      .edt_single_bypass_chain(edt_single_bypass_chain_ccm),
      .lbist_en(lbist_en),
      .ccm_en(ccm_en_buf_out),
      .edt_channels_in(edt_channels_in_buf_out),
      .edt_channels_out(edt_channels_out_buf_in),
      .edt_scan_in(edt_scan_in),
      .edt_scan_out(edt_scan_out),
      .edt_scan_out_lockup(edt_scan_out_lockup),
      .edt_bypass_in(edt_bypass_in_buf_out),
      .edt_bypass_out(edt_bypass_out));

   msrv32_top_pass2_rtl_tessent_edt_c0_misr msrv32_top_pass2_rtl_tessent_edt_c0_misr_i (
      .edt_clock(edt_clock_buf_out),
      .lbist_reset(lbist_reset),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_le_so_compactor),
      .ccm_le_so(ccm_le_so_misr),
      .ccm_te_si(ccm_te_so_compactor),
      .ccm_te_so(ccm_te_so_misr),
      .accumulate(misr_accumulate_en),
      .misr_in(lbist_misr_in),
      .misr(lbist_misr),
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ijtag_si(ijtag_so_compactor),
      .ijtag_so(ijtag_so_misr));
endmodule



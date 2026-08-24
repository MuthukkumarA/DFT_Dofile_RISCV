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
//       IP version: 2
//--------------------------------------------------------------------------------


module msrv32_top_pass2_rtl_tessent_lbist_sib ( // {{{
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_si,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   input  wire         ijtag_tck,
   input  wire         ccm_scan_en,
   input  wire         ccm_te_si,
   output wire         ccm_te_so,
   output wire         ijtag_so,
   input  wire         ijtag_from_so,
   output wire         ijtag_to_sel
);
 
   reg            sib;
   reg            sib_latch;
   reg            so_retime;
   reg            to_enable_int;
 
   assign ijtag_to_sel = (to_enable_int & ijtag_sel) | ccm_scan_en;
 
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         sib_latch           <= 1'b0;
      end else if (ccm_scan_en) begin
         sib_latch           <= ccm_te_si;
      end else if (ijtag_ue & ijtag_sel) begin
         sib_latch           <= sib;
      end
   end
 
   assign ijtag_so = ccm_scan_en ? sib : so_retime;
   assign ccm_te_so = so_retime;
   always @ (negedge ijtag_tck) begin
      so_retime     <= ccm_scan_en ? to_enable_int : sib;
      to_enable_int <= sib_latch;
   end
 
   always @ (posedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         sib <= 1'b0;
      end else if (ccm_scan_en) begin
         sib <= ijtag_from_so;
      end else if (ijtag_ce & ijtag_sel) begin
         sib <= 1'b0;
      end else if (ijtag_se & ijtag_sel) begin
         if (sib_latch) begin
            sib <= ijtag_from_so;
         end else begin
            sib <= ijtag_si;
         end
      end
   end
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_fsm ( // {{{
   input  wire         ijtag_tck,
   input  wire         ijtag_reset,
   input  wire         ijtag_se,
   input  wire         shift_clock_src,
   input  wire         edt_clock,
   input  wire   [1:0] shift_clock_select,
   input  wire         lbist_clock_disable,
   input  wire         lbist_en,
   input  wire   [2:0] lbist_setup,
   input  wire         lbist_burn_in,
   input  wire         ccm_en,
   input  wire         ccm_scan_en,
   input  wire         ccm_le_si,
   input  wire         ccm_te_si,
   input  wire   [2:0] capture_phase_size,
   input  wire         last_bit,
   input  wire         last_vector,
   input  wire         warmup_done,
   output wire         lbist_clock_disable_sync,
   output reg          lbist_reset,
   output wire         lbist_done,
   output reg          lbist_run_mode,
   output reg          prpg_en,
   output reg          misr_en,
   output wire         ccm_le_so,
   output wire         ccm_te_so,
   output wire         shift_clock_int,
   output wire         shift_clock,
   output wire         lbist_clock,
   output wire         shift_clock_en,
   output reg          capture_clock_en,
   output wire         shift_phase,
   output reg          capture_en
);
 
   // State machine values
   parameter IDLE          = 3'd0;
   parameter INIT          = 3'd1;
   parameter SHIFT         = 3'd2;
   parameter SHIFT_PAUSE   = 3'd3;
   parameter CAPTURE       = 3'd4;
   parameter CAPTURE_PAUSE = 3'd5;
   parameter DONE          = 3'd6;
 
   reg            shift_clock_disable;
   reg            lbist_clock_disable_int;
   reg            shift_clock_en_int;
   reg            shift_phase_r;
   reg            shift_phase_retime;
   reg            prpg_en_int;
   reg      [2:0] state;
   reg            lbist_en_r;
   reg            accumulate;
   reg      [3:0] cnt;
   reg      [3:0] next_cnt;
 
   wire     [3:0] next_cnt_buf;
   wire           cnt_eq_zero;
   wire           going_to_shift_state;
   wire           going_to_capture_state;
   wire           going_to_capture_early;
   wire     [1:0] shift_clock_select_int;
   wire           long_setup_mode;
   wire           single_chain_mode;
   wire           lbist_en_retime;
   wire           lbist_run_mode_w;
   wire           lbist_clock_disable_gated;
   wire           shift_clock_disable_gated;
   wire           shift_clock_gater_fe;
   wire           lbist_clock_disable_sync_ccm;
   wire           edt_clock_tck;
   wire           shift_clock_int_inv;
   wire           sync_reset;
   wire           warmup_patterns;
 
   // ------------------------------------------------------------
   // lbist_setup[2:0]  lbist_en Mode                 lbist_run_mode
   // ------------------------------------------------------------
   //      001             X     Long Setup              0
   //      010             1     Default logicbist Run   1
   //      011             1     Normal logicbist Run    1
   //      1XX             1     Single chain mode       0
   //      0XX             0     any                     0
   // ------------------------------------------------------------
   assign long_setup_mode   = (lbist_setup == 3'b001);
   assign lbist_run_mode_w  = lbist_en & (lbist_setup[2:1] == 2'b01);
   assign single_chain_mode = lbist_en & lbist_setup[2];
 
   always @ (posedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         lbist_run_mode <= 1'b0;
      end else if (ccm_scan_en) begin
         lbist_run_mode <= ccm_le_si;
      end else begin
         lbist_run_mode <= lbist_run_mode_w;
      end
   end
 
   assign shift_clock_select_int = (ccm_en) ? 2'b10 :
                                   (long_setup_mode | single_chain_mode) ? 2'b10 :
                                   lbist_run_mode_w ? shift_clock_select : 2'b11;
 
   clock_mux21 tessent_persistent_cell_shift_clock_int_mux (
      .A0                   (shift_clock_src),                  // i
      .A1                   (edt_clock_tck),                    // i
      .S0                   (shift_clock_select_int[1]),        // i
      .Y                    (shift_clock_int)                   // o
   );

   clock_mux21 tessent_persistent_cell_edt_clock_tck_mux (
      .A0                   (ijtag_tck),                        // i
      .A1                   (edt_clock),                        // i
      .S0                   (shift_clock_select_int[0]),        // i
      .Y                    (edt_clock_tck)                     // o
   );

   sync_cell_rst tessent_persistent_cell_lbist_ntc_retiming_cell_lbist_clock_disable (
      .R                    (~ijtag_reset),                     // i
      .CK                   (shift_clock_int),                  // i
      .D                    (lbist_clock_disable & ~ccm_en),    // i
      .O                    (lbist_clock_disable_sync_ccm)      // o
   );
   assign lbist_clock_disable_sync = ccm_en ? lbist_clock_disable : lbist_clock_disable_sync_ccm;

   assign shift_clock_disable_gated = lbist_clock_disable_sync | (shift_clock_disable & lbist_en) | long_setup_mode | single_chain_mode;
   assign shift_clock_en = shift_clock_en_int | (single_chain_mode & ijtag_se & ~lbist_clock_disable_sync);
   always @ (negedge shift_clock_int or negedge ijtag_reset) begin
     if (~ijtag_reset)
        shift_clock_en_int <= 1'b0;
     else if (ccm_scan_en)
        shift_clock_en_int <= ccm_te_si;
     else
        shift_clock_en_int <= ~shift_clock_disable_gated & lbist_en;
   end
   always @ (posedge shift_clock_int or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         capture_clock_en <= 1'b0;
      end else if (ccm_scan_en) begin
         capture_clock_en <= lbist_run_mode;
      end else if (state == IDLE) begin
         capture_clock_en <= 1'b0;
      end else if (going_to_capture_early && !warmup_patterns) begin
         capture_clock_en <= (capture_phase_size != 3'd0);
      end else if ((state == SHIFT_PAUSE && cnt_eq_zero) || ((state == CAPTURE) && (next_cnt == 4'd0))) begin
         capture_clock_en <= 1'b0;
      end
   end
   always @ (posedge shift_clock_int or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         capture_en <= 1'b0;
      end else if (ccm_scan_en) begin
         capture_en <= capture_clock_en;
      end else if (state == IDLE) begin
         capture_en <= 1'b0;
      end else if (going_to_capture_early && !warmup_patterns) begin
         capture_en <= (capture_phase_size != 3'd0);
      end else if ((state == CAPTURE) && cnt_eq_zero) begin
         capture_en <= 1'b0;
      end
   end
   assign shift_clock_gater_fe      = lbist_clock_disable_sync | (shift_clock_disable & lbist_en) | long_setup_mode | (single_chain_mode & ~ijtag_se);
   cgand tessent_persistent_cell_shift_clock_gater_i (
      .FE                   (~shift_clock_gater_fe),            // i
      .TE                   (~shift_clock_gater_fe),            // i
      .CK                   (shift_clock_int),                  // i
      .GCK                  (shift_clock)                       // o
   );
 
   assign lbist_clock_disable_gated = (lbist_clock_disable_sync | (lbist_clock_disable_int & lbist_en_retime)) & ~ccm_scan_en;
   cgand tessent_persistent_cell_bist_clock_gater_i (
      .FE                   (~lbist_clock_disable_gated),       // i
      .TE                   (~lbist_clock_disable_gated),       // i
      .CK                   (shift_clock_int),                  // i
      .GCK                  (lbist_clock)                       // o
   );
 
   assign warmup_patterns = ((state != IDLE) & ~accumulate & ~warmup_done & ~lbist_burn_in);
   assign cnt_eq_zero = (cnt == 4'd0);
 
   assign lbist_done        = (state == DONE) & lbist_run_mode_w;
 
   assign going_to_shift_state = (state == INIT & cnt == 4'd0) |
                                 (state == CAPTURE_PAUSE & cnt == 4'd0 & ~last_vector) |
                                 (state == SHIFT & ~last_bit);
   assign going_to_capture_state = ( lbist_run_mode & (state == SHIFT_PAUSE & cnt == 4'd0) ) ;
   assign going_to_capture_early = (state == SHIFT_PAUSE) & (cnt <= 4'd1);
 
   always @ (posedge shift_clock_int or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         shift_clock_disable     <= 1'b0;
         lbist_clock_disable_int <= 1'b0;
      end else if (ccm_scan_en) begin
         shift_clock_disable     <= capture_en;
         lbist_clock_disable_int <= shift_clock_disable;
      end else begin
         shift_clock_disable     <= lbist_run_mode & ~going_to_shift_state;
         lbist_clock_disable_int <= lbist_run_mode &
                                    (state != DONE & state != IDLE) &
                                    ~( going_to_shift_state |
                                       ( going_to_capture_state & (capture_phase_size <= 3'd1 | warmup_patterns) ) |
                                       ( (state == IDLE) & (cnt == 4'd0) ) |
                                       ( (state == INIT) & (cnt <= 4'd12) & (cnt >= 4'd10) ) |
                                       ( (state == CAPTURE) & (cnt == 4'd1) ) ) ;
      end
   end
 
   assign shift_phase   = (~lbist_en) ? 1'b0 :
                          (single_chain_mode) ? 1'b1 : (shift_phase_retime & lbist_run_mode);
   assign sync_reset    = ~lbist_run_mode & ~ccm_scan_en;
 
   always @ (negedge shift_clock_int or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         shift_phase_retime <= 1'b0;
         prpg_en            <= 1'b0;
         misr_en            <= 1'b0;
      end else if (ccm_scan_en) begin
         shift_phase_retime <= shift_clock_en_int;
         prpg_en            <= shift_phase_retime;
         misr_en            <= prpg_en;
      end else begin
         shift_phase_retime <= shift_phase_r;
         prpg_en            <= prpg_en_int & lbist_run_mode;
         misr_en            <= shift_phase_r & accumulate;
      end
   end
 
   clock_inv01 tessent_persistent_cell_shift_clock_int_inv (
      .A                    (shift_clock_int),                  // i
      .Y                    (shift_clock_int_inv)               // o
   );

   sync_cell_rst tessent_persistent_cell_lbist_ntc_retiming_cell_lbist_run_mode (
      .R                    (~ijtag_reset),                     // i
      .CK                   (shift_clock_int_inv),              // i
      .D                    (~lbist_clock_disable & lbist_run_mode), // i
      .O                    (lbist_en_retime)                   // o
   );
 
   always @ ( lbist_en_r or state or capture_phase_size or lbist_run_mode or cnt or last_bit or warmup_patterns ) begin
      if (~lbist_en_r) begin
         next_cnt = 4'd3;
      end else begin
         if (cnt == 4'b0) begin
            next_cnt = 4'd0;
            if (state == IDLE) begin
               next_cnt = 4'd14;
            end else if (state == INIT || state == CAPTURE_PAUSE) begin
               next_cnt = 4'd0;
            end else if (state == SHIFT_PAUSE) begin
               if (capture_phase_size == 3'd0 || warmup_patterns) begin
                  next_cnt = 4'd0;
               end else begin
                  next_cnt = {1'd0, capture_phase_size - 3'd1};
               end
            end else if (state == SHIFT) begin
               next_cnt = last_bit ? 4'd8 : 4'd0;
            end else if (state == CAPTURE) begin
               next_cnt = 4'd6;
            end else if (lbist_run_mode) begin
               next_cnt = 4'd7;
            end
         end else begin
            next_cnt = cnt - 4'd1;
         end
      end
   end
   buf02 tessent_persistent_cell_next_cnt_0 (
      .A                    (next_cnt[0]),                      // i
      .Y                    (next_cnt_buf[0])                   // o
   );
   buf02 tessent_persistent_cell_next_cnt_1 (
      .A                    (next_cnt[1]),                      // i
      .Y                    (next_cnt_buf[1])                   // o
   );
   buf02 tessent_persistent_cell_next_cnt_2 (
      .A                    (next_cnt[2]),                      // i
      .Y                    (next_cnt_buf[2])                   // o
   );
   buf02 tessent_persistent_cell_next_cnt_3 (
      .A                    (next_cnt[3]),                      // i
      .Y                    (next_cnt_buf[3])                   // o
   );
 
   // synopsys sync_set_reset "sync_reset"
   always @ (posedge shift_clock_int or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         lbist_en_r      <= 1'b0;
         cnt             <= 4'd3;
         state           <= IDLE;
         lbist_reset     <= 1'b0;
         accumulate      <= 1'b0;
         shift_phase_r   <= 1'b0;
         prpg_en_int     <= 1'b0;
      end else if (sync_reset) begin
         lbist_en_r      <= 1'b0;
         cnt             <= 4'd3;
         state           <= IDLE;
         lbist_reset     <= 1'b0;
         accumulate      <= 1'b0;
         shift_phase_r   <= 1'b0;
         prpg_en_int     <= 1'b0;
      end else if (ccm_scan_en) begin
         lbist_en_r      <= lbist_clock_disable_int;
         cnt             <= {lbist_en_r, cnt[3:1]};
         state           <= {cnt[0], state[2:1]};
         lbist_reset     <= state[0];
         accumulate      <= lbist_reset;
         shift_phase_r   <= accumulate;
         prpg_en_int     <= shift_phase_r;
      end else begin
         lbist_en_r <= lbist_en_retime;
         cnt        <= next_cnt_buf;
         if (~lbist_en_r) begin
            state           <= IDLE;
            lbist_reset     <= 1'b0;
            accumulate      <= 1'b0;
            shift_phase_r   <= 1'b0;
            prpg_en_int     <= 1'b0;
         end else begin
            case (state)
               IDLE  : begin // {{{
                  if (cnt_eq_zero) state <= INIT;
                  lbist_reset       <= 1'b0;
                  accumulate        <= 1'b0;
                  shift_phase_r     <= 1'b0;
                  prpg_en_int       <= 1'b0;
               end // }}}
               INIT  : begin // {{{
                  if (cnt > 4'd11 & lbist_setup == 3'b010) begin
                     lbist_reset <= 1'b1;
                  end else begin
                     lbist_reset <= 1'b0;
                  end
                  if (cnt_eq_zero) state <= SHIFT;
                  if (cnt <= 4'd8) begin
                     shift_phase_r   <= 1'b1;
                     prpg_en_int     <= 1'b1;
                  end
               end // }}}
               SHIFT : begin // {{{
                  if (last_bit) begin
                     state <= SHIFT_PAUSE;
                  end
                  shift_phase_r   <= lbist_en_r;
                  prpg_en_int     <= lbist_en_r;
               end // }}}
               SHIFT_PAUSE : begin // {{{
                  if (cnt_eq_zero) begin
                     state           <= CAPTURE;
                  end
                  shift_phase_r  <= warmup_patterns;
                  prpg_en_int    <= 1'b0;
               end // }}}
               CAPTURE : begin // {{{
                  if (cnt_eq_zero) begin
                     state         <= CAPTURE_PAUSE;
                     shift_phase_r <= ~last_vector;
                     prpg_en_int   <= ~last_vector;
                     accumulate    <= accumulate | warmup_done;
                  end else begin
                     shift_phase_r <= 1'b0;
                     prpg_en_int   <= 1'b0;
                  end
               end // }}}
               CAPTURE_PAUSE : begin // {{{
                  if (cnt_eq_zero) begin
                     if (last_vector) begin
                        state <= DONE;
                     end else begin
                        state <= SHIFT;
                     end
                  end
                  shift_phase_r   <= ~last_vector;
                  prpg_en_int     <= ~last_vector;
               end // }}}
               DONE : begin // {{{
                  accumulate      <= 1'b0;
               end // }}}
            endcase
         end
      end
   end
 
   assign ccm_le_so    = prpg_en_int;
   assign ccm_te_so    = misr_en;
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_ncp_reg ( // {{{
   input  wire         lbist_clock,
   input  wire         reset,
   input  wire         scan_en,
   input  wire         scan_in,
   input  wire         lbist_reset,
   input  wire   [7:0] new_ncp_cnt,
   output reg    [7:0] ncp_cnt
);
 
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         ncp_cnt <= 8'b00000000; // 8'd0
      end else if (scan_en) begin
         ncp_cnt <= {scan_in, ncp_cnt[7:1]};
      end else if (lbist_reset) begin
         ncp_cnt <= 8'b00000000; // 8'd0
      end else begin
         ncp_cnt <= new_ncp_cnt;
      end
   end
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_vector_cnt_reg ( // {{{
   input  wire         lbist_clock,
   input  wire         reset,
   input  wire         scan_en,
   input  wire         scan_in,
   input  wire         lbist_reset,
   input  wire  [13:0] new_vector_cnt,
   output reg   [13:0] vector_cnt
);
 
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         vector_cnt <= 14'b00010000000001; // 14'd1025
      end else if (scan_en) begin
         vector_cnt <= {scan_in, vector_cnt[13:1]};
      end else if (lbist_reset) begin
         vector_cnt <= 14'b00010000000001; // 14'd1025
      end else begin
         vector_cnt <= new_vector_cnt;
      end
   end
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_bit_cnt_reg ( // {{{
   input  wire         lbist_clock,
   input  wire         lbist_reset,
   input  wire         reset,
   input  wire         ccm_scan_en,
   input  wire         ccm_scan_in,
   input  wire         set,
   input  wire   [5:0] set_val,
   input  wire   [5:0] new_bit_cnt,
   output reg    [5:0] bit_cnt
);
 
   wire           sync_reset;
 
   assign sync_reset = lbist_reset & ~ccm_scan_en;
 
   // synopsys sync_set_reset "sync_reset"
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         bit_cnt <= 6'd32;
      end else if (sync_reset) begin
         bit_cnt <= 6'd32;
      end else if (ccm_scan_en) begin
         bit_cnt <= {ccm_scan_in, bit_cnt[5:1]};
      end else if (set) begin
         bit_cnt <= set_val;
      end else begin
         bit_cnt <= new_bit_cnt;
      end
   end
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_counter ( // {{{
   input  wire         lbist_clock,
   input  wire         lbist_scan_en,
   input  wire         lbist_run_mode,
   input  wire         reset,
   input  wire         ccm_scan_en,
   input  wire         ccm_le_si,
   output wire         ccm_le_so,
   input  wire         shift_phase,
   input  wire         prpg_en,
   input  wire         lbist_burn_in,
   input  wire         lbist_reset,
   input  wire         lbist_scan_in,
   output wire         lbist_scan_out,
   output reg    [1:0] ncp,
   input  wire   [7:0] ncp_0_limit,
   input  wire   [7:0] ncp_1_limit,
   input  wire   [7:0] ncp_2_limit,
   input  wire   [7:0] ncp_3_limit,
   output wire         last_bit,
   output wire   [9:0] vector_cnt_lsb,
   output reg          last_vector
);
 
   wire           sync_reset;
   wire     [5:0] new_bit_cnt;
   wire     [5:0] bit_cnt;
   wire    [13:0] new_vector_cnt;
   wire    [13:0] vector_cnt;
   wire     [7:0] new_ncp_cnt;
   wire     [7:0] ncp_cnt;
   wire           lbist_scan_in_int;
 
   reg      [5:0] bit_cnt_max;
   reg            vector_cnt_5_1_zero;
   reg            vector_cnt_10_6_zero;
   reg            vector_cnt_13_11_zero;
   reg            bit_cnt_5_4_zero;
   reg            end_of_vector;

   assign lbist_scan_in_int = ccm_scan_en ? ccm_le_si : lbist_scan_in;
 
   assign sync_reset     = ~lbist_run_mode & ~ccm_scan_en;
   assign vector_cnt_lsb = vector_cnt[9:0];
   assign last_bit       = prpg_en & end_of_vector & ~|bit_cnt[3:0];
 
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         bit_cnt_max <= 6'd32;
      end else if (lbist_scan_en) begin
         bit_cnt_max <= {lbist_scan_in_int, bit_cnt_max[5:1]};
      end else if (lbist_reset) begin
         bit_cnt_max <= 6'd32;
      end
   end
 
   assign new_bit_cnt = (~prpg_en) ? bit_cnt :
                        {
                           bit_cnt[5]   ^ ~|bit_cnt[4:0],
                           bit_cnt[4]   ^ ~|bit_cnt[3:0],
                           bit_cnt[3]   ^ ~|bit_cnt[2:0],
                           bit_cnt[2]   ^ ~|bit_cnt[1:0],
                           bit_cnt[1]   ^ ~|bit_cnt[0:0],
                          ~bit_cnt[0]
                        };
 
   msrv32_top_pass2_rtl_tessent_lbist_bit_cnt_reg msrv32_top_pass2_rtl_tessent_lbist_bit_cnt_reg_i (
      .lbist_clock          (lbist_clock),                      // i
      .lbist_reset          (lbist_reset),                      // i
      .reset                (reset),                            // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_scan_in          (ncp_cnt[0]),                       // i
      .set                  (last_bit | ~prpg_en),              // i
      .set_val              (bit_cnt_max),                      // i [5:0]
      .new_bit_cnt          (new_bit_cnt),                      // i [5:0]
      .bit_cnt              (bit_cnt)                           // o [5:0]
   );
 
   assign new_vector_cnt = (~last_bit | lbist_burn_in) ? vector_cnt :
                           {
                              vector_cnt[13]  ^ (~|vector_cnt[12:11] & vector_cnt_10_6_zero & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[12]  ^ (~|vector_cnt[11:11] & vector_cnt_10_6_zero & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[11]  ^ (vector_cnt_10_6_zero & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[10]  ^ (~|vector_cnt[9:6] & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[9]   ^ (~|vector_cnt[8:6] & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[8]   ^ (~|vector_cnt[7:6] & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[7]   ^ (~|vector_cnt[6:6] & vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[6]   ^ (vector_cnt_5_1_zero & ~vector_cnt[0]),
                              vector_cnt[5]   ^ ~|vector_cnt[4:0],
                              vector_cnt[4]   ^ ~|vector_cnt[3:0],
                              vector_cnt[3]   ^ ~|vector_cnt[2:0],
                              vector_cnt[2]   ^ ~|vector_cnt[1:0],
                              vector_cnt[1]   ^ ~|vector_cnt[0:0],
                             ~vector_cnt[0]
                           };
 
   msrv32_top_pass2_rtl_tessent_lbist_vector_cnt_reg msrv32_top_pass2_rtl_tessent_lbist_vector_cnt_reg_i (
      .lbist_clock          (lbist_clock),                      // i
      .reset                (reset),                            // i
      .scan_en              (lbist_scan_en),                    // i
      .scan_in              (bit_cnt_max[0]),                   // i
      .lbist_reset          (lbist_reset),                      // i
      .new_vector_cnt       (new_vector_cnt),                   // i [13:0]
      .vector_cnt           (vector_cnt)                        // o [13:0]
   );
 
   assign new_ncp_cnt = (~last_bit) ? ncp_cnt : ncp_cnt + 1'b1;
 
   msrv32_top_pass2_rtl_tessent_lbist_ncp_reg msrv32_top_pass2_rtl_tessent_lbist_ncp_reg_i (
      .lbist_clock          (lbist_clock),                      // i
      .reset                (reset),                            // i
      .scan_en              (lbist_scan_en),                    // i
      .scan_in              (vector_cnt[0]),                    // i
      .lbist_reset          (lbist_reset),                      // i
      .new_ncp_cnt          (new_ncp_cnt),                      // i [7:0]
      .ncp_cnt              (ncp_cnt)                           // o [7:0]
   );
 
   assign lbist_scan_out = ncp_cnt[0];
   assign ccm_le_so = ncp[0];
 
   // synopsys sync_set_reset "sync_reset"
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         vector_cnt_5_1_zero    <= 1'b0;
         vector_cnt_10_6_zero   <= 1'b0;
         vector_cnt_13_11_zero  <= 1'b0;
         bit_cnt_5_4_zero       <= 1'b0;
         last_vector            <= 1'b0;
         end_of_vector          <= 1'b0;
         ncp                    <= 2'd0;
      end else if (sync_reset) begin
         vector_cnt_5_1_zero    <= 1'b0;
         vector_cnt_10_6_zero   <= 1'b0;
         vector_cnt_13_11_zero  <= 1'b0;
         bit_cnt_5_4_zero       <= 1'b0;
         last_vector            <= 1'b0;
         end_of_vector          <= 1'b0;
         ncp                    <= 2'd0;
      end else if (ccm_scan_en) begin
         vector_cnt_5_1_zero    <= bit_cnt[0];
         vector_cnt_10_6_zero   <= vector_cnt_5_1_zero;
         vector_cnt_13_11_zero  <= vector_cnt_10_6_zero;
         bit_cnt_5_4_zero       <= vector_cnt_13_11_zero;
         last_vector            <= bit_cnt_5_4_zero;
         end_of_vector          <= last_vector;
         ncp                    <= {end_of_vector, ncp[1:1]};
      end else begin
         vector_cnt_5_1_zero    <= (vector_cnt[5:1] == 5'h0);
         vector_cnt_10_6_zero   <= (vector_cnt[10:6] == 5'h0);
         vector_cnt_13_11_zero  <= (vector_cnt[13:11] == 3'h0);
         bit_cnt_5_4_zero       <= (bit_cnt[5:4] == 2'h0);
         if (shift_phase) begin
            last_vector         <= vector_cnt_13_11_zero &
                                   vector_cnt_10_6_zero &
                                   vector_cnt_5_1_zero &
                                   vector_cnt[0];
            end_of_vector       <= bit_cnt_5_4_zero &
                                   ((bit_cnt[3:0] == 4'd8) | (bit_cnt[3:0] == 4'd7) | (bit_cnt[3:0] == 4'd6) | (bit_cnt[3:0] == 4'd5) |
                                    (bit_cnt[3:0] == 4'd4) | (bit_cnt[3:0] == 4'd3) | (bit_cnt[3:0] == 4'd2) | (bit_cnt[3:0] == 4'd1));
            ncp                 <= ( (|ncp_0_limit) && (ncp_cnt <= ncp_0_limit)) ? 2'd0 :
                                   ( (|ncp_1_limit) && (ncp_cnt <= ncp_1_limit)) ? 2'd1 :
                                   ( (|ncp_2_limit) && (ncp_cnt <= ncp_2_limit)) ? 2'd2 :
                                   ( (|ncp_3_limit) && (ncp_cnt <= ncp_3_limit)) ? 2'd3 : 2'd0;
         end
      end
   end
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_capture_phase_reg ( // {{{
   input  wire         lbist_clock,
   input  wire         lbist_scan_en,
   input  wire         lbist_reset,
   input  wire         reset,
   input  wire         scan_in,
   output wire         scan_out,
   output reg    [2:0] capture_phase_size
);
 
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         capture_phase_size <= 3'd0;
      end else if (lbist_scan_en) begin
         capture_phase_size <= { scan_in, capture_phase_size[2:1] };
      end else begin
         if (lbist_reset) begin
            capture_phase_size <= 3'd4;
         end
      end
   end
 
   assign scan_out = capture_phase_size[0];
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_warmup_pattern_cnt_reg ( // {{{
   input  wire         lbist_clock,
   input  wire         lbist_scan_en,
   input  wire         lbist_reset,
   input  wire         reset,
   input  wire         scan_in,
   output wire         scan_out,
   output reg    [9:0] warmup_pattern_cnt
);
 
   always @ (posedge lbist_clock or negedge reset) begin
      if (~reset) begin
         warmup_pattern_cnt <= 10'd0;
      end else if (lbist_scan_en) begin
         warmup_pattern_cnt <= { scan_in, warmup_pattern_cnt[9:1] };
      end else begin
         if (lbist_reset) begin
            warmup_pattern_cnt <= 10'b0000000000;
         end
      end
   end
 
   assign scan_out = warmup_pattern_cnt[0];
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_ncp_limits ( // {{{
   input  wire         clock,
   input  wire         lbist_reset,
   input  wire         reset,
   output reg    [7:0] ncp_0_limit,
   output reg    [7:0] ncp_1_limit,
   output reg    [7:0] ncp_2_limit,
   output reg    [7:0] ncp_3_limit,
   input  wire         ccm_scan_en,
   input  wire         ccm_le_si,
   output wire         ccm_le_so,
   input  wire         scan_en,
   input  wire         scan_in,
   output wire         scan_out
 );
   wire           scan_in_int;
 
   always @ (posedge clock or negedge reset) begin
      if (~reset) begin
         ncp_0_limit         <= 8'd63;
         ncp_1_limit         <= 8'd127;
         ncp_2_limit         <= 8'd191;
         ncp_3_limit         <= 8'd255;
      end else if (scan_en) begin
         ncp_0_limit         <= {ncp_1_limit[0], ncp_0_limit[7:1]};
         ncp_1_limit         <= {ncp_2_limit[0], ncp_1_limit[7:1]};
         ncp_2_limit         <= {ncp_3_limit[0], ncp_2_limit[7:1]};
         ncp_3_limit         <= {scan_in_int, ncp_3_limit[7:1]};
      end else if (lbist_reset) begin
         ncp_0_limit         <= 8'd63;
         ncp_1_limit         <= 8'd127;
         ncp_2_limit         <= 8'd191;
         ncp_3_limit         <= 8'd255;
      end
   end
 
   assign scan_out = ncp_0_limit[0];

   assign scan_in_int = ccm_scan_en ? ccm_le_si : scan_in;
   assign ccm_le_so   = scan_out;
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_ctrl_signals ( // {{{
   input  wire         scan_in,
   output wire         scan_out,
   input  wire         ccm_scan_en,
   input  wire         ccm_le_si,
   output wire         ccm_le_so,
   input  wire         ccm_te_si,
   output wire         ccm_te_so,
   input  wire         lbist_done,
   output reg          lbist_en,
   output reg    [2:0] lbist_setup,
   output reg          lbist_clock_disable,
   output reg          lbist_sync_reset,
   output reg    [1:0] shift_clock_select,
   output reg          lbist_burn_in,
   output reg          lbist_low_power_shift_en,
   input  wire         ijtag_tck,
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue
);
 
   reg      [9:0] tdr;
   wire           sib_to_enable;
   wire           scan_in_int;
 
   assign scan_in_int = ccm_scan_en ? ccm_le_si : scan_in;
 
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         lbist_en            <= 1'b0;
         lbist_setup         <= 3'd0;
         lbist_clock_disable <= 1'b0;
         shift_clock_select  <= 2'b00;
         lbist_burn_in       <= 1'b0;
         lbist_low_power_shift_en <= 1'b0;
      end else if (ccm_scan_en) begin
         lbist_en            <= ccm_te_si;
         lbist_setup         <= {lbist_en, lbist_setup[2:1]};
         lbist_clock_disable <= lbist_setup[0];
         shift_clock_select  <= {lbist_clock_disable, shift_clock_select[1]};
         lbist_burn_in       <= shift_clock_select[0];
         lbist_low_power_shift_en <= lbist_burn_in;
      end else if (ijtag_ue & sib_to_enable) begin
         lbist_en            <= tdr[0];
         lbist_setup         <= tdr[3:1];
         lbist_clock_disable <= tdr[4];
         shift_clock_select  <= tdr[7:6];
         lbist_burn_in       <= tdr[8];
         lbist_low_power_shift_en <= tdr[9];
      end
   end
 
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         lbist_sync_reset    <= 1'b0;
      end else if (ccm_scan_en) begin
         lbist_sync_reset    <= lbist_low_power_shift_en;
      end else if (ijtag_ue & sib_to_enable) begin
         lbist_sync_reset    <= tdr[5];
      end else if (ijtag_ce) begin
         lbist_sync_reset    <= 1'b0;
      end
   end
 
   always @ (posedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         tdr <= 10'd0;
      end else if (ccm_scan_en) begin
         tdr <= {scan_in_int, tdr[9:1]};
      end else if (ijtag_ce & sib_to_enable) begin
         tdr <= {9'd0, lbist_done};
      end else if (ijtag_se & sib_to_enable) begin
         tdr <= {scan_in_int, tdr[9:1]};
      end
   end
 
   msrv32_top_pass2_rtl_tessent_lbist_sib msrv32_top_pass2_rtl_tessent_lbist_sib_i (
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_sel            (ijtag_sel),                        // i
      .ijtag_ce             (ijtag_ce),                         // i
      .ijtag_se             (ijtag_se),                         // i
      .ijtag_ue             (ijtag_ue),                         // i
      .ijtag_tck            (ijtag_tck),                        // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_te_si            (lbist_sync_reset),                 // i
      .ccm_te_so            (ccm_te_so),                        // o
      .ijtag_from_so        (tdr[0]),                           // i
      .ijtag_si             (scan_in_int),                      // i
      .ijtag_so             (scan_out),                         // o
      .ijtag_to_sel         (sib_to_enable)                     // o
   );
 
   assign ccm_le_so = scan_out;
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist_ctrl ( // {{{
   input  wire         lbist_clock,
   input  wire         lbist_en,
   input  wire         ccm_scan_en,
   input  wire         ccm_le_si,
   output wire         ccm_le_so,
   input  wire         ccm_te_si,
   output wire         ccm_te_so,
   output wire   [2:0] capture_phase_size,
   input  wire         lbist_scan_in,
   output wire         lbist_scan_out,
   input  wire         shift_phase,
   input  wire         lbist_reset,
   input  wire         lbist_run_mode,
   input  wire         lbist_burn_in,
   input  wire         prpg_en,
   output wire         warmup_done,
   output wire   [1:0] ncp,
   output wire         last_bit,
   output wire         last_vector,
   input  wire         ijtag_tck,
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue
 );
 
   reg            counter_bist_scan_out_retime;
   reg            ncp_limits_so_retime;
   wire           lbist_scan_en_int;
   wire           capture_phase_size_so;
   wire           warmup_pattern_cnt_so;
   wire     [9:0] warmup_pattern_cnt;
   wire           ncp_limits_scan_en;
   wire           ncp_limits_sib_to_enable;
   wire           ncp_limits_so;
   wire     [7:0] ncp_0_limit;
   wire     [7:0] ncp_1_limit;
   wire     [7:0] ncp_2_limit;
   wire     [7:0] ncp_3_limit;
 
   wire           counter_bist_scan_out;
   wire           lbist_sib_scan_out;
   wire     [9:0] vector_cnt_lsb;
   wire           last_vector_int;
   wire           sib_to_enable;
   wire           ccm_te_so_lbist_sib;
   wire           lbist_sib_ijtag_from_so;
   wire           ncp_limits_sib_ijtag_from_so;
   wire           ccm_te_so_ncp_limits_sib;
   wire           lbist_scan_in_int;
   wire           lbist_counter_ccm_le_so;
   wire           ncp_limits_ccm_le_so;
 
   assign lbist_scan_in_int = ccm_scan_en ? ccm_le_si : lbist_scan_in;
   assign lbist_scan_en_int = ccm_scan_en | (lbist_en & ijtag_se & sib_to_enable);
   assign ncp_limits_scan_en = ccm_scan_en | (lbist_en & ijtag_se & ncp_limits_sib_to_enable);
   assign last_vector       = last_vector_int;
   assign warmup_done       = (vector_cnt_lsb == warmup_pattern_cnt);
 
   msrv32_top_pass2_rtl_tessent_lbist_capture_phase_reg msrv32_top_pass2_rtl_tessent_lbist_capture_phase_size_reg_i (
      .lbist_clock          (lbist_clock),                      // i
      .lbist_scan_en        (lbist_scan_en_int),                // i
      .lbist_reset          (lbist_reset),                      // i
      .reset                (ijtag_reset),                      // i
      .scan_in              (lbist_scan_in_int),                // i
      .scan_out             (capture_phase_size_so),            // o
      .capture_phase_size   (capture_phase_size)                // o [2:0]
   );
 
   msrv32_top_pass2_rtl_tessent_lbist_warmup_pattern_cnt_reg msrv32_top_pass2_rtl_tessent_lbist_warmup_pattern_cnt_reg_i (
      .lbist_clock          (lbist_clock),                      // i
      .lbist_scan_en        (lbist_scan_en_int),                // i
      .lbist_reset          (lbist_reset),                      // i
      .reset                (ijtag_reset),                      // i
      .scan_in              (capture_phase_size_so),            // i
      .scan_out             (warmup_pattern_cnt_so),            // o
      .warmup_pattern_cnt   (warmup_pattern_cnt)                // o [9:0]
   );
 
   msrv32_top_pass2_rtl_tessent_lbist_counter msrv32_top_pass2_rtl_tessent_lbist_counter_i (
      .lbist_clock          (lbist_clock),                      // i
      .lbist_scan_en        (lbist_scan_en_int),                // i
      .lbist_run_mode       (lbist_run_mode),                   // i
      .reset                (ijtag_reset),                      // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_le_si            (warmup_pattern_cnt_so),            // i
      .ccm_le_so            (lbist_counter_ccm_le_so),          // o
      .shift_phase          (shift_phase),                      // i
      .prpg_en              (prpg_en),                          // i
      .lbist_burn_in        (lbist_burn_in),                    // i
      .lbist_reset          (lbist_reset),                      // i
      .lbist_scan_in        (warmup_pattern_cnt_so),            // i
      .lbist_scan_out       (counter_bist_scan_out),            // o
      .ncp                  (ncp),                              // o [1:0]
      .ncp_0_limit          (ncp_0_limit),                      // i [7:0]
      .ncp_1_limit          (ncp_1_limit),                      // i [7:0]
      .ncp_2_limit          (ncp_2_limit),                      // i [7:0]
      .ncp_3_limit          (ncp_3_limit),                      // i [7:0]
      .last_bit             (last_bit),                         // o
      .vector_cnt_lsb       (vector_cnt_lsb),                   // o [9:0]
      .last_vector          (last_vector_int)                   // o
   );
 
   always @(negedge ijtag_tck) begin
      counter_bist_scan_out_retime <= ccm_scan_en ? ccm_te_si : counter_bist_scan_out;
   end
 
   assign lbist_sib_ijtag_from_so = ccm_scan_en ? lbist_counter_ccm_le_so : counter_bist_scan_out_retime;
 
   msrv32_top_pass2_rtl_tessent_lbist_sib msrv32_top_pass2_rtl_tessent_lbist_sib_i (
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_sel            (ijtag_sel),                        // i
      .ijtag_ce             (ijtag_ce),                         // i
      .ijtag_se             (ijtag_se),                         // i
      .ijtag_ue             (ijtag_ue),                         // i
      .ijtag_tck            (ijtag_tck),                        // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_te_si            (counter_bist_scan_out_retime),     // i
      .ccm_te_so            (ccm_te_so_lbist_sib),              // o
      .ijtag_from_so        (lbist_sib_ijtag_from_so),          // i
      .ijtag_si             (lbist_scan_in),                    // i
      .ijtag_so             (lbist_sib_scan_out),               // o
      .ijtag_to_sel         (sib_to_enable)                     // o
   );
 
   msrv32_top_pass2_rtl_tessent_lbist_ncp_limits msrv32_top_pass2_rtl_tessent_lbist_ncp_limits_i (
      .clock                (lbist_clock),                      // i
      .lbist_reset          (lbist_reset),                      // i
      .reset                (ijtag_reset),                      // i
      .ncp_0_limit          (ncp_0_limit),                      // o [7:0]
      .ncp_1_limit          (ncp_1_limit),                      // o [7:0]
      .ncp_2_limit          (ncp_2_limit),                      // o [7:0]
      .ncp_3_limit          (ncp_3_limit),                      // o [7:0]
      .ccm_scan_en          (ccm_scan_en),                      // i 
      .ccm_le_si            (lbist_sib_scan_out),               // i
      .ccm_le_so            (ncp_limits_ccm_le_so),             // o
      .scan_en              (ncp_limits_scan_en),               // i
      .scan_in              (lbist_sib_scan_out),               // i
      .scan_out             (ncp_limits_so)                     // o
   );
 
   always @(negedge ijtag_tck) begin
      ncp_limits_so_retime <= ccm_scan_en ? ccm_te_so_lbist_sib : ncp_limits_so;
   end
 
   assign ncp_limits_sib_ijtag_from_so = ccm_scan_en ? ncp_limits_ccm_le_so : ncp_limits_so_retime;
 
   msrv32_top_pass2_rtl_tessent_lbist_sib msrv32_top_pass2_rtl_tessent_lbist_ncp_limits_sib_i (
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_sel            (ijtag_sel),                        // i
      .ijtag_ce             (ijtag_ce),                         // i
      .ijtag_se             (ijtag_se),                         // i
      .ijtag_ue             (ijtag_ue),                         // i
      .ijtag_tck            (ijtag_tck),                        // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_te_si            (ncp_limits_so_retime),             // i
      .ccm_te_so            (ccm_te_so_ncp_limits_sib),         // o
      .ijtag_from_so        (ncp_limits_sib_ijtag_from_so),     // i
      .ijtag_si             (lbist_sib_scan_out),               // i
      .ijtag_so             (lbist_scan_out),                   // o
      .ijtag_to_sel         (ncp_limits_sib_to_enable)          // o
   );
 
   assign ccm_le_so      = lbist_scan_out;
   assign ccm_te_so      = ccm_te_so_ncp_limits_sib;
 
endmodule // }}}
 
 
module msrv32_top_pass2_rtl_tessent_lbist ( // {{{
   input  wire         ijtag_tck,
   input  wire         test_clock,
   input  wire         shift_clock_src,
   output wire         edt_lbist_clock,
   output wire         shift_clock,
   output wire         to_edt_scan_in,
   input  wire         from_edt_scan_out,
   input  wire         ijtag_si,
   output reg          ijtag_so,
   output wire         lbist_en,
   output wire         lbist_reset,
   input  wire         ccm_en,
   output wire         ccm_scan_en,
   output wire         ccm_scan_out,
   output wire         lbist_low_power_shift_en,
   input  wire         scan_en_in,
   output wire         scan_en_out,
   input  wire         shift_clock_in,
   output wire         shift_clock_out,
   input  wire   [1:0] shift_en_in,
   output wire   [1:0] shift_en_out,
   input  wire         capture_en_in,
   output wire         capture_en_out,
   output wire   [1:0] ncp,
   output wire         lbist_prpg_en,
   output wire         misr_accumulate_en,
   output wire         capture_en,
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   output wire         edt_sib_en
);
 
   reg            ccm_te_si_lockup;
   reg      [2:0] ijtag_ccm_tdr;
 
   wire           lbist_en_int;
   wire           test_clock_buf_out;
   wire           scan_en_in_buf;
   wire           lbist_en_buf_out;
   wire           lbist_fsm_ccm_scan_out;
   wire           ccm_en_buf_out;
   wire           lbist_burn_in;
   wire           prpg_en_int;
   wire           misr_en_int;
   wire           shift_clock_en_int;
   wire           shift_clock_en_buf_out;
   wire           shift_phase_int;
   wire           shift_phase_buf_out;
   wire           capture_clock_en_int;
   wire           capture_clock_en_buf_out;
   wire           capture_en_int;
   wire           last_bit;
   wire           last_vector;
   wire           scan_en_select;
   wire           shift_capture_clock_int;
   wire           shift_clock_int;
   wire     [1:0] shift_clock_select;
   wire     [1:0] shift_clock_select_buf_out;
   wire     [2:0] capture_phase_size;
   wire           lbist_fsm_reset;
   wire           lbist_done;
   wire           lbist_run_mode;
   wire     [2:0] lbist_setup;
   wire           lbist_clock_disable;
   wire           lbist_clock_disable_sync;
   wire           lbist_sync_reset;
   wire           lbist_ctrl_bist_scan_out;
   wire           lbist_ctrl_signals_scan_out;
   wire     [1:0] ncp_int;
   wire           warmup_done;
   wire           lbist_edt_sib_scan_out;
   wire           ijtag_so_d;
   wire           ijtag_sel_ccm;
   wire           ijtag_ce_ccm;
   wire           ijtag_se_ccm;
   wire           ijtag_ue_ccm;
   wire           ccm_le_so_lbist_ctrl;
   wire           ccm_te_so_lbist_ctrl;
   wire           ccm_le_so_lbist_ctrl_signals;
   wire           ccm_te_so_lbist_ctrl_signals;
   wire           ccm_te_so_lbist_fsm;
   wire           ccm_te_so_lbist_edt_sib;
 
   always @(posedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         ijtag_ccm_tdr <= 3'b000;
      end else if (ccm_scan_en) begin
         ijtag_ccm_tdr <= {ijtag_so, ijtag_ccm_tdr[2:1]};
      end
   end
 
   assign ijtag_sel_ccm         = ccm_en_buf_out ? ijtag_ccm_tdr[0] : ijtag_sel;
   assign ijtag_ce_ccm          = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b01) : ijtag_ce;
   assign ijtag_se_ccm          = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b10) : ijtag_se;
   assign ijtag_ue_ccm          = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b11) : ijtag_ue;
 
   buf02 tessent_persistent_cell_lbist_en_buf (
      .A                    (lbist_en_int),                     // i
      .Y                    (lbist_en_buf_out)                  // o
   );

   buf02 tessent_persistent_cell_ccm_en_buf (
      .A                    (ccm_en),                           // i
      .Y                    (ccm_en_buf_out)                    // o
   );

   buf02 tessent_persistent_cell_shift_phase_buf (
      .A                    (shift_phase_int),                  // i
      .Y                    (shift_phase_buf_out)               // o
   );

   buf02 tessent_persistent_cell_capture_en_buf (
      .A                    (capture_en_int),                   // i
      .Y                    (capture_en)                        // o
   );

   buf02 tessent_persistent_cell_shift_clock_select_0_buf (
      .A                    (shift_clock_select[0]),            // i
      .Y                    (shift_clock_select_buf_out[0])     // o
   );
   buf02 tessent_persistent_cell_shift_clock_select_1_buf (
      .A                    (shift_clock_select[1]),            // i
      .Y                    (shift_clock_select_buf_out[1])     // o
   );

   buf02 tessent_persistent_cell_shift_clock_en_buf (
      .A                    (shift_clock_en_int),               // i
      .Y                    (shift_clock_en_buf_out)            // o
   );

   buf02 tessent_persistent_cell_capture_clock_en_buf (
      .A                    (capture_clock_en_int),             // i
      .Y                    (capture_clock_en_buf_out)          // o
   );

   clock_buf02 tessent_persistent_cell_test_clock_buf (
      .A                    (test_clock),                       // i
      .Y                    (test_clock_buf_out)                // o
   );

   buf02 tessent_persistent_cell_scan_en_in_buf (
      .A                    (scan_en_in),                       // i
      .Y                    (scan_en_in_buf)                    // o
   );

   assign ccm_scan_en              = ccm_en_buf_out & scan_en_in_buf;
   assign ccm_scan_out             = ccm_en_buf_out & ccm_te_so_lbist_edt_sib;
   assign lbist_en                 = lbist_en_buf_out | ccm_scan_en;
   assign lbist_reset              = (lbist_fsm_reset | lbist_sync_reset) & ~ccm_scan_en;
   assign scan_en_select           = lbist_en_buf_out & (| lbist_setup[2:1]);
   mux21 tessent_persistent_cell_scan_en_out_mux (
      .A0                   (scan_en_in_buf),                   // i
      .A1                   (shift_phase_buf_out),              // i
      .S0                   (~ccm_scan_en & scan_en_select),    // i
      .Y                    (scan_en_out)                       // o
   );
   assign ncp                      = ncp_int & {2{lbist_en_buf_out}};
 
   clock_mux21 tessent_persistent_cell_shift_clock_out_mux (
      .A0                   (shift_clock_in),                   // i
      .A1                   (shift_capture_clock_int),          // i
      .S0                   (lbist_en),                         // i
      .Y                    (shift_clock_out)                   // o
   );
 
   mux21 tessent_persistent_cell_shift_en_out_0_mux (
      .A0                   (shift_en_in[0]),                   // i
      .A1                   (shift_clock_en_buf_out),           // i
      .S0                   (scan_en_select & ~ccm_scan_en),    // i
      .Y                    (shift_en_out[0])                   // o
   );
   mux21 tessent_persistent_cell_shift_en_out_1_mux (
      .A0                   (shift_en_in[1]),                   // i
      .A1                   (shift_clock_en_buf_out),           // i
      .S0                   (scan_en_select & ~ccm_scan_en),    // i
      .Y                    (shift_en_out[1])                   // o
   );
 
   assign capture_en_out           = lbist_en ? capture_en : capture_en_in;
 
   cgand tessent_persistent_cell_shift_capture_clock_gater_i (
      .FE                   (ccm_scan_en | (~lbist_clock_disable_sync & (capture_clock_en_buf_out | shift_clock_en_buf_out))), // i
      .TE                   (ccm_scan_en | (~lbist_clock_disable_sync & (capture_clock_en_buf_out | shift_clock_en_buf_out))), // i
      .CK                   (shift_clock_int),                  // i
      .GCK                  (shift_capture_clock_int)           // o
   );

   buf02 tessent_persistent_cell_prpg_en (
      .A                    (prpg_en_int),                      // i
      .Y                    (lbist_prpg_en)                     // o
   );

   buf02 tessent_persistent_cell_misr_en (
      .A                    (misr_en_int),                      // i
      .Y                    (misr_accumulate_en)                // o
   );

   always @(posedge ijtag_tck) begin
      ccm_te_si_lockup <= ijtag_ccm_tdr[0];
   end
 
   msrv32_top_pass2_rtl_tessent_lbist_ctrl msrv32_top_pass2_rtl_tessent_lbist_ctrl_i (
      .lbist_clock          (edt_lbist_clock),                  // i
      .lbist_en             (lbist_en_buf_out),                 // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_le_si            (ijtag_si),                         // i
      .ccm_le_so            (ccm_le_so_lbist_ctrl),             // o
      .ccm_te_si            (ccm_te_si_lockup),                 // i
      .ccm_te_so            (ccm_te_so_lbist_ctrl),             // o
      .capture_phase_size   (capture_phase_size),               // o [2:0]
      .lbist_scan_in        (ijtag_si),                         // i
      .lbist_scan_out       (lbist_ctrl_bist_scan_out),         // o
      .shift_phase          (shift_phase_buf_out),              // i
      .lbist_reset          (lbist_reset),                      // i
      .lbist_run_mode       (lbist_run_mode),                   // i
      .lbist_burn_in        (lbist_burn_in),                    // i
      .prpg_en              (prpg_en_int),                      // i
      .warmup_done          (warmup_done),                      // o
      .ncp                  (ncp_int),                          // o [1:0]
      .last_bit             (last_bit),                         // o
      .last_vector          (last_vector),                      // o
      .ijtag_tck            (ijtag_tck),                        // i
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_sel            (ijtag_sel_ccm),                    // i
      .ijtag_ce             (ijtag_ce_ccm),                     // i
      .ijtag_se             (ijtag_se_ccm),                     // i
      .ijtag_ue             (ijtag_ue_ccm)                      // i
   );
 
   msrv32_top_pass2_rtl_tessent_lbist_ctrl_signals msrv32_top_pass2_rtl_tessent_lbist_ctrl_signals_i (
      .scan_in              (lbist_ctrl_bist_scan_out),         // i
      .scan_out             (lbist_ctrl_signals_scan_out),      // o
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_le_si            (ccm_le_so_lbist_ctrl),             // i
      .ccm_le_so            (ccm_le_so_lbist_ctrl_signals),     // o
      .ccm_te_si            (ccm_te_so_lbist_ctrl),             // i
      .ccm_te_so            (ccm_te_so_lbist_ctrl_signals),     // o
      .lbist_done           (lbist_done),                       // i
      .lbist_en             (lbist_en_int),                     // o
      .lbist_setup          (lbist_setup),                      // o [2:0]
      .lbist_clock_disable  (lbist_clock_disable),              // o
      .lbist_sync_reset     (lbist_sync_reset),                 // o
      .lbist_burn_in        (lbist_burn_in),                    // o
      .shift_clock_select   (shift_clock_select),               // o [1:0]
      .lbist_low_power_shift_en (lbist_low_power_shift_en),         // o
      .ijtag_tck            (ijtag_tck),                        // i
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_sel            (ijtag_sel_ccm),                    // i
      .ijtag_ce             (ijtag_ce_ccm),                     // i
      .ijtag_se             (ijtag_se_ccm),                     // i
      .ijtag_ue             (ijtag_ue_ccm)                      // i
   );
 
   msrv32_top_pass2_rtl_tessent_lbist_fsm msrv32_top_pass2_rtl_tessent_lbist_fsm_i (
      .ijtag_tck            (ijtag_tck),                        // i
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_se             (ijtag_se_ccm),                     // i
      .shift_clock_src      (shift_clock_src),                  // i
      .edt_clock            (test_clock_buf_out),               // i
      .shift_clock_select   (shift_clock_select_buf_out),       // i [1:0]
      .lbist_clock_disable  (lbist_clock_disable),              // i
      .lbist_en             (lbist_en_buf_out),                 // i
      .lbist_setup          (lbist_setup),                      // i [2:0]
      .lbist_burn_in        (lbist_burn_in),                    // i
      .ccm_en               (ccm_en_buf_out),                   // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_le_si            (ccm_le_so_lbist_ctrl_signals),     // i
      .ccm_le_so            (lbist_fsm_ccm_scan_out),           // o
      .ccm_te_si            (ccm_te_so_lbist_ctrl_signals),     // i
      .ccm_te_so            (ccm_te_so_lbist_fsm),              // o
      .capture_phase_size   (capture_phase_size),               // i [2:0]
      .last_bit             (last_bit),                         // i
      .last_vector          (last_vector),                      // i
      .warmup_done          (warmup_done),                      // i
      .lbist_clock_disable_sync (lbist_clock_disable_sync),         // o
      .lbist_done           (lbist_done),                       // o
      .lbist_run_mode       (lbist_run_mode),                   // o
      .lbist_reset          (lbist_fsm_reset),                  // o
      .prpg_en              (prpg_en_int),                      // o
      .misr_en              (misr_en_int),                      // o
      .shift_clock_int      (shift_clock_int),                  // o
      .shift_clock          (shift_clock),                      // o
      .lbist_clock          (edt_lbist_clock),                  // o
      .shift_clock_en       (shift_clock_en_int),               // o
      .capture_clock_en     (capture_clock_en_int),             // o
      .shift_phase          (shift_phase_int),                  // o
      .capture_en           (capture_en_int)                    // o
   );
 
   assign to_edt_scan_in = ccm_scan_en ? lbist_fsm_ccm_scan_out : lbist_ctrl_signals_scan_out;
 
   msrv32_top_pass2_rtl_tessent_lbist_sib msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i (
      .ijtag_reset          (ijtag_reset),                      // i
      .ijtag_sel            (ijtag_sel_ccm),                    // i
      .ijtag_ce             (ijtag_ce_ccm),                     // i
      .ijtag_se             (ijtag_se_ccm),                     // i
      .ijtag_ue             (ijtag_ue_ccm),                     // i
      .ijtag_tck            (ijtag_tck),                        // i
      .ccm_scan_en          (ccm_scan_en),                      // i
      .ccm_te_si            (ccm_te_so_lbist_fsm),              // i
      .ccm_te_so            (ccm_te_so_lbist_edt_sib),          // o
      .ijtag_from_so        (from_edt_scan_out),                // i
      .ijtag_si             (lbist_ctrl_signals_scan_out),      // i
      .ijtag_so             (lbist_edt_sib_scan_out),           // o
      .ijtag_to_sel         (edt_sib_en)                        // o
   );
 
   assign ijtag_so_d = (ijtag_sel_ccm && ijtag_ce_ccm) ? 1'b0 :
                       (ijtag_sel_ccm && ijtag_se_ccm) ? lbist_edt_sib_scan_out : ijtag_so;
    
   always @ (posedge ijtag_tck) begin
      if (ccm_scan_en) begin
         ijtag_so <= lbist_edt_sib_scan_out;
      end else begin
         ijtag_so <= ijtag_so_d ^ (ccm_en_buf_out & (scan_en_out ^ ^shift_en_out ^ capture_en_out ^ ^ncp));
      end
   end
 
endmodule // }}}
 
 

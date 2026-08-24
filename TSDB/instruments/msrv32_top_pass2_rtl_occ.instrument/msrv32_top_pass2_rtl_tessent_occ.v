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

module msrv32_top_pass2_rtl_tessent_occ (
   input  wire         fast_clock,
   input  wire         slow_clock,
   input  wire         scan_en,
   input  wire         capture_en,
   input  wire         static_clock_control_mode,
   input  wire   [2:0] clock_sequence,
   input  wire         shift_only_mode,
   input  wire         ijtag_tck,
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   input  wire         ijtag_si,
   output wire         ijtag_so,
   output wire         clock_out,
   input  wire         scan_in,
   output wire         scan_out
);
  
   wire         inject_tck;
   wire         slow_clock_tck_injected;
   wire         slow_clock_nf_en;
   wire         slow_clock_nf;
   wire         fast_clock_en;
   wire         slow_clock_en;
   wire         slow_clock_gated;
   wire         clock_mux_select;
   wire         fast_clock_gated;

   wire         fast_clock_buf_out;
   wire         slow_clock_buf_out;
   wire         scan_en_buf_out;
   wire         capture_en_buf_out;
   wire         static_clock_control_mode_buf_out;
   wire   [2:0] clock_sequence_buf_out;
   wire         scan_in_buf_out;
   wire         scan_out_buf_in;

   clock_buf02 tessent_persistent_cell_fast_clock_buf (
      .A                                     ( fast_clock                       ),
      .Y                                     ( fast_clock_buf_out               )
   );
   clock_buf02 tessent_persistent_cell_slow_clock_buf (
      .A                                     ( slow_clock                       ),
      .Y                                     ( slow_clock_buf_out               )
   );
   buf02 tessent_persistent_cell_scan_en_buf (
      .A                                     ( scan_en                          ),
      .Y                                     ( scan_en_buf_out                  )
   );
   buf02 tessent_persistent_cell_capture_en_buf (
      .A                                     ( capture_en                       ),
      .Y                                     ( capture_en_buf_out               )
   );
   buf02 tessent_persistent_cell_static_clock_control_mode_buf (
      .A                                     ( static_clock_control_mode        ),
      .Y                                     ( static_clock_control_mode_buf_out )
   );
   buf02 tessent_persistent_cell_clock_sequence_buf_0 (
      .A                                     ( clock_sequence[0]                ),
      .Y                                     ( clock_sequence_buf_out[0]        )
   );
   buf02 tessent_persistent_cell_clock_sequence_buf_1 (
      .A                                     ( clock_sequence[1]                ),
      .Y                                     ( clock_sequence_buf_out[1]        )
   );
   buf02 tessent_persistent_cell_clock_sequence_buf_2 (
      .A                                     ( clock_sequence[2]                ),
      .Y                                     ( clock_sequence_buf_out[2]        )
   );
   buf02 tessent_persistent_cell_scan_in_buf (
      .A                                     ( scan_in                          ),
      .Y                                     ( scan_in_buf_out                  )
   );
   buf02 tessent_persistent_cell_scan_out_buf (
      .A                                     ( scan_out_buf_in                  ),
      .Y                                     ( scan_out                         )
   );
   
   cgand tessent_persistent_cell_cgc_slow_clock_nf (
     .CK                                     ( slow_clock_buf_out               ),
     .FE                                     ( slow_clock_nf_en                 ),
     .TE                                     ( slow_clock_nf_en                 ),
     .GCK                                    ( slow_clock_nf                    )
   );
   
   clock_mux21 tessent_persistent_cell_inject_tck_mux (
     .A0                                     ( slow_clock_nf                    ),
     .A1                                     ( ijtag_tck                        ),
     .S0                                     ( inject_tck                       ),
     .Y                                      ( slow_clock_tck_injected          )
   );
   msrv32_top_pass2_rtl_tessent_occ_control occ_control (
     .fast_clock                             ( fast_clock_buf_out               ),
     .slow_clock                             ( slow_clock_tck_injected          ),
     .bypass_clock                           ( clock_out                        ),
     .scan_en                                ( scan_en_buf_out                  ),
     .capture_en                             ( capture_en_buf_out               ),
     .static_clock_control_mode              ( static_clock_control_mode_buf_out ),
     .clock_sequence                         ( clock_sequence_buf_out           ),
     .shift_only_mode                        ( shift_only_mode                  ),
     .slow_clock_nf_en                       ( slow_clock_nf_en                 ),
     .ijtag_tck                              ( ijtag_tck                        ),
     .ijtag_reset                            ( ijtag_reset                      ),
     .ijtag_sel                              ( ijtag_sel                        ),
     .ijtag_ce                               ( ijtag_ce                         ),
     .ijtag_se                               ( ijtag_se                         ),
     .ijtag_ue                               ( ijtag_ue                         ),
     .ijtag_si                               ( ijtag_si                         ),
     .ijtag_so                               ( ijtag_so                         ),
     .inject_tck                             ( inject_tck                       ),
     .fast_clock_en                          ( fast_clock_en                    ),
     .slow_clock_en                          ( slow_clock_en                    ),
     .clock_mux_select                       ( clock_mux_select                 ),
     .scan_in                                ( scan_in_buf_out                  ),
     .scan_out                               ( scan_out_buf_in                  )
   );
 
   cgand tessent_persistent_cell_cgc_fast_clock (
     .CK                                     ( fast_clock_buf_out               ),
     .FE                                     ( fast_clock_en                    ),
     .TE                                     ( fast_clock_en                    ),
     .GCK                                    ( fast_clock_gated                 )
   );
  
   cgand tessent_persistent_cell_cgc_slow_clock (
     .CK                                     ( slow_clock_tck_injected          ),
     .FE                                     ( slow_clock_en                    ),
     .TE                                     ( slow_clock_en                    ),
     .GCK                                    ( slow_clock_gated                 )
   );
 
   clock_mux21 tessent_persistent_cell_clock_out_mux  (
     .A0                                     ( fast_clock_gated                 ),
     .A1                                     ( slow_clock_gated                 ),
     .S0                                     ( clock_mux_select                 ),
     .Y                                      ( clock_out                        )
   );
endmodule
  
module msrv32_top_pass2_rtl_tessent_occ_control (
   input  wire         fast_clock,
   input  wire         slow_clock,
   input  wire         bypass_clock,
   input  wire         scan_en,
   input  wire         capture_en,
   input  wire         static_clock_control_mode,
   input  wire   [2:0] clock_sequence,
   input  wire         shift_only_mode,
   output wire         slow_clock_nf_en,
   input  wire         ijtag_tck,
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   input  wire         ijtag_si,
   output wire         ijtag_so,
   output reg          inject_tck,
   output wire         slow_clock_en,
   output wire         clock_mux_select,
   output wire         fast_clock_en,
   input  wire         scan_in,
   output reg          scan_out
);
 
   wire         CAPTURE_EN_sync;
   wire         ShiftReg_EN;
   reg          BYPASS_SHIFT_FF;
   wire         SCAN_OUT_d;
   wire         ShiftReg_SCAN_OUT;
   wire         SHIFT_REG_CLK_en;
   wire         SHIFT_REG_CLK_G;
   wire         SHIFT_REG_CLK;
 
   reg          CE_SLOW_CLK;
   wire         tdr_en;
   reg    [9:0] tdr;
   reg          tdr_so_retime;
   reg          test_mode;
   reg          fast_capture_mode;
   reg          active_upstream_parent_occ;
   reg    [1:0] capture_cycle_width;
   reg          ijtag_static_clock_control_mode;
   reg    [2:0] ijtag_clock_sequence;
 
   assign slow_clock_nf_en = (test_mode | shift_only_mode) & (scan_en | capture_en);
 
   always @ (negedge slow_clock or negedge test_mode) begin
     if (~test_mode) begin
       CE_SLOW_CLK <= 1'b0;
     end else begin
       CE_SLOW_CLK <= capture_en;
     end
   end
   sync_cell_rst tessent_persistent_cell_ltest_ntc_sync_cell (
     .D                                      ( CE_SLOW_CLK                      ),
     .CK                                     ( fast_clock                       ),
     .R                                      ( scan_en | ~test_mode             ),
     .O                                      ( CAPTURE_EN_sync                  )
   );
 
   assign SHIFT_REG_CLK_en = test_mode & ShiftReg_EN & (CAPTURE_EN_sync || active_upstream_parent_occ);
 
   cgand tessent_persistent_cell_cgc_SHIFT_REG_CLK (
     .CK                                     ( fast_clock                       ), 
     .FE                                     ( SHIFT_REG_CLK_en                 ),
     .TE                                     ( SHIFT_REG_CLK_en                 ),
     .GCK                                    ( SHIFT_REG_CLK_G                  )
   );
 
   clock_mux21 tessent_persistent_cell_SHIFT_REG_CLK_mux (
     .A0                                     ( SHIFT_REG_CLK_G                  ), 
     .A1                                     ( slow_clock                       ),
     .S0                                     ( ~capture_en | ~fast_capture_mode ),
     .Y                                      ( SHIFT_REG_CLK                    )
   );
  
   always @ (posedge bypass_clock) begin
     BYPASS_SHIFT_FF <= scan_in & scan_en;
   end
   assign SCAN_OUT_d = (( static_clock_control_mode | ijtag_static_clock_control_mode ) | ~test_mode) ? BYPASS_SHIFT_FF : ShiftReg_SCAN_OUT;
 
   always @ (negedge bypass_clock) begin
     scan_out <= SCAN_OUT_d & scan_en;
   end
 
   msrv32_top_pass2_rtl_tessent_occ_sib tdr_sib (
     .clock                                  ( ijtag_tck                        ),
     .reset                                  ( ijtag_reset                      ),
     .enable                                 ( ijtag_sel                        ),
     .capture_en                             ( ijtag_ce                         ),
     .shift_en                               ( ijtag_se                         ),
     .update_en                              ( ijtag_ue                         ),
     .scan_in                                ( ijtag_si                         ),
     .from_scan_out                          ( tdr_so_retime                    ),
     .scan_out                               ( ijtag_so                         ),
     .to_enable                              ( tdr_en                           )
   );
  
   always @ (posedge ijtag_tck) begin
     if (ijtag_ce && tdr_en) begin
       tdr <= 10'b0000000000;
     end else if (ijtag_se && tdr_en) begin
       tdr <= {ijtag_si, tdr[9:1]};
     end
   end
   
   always @ (negedge ijtag_tck) begin
     tdr_so_retime <= tdr[0];
   end
  
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       test_mode <= 1'b0;
     end else begin
       if (ijtag_ue && tdr_en) begin
         test_mode <= tdr[0];
       end
     end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       fast_capture_mode <= 1'b0;
     end else begin
       if (ijtag_ue && tdr_en) begin
         fast_capture_mode <= tdr[1];
       end
     end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       active_upstream_parent_occ <= 1'b0;
     end else begin
       if (ijtag_ue && tdr_en) begin
         active_upstream_parent_occ <= tdr[2];
       end
     end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       capture_cycle_width <= 2'b00;
     end else begin
       if (ijtag_ue && tdr_en) begin
         capture_cycle_width <= tdr[4:3];
       end
     end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       inject_tck <= 1'b0;
     end else begin
       if (ijtag_ue && tdr_en) begin
         inject_tck <= tdr[5];
       end
     end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       ijtag_static_clock_control_mode <= 1'b0;
     end else begin
       if (ijtag_ue && tdr_en) begin
         ijtag_static_clock_control_mode <= tdr[6];
       end
     end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       ijtag_clock_sequence <= 3'b000;
     end else begin
       if (ijtag_ue && tdr_en) begin
         ijtag_clock_sequence <= tdr[9:7];
       end
     end
   end
   msrv32_top_pass2_rtl_tessent_occ_shift_reg ShiftReg (
     .clk                                    ( SHIFT_REG_CLK                    ),
     .scan_en                                ( scan_en                          ),
     .capture_cycle_width                    ( capture_cycle_width              ),
     .parallel_load_en                       ( ( static_clock_control_mode | ijtag_static_clock_control_mode ) ),
     .parallel_load_value                    ( ijtag_static_clock_control_mode ? ijtag_clock_sequence : clock_sequence ),
     .some_ones_left                         ( ShiftReg_EN                      ),
     .scan_in                                ( scan_in                          ),
     .scan_out                               ( ShiftReg_SCAN_OUT                )
   );
 
 
   assign fast_clock_en    = (ShiftReg_SCAN_OUT & fast_capture_mode & (CAPTURE_EN_sync || active_upstream_parent_occ)) | ~test_mode;
   assign slow_clock_en    = ((ShiftReg_SCAN_OUT | scan_en) & test_mode) | inject_tck | (shift_only_mode & scan_en);
   assign clock_mux_select = ((scan_en | ~fast_capture_mode) & test_mode) | inject_tck | (shift_only_mode & scan_en);
 
endmodule
  
  
module msrv32_top_pass2_rtl_tessent_occ_shift_reg (
   input  wire         clk,
   input  wire         scan_en,
   input  wire   [1:0] capture_cycle_width,
   input  wire         parallel_load_en,
   input  wire   [2:0] parallel_load_value,
   output wire         some_ones_left,
   input  wire         scan_in,
   output wire         scan_out
);
   reg    [2:0] FF;
   wire         scan_in_gated;
 
   assign scan_in_gated = scan_in & scan_en;
    
   always @ (posedge clk) begin
     if (parallel_load_en && scan_en) begin
       FF <= parallel_load_value;
     end else begin
        case (capture_cycle_width)
           2'd2: FF <= {scan_in_gated, FF[2:1]};
           2'd1: FF <= {1'b0, scan_in_gated, FF[1:1]};
           2'd0: FF <= {2'b0, scan_in_gated};
           default: FF <= {scan_in_gated, FF[2:1]};
        endcase
     end
   end
 
   assign some_ones_left = |FF;
   assign scan_out = FF[0];
   
endmodule
 
module msrv32_top_pass2_rtl_tessent_occ_sib (
   input  wire         clock,
   input  wire         reset,
   input  wire         enable,
   input  wire         capture_en,
   input  wire         shift_en,
   input  wire         update_en,
   input  wire         scan_in,
   input  wire         from_scan_out,
   output wire         scan_out,
   output wire         to_enable
);
   reg          sib;
   reg          sib_latch;
   reg          so_retime;
   reg          to_enable_int;
 
   assign to_enable = to_enable_int & enable;
 
   always @ (negedge clock or negedge reset) begin
     if (~reset) begin
       sib_latch <= 1'b0;
     end else begin
       if (update_en && enable) begin
         sib_latch <= sib;
       end
     end
   end
 
   always @ (negedge clock) begin
     so_retime <= sib;
     to_enable_int <= sib_latch;
   end
 
   always @ (posedge clock or negedge reset) begin
     if (~reset) begin
       sib <= 1'b0;
     end else begin
       if (capture_en && enable) begin
         sib <= 1'b0;
       end else begin
         if (shift_en && enable) begin
           if (sib_latch) begin
             sib <= from_scan_out;
           end else begin
             sib <= scan_in;
           end
         end
       end
     end
   end
   
   assign scan_out = so_retime;
   
endmodule

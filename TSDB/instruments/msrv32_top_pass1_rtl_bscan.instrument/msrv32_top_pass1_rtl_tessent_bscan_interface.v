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
//       Created on: Tue Apr  7 17:30:07 IST 2026
//--------------------------------------------------------------------------

module msrv32_top_pass1_rtl_tessent_bscan_interface (
  // from the TAP
  input  wire         ijtag_tck,
  input  wire         scan_in,
  input  wire         bscan_select,
  input  wire         ijtag_shift_en,
  input  wire         ijtag_update_en,
  input  wire         ijtag_capture_en,
  input  wire         force_disable,
  input  wire         select_jtag_input,
  input  wire         select_jtag_output,
  input  wire         output_pad_disable,
  input  wire         bscan_clamp_enable,
  // from the boundary scan chain
  input  wire         from_bscan_scan_out,
  // to the TAP
  output wire         scan_out,
  // to the boundary scan chain
  output wire         to_bscan_force_disable,
  output wire         to_bscan_tck,
  output wire         to_bscan_select,
  output wire         to_bscan_shift_en,
  output wire         to_bscan_update_en,
  output wire         to_bscan_capture_shift_clock,
  output wire         to_bscan_update_clock,
  output wire         to_bscan_capture_en,
  output wire         to_bscan_select_jtag_input,
  output wire         to_bscan_select_jtag_output,
  output wire         to_bscan_pad_sel,
  output wire         to_bscan_scan_in
);

  wire             ijtag_tck_int_wire;
  wire             bscan_select_int_wire;
  wire             ijtag_shift_en_int_wire;
  wire             ijtag_update_en_int_wire;
  wire             ijtag_capture_en_int_wire;
  wire             force_disable_int_wire;
  wire             select_jtag_input_int_wire;
  wire             select_jtag_output_int_wire;
  wire             capture_shift_clock_enable_wire;
  wire             update_clock_enable_wire;

  assign capture_shift_clock_enable_wire   = bscan_select_int_wire & (ijtag_shift_en_int_wire | ijtag_capture_en_int_wire);
  assign update_clock_enable_wire          = bscan_select_int_wire & ijtag_update_en_int_wire;
  assign to_bscan_tck                      = ijtag_tck_int_wire;
  assign to_bscan_select                   = bscan_select_int_wire;
  assign to_bscan_force_disable            = force_disable_int_wire | output_pad_disable;
  assign to_bscan_capture_en               = bscan_select_int_wire & ijtag_capture_en_int_wire;
  assign to_bscan_shift_en                 = bscan_select_int_wire & ijtag_shift_en_int_wire;
  assign to_bscan_update_en                = bscan_select_int_wire & ijtag_update_en_int_wire;
  assign to_bscan_select_jtag_input        = select_jtag_input_int_wire;
  assign to_bscan_select_jtag_output       = select_jtag_output_int_wire | bscan_clamp_enable;
  assign to_bscan_pad_sel                  = bscan_select_int_wire | select_jtag_output_int_wire | bscan_clamp_enable;
  assign to_bscan_scan_in                  = scan_in;
  assign scan_out                          = from_bscan_scan_out;

  clock_buf02 tessent_persistent_cell_ijtag_tck_buf (
    .A                    (ijtag_tck),
    .Y                    (ijtag_tck_int_wire)
  );
  buf02 tessent_persistent_cell_bscan_select_buf (
    .A                    (bscan_select),
    .Y                    (bscan_select_int_wire)
  );
  buf02 tessent_persistent_cell_ijtag_shift_en_buf (
    .A                    (ijtag_shift_en),
    .Y                    (ijtag_shift_en_int_wire)
  );
  buf02 tessent_persistent_cell_ijtag_update_en_buf (
    .A                    (ijtag_update_en),
    .Y                    (ijtag_update_en_int_wire)
  );
  buf02 tessent_persistent_cell_ijtag_capture_en_buf (
    .A                    (ijtag_capture_en),
    .Y                    (ijtag_capture_en_int_wire)
  );
  buf02 tessent_persistent_cell_force_disable_buf (
    .A                    (force_disable),
    .Y                    (force_disable_int_wire)
  );
  buf02 tessent_persistent_cell_select_jtag_input_buf (
    .A                    (select_jtag_input),
    .Y                    (select_jtag_input_int_wire)
  );
  buf02 tessent_persistent_cell_select_jtag_output_buf (
    .A                    (select_jtag_output),
    .Y                    (select_jtag_output_int_wire)
  );

  cgand tessent_persistent_cell_capture_shift_clock_gater_inst (
    .CK                   (ijtag_tck_int_wire),
    .FE                   (capture_shift_clock_enable_wire),
    .TE                   (capture_shift_clock_enable_wire),
    .GCK                  (to_bscan_capture_shift_clock)
  );

  cgand tessent_persistent_cell_update_clock_gater_inst (
    .CK                   (~ijtag_tck_int_wire),
    .FE                   (update_clock_enable_wire),
    .TE                   (update_clock_enable_wire),
    .GCK                  (to_bscan_update_clock)
  );
endmodule

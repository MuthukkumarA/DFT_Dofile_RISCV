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

module msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl (
  input wire ijtag_reset,
  input wire ijtag_sel,
  input wire ijtag_si,
  input wire ijtag_ce,
  input wire ijtag_se,
  input wire ijtag_ue,
  input wire ijtag_tck,
  output wire mcp_bounding_en,
  output wire control_test_point_en,
  output wire observe_test_point_en,
  output wire x_bounding_en,
  output wire ijtag_so
);
wire                mcp_bounding_en_to_buf;
wire                control_test_point_en_to_buf;
wire                observe_test_point_en_to_buf;
wire                x_bounding_en_to_buf;
reg    [3:0]        tdr;
reg                 retiming_so ;
reg                 mcp_bounding_en_latch;
reg                 control_test_point_en_latch;
reg                 observe_test_point_en_latch;
reg                 x_bounding_en_latch;
 
 
buf02 tessent_persistent_cell_mcp_bounding_en ( .A (mcp_bounding_en_latch), .Y (mcp_bounding_en) );
buf02 tessent_persistent_cell_control_test_point_en ( .A (control_test_point_en_latch), .Y (control_test_point_en) );
buf02 tessent_persistent_cell_observe_test_point_en ( .A (observe_test_point_en_latch), .Y (observe_test_point_en) );
buf02 tessent_persistent_cell_x_bounding_en ( .A (x_bounding_en_latch), .Y (x_bounding_en) );
 
// --------- ShiftRegister ---------
 
always @ (posedge ijtag_tck) begin
  if (ijtag_ce & ijtag_sel) begin
    tdr <= { 4'b0000};
  end else if (ijtag_se & ijtag_sel) begin
    tdr <= {ijtag_si,tdr[3:1]};
  end
end
 
assign ijtag_so = retiming_so;
always @ (ijtag_tck or tdr[0]) begin
  if (~ijtag_tck) begin
    retiming_so <= tdr[0];
  end
end
 
// --------- DataOutPort 3 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    mcp_bounding_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      mcp_bounding_en_latch <= tdr[3];
    end
  end
end
 
// --------- DataOutPort 2 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    control_test_point_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      control_test_point_en_latch <= tdr[2];
    end
  end
end
 
// --------- DataOutPort 1 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    observe_test_point_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      observe_test_point_en_latch <= tdr[1];
    end
  end
end
 
// --------- DataOutPort 0 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    x_bounding_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      x_bounding_en_latch <= tdr[0];
    end
  end
end
 
endmodule

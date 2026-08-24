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
//       Created on: Tue Apr  7 17:29:57 IST 2026
//--------------------------------------------------------------------------

module msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl (
  input wire ijtag_reset,
  input wire ijtag_sel,
  input wire ijtag_si,
  input wire ijtag_ce,
  input wire ijtag_se,
  input wire ijtag_ue,
  input wire ijtag_tck,
  output wire async_set_reset_static_disable,
  output wire ijtag_so
);
wire                async_set_reset_static_disable_to_buf;
reg    [0:0]        tdr;
reg                 retiming_so ;
reg                 async_set_reset_static_disable_latch;
 
 
buf02 tessent_persistent_cell_async_set_reset_static_disable ( .A (async_set_reset_static_disable_latch), .Y (async_set_reset_static_disable) );
 
// --------- ShiftRegister ---------
 
always @ (posedge ijtag_tck) begin
  if (ijtag_ce & ijtag_sel) begin
    tdr <= { 1'b0};
  end else if (ijtag_se & ijtag_sel) begin
    tdr <= ijtag_si;
  end
end
 
assign ijtag_so = retiming_so;
always @ (ijtag_tck or tdr[0]) begin
  if (~ijtag_tck) begin
    retiming_so <= tdr[0];
  end
end
 
// --------- DataOutPort 0 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    async_set_reset_static_disable_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      async_set_reset_static_disable_latch <= tdr[0];
    end
  end
end
 
endmodule

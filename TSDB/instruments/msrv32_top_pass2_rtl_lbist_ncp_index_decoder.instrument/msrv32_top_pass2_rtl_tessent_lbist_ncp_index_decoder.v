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
//       Created on: Tue Apr  7 17:43:15 IST 2026
//--------------------------------------------------------------------------

module msrv32_top_pass2_rtl_tessent_lbist_ncp_index_decoder (
   input  wire   [1:0] ncp_index,
   output wire   [2:0] occ1_clock_sequence,
   output wire   [2:0] occ2_clock_sequence
);
   reg    [2:0] occ1_clock_sequence_reg;
   reg    [2:0] occ2_clock_sequence_reg;

   wire   [1:0] ncp_index_buf_out;
   wire   [2:0] occ1_clock_sequence_buf_in;
   wire   [2:0] occ2_clock_sequence_buf_in;

   buf02 tessent_persistent_cell_ncp_index_buf_0 (
      .A                                ( ncp_index[0] ),
      .Y                                ( ncp_index_buf_out[0] )
   );
   buf02 tessent_persistent_cell_ncp_index_buf_1 (
      .A                                ( ncp_index[1] ),
      .Y                                ( ncp_index_buf_out[1] )
   );
   buf02 tessent_persistent_cell_occ1_clock_sequence_buf_0 (
      .A                                ( occ1_clock_sequence_buf_in[0] ),
      .Y                                ( occ1_clock_sequence[0] )
   );
   buf02 tessent_persistent_cell_occ1_clock_sequence_buf_1 (
      .A                                ( occ1_clock_sequence_buf_in[1] ),
      .Y                                ( occ1_clock_sequence[1] )
   );
   buf02 tessent_persistent_cell_occ1_clock_sequence_buf_2 (
      .A                                ( occ1_clock_sequence_buf_in[2] ),
      .Y                                ( occ1_clock_sequence[2] )
   );
   buf02 tessent_persistent_cell_occ2_clock_sequence_buf_0 (
      .A                                ( occ2_clock_sequence_buf_in[0] ),
      .Y                                ( occ2_clock_sequence[0] )
   );
   buf02 tessent_persistent_cell_occ2_clock_sequence_buf_1 (
      .A                                ( occ2_clock_sequence_buf_in[1] ),
      .Y                                ( occ2_clock_sequence[1] )
   );
   buf02 tessent_persistent_cell_occ2_clock_sequence_buf_2 (
      .A                                ( occ2_clock_sequence_buf_in[2] ),
      .Y                                ( occ2_clock_sequence[2] )
   );
   assign occ1_clock_sequence_buf_in = occ1_clock_sequence_reg;
   assign occ2_clock_sequence_buf_in = occ2_clock_sequence_reg;
   always @(ncp_index_buf_out)
   begin
      case (ncp_index_buf_out)
         2'd0: begin
            occ1_clock_sequence_reg = 3'b011;
            occ2_clock_sequence_reg = 3'b000;
         end
         2'd1: begin
            occ1_clock_sequence_reg = 3'b000;
            occ2_clock_sequence_reg = 3'b011;
         end
         2'd2: begin
            occ1_clock_sequence_reg = 3'b001;
            occ2_clock_sequence_reg = 3'b001;
         end
         2'd3: begin
            occ1_clock_sequence_reg = 3'b011;
            occ2_clock_sequence_reg = 3'b000;
         end
      endcase
   end
endmodule
  
  

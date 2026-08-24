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
--  File        :  msrv32_top_pass1_rtl_tessent_bscan_cells.v
--  Description :  Pads and boundary scan cells RTL descriptions
--
--=============================================================================
*/
 
//******************************************************************************
// BOUNDARY SCAN CELLS (Bcell) 
//******************************************************************************

// Bcell: I(S)
  
module   msrv32_top_pass1_rtl_tessent_bscan_cell_in_s (
			fromPad,
			selectJtagInput,
			clockBscan,
			shiftBscan2Edge,
			bscanShiftIn,
			bscanShiftOut
			);
  input   fromPad;
  input   selectJtagInput;
  input   clockBscan;
  input   shiftBscan2Edge;
  input   bscanShiftIn;
  output  bscanShiftOut;
 
  wire  SJI_Mux;           // selectJtagInput mux
  wire  bscanShiftMux;     // Mux selects bscanShiftIn or capture data
  reg   retimeElem;        // Retiming element, after the bscan register
  reg   bscanReg;          // boundary scan register's output

  assign bscanShiftMux  = shiftBscan2Edge   ? bscanShiftIn : SJI_Mux;
  assign SJI_Mux        = selectJtagInput   ? retimeElem  : fromPad;
  assign bscanShiftOut  = retimeElem;

  // bscan flop
  always @(posedge clockBscan)
      bscanReg  <= bscanShiftMux;

  // Retiming Latch
  always @(bscanReg or clockBscan)
      if (~clockBscan) retimeElem <= bscanReg;
 
 
endmodule

// Bcell: I
  
module   msrv32_top_pass1_rtl_tessent_bscan_cell_in (
			fromPad,
			toCore,
			selectJtagInput,
			clockBscan,
			shiftBscan2Edge,
			updateBscan,
			bscanShiftIn,
			bscanShiftOut
			);
  input   fromPad;
  output  toCore;
  input   selectJtagInput;
  input   clockBscan;
  input   shiftBscan2Edge;
  input   updateBscan;
  input   bscanShiftIn;
  output  bscanShiftOut;
 
  wire  SJI_Mux;           // selectJtagInput mux
  wire  bscanShiftMux;     // Mux selects bscanShiftIn or capture data
  reg   retimeElem;        // Retiming element, after the bscan register
  reg   bscanReg;          // boundary scan register's output
  reg   updLatch;          // update latch's output

  assign bscanShiftMux  = shiftBscan2Edge   ? bscanShiftIn : SJI_Mux;
  assign SJI_Mux        = selectJtagInput   ? updLatch  : fromPad;
  assign toCore         = SJI_Mux;
  assign bscanShiftOut  = retimeElem;

  // bscan flop
  always @(posedge clockBscan)
      bscanReg  <= bscanShiftMux;

  // Retiming Latch
  always @(bscanReg or clockBscan)
      if (~clockBscan) retimeElem <= bscanReg;
 
  // update latch
  always @(bscanReg or updateBscan)
      if (updateBscan) updLatch <= bscanReg;
 
 
endmodule

// Bcell: EN(1)
  
module   msrv32_top_pass1_rtl_tessent_bscan_cell_en_1 (
			userEnable,
			padEnable1,
			selectJtagOutput,
			forceDisable,
			clockBscan,
			shiftBscan2Edge,
			updateBscan,
			bscanShiftIn,
			bscanShiftOut
			);
  input   userEnable;
  output  padEnable1;
  input   selectJtagOutput;
  input   forceDisable;
  input   clockBscan;
  input   shiftBscan2Edge;
  input   updateBscan;
  input   bscanShiftIn;
  output  bscanShiftOut;
 
  wire  SJO_Mux;           // selectJtagOutput mux 
  wire  bscanShiftMux;     // Mux selects bscanShiftIn or capture data
  reg   retimeElem;        // Retiming element, after the bscan register
  reg   bscanReg;          // boundary scan register's output
  reg   updLatch;          // update latch's output

  assign bscanShiftMux  = shiftBscan2Edge   ? bscanShiftIn : SJO_Mux;
  assign SJO_Mux        = selectJtagOutput   ? updLatch  : userEnable;
  assign padEnable1     = SJO_Mux & ~forceDisable;
  assign bscanShiftOut  = retimeElem;

  // bscan flop
  always @(posedge clockBscan)
      bscanReg  <= bscanShiftMux;

  // Retiming Latch
  always @(bscanReg or clockBscan)
      if (~clockBscan) retimeElem <= bscanReg;
 
  // update latch
  always @(bscanReg or updateBscan)
      if (updateBscan) updLatch <= bscanReg;
 
 
endmodule

// Bcell: O
  
module   msrv32_top_pass1_rtl_tessent_bscan_cell_out (
			fromCore,
			selectJtagOutput,
			toPad,
			clockBscan,
			shiftBscan2Edge,
			updateBscan,
			bscanShiftIn,
			bscanShiftOut
			);
  input   fromCore;
  input   selectJtagOutput;
  output  toPad;
  input   clockBscan;
  input   shiftBscan2Edge;
  input   updateBscan;
  input   bscanShiftIn;
  output  bscanShiftOut;
 
  wire  SJO_Mux;           // selectJtagOutput mux 
  wire  bscanShiftMux;     // Mux selects bscanShiftIn or capture data
  reg   retimeElem;        // Retiming element, after the bscan register
  reg   bscanReg;          // boundary scan register's output
  reg   updLatch;          // update latch's output

  assign bscanShiftMux  = shiftBscan2Edge   ? bscanShiftIn : SJO_Mux;
  assign SJO_Mux        = selectJtagOutput   ? updLatch  : fromCore;
  assign toPad          = SJO_Mux;
  assign bscanShiftOut  = retimeElem;

  // bscan flop
  always @(posedge clockBscan)
      bscanReg  <= bscanShiftMux;

  // Retiming Latch
  always @(bscanReg or clockBscan)
      if (~clockBscan) retimeElem <= bscanReg;
 
  // update latch
  always @(bscanReg or updateBscan)
      if (updateBscan) updLatch <= bscanReg;
 
 
endmodule

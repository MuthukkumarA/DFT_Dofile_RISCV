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

module msrv32_top_pass1_rtl_tessent_tap_main (
  input wire tdi,
  input wire tms,
  input wire tck,
  input wire trst,
  output wire tdo,
  output wire [3:0] fsm_state,
  output reg host_bscan_to_sel,
  input wire host_bscan_from_so,
  output reg force_disable,
  output reg select_jtag_input,
  output reg select_jtag_output,
  output reg extest_pulse,
  output reg extest_train,
  output wire host_1_to_sel,
  input wire host_1_from_so,
  output wire capture_dr_en,
  output wire test_logic_reset,
  output wire shift_dr_en,
  output wire update_dr_en,
  output wire tdo_en
);
reg [3:0] instruction, instruction_latch;
reg bypass;
reg  host_1_to_sel_int;
reg  retiming_tdo;
wire capture_en_int;
wire tlr_int;
wire shift_en_int;
wire update_en_int;
wire tdo_int, tdr_mux;
wire tck_int;
wire irSel, irce, irse, irue, tlr;
wire [3:0] fsm_state_int;
wire bypass_or_unknown_instruction;
wire BYPASS_decoded;
wire CLAMP_decoded;
wire EXTEST_decoded;
wire EXTEST_PULSE_decoded;
wire EXTEST_TRAIN_decoded;
wire INTEST_decoded;
wire SAMPLE_PRELOAD_decoded;
wire HIGHZ_decoded;
wire HOSTIJTAG_1_decoded;
reg  BYPASS_decoded_latched;
wire host_bscan_to_sel_int;
wire force_disable_int;
wire select_jtag_input_int;
wire select_jtag_output_int;
wire extest_pulse_int;
wire extest_train_int;
assign host_bscan_to_sel_int = 
  (
    EXTEST_decoded |
    INTEST_decoded |
    EXTEST_PULSE_decoded |
    EXTEST_TRAIN_decoded |
    SAMPLE_PRELOAD_decoded  
  );
assign force_disable_int = HIGHZ_decoded;
assign select_jtag_input_int = INTEST_decoded;
assign select_jtag_output_int = 
  (
    EXTEST_decoded |
    EXTEST_PULSE_decoded |
    EXTEST_TRAIN_decoded |
    CLAMP_decoded |
    HIGHZ_decoded  
  );
assign extest_pulse_int = EXTEST_PULSE_decoded;
assign extest_train_int = EXTEST_TRAIN_decoded;
assign fsm_state = fsm_state_int;
 
// --------- Instruction Decoding ----------
assign bypass_or_unknown_instruction =
 ~(
     CLAMP_decoded |
     EXTEST_decoded |
     EXTEST_PULSE_decoded |
     EXTEST_TRAIN_decoded |
     INTEST_decoded |
     SAMPLE_PRELOAD_decoded |
     HIGHZ_decoded |
     HOSTIJTAG_1_decoded 
  );
assign BYPASS_decoded = 
     bypass_or_unknown_instruction |
  (
  // instruction_code(0) 4'b1111
     instruction[3] &
     instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign CLAMP_decoded = 
  (
  // instruction_code(0) 4'b0000
    ~instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign EXTEST_decoded = 
  (
  // instruction_code(0) 4'b0001
    ~instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign EXTEST_PULSE_decoded = 
  (
  // instruction_code(0) 4'b0010
    ~instruction[3] &
    ~instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );
assign EXTEST_TRAIN_decoded = 
  (
  // instruction_code(0) 4'b0011
    ~instruction[3] &
    ~instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign INTEST_decoded = 
  (
  // instruction_code(0) 4'b0100
    ~instruction[3] &
     instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign SAMPLE_PRELOAD_decoded = 
  (
  // instruction_code(0) 4'b0101
    ~instruction[3] &
     instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign HIGHZ_decoded = 
  (
  // instruction_code(0) 4'b0110
    ~instruction[3] &
     instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );
assign HOSTIJTAG_1_decoded = 
  (
  // instruction_code(0) 4'b0111
    ~instruction[3] &
     instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign tdr_mux =  BYPASS_decoded_latched ? bypass:
                  (BYPASS_decoded & bypass) |
                  (CLAMP_decoded & bypass) |
                  (EXTEST_decoded & host_bscan_from_so) |
                  (EXTEST_PULSE_decoded & host_bscan_from_so) |
                  (EXTEST_TRAIN_decoded & host_bscan_from_so) |
                  (INTEST_decoded & host_bscan_from_so) |
                  (SAMPLE_PRELOAD_decoded & host_bscan_from_so) |
                  (HIGHZ_decoded & bypass) |
                  (HOSTIJTAG_1_decoded & host_1_from_so);
 
assign tdo_int = (irSel) ? instruction[0] : tdr_mux;
 
always @ (tck_int or tdo_int) begin
   if (~tck_int) begin
      retiming_tdo <= tdo_int;
   end
end
assign tdo = retiming_tdo;
 
always @ (posedge tck_int) begin
   if (irce) begin
       instruction <= 4'b0001;
   end else begin
       if (irse) begin
          instruction <= {tdi,instruction[3:1]};
       end
   end
   if (capture_dr_en) begin
       bypass <= 1'b0;
   end else begin
       if (shift_dr_en) begin
          bypass <= tdi;
       end
   end
end
always @ (negedge tck_int or negedge trst) begin
   if (~trst) begin
      instruction_latch       <= 4'b1111;
      host_bscan_to_sel       <= 1'b0;
      force_disable           <= 1'b0;
      select_jtag_input       <= 1'b0;
      select_jtag_output      <= 1'b0;
      extest_pulse            <= 1'b0;
      extest_train            <= 1'b0;
      host_1_to_sel_int       <= 1'b0;
      BYPASS_decoded_latched  <= 1'b1;
   end else begin
      if (~tlr_int) begin
         instruction_latch    <= 4'b1111;
         host_bscan_to_sel    <= 1'b0;
         force_disable        <= 1'b0;
         select_jtag_input    <= 1'b0;
         select_jtag_output   <= 1'b0;
         extest_pulse         <= 1'b0;
         extest_train         <= 1'b0;
         host_1_to_sel_int    <= 1'b0;
         BYPASS_decoded_latched <= 1'b1;
      end else begin
         if (irue) begin
            instruction_latch <= instruction;
            host_bscan_to_sel <= host_bscan_to_sel_int;
            force_disable     <= force_disable_int;
            select_jtag_input <= select_jtag_input_int;
            select_jtag_output <= select_jtag_output_int;
            extest_pulse      <= extest_pulse_int;
            extest_train      <= extest_train_int;
            host_1_to_sel_int <= HOSTIJTAG_1_decoded;
            BYPASS_decoded_latched <= BYPASS_decoded;
         end
      end
   end
end
 
// Stop clock tree synthesis at this buffer to have the TAP on an early version of TCK
clock_buf02 tessent_persistent_cell_tck_cts_stop_buf (.A (tck),.Y (tck_int));
// Persistent buffers for SDC anchors
buf02 tessent_persistent_cell_shift_en_buf (.A (shift_en_int),.Y (shift_dr_en));
buf02 tessent_persistent_cell_capture_en_buf (.A (capture_en_int),.Y (capture_dr_en));
buf02 tessent_persistent_cell_update_en_buf (.A (update_en_int),.Y (update_dr_en));
buf02 tessent_persistent_cell_tlr_buf (.A (tlr_int),.Y (test_logic_reset));
buf02 tessent_persistent_cell_host_1_to_sel_buf (.A (host_1_to_sel_int),.Y (host_1_to_sel));
 
msrv32_top_pass1_rtl_tessent_tap_main_fsm fsm (.tck(tck_int), .trst(trst), .tms(tms), .irSel(irSel), .irce(irce), .irse(irse), .irue(irue), .tlr(tlr_int), .ce(capture_en_int), .se(shift_en_int), .ue(update_en_int), .state(fsm_state_int));
 
assign tdo_en = (irse | shift_dr_en);
 
endmodule
 
module msrv32_top_pass1_rtl_tessent_tap_main_fsm (
  input wire tck,
  input wire trst,
  input wire tms,
  output reg irSel,
  output reg irce,
  output reg irse,
  output reg irue,
  output reg tlr,
  output reg ce,
  output reg se,
  output reg ue,
  output reg [3:0] state
);
reg [3:0] tms_sr;
wire five_tms;
localparam test_logic_reset   = 4'b1111;
localparam run_test_idle      = 4'b1100;
localparam select_dr          = 4'b0111;
localparam capture_dr         = 4'b0110;
localparam shift_dr           = 4'b0010;
localparam exit1_dr           = 4'b0001;
localparam pause_dr           = 4'b0011;
localparam exit2_dr           = 4'b0000;
localparam update_dr          = 4'b0101;
localparam select_ir          = 4'b0100;
localparam capture_ir         = 4'b1110;
localparam shift_ir           = 4'b1010;
localparam exit1_ir           = 4'b1001;
localparam pause_ir           = 4'b1011;
localparam exit2_ir           = 4'b1000;
localparam update_ir          = 4'b1101;
always @ (negedge tck or negedge trst) begin
  if (~trst) begin
      irce  <= 1'b0;
      irse  <= 1'b0;
      ce    <= 1'b0;
      se    <= 1'b0;
  end else begin
      ce    <= (state == capture_dr);
      se    <= (state == shift_dr);
      irce  <= (state == capture_ir);
      irse  <= (state == shift_ir);
  end
end
assign five_tms = &tms_sr & tms;
always @ (posedge tck or negedge trst) begin
   if (~trst) begin
      state    <= test_logic_reset;
      irSel    <= 1'b0;
      irue     <= 1'b0;
      tlr      <= 1'b0;
      ue       <= 1'b0;
      tms_sr   <= 4'b0;
   end else begin
      if (tms) begin
         tms_sr <= {1'b1,tms_sr[3:1]};
      end else begin
         tms_sr <= 4'b0;
      end
      if (five_tms) begin
        state <= test_logic_reset;
        irSel <= 1'b0;
        irue  <= 1'b0;
        tlr   <= 1'b0;
        ue    <= 1'b0;
      end else begin
           if ((state == select_ir) & ~tms) irSel <= 1'b1;
           else if (state == update_ir)    irSel <= 1'b0;
           irue <= ((state == exit1_ir) | (state == exit2_ir)) & tms;
           ue   <= ((state == exit1_dr) | (state == exit2_dr)) & tms;
           tlr  <= ~(((state == select_ir) | (state == test_logic_reset)) & tms);
           case (state)
           test_logic_reset : if (tms)  state <= test_logic_reset;
                              else      state <= run_test_idle;
           run_test_idle    : if (tms)  state <= select_dr;
                              else      state <= run_test_idle;
           select_dr        : if (tms)  state <= select_ir;
                              else      state <= capture_dr;
           capture_dr       : if (tms)  state <= exit1_dr;
                              else      state <= shift_dr;
           shift_dr         : if (tms)  state <= exit1_dr;
                              else      state <= shift_dr;
           exit1_dr         : if (tms)  state <= update_dr;
                              else      state <= pause_dr;
           pause_dr         : if (tms)  state <= exit2_dr;
                              else      state <= pause_dr;
           exit2_dr         : if (tms)  state <= update_dr;
                              else      state <= shift_dr;
           update_dr        : if (tms)  state <= select_dr;
                              else      state <= run_test_idle;
           select_ir        : if (tms)  state <= test_logic_reset;
                              else      state <= capture_ir;
           capture_ir       : if (tms)  state <= exit1_ir;
                              else      state <= shift_ir;
           shift_ir         : if (tms)  state <= exit1_ir;
                              else      state <= shift_ir;
           exit1_ir         : if (tms)  state <= update_ir;
                              else      state <= pause_ir;
           pause_ir         : if (tms)  state <= exit2_ir;
                              else      state <= pause_ir;
           exit2_ir         : if (tms)  state <= update_ir;
                              else      state <= shift_ir;
           update_ir        : if (tms)  state <= select_dr;
                              else      state <= run_test_idle;
          endcase
      end
   end
end
endmodule
    

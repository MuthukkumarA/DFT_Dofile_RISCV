//
// Verilog format test patterns produced by Tessent Shell 2022.2
// Filename       : ./TSDB/patterns/msrv32_top_pass2_rtl.patterns_signoff/ICLNetwork.v
// Idstamp        : 2022.2:ec94:6099:0:0000
// Date           : Tue Apr  7 17:43:37 2026
//
// Begin_Verify_Section 
//   format            = Verilog 
//   top_module_name   = TB 
//   serial_flag       = OFF 
//   test_set_type     = IJTAG_TEST 
//   pad_value         = X 
//   one_setup         = ON 
//   no_initialization = ON 
// End_Verify_Section 
// Parameter File Keyword Settings 
//   SIM_CHANGE_PATH           true ; 
//   SIM_TOP_NAME              TB ; 
//   SIM_INSTANCE_NAME         DUT_inst ; 
//   SIM_CLOCK_MONITOR         true ; 
// End Parameter File Keyword Settings 


`define SIM_INSTANCE_NAME DUT_inst


`timescale 1ns / 1ns

module TB;

integer     _write_DIAG_file;
integer     _DIAG_file_header;
integer     _diag_file;
integer     _diag_chain_header;
integer     _diag_scan_header;
integer     _last_fail_pattern;
integer     _fail_pattern_cnt;
integer     _write_MASK_file;
integer     _MASK_file_header;
integer     _mask_file;
integer     _par_shift_cnt;
integer     _chain_test_;
integer     _compare_fail;
integer     _compare_fail_count;
integer     _compare_count;
integer     _compare_z_count;
integer     _bit_count;
integer     _report_bit_cnt;
integer     _miscompare_limit;
integer     _found_fail;
integer     _found_fail_per_cycle;
integer     _end_vec_file_ok;
integer     _cycle_count, _save_cycle_count;
integer     _pattern_count, _repeat_count_nest[0:8], _repeat_count, _message_index;
integer     _index, _scan_index, _file_cnt, _max_index, _vec_pat_count, _save_index[0:8];
integer     _repeat_depth;
integer     _file_check;
integer     _run_testsetup;
integer     _in_testsetup;
integer     _start_pat;
integer     _end_pat;
integer     _end_after_setup;
integer     _no_setup;
integer     _save_state;
integer     _restart_state;
integer     _in_restart;
integer     _override_cfg;
integer     _in_range;
integer     _do_compare;
integer     _in_chaintest;
integer     _pat_num;
integer     _skipped_patterns;
integer     _end_simulation;
integer     _config_file;
integer     _fstat;
integer     _max_file_cnt;
reg[256*8:1] _vec_file_name;
reg[256*8:1] _cfg_file_name;
integer     _scan_shift_count;
reg[5:0]    _ibus;
reg[0:0]    _exp_obus, _msk_obus;
wire[0:0]   _sim_obus;
reg[2:0]    _pat_type;
reg         _tp_num;
reg         mgcdft_save_signal, mgcdft_restart_signal;
reg[38:0]   vect;

wire tms_p, trst_p, tdi_p, tck_p, scan_en, control_chain_enable, tdo_p;

event       before_finish;
assign tms_p = _ibus[5];
assign trst_p = _ibus[4];
assign tdi_p = _ibus[3];
assign tck_p = _ibus[2];
assign scan_en = _ibus[1];
assign control_chain_enable = _ibus[0];

assign _sim_obus[0] = tdo_p;

// Change Path Variables & Get Argument 
integer      _change_path; 
integer      _change_out_path; 
reg[512*8:1]  _new_path; 
reg[512*8:1]  _new_out_path; 
reg[512*8:1]  _new_filename; 
reg[512*8:1]  _vcd_dump_file_name; 
reg[512*8:1]  _utvcd_dump_file_name; 
reg[512*8:1]  _fsdb_dump_file_name; 
reg[512*8:1]  _qwave_dump_file_name; 
reg[512*8:1]  _tmp_filename; 
initial begin 
  _change_path = 0; 
  _change_out_path = 0; 
  if ($value$plusargs("NEWPATH=%s", _new_path)) begin 
    $display("Found New Path %0s\n", _new_path); 
    _change_path = 1; 
  end 
  if ($value$plusargs("NEWOUTPATH=%s", _new_out_path)) begin 
    $display("Found New Out Path %0s\n", _new_out_path); 
    _change_out_path = 1; 
  end 

`ifdef VCD
    $sformat(_vcd_dump_file_name, "ICLNetwork.v.dump");
    if(_change_out_path) begin 
      $sformat(_vcd_dump_file_name, "%0s/%0s", _new_out_path, _vcd_dump_file_name);
    end
    $dumpfile(_vcd_dump_file_name);
    $dumpvars;
`endif

`ifdef UTVCD
    $sformat(_utvcd_dump_file_name, "ICLNetwork.v.dump");
    if(_change_out_path) begin 
      $sformat(_utvcd_dump_file_name, "%0s/%0s", _new_out_path, _utvcd_dump_file_name);
    end
    $dumpfile(_utvcd_dump_file_name);
    $vtDump;
    $dumpvars;
`endif

`ifdef debussy
    $sformat(_fsdb_dump_file_name, "ICLNetwork.v.fsdb");
    if(_change_out_path) begin 
      $sformat(_fsdb_dump_file_name, "%0s/%0s", _new_out_path, _fsdb_dump_file_name);
    end
    $fsdbDumpfile(_fsdb_dump_file_name);
    $fsdbDumpvars;
`endif

`ifdef QWAVE
    $sformat(_qwave_dump_file_name, "ICLNetwork.v.qwave.db");
    if(_change_out_path) begin 
      $sformat(_qwave_dump_file_name, "%0s/%0s", _new_out_path, _qwave_dump_file_name);
    end
    $qwavedb_dumpvars_filename(_qwave_dump_file_name);
    $qwavedb_dumpvars;
`endif
end 

reg /* sparse */[39:0] _nam_obus[0:0];
initial begin 
   if(_change_path) begin 
     $sformat(_new_filename,"%0s/ICLNetwork.v.po.name",_new_path); 
     $display("Loading %0s\n", _new_filename ); 
     $readmemh(_new_filename,_nam_obus,0,0); 
   end 
   else begin
     $display("Loading ICLNetwork.v.po.name");
     $readmemh("ICLNetwork.v.po.name",_nam_obus,0,0);
   end 
end 


// Declare Wires for tracking Vector Type
reg[3:0] _MGCDFT_VECTYPE ;
reg[160:0] _procedure_string ;
reg mgcdft_test_setup, mgcdft_load_unload, mgcdft_shift,
     mgcdft_single_shift, mgcdft_shift_extra, 
     mgcdft_shadow_control, mgcdft_master_observe,
     mgcdft_shadow_observe, mgcdft_skew_load, 
     mgcdft_seq_transparent, mgcdft_launch_capture,
     mgcdft_clock_proc, mgcdft_test_end, mgcdft_unknown; 

event       set_vector_type;
always @(_MGCDFT_VECTYPE) begin
  assign mgcdft_test_setup      = 1'b0;
  assign mgcdft_load_unload     = 1'b0;
  assign mgcdft_shift           = 1'b0;
  assign mgcdft_single_shift    = 1'b0;
  assign mgcdft_shift_extra     = 1'b0;
  assign mgcdft_shadow_control  = 1'b0;
  assign mgcdft_master_observe  = 1'b0;
  assign mgcdft_shadow_observe  = 1'b0;
  assign mgcdft_skew_load       = 1'b0;
  assign mgcdft_seq_transparent = 1'b0;
  assign mgcdft_launch_capture  = 1'b0;
  assign mgcdft_clock_proc      = 1'b0;
  assign mgcdft_test_end        = 1'b0;
  assign mgcdft_unknown         = 1'b0;
  case (_MGCDFT_VECTYPE)
    4'b0001: begin
               assign mgcdft_test_setup      = 1'b1;
               _procedure_string = "TEST_SETUP";
               _scan_shift_count = 0;
             end
    4'b0010: begin
               assign mgcdft_load_unload     = 1'b1;
               _procedure_string = "LOAD";
               _scan_shift_count = 0;
             end
    4'b0011: begin
               assign mgcdft_shift           = 1'b1;
               _procedure_string = "SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0100: begin
               assign mgcdft_single_shift    = 1'b1;
               _procedure_string = "SINGLE_SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0101: begin
               assign mgcdft_shift_extra     = 1'b1;
               _procedure_string = "SHIFT_EXTRA";
               _scan_shift_count = 0;
             end
    4'b0110: begin
               assign mgcdft_shadow_control  = 1'b1;
               _procedure_string = "SHADOW_CONTROL";
               _scan_shift_count = 0;
             end
    4'b0111: begin
               assign mgcdft_master_observe  = 1'b1;
               _procedure_string = "MASTER_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1000: begin
               assign mgcdft_shadow_observe  = 1'b1;
               _procedure_string = "SHADOW_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1001: begin
               assign mgcdft_skew_load       = 1'b1;
               _procedure_string = "SKEW_LOAD";
               _scan_shift_count = 0;
             end
    4'b1010: begin
               assign mgcdft_seq_transparent = 1'b1;
               _procedure_string = "SEQ_TRANSPARENT";
               _scan_shift_count = 0;
             end
    4'b1011: begin
               assign mgcdft_launch_capture  = 1'b1;
               _procedure_string = "LAUNCH_CAPTURE";
               _scan_shift_count = 0;
             end
    4'b1101: begin
               assign mgcdft_clock_proc      = 1'b1;
               _procedure_string = "CLOCK_PROC";
               _scan_shift_count = 0;
             end
    4'b1111: begin
               assign mgcdft_test_end        = 1'b1;
               _procedure_string = "TEST_END";
               _scan_shift_count = 0;
             end
    4'b0000: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
    default: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
  endcase
end

function integer do_finish_summary;
input local_end_vec_file_ok;
integer local_end_vec_file_ok;
begin
  if (_end_vec_file_ok) begin
     $display("\nSimulation finished at time %.0f", $realtime);
     $display("Number of miscompares            = %d", _compare_fail_count);
     $display("Number of 0/1 compares           = %d", _compare_count);
     $display("Number of Z compares             = %d\n", _compare_z_count);
  end

  if ((_end_vec_file_ok) && (_compare_fail == 0) && (_compare_fail_count == 0)) begin
     $display("No error between simulated and expected patterns\n");
  end

  if ((_compare_fail != 0) || (_compare_fail_count != 0)) begin
     $display("Error between simulated and expected patterns\n");
  end

do_finish_summary = local_end_vec_file_ok;
end
endfunction


event       compare_exp_sim_obus;
always @(compare_exp_sim_obus) begin
 _found_fail = 0;
 if (_do_compare) begin
 for(_bit_count = 0;
     (_bit_count < 1);
      _bit_count =_bit_count +1) begin
   if (_msk_obus[_bit_count] === 1'b1) begin
     if (_exp_obus[_bit_count] === 1'bZ) begin
       _compare_z_count = _compare_z_count + 1;
     end
     else begin
       _compare_count = _compare_count + 1;
     end
   end
 end
  if (_exp_obus !== _sim_obus) begin
     for(_bit_count = 0;
         ((_bit_count < 1)&&(_found_fail==0));
          _bit_count =_bit_count +1) begin
        if ((_msk_obus[_bit_count] === 1'b1) &&
            (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
           _found_fail = 1;
           _found_fail_per_cycle = 1;
        end
     end
  end
  if (_found_fail == 1) begin
     for(_bit_count = 0;
         ((_bit_count < 1)&&((_miscompare_limit==0)||(_compare_fail<=_miscompare_limit)));
          _bit_count =_bit_count +1) begin
      if ((_msk_obus[_bit_count] === 1'b1) &&
          (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
        _compare_fail_count = _compare_fail_count + 1;
        $write($realtime, "ns: Mismatch at pin %d name %s, Simulated %b, Expected %b\n",_bit_count,_nam_obus[_bit_count],_sim_obus[_bit_count],_exp_obus[_bit_count]);
        if (_write_DIAG_file == 1) begin
          if (_DIAG_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "ICLNetwork.v_%0d_%0d.fail",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "ICLNetwork.v_%0d.fail",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "ICLNetwork.v__%0d.fail",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "ICLNetwork.v.fail");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _diag_file = $fopen(_tmp_filename);
            if (_diag_file == 0) begin
              $display("ERROR: Couldn't open .fail file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            if(_change_out_path) begin 
              $fwrite(_diag_file, "// This File is simulation generated (%0s/ICLNetwork.v)\n", _new_out_path);
            end
            else begin
              $fwrite(_diag_file, "// This File is simulation generated (ICLNetwork.v)\n");
            end
            $fwrite(_diag_file, "format cycle\n");
            $fwrite(_diag_file, " failures_begin\n");
            $fwrite(_diag_file, "//cycle_number  PO_name  expected_value  simulated_value  ");
            $fwrite(_diag_file, "pattern_id  chain_name  cell_number\n\n");
            _DIAG_file_header = 1;
          end
          if ((_pattern_count == _last_fail_pattern) && (_pattern_count == 0)) begin
             _fail_pattern_cnt = 1; 
          end
          if (_pattern_count > _last_fail_pattern) begin 
             _fail_pattern_cnt = _fail_pattern_cnt + 1;
             _last_fail_pattern = _pattern_count;
          end

          $fwrite(_diag_file, "%d  %s ", _cycle_count, _nam_obus[_bit_count]);
          case ( _exp_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, "            H"); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, "            L"); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, "            Z"); 
                  end
          endcase
          case ( _sim_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, " H  // Pattern %d ", _pattern_count); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, " L  // Pattern %d ", _pattern_count); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, " Z  // Pattern %d ", _pattern_count); 
                  end
            1'bX: begin
                    $fwrite(_diag_file, " X  // Pattern %d ", _pattern_count); 
                  end
          endcase
         if (_scan_shift_count == 0) begin
                 $fwrite(_diag_file, ", simulation_time=%.0f\n", $realtime);
         end // EndIf  _ScanShift_count
        end // EndIf _write_DIAG_file
        if (_write_MASK_file == 1) begin
          if (_MASK_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "ICLNetwork.v_%0d_%0d.mask",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "ICLNetwork.v_%0d.mask",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "ICLNetwork.v__%0d.mask",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "ICLNetwork.v.mask");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _mask_file = $fopen(_tmp_filename);
            if (_mask_file == 0) begin
              $display("ERROR: Couldn't open .mask file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            $fwrite(_mask_file, "%s\n%s\n", "type mask", "");
            _MASK_file_header = 1;
          end
          if (_chain_test_ == 0) begin
            $fwrite(_mask_file, "%d %s\n", _pattern_count,_nam_obus[_bit_count]);
          end
          if (_chain_test_ == 1) begin
            $fwrite(_mask_file, "// %d %s\n", _pattern_count,_nam_obus[_bit_count]);
          end
        end
      end
    end
    _compare_fail = _compare_fail + 1;
  end
 end // if _do_compare
end

reg[38:0]     mem [0:3441479];
msrv32_top DUT_inst (.tms_p(tms_p), .trst_p(trst_p), 
     .tdi_p(tdi_p), .tck_p(tck_p), .scan_en(scan_en), 
     .control_chain_enable(control_chain_enable), .tdo_p(tdo_p));

initial begin
_in_restart = 0;
while (_in_restart < 2) begin
_in_restart = _in_restart + 1;
_restart_state     = -1;
if ($value$plusargs("RESTART=%d", _restart_state)) begin
  $display(" Found RESTART   %d", _restart_state);
end

if ((_in_restart < 2) || (_restart_state == 1)) begin
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
if (_restart_state == 1) begin
  #0;
  mgcdft_restart_signal = 1'b1;
//  $display("Reading checkpoint ICLNetwork.v.dat");
//  $restart("ICLNetwork.v.dat");
end

#0;
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
_compare_fail = 0;
_compare_fail_count = 0;
_compare_count = 0;
_compare_z_count = 0;
_pattern_count = 0;
_cycle_count = 0;
_save_cycle_count = 0;
_write_DIAG_file = 0; // change to 1, to generate file
_write_MASK_file = 0; // change to 1, to generate file
_DIAG_file_header = 0;
_diag_file = 0;
_diag_chain_header = 0;
_diag_scan_header = 0;
_fail_pattern_cnt = 0;
_last_fail_pattern = 0;
_MASK_file_header = 0;
_mask_file = 0;
_chain_test_ = 0;
_par_shift_cnt = 0;
_report_bit_cnt = 0;
// Limit # of miscompares before aborting simulation (non-zero)
_miscompare_limit = 0; 
_end_vec_file_ok = 0; 
_scan_shift_count = 0;
_run_testsetup  = 0;
_in_testsetup = 0;
_start_pat      = -1;
_end_pat        = -1;
_end_after_setup = -1;
_no_setup       = -1;
_save_state     = -1;
_override_cfg   = 0;
_pat_num        = -1;
_in_range       = 1;
_do_compare     = 1;
_in_chaintest   = 0;

_skipped_patterns = 0;

_end_simulation   = 0;

if ($value$plusargs("STARTPAT=%d", _start_pat)) begin
  if (_start_pat > -1) begin
    $display(" Found Start pattern number %d", _start_pat);
    _in_range = 0;
    _do_compare = 0;
  end
  else begin
    $display(" Ignoring negative Start pattern number   %d", _start_pat);
    _start_pat = -1;
  end
end
if ($value$plusargs("ENDPAT=%d", _end_pat)) begin
  if (_end_pat > -1) begin
    $display(" Found End pattern number   %d", _end_pat);
  end
  else begin
    $display(" Ignoring negative End pattern number   %d", _end_pat);
    _end_pat = -1;
  end
end

if ($value$plusargs("CHAINTEST=%d", _in_chaintest)) begin
  if (_in_chaintest) begin
    $display(" Found ChainTest identifier %d", _in_chaintest);
  end
end

if ($value$plusargs("END_AFTER_SETUP=%d", _end_after_setup)) begin
  $display(" Found End after setup   %d", _end_after_setup);
  if (_end_after_setup > 0) begin
    _end_pat = 0;
    _in_chaintest = 1;
  end
end

if ($value$plusargs("SKIP_SETUP=%d", _no_setup)) begin
  $display(" Found Skip setup   %d", _no_setup);
  if (_no_setup > 0) begin
    if (_start_pat == -1) begin
      _start_pat = 0;
      _in_chaintest = 1;
    end
    if (_in_chaintest == 1) begin
      _chain_test_ = 1;
    end
    _run_testsetup = 0;
    _in_range = 0;
    _do_compare = 0;
  end
end

if ($value$plusargs("SAVE=%d", _save_state)) begin
  $display(" Found SAVE   %d", _save_state);
end

if ($value$plusargs("CONFIG=%0s", _cfg_file_name)) begin
  $display(" Found CONFIG identifier   %0s", _cfg_file_name);
  _override_cfg = 1;
end
else begin
  _cfg_file_name = "ICLNetwork.v.cfg";
end

if ((_end_pat != -1) && (_end_pat < _start_pat)) begin
  _start_pat = -1;
  _in_range = 1;
  _do_compare = 1;
  $display("STARTPAT less than ENDPAT, ignoring STARTPAT ");
end

// read vector config file
if(_override_cfg) begin 
  _config_file = $fopen(_cfg_file_name, "r");
end
else begin
if(_change_path) begin 
  $sformat(_new_filename,"%0s/ICLNetwork.v.cfg",_new_path); 
  _config_file = $fopen(_new_filename, "r");
end
else begin
  _config_file = $fopen("ICLNetwork.v.cfg", "r");
end

end

if (_config_file == 0) begin
  $display("ERROR: Couldn't open configuration file, simulation aborted\n");
  ->before_finish;
  #0;
  $finish;
end
_fstat = 0;
if (_start_pat != -1) begin
  if (_no_setup > 0) begin
  $display("BEGIN pattern read loop  Skip test_setup\n");
  end
  else if (_in_chaintest == 0) begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start pattern (%d) End pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start pattern (%d) \n",
_start_pat);
    end
  end
  else begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start chain pattern (%d) End chain pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start chain pattern (%d)\n",
_start_pat);
    end
  end
end
else if (_end_pat != -1) begin
  if (_end_after_setup > 0) begin
  $display("BEGIN pattern read loop  End after test_setup\n");
  end
  else if (_in_chaintest == 0) begin
  $display("BEGIN pattern read loop  End pattern (%d)\n", _end_pat);
  end
  else begin
  $display("BEGIN pattern read loop  End chain pattern (%d)\n", _end_pat);
  end
end

// begin pattern read loop
while (!$feof(_config_file) && (!_end_simulation))
begin
         _fstat = $fscanf(_config_file, "%s", _vec_file_name);
         _fstat = $fscanf(_config_file, "%d", _max_index);
   if (_fstat != -1) begin
         _fstat = $fscanf(_config_file, "%d", _vec_pat_count);
         if (_fstat == -1) begin
           _vec_pat_count = -1;
         end
         // skip .vec file if _start_pat greater than this
         if ((_start_pat != -1) && !_in_range && (_vec_pat_count != -1) &&
             !_in_testsetup && !_in_chaintest &&
             ((_pat_num + _vec_pat_count) < _start_pat)) begin
           _max_index = -1;
           if (_chain_test_) begin
             _pattern_count = 0;
             _pat_num = 0;
           end
           _pat_num = _pat_num + _vec_pat_count;
           _skipped_patterns = _skipped_patterns + _vec_pat_count;
           _end_vec_file_ok = 1;
           _chain_test_ = 0;
            $display("Skipping %0s\n", _vec_file_name);
         end
         else begin
          if(_change_path) begin 
            $sformat(_new_filename,"%0s/%0s",_new_path, _vec_file_name); 
            $display("Loading %0s\n", _new_filename ); 
            $readmemb(_new_filename, mem, 0, _max_index);
         end
         else begin
           $display("Loading %0s\n", _vec_file_name);
           $readmemb(_vec_file_name, mem, 0, _max_index);
         end
           _end_vec_file_ok = 0;
         end
   end
   else begin
     _max_index = -1;
     _vec_pat_count = -1;
   end
   _scan_index = 0;
   _repeat_count_nest[0] = 0;
   _repeat_count = 0;
   _repeat_depth = 0;
   _message_index = 0;
   _save_index[0] = 0;
   for (_index=0; _index <= _max_index; _index = _index+1)
   begin
      vect = mem[_index];
      _exp_obus=1'bX;
      _msk_obus=1'b0;
      _MGCDFT_VECTYPE = vect[3:0];
      _pat_type = vect[6:4];
      _tp_num = vect[7];
      //    Range Check
      if ((_start_pat != -1) && ((_start_pat != 0) || (!_in_testsetup)) &&
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
        if (!_chain_test_ && _in_chaintest && !_in_range && !_in_testsetup) begin
          _in_range = 1;
          _do_compare = 1;
        end
        if ((_pat_num == _start_pat) && !_in_range) begin
          _in_range = 1;
          _do_compare = 0;
          _pattern_count = (_pat_num - 1);
          if (_pattern_count < 0) begin
            _pattern_count = 0;
          end
        end
        if (_pat_num == (_start_pat + 1)) begin
          _do_compare = 1;
        end
      end

      if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_end_pat != -1) && !_chain_test_ && _in_chaintest &&
          !_run_testsetup) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_in_range) || (_run_testsetup)) begin
      case (_pat_type)
         3'b000:  begin // end vector
            _index = _max_index + 1;
         end // end vector
         3'b001: ;// skip scan vector, handled by shift vector
         3'b010:  begin // broadside vector
            _found_fail_per_cycle = 0;
            if (vect[8] == 1'b1) begin
               _pattern_count = _pattern_count + 1;
               _par_shift_cnt = 0;
              if ((!_do_compare) && (_pattern_count >= _start_pat)) begin
                _do_compare = 1;
              end
              if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
                  ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
                // simulation complete, exit
                _index = _max_index + 1;
                _end_vec_file_ok = 1;
                _end_simulation = 1;
                _in_range = 0;
              end
            end
            if (vect[8] === 1'bz) begin
               _pattern_count = 0;
               _par_shift_cnt = 0;
            end
            if(_scan_shift_count) begin
               _scan_shift_count = _scan_shift_count + 1;
            end
            case (_tp_num)
               1'b1: begin // timeplate 1 - gen_tp1
                  _ibus[2] = 1'b0;
                  _ibus[5:3] = vect[16:14];
                  _ibus[1:0] = vect[12:11];

                  #24; // 24 ns
                  _exp_obus[0] = vect[10];
                  _msk_obus[0] = vect[9];
                  #0;
                  ->compare_exp_sim_obus;
                  if ((_miscompare_limit)&&(_compare_fail>=_miscompare_limit)) begin
                    $display("ERROR: exceeded miscompare limit(%d), exiting simulation",_miscompare_limit);
                    _end_vec_file_ok = 1;
                    if (_DIAG_file_header == 1) begin
                       if (_diag_scan_header==1) begin
                         $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                       end
                       $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
                       $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
                       $fwrite(_diag_file, "failure_file_end\n");
                       $fclose(_diag_file);
                    end
                    _end_vec_file_ok = do_finish_summary(_end_vec_file_ok);
                    ->before_finish;
                    #0;
                    $finish;
                  end

                  #1; // 25 ns
                  _ibus[2] = vect[13];

                  #50; // 75 ns
                  _ibus[2] = 1'b0;

                  #25; // 100 ns
               end // timeplate 1 - gen_tp1
               default: begin
                  $display("ERROR: corrupt timeplate number\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _tp_num
            _cycle_count = _cycle_count + 1;
            _par_shift_cnt = 0;
         end // broadside vector
         3'b011:  begin // status message vector
            _message_index = vect[38:7];
            case (_message_index)
               0: begin
                  $display("Begin chain test\n");
                 _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                 _chain_test_ = 0;
                  if (_diag_chain_header) begin
                    $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                  end
                  _diag_scan_header = 0;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = -1;
                  _pattern_count = 0;
                  $display("End chain test\n");
               end
               2: begin
                  $display("Status update: simulated through pattern %d\n",_pattern_count);
               end
               3: begin
                  _end_vec_file_ok = 1;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (!_chain_test_) begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (_chain_test_) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                      end
                      else begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               20: begin
                  $display($realtime, "ns: Pattern_set msrv32_top");
               end
               21: begin
                  $display($realtime, "ns:  Activate selection of the following scan muxes:");
               end
               22: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.IRMux, selection 0: fsm.irSel = 1'b0 -> IRMux = DRMux");
               end
               23: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.DRMux, selection 9: instruction = 'bx -> DRMux = bypass");
               end
               24: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[0] ");
                  end
               end
               25: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[1] ");
                  end
               end
               26: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[2] ");
                  end
               end
               27: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[3] ");
                  end
               end
               28: begin
                  $display($realtime, "ns:  Scan in verification pattern to the following scan register:");
               end
               29: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.bypass, load value = 1");
               end
               30: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tap_main_inst.bypass ");
                  end
               end
               31: begin
                  $display($realtime, "ns:  Scan out verification pattern from the following scan register:");
               end
               32: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.bypass, expected value = 1");
               end
               33: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.DRMux, selection 8: instruction = 4'b0111 -> DRMux = host_1_from_so");
               end
               34: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_inst.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               35: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_inst.sib, load value = 1");
               end
               36: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_sib_sri_inst.sib ");
                  end
               end
               37: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_inst.sib, expected value = 1");
               end
               38: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_inst.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               39: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               40: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_edt_inst.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               41: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_occ_inst.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               42: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_lbist_inst.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               43: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               44: begin
                  $display($realtime, "ns:  Scan in verification pattern to the following scan registers:");
               end
               45: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.sib, load value = 0");
               end
               46: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_lbist_inst.sib, load value = 0");
               end
               47: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_occ_inst.sib, load value = 1");
               end
               48: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_edt_inst.sib, load value = 1");
               end
               49: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.sib, load value = 0");
               end
               50: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.sib ");
                  end
               end
               51: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_sib_edt_inst.sib ");
                  end
               end
               52: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_sib_occ_inst.sib ");
                  end
               end
               53: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_sib_lbist_inst.sib ");
                  end
               end
               54: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.sib ");
                  end
               end
               55: begin
                  $display($realtime, "ns:  Scan out verification pattern from the following scan registers:");
               end
               56: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.sib, expected value = 0");
               end
               57: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_lbist_inst.sib, expected value = 0");
               end
               58: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_occ_inst.sib, expected value = 1");
               end
               59: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_edt_inst.sib, expected value = 1");
               end
               60: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.sib, expected value = 0");
               end
               61: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_sri_ctrl_inst.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               62: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.sib, load value = 1");
               end
               63: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_lbist_inst.sib, load value = 1");
               end
               64: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[3:0], load value = 1100");
               end
               65: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[0] ");
                  end
               end
               66: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[1] ");
                  end
               end
               67: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[2] ");
                  end
               end
               68: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[3] ");
                  end
               end
               69: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.sib, expected value = 1");
               end
               70: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_lbist_inst.sib, expected value = 1");
               end
               71: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[3:0], expected value = 1100");
               end
               72: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_edt_inst.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               73: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_occ_inst.sib, load value = 0");
               end
               74: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.tdr[1:0], load value = 10");
               end
               75: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_occ_inst.sib, expected value = 0");
               end
               76: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.tdr[1:0], expected value = 10");
               end
               77: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.tdr[0] ");
                  end
               end
               78: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_tdr_inst.tdr[1] ");
                  end
               end
               79: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_occ_inst.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               80: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr_sib.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = scan_in");
               end
               81: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = scan_in");
               end
               82: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.sib, load value = 0");
               end
               83: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr_sib.sib, load value = 0");
               end
               84: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr_sib.sib ");
                  end
               end
               85: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.sib ");
                  end
               end
               86: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.sib, expected value = 0");
               end
               87: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr_sib.sib, expected value = 0");
               end
               88: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr_sib.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = from_scan_out");
               end
               89: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.sib, load value = 1");
               end
               90: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[9:0], load value = 0111100001");
               end
               91: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[0] ");
                  end
               end
               92: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[1] ");
                  end
               end
               93: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[2] ");
                  end
               end
               94: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[3] ");
                  end
               end
               95: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[4] ");
                  end
               end
               96: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[5] ");
                  end
               end
               97: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[6] ");
                  end
               end
               98: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[7] ");
                  end
               end
               99: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[8] ");
                  end
               end
               100: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[9] ");
                  end
               end
               101: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.sib, expected value = 1");
               end
               102: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ramclk_p_inst.tdr[9:0], expected value = 0111100001");
               end
               103: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr_sib.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = from_scan_out");
               end
               104: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[9:0], load value = 1111000011");
               end
               105: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[0] ");
                  end
               end
               106: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[1] ");
                  end
               end
               107: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[2] ");
                  end
               end
               108: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[3] ");
                  end
               end
               109: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[4] ");
                  end
               end
               110: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[5] ");
                  end
               end
               111: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[6] ");
                  end
               end
               112: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[7] ");
                  end
               end
               113: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[8] ");
                  end
               end
               114: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[9] ");
                  end
               end
               115: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_occ_ms_riscv32_mp_clk_in_p_inst.tdr[9:0], expected value = 1111000011");
               end
               116: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_sib_lbist_inst.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               117: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ijtag_so_mux, selection 0: ccm_en = 1'b0 -> ijtag_so_mux = ijtag_so_ff");
               end
               118: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               119: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               120: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               121: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               122: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               123: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               124: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.sib, load value = 0");
               end
               125: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.sib, load value = 0");
               end
               126: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.sib, load value = 1");
               end
               127: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.sib, load value = 1");
               end
               128: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.sib, load value = 1");
               end
               129: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.sib, load value = 1");
               end
               130: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ijtag_so_ff, load value = 0");
               end
               131: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ijtag_so_ff ");
                  end
               end
               132: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.sib ");
                  end
               end
               133: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.sib ");
                  end
               end
               134: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.sib ");
                  end
               end
               135: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.sib ");
                  end
               end
               136: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.sib ");
                  end
               end
               137: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.sib ");
                  end
               end
               138: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.sib, expected value = 0");
               end
               139: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.sib, expected value = 0");
               end
               140: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.sib, expected value = 1");
               end
               141: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.sib, expected value = 1");
               end
               142: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.sib, expected value = 1");
               end
               143: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.sib, expected value = 1");
               end
               144: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ijtag_so_ff, expected value = 0");
               end
               145: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_edt_sib_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               146: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.from_edt_scan_out_mux, selection 0: edt_scan_path_en = 1'b1 -> from_edt_scan_out_mux = from_edt_scan_out");
               end
               147: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               148: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               149: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               150: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               151: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               152: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_scan_in_mux, selection 0: ccm_en = 1'b0 -> lbist_scan_in_mux = ijtag_si");
               end
               153: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bist_setup[0] ");
                  end
               end
               154: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bist_setup[1] ");
                  end
               end
               155: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bist_setup[2] ");
                  end
               end
               156: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bist_clock_disable ");
                  end
               end
               157: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bist_sync_reset ");
                  end
               end
               158: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.shift_clock_select[0] ");
                  end
               end
               159: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.shift_clock_select[1] ");
                  end
               end
               160: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_burn_in_reg ");
                  end
               end
               161: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_low_power_shift_en_reg ");
                  end
               end
               162: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.sib, load value = 1");
               end
               163: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.sib, load value = 1");
               end
               164: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.sib, load value = 0");
               end
               165: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.sib, load value = 0");
               end
               166: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.sib, load value = 0");
               end
               167: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.sib, load value = 0");
               end
               168: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.sib, load value = 1");
               end
               169: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.sib, load value = 1");
               end
               170: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i.sib, load value = 1");
               end
               171: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i.sib ");
                  end
               end
               172: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.sib ");
                  end
               end
               173: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.sib ");
                  end
               end
               174: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.sib ");
                  end
               end
               175: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.sib ");
                  end
               end
               176: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.sib, expected value = 1");
               end
               177: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.sib, expected value = 1");
               end
               178: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.sib, expected value = 0");
               end
               179: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.sib, expected value = 0");
               end
               180: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.sib, expected value = 0");
               end
               181: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.sib, expected value = 0");
               end
               182: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.sib, expected value = 1");
               end
               183: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.sib, expected value = 1");
               end
               184: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i.sib, expected value = 1");
               end
               185: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_misr_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               186: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.sib, load value = 1");
               end
               187: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.sib, load value = 1");
               end
               188: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[23:0], load value = 110000111111110000000011");
               end
               189: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.sib, expected value = 1");
               end
               190: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.sib, expected value = 1");
               end
               191: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[23:0], expected value = 110000111111110000000011");
               end
               192: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[0] ");
                  end
               end
               193: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[1] ");
                  end
               end
               194: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[2] ");
                  end
               end
               195: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[3] ");
                  end
               end
               196: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[4] ");
                  end
               end
               197: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[5] ");
                  end
               end
               198: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[6] ");
                  end
               end
               199: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[7] ");
                  end
               end
               200: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[8] ");
                  end
               end
               201: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[9] ");
                  end
               end
               202: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[10] ");
                  end
               end
               203: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[11] ");
                  end
               end
               204: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[12] ");
                  end
               end
               205: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[13] ");
                  end
               end
               206: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[14] ");
                  end
               end
               207: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[15] ");
                  end
               end
               208: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[16] ");
                  end
               end
               209: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[17] ");
                  end
               end
               210: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[18] ");
                  end
               end
               211: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[19] ");
                  end
               end
               212: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[20] ");
                  end
               end
               213: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[21] ");
                  end
               end
               214: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[22] ");
                  end
               end
               215: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.misr[23] ");
                  end
               end
               216: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_chain_mask_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               217: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.sib, load value = 0");
               end
               218: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[9:0], load value = 0000111111");
               end
               219: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask_load_en, load value = 1");
               end
               220: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.sib, expected value = 0");
               end
               221: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[9:0], expected value = 0000111111");
               end
               222: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask_load_en, expected value = 1");
               end
               223: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask_load_en ");
                  end
               end
               224: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[0] ");
                  end
               end
               225: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[1] ");
                  end
               end
               226: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[2] ");
                  end
               end
               227: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[3] ");
                  end
               end
               228: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[4] ");
                  end
               end
               229: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[5] ");
                  end
               end
               230: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[6] ");
                  end
               end
               231: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[7] ");
                  end
               end
               232: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[8] ");
                  end
               end
               233: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.bist_chain_mask[9] ");
                  end
               end
               234: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_mask_shift_reg_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               235: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[30:0], load value = 0000111111110000000011111111111");
               end
               236: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[30:0], expected value = 0000111111110000000011111111111");
               end
               237: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[0] ");
                  end
               end
               238: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[1] ");
                  end
               end
               239: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[2] ");
                  end
               end
               240: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[3] ");
                  end
               end
               241: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[4] ");
                  end
               end
               242: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[5] ");
                  end
               end
               243: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[6] ");
                  end
               end
               244: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[7] ");
                  end
               end
               245: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[8] ");
                  end
               end
               246: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[9] ");
                  end
               end
               247: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[10] ");
                  end
               end
               248: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[11] ");
                  end
               end
               249: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[12] ");
                  end
               end
               250: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[13] ");
                  end
               end
               251: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[14] ");
                  end
               end
               252: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[15] ");
                  end
               end
               253: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[16] ");
                  end
               end
               254: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[17] ");
                  end
               end
               255: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[18] ");
                  end
               end
               256: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[19] ");
                  end
               end
               257: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[20] ");
                  end
               end
               258: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[21] ");
                  end
               end
               259: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[22] ");
                  end
               end
               260: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[23] ");
                  end
               end
               261: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[24] ");
                  end
               end
               262: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[25] ");
                  end
               end
               263: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[26] ");
                  end
               end
               264: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[27] ");
                  end
               end
               265: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[28] ");
                  end
               end
               266: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[29] ");
                  end
               end
               267: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_mask_shift_reg[30] ");
                  end
               end
               268: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_lbist_lp_static_control_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               269: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_hold_reg[3:0], load value = 1110");
               end
               270: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_toggle_reg[3:0], load value = 1111");
               end
               271: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_switching_reg[3:0], load value = 0001");
               end
               272: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_hold_reg[3:0], expected value = 1110");
               end
               273: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_toggle_reg[3:0], expected value = 1111");
               end
               274: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_switching_reg[3:0], expected value = 0001");
               end
               275: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_switching_reg[0] ");
                  end
               end
               276: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_switching_reg[1] ");
                  end
               end
               277: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_switching_reg[2] ");
                  end
               end
               278: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_switching_reg[3] ");
                  end
               end
               279: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_toggle_reg[0] ");
                  end
               end
               280: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_toggle_reg[1] ");
                  end
               end
               281: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_toggle_reg[2] ");
                  end
               end
               282: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_toggle_reg[3] ");
                  end
               end
               283: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_hold_reg[0] ");
                  end
               end
               284: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_hold_reg[1] ");
                  end
               end
               285: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_hold_reg[2] ");
                  end
               end
               286: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lbist_lp_hold_reg[3] ");
                  end
               end
               287: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.msrv32_top_pass2_rtl_tessent_edt_c0_sib_decompressor_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               288: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec_scan_in_mux, selection 0: lbist_en = 1'b1 -> lfsm_vec_scan_in_mux = lbist_scan_in_mux");
               end
               289: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[30:0], load value = 0011111111000000001111111111111");
               end
               290: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[30:0], expected value = 0011111111000000001111111111111");
               end
               291: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[0] ");
                  end
               end
               292: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[1] ");
                  end
               end
               293: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[2] ");
                  end
               end
               294: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[3] ");
                  end
               end
               295: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[4] ");
                  end
               end
               296: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[5] ");
                  end
               end
               297: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[6] ");
                  end
               end
               298: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[7] ");
                  end
               end
               299: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[8] ");
                  end
               end
               300: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[9] ");
                  end
               end
               301: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[10] ");
                  end
               end
               302: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[11] ");
                  end
               end
               303: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[12] ");
                  end
               end
               304: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[13] ");
                  end
               end
               305: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[14] ");
                  end
               end
               306: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[15] ");
                  end
               end
               307: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[16] ");
                  end
               end
               308: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[17] ");
                  end
               end
               309: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[18] ");
                  end
               end
               310: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[19] ");
                  end
               end
               311: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[20] ");
                  end
               end
               312: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[21] ");
                  end
               end
               313: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[22] ");
                  end
               end
               314: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[23] ");
                  end
               end
               315: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[24] ");
                  end
               end
               316: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[25] ");
                  end
               end
               317: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[26] ");
                  end
               end
               318: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[27] ");
                  end
               end
               319: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[28] ");
                  end
               end
               320: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[29] ");
                  end
               end
               321: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_edt_lbist_c0_inst.lfsm_vec[30] ");
                  end
               end
               322: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_ncp_limits_sib_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               323: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.from_ncp_limits_path_mux, selection 0: lbist_register_path_en = 1'b1 -> from_ncp_limits_path_mux = msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so");
               end
               324: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[7:0], load value = 11111111");
               end
               325: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[7:0], load value = 00000111");
               end
               326: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[7:0], load value = 11111000");
               end
               327: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[7:0], load value = 10000111");
               end
               328: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[7:0], expected value = 11111111");
               end
               329: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[7:0], expected value = 00000111");
               end
               330: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[7:0], expected value = 11111000");
               end
               331: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[7:0], expected value = 10000111");
               end
               332: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[0] ");
                  end
               end
               333: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[1] ");
                  end
               end
               334: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[2] ");
                  end
               end
               335: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[3] ");
                  end
               end
               336: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[4] ");
                  end
               end
               337: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[5] ");
                  end
               end
               338: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[6] ");
                  end
               end
               339: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_0_limit[7] ");
                  end
               end
               340: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[0] ");
                  end
               end
               341: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[1] ");
                  end
               end
               342: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[2] ");
                  end
               end
               343: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[3] ");
                  end
               end
               344: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[4] ");
                  end
               end
               345: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[5] ");
                  end
               end
               346: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[6] ");
                  end
               end
               347: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_1_limit[7] ");
                  end
               end
               348: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[0] ");
                  end
               end
               349: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[1] ");
                  end
               end
               350: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[2] ");
                  end
               end
               351: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[3] ");
                  end
               end
               352: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[4] ");
                  end
               end
               353: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[5] ");
                  end
               end
               354: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[6] ");
                  end
               end
               355: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_2_limit[7] ");
                  end
               end
               356: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[0] ");
                  end
               end
               357: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[1] ");
                  end
               end
               358: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[2] ");
                  end
               end
               359: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[3] ");
                  end
               end
               360: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[4] ");
                  end
               end
               361: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[5] ");
                  end
               end
               362: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[6] ");
                  end
               end
               363: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_3_limit[7] ");
                  end
               end
               364: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_bist_registers_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               365: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.from_lbist_register_path_mux, selection 0: lbist_register_path_en = 1'b1 -> from_lbist_register_path_mux = ijtag_si");
               end
               366: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.capture_phase_size[2:0], load value = 000");
               end
               367: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[9:0], load value = 1111111100");
               end
               368: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[5:0], load value = 111111");
               end
               369: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[13:0], load value = 11110000000011");
               end
               370: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[7:0], load value = 00001111");
               end
               371: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.capture_phase_size[2:0], expected value = 000");
               end
               372: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[9:0], expected value = 1111111100");
               end
               373: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[5:0], expected value = 111111");
               end
               374: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[13:0], expected value = 11110000000011");
               end
               375: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[7:0], expected value = 00001111");
               end
               376: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[0] ");
                  end
               end
               377: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[1] ");
                  end
               end
               378: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[2] ");
                  end
               end
               379: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[3] ");
                  end
               end
               380: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[4] ");
                  end
               end
               381: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[5] ");
                  end
               end
               382: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[6] ");
                  end
               end
               383: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.ncp_cnt[7] ");
                  end
               end
               384: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[0] ");
                  end
               end
               385: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[1] ");
                  end
               end
               386: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[2] ");
                  end
               end
               387: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[3] ");
                  end
               end
               388: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[4] ");
                  end
               end
               389: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[5] ");
                  end
               end
               390: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[6] ");
                  end
               end
               391: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[7] ");
                  end
               end
               392: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[8] ");
                  end
               end
               393: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[9] ");
                  end
               end
               394: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[10] ");
                  end
               end
               395: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[11] ");
                  end
               end
               396: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[12] ");
                  end
               end
               397: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.vector_cnt[13] ");
                  end
               end
               398: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[0] ");
                  end
               end
               399: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[1] ");
                  end
               end
               400: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[2] ");
                  end
               end
               401: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[3] ");
                  end
               end
               402: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[4] ");
                  end
               end
               403: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bit_cnt_max[5] ");
                  end
               end
               404: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[0] ");
                  end
               end
               405: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[1] ");
                  end
               end
               406: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[2] ");
                  end
               end
               407: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[3] ");
                  end
               end
               408: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[4] ");
                  end
               end
               409: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[5] ");
                  end
               end
               410: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[6] ");
                  end
               end
               411: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[7] ");
                  end
               end
               412: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[8] ");
                  end
               end
               413: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.warmup_pattern_cnt[9] ");
                  end
               end
               414: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.capture_phase_size[0] ");
                  end
               end
               415: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.capture_phase_size[1] ");
                  end
               end
               416: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.capture_phase_size[2] ");
                  end
               end
               417: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               418: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i.blk1_sib_i.scan_in_mux, selection 0: sib = 1'b0 -> scan_in_mux = ijtag_si");
               end
               419: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i.blk1_sib_i.sib, load value = 0");
               end
               420: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i.blk1_sib_i.sib ");
                  end
               end
               421: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.msrv32_top_pass2_rtl_tessent_edt_internal_scan_registers_i.blk1_sib_i.sib, expected value = 0");
               end
               422: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               423: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_single_bypass, load value = 0");
               end
               424: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_single_bypass, expected value = 0");
               end
               425: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_single_bypass ");
                  end
               end
               426: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.msrv32_top_pass2_rtl_tessent_lbist_sib_control_registers_i.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               427: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_low_power_shift_en_reg, load value = 1");
               end
               428: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_burn_in_reg, load value = 1");
               end
               429: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.shift_clock_select[1:0], load value = 11");
               end
               430: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_sync_reset, load value = 0");
               end
               431: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_clock_disable, load value = 0");
               end
               432: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_setup[2:0], load value = 100");
               end
               433: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_en, load value = 1");
               end
               434: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_low_power_shift_en_reg, expected value = 1");
               end
               435: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.lbist_burn_in_reg, expected value = 1");
               end
               436: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.shift_clock_select[1:0], expected value = 11");
               end
               437: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_sync_reset, expected value = 0");
               end
               438: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_clock_disable, expected value = 0");
               end
               439: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_setup[2:0], expected value = 100");
               end
               440: begin
                  $display($realtime, "ns:   msrv32_top_pass2_rtl_tessent_lbist_inst.bist_en, expected value = 1");
               end
               441: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass2_rtl_tessent_lbist_inst.bist_en ");
                  end
               end
               442: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_sib_sri_ctrl_inst.scan_in_mux, selection 1: sib = 1'b1 -> scan_in_mux = ijtag_from_so");
               end
               443: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst.tdr[0:0], load value = 1");
               end
               444: begin
                  if (_found_fail_per_cycle == 1) begin
                    $display($realtime, "ns: Previous Compare : pin tdo_p , ICL register = msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst.tdr[0] ");
                  end
               end
               445: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl_inst.tdr[0:0], expected value = 1");
               end
               446: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.DRMux, selection 7: instruction = 4'b0110 -> DRMux = bypass");
               end
               447: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.DRMux, selection 1: instruction = 4'b0000 -> DRMux = bypass");
               end
               448: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.DRMux, selection 0: instruction = 4'b1111 -> DRMux = bypass");
               end
               449: begin
                  $display($realtime, "ns:  Activate selection for scan mux msrv32_top_pass1_rtl_tessent_tap_main_inst.IRMux, selection 1: fsm.irSel = 1'b1 -> IRMux = instruction[0]");
               end
               450: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[3:0], load value = 1011");
               end
               451: begin
                  $display($realtime, "ns:   msrv32_top_pass1_rtl_tessent_tap_main_inst.instruction[3:0], expected value = 1011");
               end
               default: begin
                  $display("ERROR: corrupt message index\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _message_index
         end
         default: begin
            $display("ERROR: corrupt vector number\n");
            ->before_finish;
            #0;
            $finish;
         end
      endcase
   end // if in_range
      else begin
      case (_pat_type)  // _pat_type = vect[6:4]; 
         3'b011:  begin // status message vector
            _message_index = vect[38:7]; 
            case (_message_index)
               0: begin
                  _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                  if (_pat_num > -1) begin
                    $display("Skipped chain pattern %d\n",_pat_num);
                  end
                  _chain_test_ = 0;
                  _pat_num = -1;
                  $display("End chain test\n");
               end
               3: begin 
                  _end_vec_file_ok = 1;
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      _skipped_patterns = _skipped_patterns + 1;
                    end
                  end
                  if (_pat_num > -1) begin
                    if (_chain_test_) begin
                      $display("Skipped chain pattern %d\n",_pat_num);
                    end
                    else begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               default: begin
                  // Skip
               end
            endcase // _message_index
         end
         default: begin
            // Skip
         end
      endcase
      end // else !_in_range
   end // index loop
end // file_cnt loop

if (_save_state == 1) begin
  #1;
  mgcdft_save_signal = 1'b1;
//  $display("Writing checkpoint ICLNetwork.v.dat");
//  $save("ICLNetwork.v.dat");
  #1;
  $stop;
end
end
end  // while _in_restart
 if (_DIAG_file_header == 1) begin
    if (_diag_scan_header==1) begin
      $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
    end
    $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
    $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
    $fwrite(_diag_file, "failure_file_end\n");
    $fclose(_diag_file);
 end


#1;
if (_end_vec_file_ok == 0) begin
  $display("ERROR: Pattern file corrupted, simulation aborted\n");
end
_end_vec_file_ok = do_finish_summary(_end_vec_file_ok);
#1;
->before_finish;
#0;
$finish;
end
endmodule

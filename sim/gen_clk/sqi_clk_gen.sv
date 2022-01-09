class sqi_clk_gen extends uvm_sequence_item;
  `uvm_object_utils (sqi_clk_gen)

  rand time period = DEFAULT_CLK_PERIOD;

  extern  function        new (string name = "sqi_clk_gen");
  extern  function void   do_record (uvm_recorder recorder);
  extern  function void   do_print (uvm_printer printer);
  extern  function string convert2string ();
  extern  function void   do_copy (uvm_object rhs);
  extern  function bit    do_compare (uvm_object rhs, uvm_comparer comparer);

endclass: sqi_clk_gen

function sqi_clk_gen::new (string name = "sqi_clk_gen");
  super.new(name);
endfunction: new

function void sqi_clk_gen::do_record (uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_time  ("period", period)
endfunction: do_record

function void sqi_clk_gen::do_print (uvm_printer printer);
  super.do_print(printer);
  printer.print_int       ("id",          get_transaction_id(), 'd4, UVM_DEC);
  printer.print_time      ("period",      period);
endfunction

function string sqi_clk_gen::convert2string ();
  string s;
  s = $sformatf("\n| period       |\n");
  s = {s, $sformatf("+--------------+\n")};
  s = {s, $sformatf("| %10t |", period)};
  return s;
endfunction

function void sqi_clk_gen::do_copy (uvm_object rhs);
  sqi_clk_gen rhs_;

  if(!$cast(rhs_, rhs)) `uvm_fatal(get_name(), CLK_GEN_RPTS_SQI_CAST_FAILURE)
  super.do_copy(rhs);

  period = rhs_.period;
endfunction: do_copy

function bit sqi_clk_gen::do_compare (uvm_object rhs, uvm_comparer comparer);
  sqi_clk_gen rhs_;

  if(!$cast(rhs_, rhs)) begin
    `uvm_error(get_name(), CLK_GEN_RPTS_SQI_CAST_FAILURE)
    return 0;
  end

  return (
    super.do_compare(rhs, comparer) &&
    period == rhs_.period
  );
endfunction: do_compare

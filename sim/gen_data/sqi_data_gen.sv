class sqi_data_gen extends uvm_sequence_item;
  `uvm_object_utils (sqi_data_gen)
  //----
  rand logic [`INPUT_WIDTH-1:0] data_in = 0;
  //----
  extern  function        new (string name = "sqi_data_gen");
  extern  function void   do_record (uvm_recorder recorder);
  extern  function void   do_print (uvm_printer printer);
  extern  function string convert2string ();
  extern  function void   do_copy (uvm_object rhs);
  extern  function bit    do_compare (uvm_object rhs, uvm_comparer comparer);

endclass: sqi_data_gen

//----
function sqi_data_gen::new (string name = "sqi_data_gen");
  super.new(name);
endfunction: new

//----
function void sqi_data_gen::do_record (uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_field   ("data_in ", data_in)
endfunction: do_record

//----
function void sqi_data_gen::do_print (uvm_printer printer);
  super.do_print(printer);
  printer.print_int       ("id",          get_transaction_id(), 'd4, UVM_DEC);
  printer.print_int    ("data state",   data_in, 'd10, UVM_DEC);
endfunction

//----
function string sqi_data_gen::convert2string ();
  string s;
  s = $sformatf("\n| data  |");
  s = {s, $sformatf("\n+-------+")};
  s = {s, $sformatf("\n| %5d |",
      data_in
    )
  };
  return s;
endfunction

//----
function void sqi_data_gen::do_copy (uvm_object rhs);
  sqi_data_gen rhs_;
  //----
  if(!$cast(rhs_, rhs)) `uvm_fatal(get_name(), DATA_GEN_RPTS_SQI_CAST_FAILURE)
  super.do_copy(rhs);
  //----
  data_in = rhs_.data_in;
endfunction: do_copy

//----
function bit sqi_data_gen::do_compare (uvm_object rhs, uvm_comparer comparer);
  sqi_data_gen rhs_;
  //----
  if(!$cast(rhs_, rhs)) begin
    `uvm_error(get_name(), DATA_GEN_RPTS_SQI_CAST_FAILURE)
    return 0;
  end
  //----
  return (
    super.do_compare(rhs, comparer) &&
    data_in == rhs_.data_in
  );
endfunction: do_compare

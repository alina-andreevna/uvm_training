class sqi_rst_gen extends uvm_sequence_item;
  `uvm_object_utils (sqi_rst_gen)
  //----
  rand rst_level_t rst_lvl = PASSIVE;
  //----
  extern  function        new (string name = "sqi_rst_gen");
  extern  function void   do_record (uvm_recorder recorder);
  extern  function void   do_print (uvm_printer printer);
  extern  function string convert2string ();
  extern  function void   do_copy (uvm_object rhs);
  extern  function bit    do_compare (uvm_object rhs, uvm_comparer comparer);
  //---- extern function void   do_pack ();
  //---- extern function void   do_unpack ();
endclass: sqi_rst_gen

//----
function sqi_rst_gen::new (string name = "sqi_rst_gen");
  super.new(name);
endfunction: new

//----
function void sqi_rst_gen::do_record (uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_string   ("rst_lvl ", rst_lvl.name())
endfunction: do_record

//----
function void sqi_rst_gen::do_print (uvm_printer printer);
  super.do_print(printer);
  printer.print_int       ("id",          get_transaction_id(), 'd4, UVM_DEC);
  printer.print_string    ("rst state",   rst_lvl.name());
endfunction

//----
function string sqi_rst_gen::convert2string ();
  string s;
  s = $sformatf("\n| rst level |");
  s = {s, $sformatf("\n+-----------+")};
  s = {s, $sformatf("\n| %9s |",
      rst_lvl.name()
    )
  };
  return s;
endfunction

//----
function void sqi_rst_gen::do_copy (uvm_object rhs);
  sqi_rst_gen rhs_;
  //----
  if(!$cast(rhs_, rhs)) `uvm_fatal(get_name(), RST_GEN_RPTS_SQI_CAST_FAILURE)
  super.do_copy(rhs);
  //----
  rst_lvl = rhs_.rst_lvl;
endfunction: do_copy

//----
function bit sqi_rst_gen::do_compare (uvm_object rhs, uvm_comparer comparer);
  sqi_rst_gen rhs_;
  //----
  if(!$cast(rhs_, rhs)) begin
    `uvm_error(get_name(), RST_GEN_RPTS_SQI_CAST_FAILURE)
    return 0;
  end
  //----
  return (
    super.do_compare(rhs, comparer) &&
    rst_lvl == rhs_.rst_lvl
  );
endfunction: do_compare

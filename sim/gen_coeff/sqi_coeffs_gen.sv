import pkg_fir::*;
class sqi_coeffs_gen extends uvm_sequence_item;
  `uvm_object_utils (sqi_coeffs_gen)
  //----
  rand coeffs_t coeffs;
  //----
  extern  function        new (string name = "sqi_coeffs_gen");
  extern  function void   do_print (uvm_printer printer);
  extern  function string convert2string ();
  extern  function void   do_copy (uvm_object rhs);
  extern  function bit    do_compare (uvm_object rhs, uvm_comparer comparer);
endclass: sqi_coeffs_gen

//----
function sqi_coeffs_gen::new (string name = "sqi_coeffs_gen");
  super.new(name);
endfunction: new

//----
function void sqi_coeffs_gen::do_print (uvm_printer printer);
    super.do_print(printer);
    printer.print_int       ("id",          get_transaction_id(), 'd4, UVM_DEC);
    printer.print_time      ("accept time", get_accept_time());
    printer.print_time      ("begin time",  get_begin_time());
    printer.print_time      ("end time",    get_end_time());
    for (int i=0; i<fir_order; i++)
        printer.print_int   ($sformatf("coeffs[%0d]", i), coeffs[i], 'd14, UVM_DEC);
endfunction

//----
function string sqi_coeffs_gen::convert2string ();
  string s;
  s = $sformatf("\n filter coeffs ");
  s = {s, $sformatf("%p",
      coeffs
    )
  };
  return s;
endfunction

//----
function void sqi_coeffs_gen::do_copy (uvm_object rhs);
  sqi_coeffs_gen rhs_;
  //----
  if(!$cast(rhs_, rhs)) `uvm_fatal(get_name(), UVC_COEFFS_RPTS_SQI_CAST_FAILURE)
  super.do_copy(rhs);
  //----
  coeffs = rhs_.coeffs;
endfunction: do_copy

//----
function bit sqi_coeffs_gen::do_compare (uvm_object rhs, uvm_comparer comparer);
  sqi_coeffs_gen rhs_;
  //----
  if(!$cast(rhs_, rhs)) begin
    `uvm_error(get_name(), UVC_COEFFS_RPTS_SQI_CAST_FAILURE)
    return 0;
  end
  //----
  return (
    super.do_compare(rhs, comparer) &&
    coeffs ==  rhs_.coeffs
  );
endfunction: do_compare

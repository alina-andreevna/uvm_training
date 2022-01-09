class sq_start extends sq_base;
  `uvm_object_utils(sq_start)
  //----
  extern function  new(string name = "sq_start");
  extern task      body();
endclass: sq_start

//----
function sq_start::new(string name = "sq_start");
  super.new(name);
  local_vrb_lvl = UVM_HIGH;
endfunction: new

//----
task sq_start::body();
  `uvm_info(get_name(), "starting", local_vrb_lvl)
  //---- set clk and reset
  fork
    generate_rst0(10*CLK_PERIOD);
    set_clk0(CLK_PERIOD);
  join
    set_filter_coeff(DEFAULT_COEFFS);
    generate_filter_coeff();
    #CLK_PERIOD;
    generate_pulse_union(CLK_PERIOD);
    #200ns;
    `uvm_info(get_name(), "\nload filter coeffs from the file\n", local_vrb_lvl)
    set_filter_coeff(DEFAULT_COEFFS, "filter_coeff/coeff.txt");
    generate_filter_coeff();
    #CLK_PERIOD;
    generate_pulse_union(CLK_PERIOD);
    #1000ns;
    $finish;
endtask: body

class sq_base extends uvm_sequence;
  `uvm_object_utils(sq_base)
  `uvm_declare_p_sequencer(vsqr)
  //----
  sqi_rst_gen   sq_rst_gen0;
  sqi_clk_gen   sq_clk_gen0;
  sqi_data_gen  sq_data_gen0;
  sqi_coeffs_gen  sq_coeffs_gen0;
  uvm_verbosity local_vrb_lvl = UVM_LOW;
  //----
  coeffs_t filter_coeff;
  //----
  extern function new(string name = "sq_base");
  extern task     pre_body();
  extern task     post_body();
  extern task     generate_rst0(input time delay);
  extern task     set_active_rst0();
  extern task     set_inactive_rst0();
  extern task     set_clk0(input time prd);
  extern task     generate_pulse_union(input time delay);
  extern task     generate_constant_data(input int data);
  extern task     set_filter_coeff(input coeffs_t def_coeffs = DEFAULT_COEFFS, input string path = " ");
  extern task     generate_filter_coeff();
endclass: sq_base

//----
function sq_base::new(string name = "sq_base");
  super.new(name);
endfunction: new

//----
task sq_base::pre_body();
  //----
  if (starting_phase != null) starting_phase.raise_objection(this, {"Running sequence '", get_full_name(), "'"});
  sq_rst_gen0  = sqi_rst_gen::type_id::create("req_rst_gen0");
  sq_clk_gen0  = sqi_clk_gen::type_id::create("req_clk_gen0");
  sq_data_gen0  = sqi_data_gen::type_id::create("req_data_gen0");
  sq_coeffs_gen0  = sqi_coeffs_gen::type_id::create("req_coeffs_gen0");
endtask: pre_body
//----
task sq_base::post_body();
  if (starting_phase != null) starting_phase.drop_objection(this, {"Completed sequence '", get_full_name(), "'"});
endtask: post_body
//----
task sq_base::generate_rst0(input time delay);
  set_active_rst0();
  #delay;
  set_inactive_rst0();
endtask: generate_rst0

//----
task sq_base::set_active_rst0();
  `uvm_do_on_with(sq_rst_gen0, p_sequencer.m_sqr_rst_gen0, {rst_lvl == ACTIVE;})
  `uvm_info(get_name(), $sformatf("\nReset is set\n"), local_vrb_lvl)
endtask: set_active_rst0
//----
task sq_base::set_inactive_rst0();
  `uvm_do_on_with(sq_rst_gen0, p_sequencer.m_sqr_rst_gen0, {rst_lvl == PASSIVE;})
  `uvm_info(get_name(), $sformatf("\nReset is released\n"), local_vrb_lvl)
endtask: set_inactive_rst0
//----
task sq_base::set_clk0(input time prd);
  `uvm_do_on_with(sq_clk_gen0, p_sequencer.m_sqr_clk_gen0, {period == prd;})
  `uvm_info(get_name(), $sformatf("\nNew clock period is set\n"), local_vrb_lvl)
endtask: set_clk0
//----
task sq_base::generate_pulse_union(input time delay);
  generate_constant_data(1);
  #delay;
  generate_constant_data(0);
endtask: generate_pulse_union
  //----
task sq_base::generate_constant_data(input int data);
  `uvm_do_on_with(sq_data_gen0, p_sequencer.m_sqr_data_gen0, {data_in == data;})
  `uvm_info(get_name(), $sformatf("\nNew data value is set\n"), local_vrb_lvl)
endtask: generate_constant_data
  //----
task sq_base::set_filter_coeff(input coeffs_t def_coeffs = DEFAULT_COEFFS, input string path = " ");
  filter_coeff = def_coeffs;
  if (path == " ") begin
    `uvm_info(get_name(), $sformatf("\nUsing default coeff values\n", path), local_vrb_lvl)
  end else begin
    $readmemh(path, filter_coeff);
    `uvm_info(get_name(), $sformatf("\nNew coeff values was read from the %0s\n", path), local_vrb_lvl)
  end
endtask: set_filter_coeff
//----
task sq_base::generate_filter_coeff();
  `uvm_do_on_with(sq_coeffs_gen0, p_sequencer.m_sqr_coeffs_gen0, {foreach (coeffs[i]) {coeffs[i] == filter_coeff[i];}})
  `uvm_info(get_name(), $sformatf("\nNew filer coefficients is set\n"), local_vrb_lvl)
endtask: generate_filter_coeff

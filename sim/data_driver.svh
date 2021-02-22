`ifndef DRV_DEF
    `define DRV_DEF
    
    `include "fir_param_pkg.svh"

    class data_driver extends uvm_driver #(data_seq_item);
      `uvm_component_utils(data_driver)
     
      // Virtual Interface
      virtual fir_if vif;
      bit [`INPUT_WORD_SIZE-1:0] data_to_drive;
     
      // Constructor
      function new (string name="data_driver", uvm_component parent);
        super.new(name, parent);
      endfunction : new
     
      function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        vif = global_fir_if;

      endfunction: build_phase
     
      // run phase
      virtual task run_phase(uvm_phase phase);
        forever begin
        seq_item_port.get_next_item(req);
        data_to_drive = req.data;
        drive();
        seq_item_port.item_done();
        end
      endtask : run_phase
     
      // drive
      virtual task drive();
        req.print();
        @(posedge vif.clk_in);
        vif.data_in <= data_to_drive;
        $display("-----------------------------------------");
      endtask : drive
     
    endclass : data_driver

`endif
`ifndef DRV_DEF
    `define DRV_DEF

    class driver extends uvm_agent;

        `uvm_component_utils(driver)    
        virtual interface fir_if fif;

        // constructor
        function new(string name = "driver", uvm_component parent = null );

            super.new(name, parent);
        // Insert Constructor Code Here
        endfunction : new

        // build
        virtual   function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            fif = tb_pkg::global_fir_if;
        endfunction : build_phase

        task run_phase(uvm_phase phase);
            int data_in[$];
            data_in = {1, 0, 0, 0, 0, 0, 0, 0, 0};

            phase.raise_objection(this);
                for (int i=0; i<data_in.size(); i++)
                    @(negedge fif.clk);
                    fif.data_in = data_in.pop_front();

            phase.drop_objection(this);


        endtask : run_phase

    endclass : driver

`endif
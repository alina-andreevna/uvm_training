`ifndef PRT_DEF
    `define PRT_DEF

    class printer extends uvm_agent;

        `uvm_component_utils(printer) 

        virtual interface fir_if fif;

        function new(string name = "printer", uvm_component parent = null );
            super.new(name, parent);
        endfunction : new

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            fif = global_fir_if;
        endfunction : build_phase

        task run_phase(uvm_phase phase);
            forever begin
                @(posedge fif.clk);

                `uvm_info("run",
                $psprintf("data_in = %d, data_out = %d", fif.data_in, fif.data_out),UVM_MEDIUM);
                    
            end
        endtask : run_phase

    endclass : printer

`endif

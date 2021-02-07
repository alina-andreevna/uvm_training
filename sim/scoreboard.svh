`ifndef SCB_DEF
    `define SCB_DEF

    `include "uvm_macros.svh"

    class scoreboard extends uvm_agent;
        `uvm_component_utils(scoreboard)    

        virtual interface fir_if fif;

        // constructor
        function new(string name = "scoreboard", uvm_component parent = null );
            super.new(name, parent);
        endfunction : new

        // build
        function void build();
            super.build();
            // Insert Build Code Here
            fif = global_fir_if;
        endfunction : build

        task run();
            int coeff[$];
            coeff = {7, 17, 32, 46, 52, 46, 32, 17, 7};

            for(int i=0; i<coeff.size(); i++) begin
                @(posedge fif.clk);
                
                assert(fif.data_out == coeff[i]) else
                `uvm_error("run",
                            $psprintf("coeff[%d] =  %d  fif.data_out = : %d",
                            i,coeff[i], fif.data_out));
            end
        endtask //run
        
    endclass : scoreboard

`endif
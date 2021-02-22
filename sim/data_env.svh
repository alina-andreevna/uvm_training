`ifndef ENV_DT_DEF
    `define ENV_DT_DEF

    class data_env extends uvm_env;

        `uvm_component_utils(data_env)    

        data_agent agt;
        data_scoreboard scb;

        function new(string name = "data_env", uvm_component parent = null );
            super.new(name, parent);
        endfunction : new

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agt = data_agent::type_id::create("data_agent",this);
            scb = data_scoreboard::type_id::create("data_scb",this);
        endfunction : build_phase

        function void connect_phase(uvm_phase phase);
            agt.mon.item_collected_port.connect(scb.item_collected_export);
        endfunction : connect_phase
    endclass : data_env

`endif
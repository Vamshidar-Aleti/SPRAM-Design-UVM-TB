//`include "package.sv"
//`include "base_test2.sv"
class base_test extends uvm_test;

  env env_o;
  base_seq bseq;


  `uvm_component_utils(base_test)

  function new(string name = "base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o",this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TOPOLOGY", "Printing UVM component topology at end_of_elaboration_phase", UVM_LOW)
    uvm_top.print_topology();
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq = base_seq::type_id::create("bseq");
    bseq.start(env_o.agt.seqr);
    //#10ns;
    //`uvm_info("TOPOLOGY", "Printing UVM component topology...", UVM_LOW)
     //uvm_top.print_topology();
    #10ns;
    phase.drop_objection(this);
  endtask
  
  function void finial_phase(uvm_phase phased);
    `uvm_info(get_type_name,"end of test caese ",UVM_LOW);
  endfunction
  
endclass

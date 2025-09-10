class agent extends uvm_agent;
  `uvm_component_utils(agent)
  driver dvr;
  main_monitor mon;
  sequencer seqr;

  function new(string name="agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active == UVM_ACTIVE) begin
      dvr = driver::type_id::create("dvr",this);
      seqr = sequencer::type_id::create("seqr",this);
    end
    mon = main_monitor::type_id::create("mon",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(get_is_active == UVM_ACTIVE)begin
      dvr.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass

class monitor extends uvm_monitor;
  virtual intf vif;
  uvm_analysis_port#(seq_item) item_collect_port;

  seq_item mon_item;

  `uvm_component_utils(monitor)

  function new(string name = "monitor", uvm_component parent=null);
    super.new(name, parent);
    item_collect_port=new("item_collect_port", this);
    mon_item=new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"*", "vif", vif))
      `uvm_fatal(get_type_name(),"not set at top level");
  endfunction
  
  task run_phase(uvm_phase phase);
    wait(!vif.rst);
    forever begin
      mon_item = seq_item::type_id::create("mon_item");
      
      // Wait for a transaction
      @(posedge vif.clk);
      
      // Sample inputs at the first clock edge
      mon_item.wren = vif.wren;
      mon_item.addrs = vif.addrs;
      if (vif.wren) begin
        mon_item.data_in = vif.data_in;
      end
      
      // Wait one cycle to sample the output for read operations due to DUT latency
      @(posedge vif.clk);
      mon_item.data_out = vif.data_out;
      
      // FIX: Placed info message after all data is collected for accurate logging.
      `uvm_info(get_type_name, $sformatf("Monitored item: wren=%0d, addrs=%0h, data_in=%0h, data_out=%0h", mon_item.wren, mon_item.addrs, mon_item.data_in, mon_item.data_out), UVM_LOW);
      item_collect_port.write(mon_item);
    end
  endtask
endclass

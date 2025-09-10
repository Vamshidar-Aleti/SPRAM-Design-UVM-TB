class driver extends uvm_driver#(seq_item);

  `uvm_component_utils(driver)

  virtual intf vif;

  function new(string name ="driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"*", "vif", vif))
      `uvm_fatal(get_type_name(), "not set up at top level");
  endfunction

  task run_phase(uvm_phase phase);
    
    wait(!vif.rst);
    
    forever begin
      seq_item_port.get_next_item(req);
      
      `uvm_info(get_type_name(), $sformatf("wren=%0d, addrs=%0d, data_in=%0d, data_out=%0d", req.wren, req.addrs, req.data_in, req.data_out), UVM_LOW);
      
      @(posedge vif.clk);
      vif.wren <= req.wren;
      vif.addrs <= req.addrs;
      
      if(req.wren)begin
        vif.data_in <= req.data_in;
      end else begin
        vif.data_in <=8'bz;
      end

      //@(posedge vif.clk);
      seq_item_port.item_done();
    end
  endtask
endclass

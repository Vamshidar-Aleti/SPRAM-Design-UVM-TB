class spram_coverage extends uvm_subscriber #(seq_item);

  `uvm_component_utils(spram_coverage)

  covergroup spram_op_cg with function sample(seq_item trans);
    option.per_instance =1;
    type_option.comment="Functional coverage for SPRAM opertions";

    CP_ADDR: coverpoint trans.addrs{
      bins addresses[] = {[0:15]};
    }

    CP_WREN: coverpoint trans.wren{
      bins read_op = {0};
      bins write_op = {1};
    }

    CP_DATA_IN: coverpoint trans.data_in iff(trans.wren) {
      // bins zeros =(8'h00);
      //bins ones =(8'hFF);
      bins walking_1 = { 8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000, 8'b00010000, 8'b00100000, 8'b01000000, 8'b10000000};
    }

    CROSS_ADDR_WREN: cross CP_ADDR, CP_WREN;
  endgroup;

  function new(string name = "spram_coverage", uvm_component parent = null);
    super.new(name, parent);
    spram_op_cg = new();
  endfunction

  function void write(seq_item t);
    `uvm_info(get_type_name(), "Sampling transcation for coverage ", UVM_LOW)
    spram_op_cg.sample(t);
  endfunction
endclass
//

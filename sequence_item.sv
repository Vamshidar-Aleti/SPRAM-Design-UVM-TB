class seq_item extends uvm_sequence_item;
  rand bit wren;
  rand bit [3:0] addrs;
  rand bit [7:0] data_in;
  bit [7:0] data_out;

  function new (string name = "seq_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(wren, UVM_ALL_ON)
  `uvm_field_int(addrs, UVM_ALL_ON)
    `uvm_field_int(data_in, UVM_ALL_ON)
    `uvm_field_int(data_out, UVM_ALL_ON)
  `uvm_object_utils_end

  constraint limit {addrs inside {[1:15]};}
  
  constraint wren_distb{
    wren dist{0:=1, 1:=1};}
endclass

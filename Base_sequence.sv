class base_seq extends uvm_sequence#(seq_item);
  seq_item req;
  `uvm_object_utils(base_seq)

  function new(string name = "base_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "sequence staring will generate 15 tranacations", UVM_LOW);
    repeat(30)begin
    `uvm_do(req);
    end
    `uvm_info(get_type_name(), "sequence finished",UVM_LOW);
  endtask
endclass

class scoreboard extends uvm_scoreboard;
  seq_item item_q[$],dr,mont;
  
  uvm_analysis_imp#(seq_item, scoreboard) item_collect_export;
  
  bit[7:0] mem[0:15];
  `uvm_component_utils(scoreboard)
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dr = seq_item::type_id::create("dr",this);
    mont = seq_item::type_id::create("mont",this);
    foreach(mem[i])
      mem[i]=0;
  endfunction

  function void write(seq_item req);
    item_q.push_back(req);
  endfunction

  int write_count =0;
  int read_count =0;
  
  task run_phase(uvm_phase phase);
    seq_item sb_item;
    forever begin
      wait(item_q.size()>0);
      sb_item = item_q.pop_front();
      $display("----------------------------------%0t",$realtime);
      sb_item.print();
      if(sb_item.wren) begin
        mem[sb_item.addrs] = sb_item.data_in;
        write_count++;
        `uvm_info(get_type_name(),$sformatf("write: addrs=%0d, data_in=%0d, write_count=%0d",sb_item.addrs,sb_item.data_in,write_count),UVM_LOW);
      end
      else if(!sb_item.wren) begin
        if(mem[sb_item.addrs] == sb_item.data_out) begin
          read_count++;
          `uvm_info(get_type_name,$sformatf("[SCOREBOARD] matched: wren=%0d,mem_data_out=%0d, addrs=%0d,data_out=%0d, read_count=%0d",sb_item.wren,mem[sb_item.addrs],sb_item.addrs,sb_item.data_out,read_count),UVM_LOW);
        end
        else begin
          read_count++;
          `uvm_info(get_type_name,$sformatf("NOT_matched: wren=%0d, mem_data_out=%0d, addrs=%0d,data_out=%0d,read_count=%0d", sb_item.wren,mem[sb_item.addrs],sb_item.addrs,sb_item.data_out,read_count),UVM_LOW);
        end
      end
    end
  endtask
endclass

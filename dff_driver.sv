//
//
import uvm_pkg::*;
`include "uvm_macros.svh"

class dff_driver extends uvm_driver#(dff_txn);
  `uvm_component_utils
  
  virtual dff_if vif;

function new(string name,uvm_component parent);
  super.new(name,this);
endfunction

function build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

task run_phase(uvm_phase phase);
dff_transaction tx;
forever begin
  seq_item_port.get_next_item(tx);
  @(posedge vif.clk)     //interchange this with vif.d line for right working
  vif.d<=tx.d;
seq_item_port.item_done();
end
endtask
  
endclass  
  
  

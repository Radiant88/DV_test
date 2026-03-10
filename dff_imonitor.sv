//
//
import uvm_pkg::*;
`include "uvm_macros.svh"

class dff_imonitor extends uvm_monitor;
  `uvm_component_utils(dff_imonitor)

  virtual dff_if vif;

uvm_analysis_port #(dff_transaction) ap;

function new(string name, uvm_component parent);
    super.new(name,parent);
    ap = new("ap",this);
endfunction

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual dff_if)::get(this,"","vif",vif))
        `uvm_fatal("NOVIF","No interface")
endfunction

task run_phase(uvm_phase phase);

    dff_transaction tx;

    forever begin
        @(posedge vif.clk);

        tx = dff_transaction::type_id::create("tx");

        tx.d = vif.d;
        tx.q = vif.q;

        ap.write(tx);
    end

endtask

endclass
  

class v_seq extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(v_seq);

  function new(string name="v_seq");
    super.new(name);
  endfunction

  ahb_sequencer ahb_seqrh;
  v_sequencer v_seqrh;

  single_seq seq1;
  incr seq2;
  wrap4_trans seq3;
  wrap8_trans seq4;
  wrap16_trans seq5;  
  wrap16_cov seq6;
  wrap16_cov1 seq7;
  task body();
    if(!$cast(v_seqrh,m_sequencer))
      `uvm_error("BODY", "Error in $cast of virtual sequencer")
	else
    ahb_seqrh=v_seqrh.ahb_seqrh;
  endtask
endclass

class v_seq1 extends v_seq;
  `uvm_object_utils(v_seq1);

  function new(string name="v_seq1");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    seq1=single_seq::type_id::create("seq1");
    seq1.start(ahb_seqrh);
  endtask

endclass


class v_seq2 extends v_seq;
  `uvm_object_utils(v_seq2);

  function new(string name="v_seq2");
    super.new(name);
  endfunction
  
   task body();
    super.body();
     seq2=incr::type_id::create("seq2");
     seq2.start(ahb_seqrh);
   endtask
endclass


class v_seq3 extends v_seq;
  `uvm_object_utils(v_seq3);

  function new(string name="v_seq3");
    super.new(name);
  endfunction

   task body();
    super.body();
     seq3=wrap4_trans::type_id::create("seq3");
     seq3.start(ahb_seqrh);
   endtask
endclass
class v_seq4 extends v_seq;
  `uvm_object_utils(v_seq4);

  function new(string name="v_seq4");
    super.new(name);
  endfunction

   task body();
    super.body();
     seq4=wrap8_trans::type_id::create("seq4");
     seq4.start(ahb_seqrh);
   endtask
endclass
class v_seq5 extends v_seq;
  `uvm_object_utils(v_seq5);

  function new(string name="v_seq5");
    super.new(name);
  endfunction

   task body();
    super.body();
     seq5=wrap16_trans::type_id::create("seq5");
     seq5.start(ahb_seqrh);
   endtask
endclass

class v_seq6 extends v_seq;
  `uvm_object_utils(v_seq6);

  function new(string name="v_seq6");
    super.new(name);
  endfunction

   task body();
    super.body();
     seq6=wrap16_cov::type_id::create("seq6");
     seq6.start(ahb_seqrh);
   endtask
endclass
class v_seq7 extends v_seq;
  `uvm_object_utils(v_seq7);

  function new(string name="v_seq7");
    super.new(name);
  endfunction

   task body();
    super.body();
     seq7=wrap16_cov1::type_id::create("seq7");
     seq7.start(ahb_seqrh);
   endtask
endclass


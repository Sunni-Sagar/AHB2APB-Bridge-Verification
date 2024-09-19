class base_seq extends uvm_sequence #(ahb_xtn);
  `uvm_object_utils(base_seq);
  
  function new (string name = "base_seq");
    super.new(name);
  endfunction
endclass

class single_seq extends base_seq;
  `uvm_object_utils(single_seq);
  
  function new (string name = "single_seq");
    super.new(name);
  endfunction

  task body();
// repeat(200)
  begin
     req=ahb_xtn::type_id::create("req");
    start_item(req);
    req.transaction_no=req.transaction_no+1;
    assert(req.randomize() with {Hburst ==0;Htrans==2'b10; Hwrite==1;});
    finish_item(req);
  end
endtask
endclass

class incr extends base_seq;
  `uvm_object_utils(incr);

  function new (string name = "incr");
    super.new(name);
  endfunction
  
  bit [31:0]haddr;
  bit [2:0]hsize,hburst;
  bit hwrite;
  bit [9:0] hlength;

  task body();
//repeat(200) 
begin
    req=ahb_xtn::type_id::create("req");
    start_item(req);
	req.transaction_no=req.transaction_no+1;
    req.randomize with {Htrans==2'b10; Hburst inside {1,3,5,7}; length ==4;};
    finish_item(req);
    
    haddr=req.Haddr;
    hsize=req.Hsize;
    hburst=req.Hburst;
    hwrite=req.Hwrite;
    hlength=req.length;
    
    for(int i=1;i<hlength;i++)
    begin
      start_item(req);
	req.transaction_no=req.transaction_no+1;
      assert(req.randomize with { Htrans==2'b11;
                          Hsize==hsize;
                          Hwrite==hwrite;
                          Hburst==hburst;
                          Haddr==haddr+(2**Hsize);});
      finish_item(req);
      haddr=req.Haddr;
   end
end
 endtask
endclass
    
class wrap4_trans extends base_seq;
  `uvm_object_utils(wrap4_trans);

  function new (string name = "wrap4_trans");
    super.new(name);
  endfunction
  
  bit [31:0]haddr;
  bit [2:0]hsize,hburst;
  bit hwrite;
  bit [9:0] hlength;

  task body();
  // repeat(200) 
begin
	 req=ahb_xtn::type_id::create("req");
    start_item(req);
	req.transaction_no=req.transaction_no+1;
    req.randomize() with { Htrans==2'b10; // making NS
                          Hburst==3'b010;}; // making type wrap 4
    finish_item(req);
    
    haddr=req.Haddr;
    hsize=req.Hsize;
    hburst=req.Hburst;
    hwrite=req.Hwrite;
    hlength=req.length;
    
    for(int i=1;i<hlength;i++)
      begin
        start_item(req);
	req.transaction_no=req.transaction_no+1;
        if(hsize==0)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
				Hburst==hburst;
                                Haddr=={haddr[31:2],haddr[1:0]+2'b01};};
        if(hsize==1)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
				Hburst==hburst;
                                Haddr=={haddr[31:3],haddr[2:0]+2'b10};};
        if(hsize==2)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
				Hburst==hburst;
                                Haddr=={haddr[31:4],haddr[3:0]+3'b100};};
        finish_item(req);
      	haddr=req.Haddr;
	end end
  endtask
endclass
          
class wrap8_trans extends base_seq;
  `uvm_object_utils(wrap8_trans);

  function new (string name = "wrap8_trans");
    super.new(name);
  endfunction

  bit [31:0]haddr;
  bit [2:0]hsize,hburst;
  bit hwrite;
  bit [9:0] hlength;
 
  task body();
repeat(200)
 begin
    req=ahb_xtn::type_id::create("req");
    start_item(req);
	req.transaction_no=req.transaction_no+1;
    req.randomize() with { Htrans==2'b10; // making NS
                          Hburst==3'b100;}; // making type wrap 8
    finish_item(req);

    haddr=req.Haddr;
    hsize=req.Hsize;
    hburst=req.Hburst;
    hwrite=req.Hwrite;
    hlength=req.length;

    for(int i=1;i<hlength;i++)
      begin
        start_item(req);
	req.transaction_no=req.transaction_no+1;
        if(hsize==0)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:3],haddr[2:0] + 3'b001};};
        if(hsize==1)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:4],haddr[3:0] + 4'b0010};};
        if(hsize==2)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:5],haddr[4:0] + 5'b00100};};
        finish_item(req);
        haddr=req.Haddr;
        end end
  endtask
endclass

class wrap16_trans extends base_seq;
  `uvm_object_utils(wrap16_trans);

  function new (string name = "wrap16_trans");
    super.new(name);
  endfunction

  bit [31:0]haddr;
  bit [2:0]hsize,hburst;
  bit hwrite;
  bit [9:0] hlength;
 
  task body();
//repeat(200) 
begin
    req=ahb_xtn::type_id::create("req");
    start_item(req);
req.transaction_no=req.transaction_no+1;
    req.randomize() with { Htrans==2'b10; // making NS
                          Hburst==3'b110;}; // making type wrap 8
    finish_item(req);

    haddr=req.Haddr;
    hsize=req.Hsize;
    hburst=req.Hburst;
    hwrite=req.Hwrite;
    hlength=req.length;

    for(int i=1;i<hlength;i++)
      begin
        start_item(req);
req.transaction_no=req.transaction_no+1;
        if(hsize==0)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:4],haddr[3:0] + 4'b0001};};
        if(hsize==1)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:5],haddr[4:0] + 5'b00010};};
        if(hsize==2)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:6],haddr[5:0] + 6'b000100};};
        finish_item(req);
        haddr=req.Haddr;
        end end
  endtask
endclass

class wrap16_cov extends base_seq;
  `uvm_object_utils(wrap16_cov);

  function new (string name = "wrap16_cov");
    super.new(name);
  endfunction

  bit [31:0]haddr;
  bit [2:0]hsize,hburst;
  bit hwrite;
  bit [9:0] hlength;

  task body();
repeat(200) 
begin
    req=ahb_xtn::type_id::create("req");
    start_item(req);
req.transaction_no=req.transaction_no+1;
    req.randomize() with { Htrans==2'b10; // making NS
                          Hburst==3'b110;
			Hsize==2'b10;}; // making type wrap 8
    finish_item(req);

    haddr=req.Haddr;
    hsize=req.Hsize;
    hburst=req.Hburst;
    hwrite=req.Hwrite;
    hlength=req.length;

    for(int i=1;i<hlength;i++)
      begin
        start_item(req);
req.transaction_no=req.transaction_no+1;
        if(hsize==0)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
				Haddr inside {[32'h8800_0000:32'h8800_03ff]};
                                Haddr=={haddr[31:4],haddr[3:0] + 4'b0001};};
        if(hsize==1)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:5],haddr[4:0] + 5'b00010};};
        if(hsize==2)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
				Haddr inside {[32'h8800_0000:32'h8800_03ff]};
                                Haddr=={haddr[31:6],haddr[5:0] + 6'b000100};};
        finish_item(req);
        haddr=req.Haddr;
        end end
  endtask
endclass
 
class wrap16_cov1 extends base_seq;
  `uvm_object_utils(wrap16_cov1);

  function new (string name = "wrap16_cov1");
    super.new(name);
  endfunction

  bit [31:0]haddr;
  bit [2:0]hsize,hburst;
  bit hwrite;
  bit [9:0] hlength;

  task body();
 repeat(200) 
begin
    req=ahb_xtn::type_id::create("req");
    start_item(req);
req.transaction_no=req.transaction_no+1;
    req.randomize() with { Htrans==2'b10; // making NS
                          Hburst==3'b110;
                       Hwrite==1;}; // making type wrap 8
    finish_item(req);

    haddr=req.Haddr;
    hsize=req.Hsize;
    hburst=req.Hburst;
    hwrite=req.Hwrite;
    hlength=req.length;

    for(int i=1;i<hlength;i++)
      begin
        start_item(req);
req.transaction_no=req.transaction_no+1;
        if(hsize==0)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:4],haddr[3:0] + 4'b0001};};
        if(hsize==1)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:5],haddr[4:0] + 5'b00010};};
        if(hsize==2)
          req.randomize() with {Htrans ==2'b11;
                                Hwrite ==hwrite;
                                Hsize==hsize;
                                Hburst==hburst;
                                Haddr=={haddr[31:6],haddr[5:0] + 6'b000100};};
        finish_item(req);
        haddr=req.Haddr;
        end end
  endtask
endclass


    
    
    
    
    
    
        

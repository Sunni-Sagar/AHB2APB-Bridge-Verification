class ahb_xtn extends uvm_sequence_item;
  `uvm_object_utils(ahb_xtn);
  
  rand bit [31:0] Haddr;
  rand bit [31:0] Hwdata;
       bit [31:0] Hrdata;
  rand bit [2:0] Hsize;
  rand bit [1:0] Htrans;
  rand bit [2:0] Hburst;
       bit Hresetn;
  rand bit Hwrite;
       bit Hreadyout;
  rand bit Hreadyin;
  
  rand bit [9:0] length;
  
  int transaction_no;  

  constraint valid_size { Hsize inside {0,1,2};}
  constraint valid_Haddr { Haddr inside 
                     			     {[32'h8000_0000 : 32'h8000_03ff],
                                               [32'h8400_0000 : 32'h8400_03ff],
                                               [32'h8800_0000 : 32'h8800_03ff],
                                               [32'h8c00_0000 : 32'h8c00_03ff]};}
  constraint boundary {Hburst==1->{Haddr%1024+(length*2**Hsize)<=1023};
			Hburst==0->length==1; 
			Hburst==2->length==4;
			Hburst==3->length==4;
			 Hburst==4->length==8;
			Hburst==5->length==8;
			Hburst==6->length==16;
			Hburst==7->length==16;}

  
  constraint aligned {Hsize ==1 -> Haddr %2 ==0;
                      Hsize ==2 -> Haddr %4 ==0;}
  
  function new (string name= "ahb_xtn");
    super.new(name);
  endfunction
  
  function void do_print (uvm_printer printer);
	super.do_print(printer);
    printer.print_field( "Transction no ",this.transaction_no,32,UVM_DEC);
    printer.print_field( "Haddr",this.Haddr,32,UVM_HEX);
    printer.print_field( "Hwdata",this.Hwdata,32,UVM_HEX);
    printer.print_field( "Hrdata",this.Hrdata,32,UVM_HEX);
    printer.print_field( "Hsize",this.Hsize,3,UVM_HEX);
    printer.print_field( "Htrans",this.Htrans,3,UVM_HEX);
    printer.print_field( "Hresetn",this.Hresetn,1,UVM_HEX);
    printer.print_field( "Hreadyout",this.Hreadyout,1,UVM_HEX);
    printer.print_field( "Hreadyin",this.Hreadyin,1,UVM_HEX);
   printer.print_field( "Hwrite",this.Hwrite,1,UVM_HEX);
    printer.print_field( "Hburst",this.Hburst,3,UVM_DEC);
    printer.print_field( "Length",this.length,10,UVM_DEC);
  endfunction
endclass
                
                          
                         

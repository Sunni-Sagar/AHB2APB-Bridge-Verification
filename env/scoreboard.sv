class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard);
  uvm_tlm_analysis_fifo #(ahb_xtn) ahb_fifo;
  uvm_tlm_analysis_fifo #(apb_xtn) apb_fifo;

  ahb_xtn ahb;
  apb_xtn apb;
  
covergroup ahb_cg;
  HADDR: coverpoint ahb.Haddr{
    bins slave1={[32'h8000_0000:32'h8000_03ff]};
    bins slave2={[32'h8400_0000:32'h8400_03ff]};
    bins slave3={[32'h8800_0000:32'h8800_03ff]};
    bins slave4={[32'h8c00_0000:32'h8c00_03ff]};}
  
  HTRANS: coverpoint ahb.Htrans{
    bins non_seq ={2};
    bins seq ={3};}
  
  HWRITE: coverpoint ahb.Hwrite{
    bins write ={1};
    bins read ={0};}
  
  HSIZE : coverpoint ahb.Hsize{
    bins one_byte={0};
    bins two_byte={1};
    bins four_byte={2};}
  
CROSS:  cross HADDR,HTRANS,HSIZE,HWRITE;
endgroup

covergroup apb_cg;
  PADDR: coverpoint apb.Paddr{
    bins slave1={[32'h800_0000:32'h8000_03ff]};
    bins slave2={[32'h8400_0000:32'h8400_03ff]};
    bins slave3={[32'h8800_0000:32'h8800_03ff]};
    bins slave4={[32'h8c00_0000:32'h8c00_03ff]};}
  
  PWRITE: coverpoint apb.Pwrite{
    bins write ={1};
    bins read ={0};}
  
  PSELX: coverpoint apb.Pselx{
    bins first_addr={1};
    bins second_addr={2};
    bins third_addr={4};
    bins forth_addr={8};}

CROSS: cross PADDR,PWRITE,PSELX;
endgroup
  
  function new(string name="scoreboard",uvm_component parent);
    super.new(name,parent);
    ahb_fifo = new("ahb_fifo",this);
    apb_fifo= new("apb_fifo",this);
    ahb= new();
    apb= new();
    ahb_cg=new();
    apb_cg=new();
endfunction

task run_phase(uvm_phase phase);
  forever
  begin
    fork
      begin
        ahb_fifo.get(ahb);
        ahb.print;
        ahb_cg.sample();
      end
      begin
        apb_fifo.get(apb);
        apb.print;
        apb_cg.sample();
      end
    join
    check_data(ahb,apb);
  end
endtask

  task compare(int Haddr,Paddr,Hdata,Pdata);
    if(Haddr==Paddr)
      `uvm_info("SC Addr", $sformatf("Successfull: Haddr = 0x%0h Paddr = 0x%0h",Haddr,Paddr), UVM_LOW)
    else
      `uvm_info("SC Addr", $sformatf("Not Successfull: Haddr = 0x%0h Paddr = 0x%0h",Haddr,Paddr), UVM_LOW)
    if(Hdata==Pdata)
      `uvm_info("SC data", $sformatf("Successfull: Hdata = 0x%0h Pdata = 0x%0h", Hdata,Pdata), UVM_LOW)
    else
      `uvm_info("SC data", $sformatf("Not Successfull: Hdata = 0x%0h Pdata = 0x%0h", Hdata,Pdata), UVM_LOW)
  endtask
  
  task check_data(ahb_xtn ahb_h, apb_xtn apb_h);
    if(ahb_h.Hwrite==1)
      begin
        if(ahb_h.Hsize==0)
          begin
            if(ahb_h.Haddr[1:0]==0)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata[7:0],apb_h.Pwdata[7:0]);
            if(ahb_h.Haddr[1:0]==1)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata[15:8],apb_h.Pwdata[7:0]);
            if(ahb_h.Haddr[1:0]==2)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata[23:16],apb_h.Pwdata[7:0]);
            if(ahb_h.Haddr[1:0]==3)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata[31:24],apb_h.Pwdata[7:0]);
          end
        if(ahb_h.Hsize==1)
          begin
            if(ahb_h.Haddr[1:0]==0)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata[15:0],apb_h.Pwdata[15:0]);
            if(ahb_h.Haddr[1:0]==1)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata[31:16],apb_h.Pwdata[15:0]);
          end
        if(ahb_h.Hsize==2)
          begin
            if(ahb_h.Haddr[1:0]==0)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hwdata,apb_h.Pwdata);
          end
      end
    if(ahb_h.Hwrite==0)
      begin
        if(ahb_h.Hsize==0)
          begin
            if(ahb_h.Haddr[1:0]==0)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata[7:0],apb_h.Prdata[7:0]);
            if(ahb_h.Haddr[1:0]==1)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata[7:0],apb_h.Prdata[15:8]);
            if(ahb_h.Haddr[1:0]==2)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata[7:0],apb_h.Prdata[23:16]);
            if(ahb_h.Haddr[1:0]==3)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata[7:0],apb_h.Prdata[31:24]);
          end
        if(ahb_h.Hsize==1)
          begin
            if(ahb_h.Haddr[1:0]==0)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata[15:0],apb_h.Prdata[15:0]);
            if(ahb_h.Haddr[1:0]==1)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata[15:0],apb_h.Prdata[31:16]);
          end
        if(ahb_h.Hsize==2)
          begin
            if(ahb_h.Haddr[1:0]==0)
              compare(ahb_h.Haddr,apb_h.Paddr,ahb_h.Hrdata,apb_h.Prdata);
          end
      end
  endtask
endclass


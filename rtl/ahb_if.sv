interface ahb_interface(input bit Hclk);
  logic Hresetn;
  logic Hwrite;
  logic [2:0] Hsize;
  logic [1:0] Htrans;
  logic [1:0] Hresp;
  logic [31:0] Haddr;
  logic [31:0] Hwdata;
  logic [31:0] Hrdata;
  logic Hreadyin;
  logic Hreadyout;
  
  clocking ahb_drv @(posedge Hclk);
    default input #1 output #1;
    output Hwrite,Htrans,Hsize,Haddr,Hwdata,Hresetn,Hreadyin;
    input Hreadyout,Hrdata;
  endclocking
  
  clocking ahb_mon @(posedge Hclk);
    default input #1 output #1;
    input Hwrite,Htrans,Hresp,Hsize,Haddr,Hwdata,Hrdata,Hresetn;
    input Hreadyin,Hreadyout;
endclocking
 
  modport AHB_DRV(clocking ahb_drv);
    modport AHB_MON(clocking ahb_mon);

endinterface


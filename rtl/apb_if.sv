interface apb_interface(input bit Pclk);
  
  logic Pwrite;
  logic [31:0] Pwdata;
  logic [31:0] Prdata;
  logic Penable;
  logic [31:0] Paddr;
  logic [3:0] Pselx;
  
  clocking apb_drv @(posedge Pclk);
    default input #1 output #1;
    input Penable,Pselx,Pwrite,Paddr,Pwdata;
    output Prdata;
  endclocking
  
  clocking apb_mon @(posedge Pclk);
    default input #1 output #1;
    input Penable,Pselx,Paddr,Pwdata,Prdata,Pwrite;
  endclocking
  
  modport APB_DRV(clocking apb_drv);
    modport APB_MON(clocking apb_mon);

endinterface


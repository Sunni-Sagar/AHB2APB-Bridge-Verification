module top;
  import bridge_test_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  bit clock;
  always #10 clock=!clock;     

   //interface
  ahb_interface ahb_if(clock);
  apb_interface apb_if(clock);
  //dut
   rtl_top DUT(
            .Hclk(clock),
            .Hresetn(ahb_if.Hresetn),
            .Htrans(ahb_if.Htrans),
            .Hsize(ahb_if.Hsize),
            .Hreadyin(ahb_if.Hreadyin),
            .Hwdata(ahb_if.Hwdata),
            .Haddr(ahb_if.Haddr),
            .Hwrite(ahb_if.Hwrite),
            .Hrdata(ahb_if.Hrdata),
            .Hresp(ahb_if.Hresp),
            .Hreadyout(ahb_if.Hreadyout),
            .Pselx(apb_if.Pselx),
            .Pwrite(apb_if.Pwrite),
            .Penable(apb_if.Penable),
	    .Prdata(apb_if.Prdata),
            .Paddr(apb_if.Paddr),
	    .Pwdata(apb_if.Pwdata)
            ) ;


property stable;
  @(posedge clock) disable iff(!ahb_if.Hresetn)
  (ahb_if.Hreadyout==0)|=>($stable(ahb_if.Haddr)&&$stable(ahb_if.Hwrite)&&$stable(ahb_if.Htrans)&&$stable(ahb_if.Hsize));
endproperty
assert property(stable);

property addr;
  @(posedge clock) disable iff(!ahb_if.Hresetn)
  (ahb_if.Hreadyout && apb_if.Pselx)|-> ((ahb_if.Hwrite==apb_if.Pwrite)&&(ahb_if.Haddr==apb_if.Paddr));
endproperty
assert property(addr);


/*assert property(stable)
$display("Property STABLE pass");
else 
$error("Error: Property STABLE fails");
assert property(addr)
$display("Property addr pass");
else 
$error("Error: Property addr fails");
*/
  initial 
    begin
      //set config db vif
     uvm_config_db #(virtual ahb_interface)::set(null,"*","ahb_if",ahb_if);
     uvm_config_db #(virtual apb_interface)::set(null,"*","apb_if",apb_if);
     run_test();
	end

endmodule

  
   
  


module bridge_top(input hclk,hresetn,hwrite,hreadyin,
input [1:0]htrans,
input [31:0]hwdata,haddr,prdata,
output penable,pwrite,hr_readyout,
output [2:0]psel,
output [1:0]hresp,output [31:0]paddr,pwdata,hrdata);
wire [31:0]hwdata1,hwdata2,haddr1,hadddr2;
wire [2:0]temp_sel;
wire hwrite_reg,hwrite_reg1;
wire valid;

AHB_SLAVE t1(hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,valid,hwritereg1,hwritereg,tempselx,
haddr1,haddr2,hwdata1,hwdata2,hrdata);

APB_CONTROLLER t2(hclk,hresetn,hwrite,hwritereg,valid,temp_selx,haddr,haddr1,haddr2,hwdata,hwdata1,hwdata2,
prdata,pwrite,penable,hr_readyout,psel,paddr,pwdata);
endmodule

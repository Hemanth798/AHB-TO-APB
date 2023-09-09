module top_tb;
reg hclk;
reg hresetn;
wire [31:0]haddr,hwdata,hrdata,paddr,prdata,pwdata,paddr_out,pwdata_out;
wire hwrite,hreadyin;
wire [1:0]htrans;
wire [1:0]hresp;
wire penable,pwrite,hr_readyout,pwrite_out,penable_out;
wire [2:0]psel,psel_out;

AHB_MASTER AHB(hclk,hresetn,hreadyout,hradata,hresp,hwrite,hreadyin,
haddr,hwdata,htrans);

bridge_top BRIDGE(hclk,hresetn,hwrite,hreadyin,htrans,hwdata,haddr,prdata,
penable,pwrite,hr_readyout,psel,hresp,paddr,pwdata,hrdata);

APB_INTERFACE APB(pwrite,penable,psel,paddr,pwdata,pwrite_out,penable_out,
psel_out,paddr_out,pwdata_out,pr_data);

initial begin
hclk=1'b0;
forever #10 hclk=~hclk;
end

task reset;
begin
@(negedge hclk)
hresetn=1'b0;
@(negedge hclk)
hresetn=1'b1;
end
endtask
initial begin
reset;
///AHB.Single_write; #400;
//AHB.Single_read; #400;
AHB.burst_incr4_write; #400;
$finish;
end
endmodule






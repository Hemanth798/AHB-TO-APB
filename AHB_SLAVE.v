module AHB_SLAVE(input hclk,hresetn,hwrite,hreadyin,
input [1:0] htrans,
input [31:0] haddr,hwdata,prdata,
output reg valid,hwritereg1,hwritereg,
output reg [2:0]tempselx,
output reg [31:0] haddr1,haddr2,hwdata1,hwdata2, 
output wire [31:0] hrdata);
//pipeline for haddr,hwdata,write signal
always@(posedge hclk)
begin
if(!hresetn)
begin
haddr1<=0;
haddr2<=0;
end
else
begin
haddr1<=haddr;
haddr2<=haddr1;
end
end
always@(posedge hclk)
begin
if(!hresetn)
begin
hwdata1<=0;
hwdata2<=0;
end
else
begin
hwdata1<=hwdata;
hwdata2<=hwdata1;
end
end
always@(posedge hclk)
begin
if(!hresetn)
begin
hwritereg1<=0;
hwritereg<=0;
end
else
begin
hwritereg<=hwrite;
hwritereg1<=hwritereg;
end
end
//generating valid signal
always@(*)
begin
valid=0;
if(hreadyin==1&&haddr>=32'h8000_0000&&haddr<32'h8c00_0000&&(htrans==2'b10||htrans==2'b11))
valid=1;
else
valid=0;
end
//generating tempselx signal
always@(*)
begin
tempselx=3'b000;
if(haddr>=32'h8000_0000&&haddr<32'h8400_0000)
tempselx=3'b001;
if(haddr>=32'h8400_0000&&haddr<32'h8800_0000)
tempselx=3'b010;
if(haddr>=32'h8800_0000&&haddr<32'h8c00_0000)
tempselx=3'b100;
end
assign hrdata=prdata;
endmodule



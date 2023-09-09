module AHB_MASTER(input hclk,hresetn,hreadyout,
input [31:0]hradata,
input [1:0]hresp,
output reg hwrite,hreadyin,
output reg[31:0] haddr,hwdata,
output reg[1:0] htrans);
reg [2:0] hsize,hburst;
integer i=0;

task Single_write;
begin
@(posedge hclk)
#1
begin
hwrite=1;
hsize=0;
htrans=2'd2;
hburst=0;
hreadyin=1;
haddr=32'h8400_0000;
end
@(posedge hclk)
#1
begin
hwdata=32'h29;
htrans=2'd0;
end
end
endtask

task Single_read;
begin
@(posedge hclk)
#1
begin
hwrite=0;
hsize=0;
htrans=2'd2;
hburst=0;
hreadyin=1;
haddr=32'h8400_0000;
end
@(posedge hclk)
#1
begin
htrans=2'd0;
end
end
endtask

task burst_incr4_write;
begin

@(posedge hclk)
#1
begin
hwrite=1;
hsize=0;
htrans=2'd2;
hburst=3'd1;
hreadyin=1;
haddr=32'h8400_0000;
end

@(posedge hclk)
#1
begin
haddr=haddr+1;
hwdata=($random)%256;
htrans=2'd3;
end

for(i=0;i<2;i=i+1)
begin
    @(posedge hclk)
    #1
    begin
    haddr=haddr+1;
    hwdata=($random)%256;
    htrans=2'd3;
    end
    @(posedge hclk)
    begin
    end
end

@(posedge hclk)
#1
begin
hwdata=($random)%256;
htrans=2'd0;
end
end
endtask
endmodule







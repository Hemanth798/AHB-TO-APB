module APB_INTERFACE(input pwrite,penable,
input [2:0]psel,
input [31:0]paddr,pwdata,
output pwrite_out,penable_out,
output [2:0]psel_out,
output [31:0]paddr_out,pwdata_out,
output reg [31:0] pr_data);
assign pwrite_out=pwrite;
assign penable_out=penable;
assign psel_out=psel;
assign paddr_out_out=paddr;
assign pwdata_out=pwdata;
always@(*)
begin
if(!pwrite&&penable)
pr_data=32'd25;
else
pr_data=32'd0;
end
endmodule


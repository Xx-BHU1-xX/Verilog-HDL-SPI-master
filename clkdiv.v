module clkdiv (iclk,rst,oclk,ps,mode);
input iclk,rst;
input [1:0] ps,mode;//iclk is slowed down by a factor of 2^ps
output reg oclk;
reg [1:0] count;
wire CPOL;
assign CPOL = (mode==0||mode==1)?0:1;
always @ (posedge iclk,posedge rst) begin
	if(rst) begin
	count <= ps-1;
	oclk <= CPOL;
	end
	else if(count==0)begin
	count <= ps-1;
	oclk <= ~oclk;
	end
	else
	count <= count-1;
end
endmodule
	
module SPI (tv,t,MISO,iclk,rst,mode,ps,SCK,CSN,MOSI,rv,r);
input tv,MISO,iclk,rst;
input [1:0] mode,ps;
input [7:0] t;
output reg [7:0] r;
output reg CSN,MOSI,rv;
output SCK;
reg st;
clkdiv c0 (iclk,(rst||st),SCK,ps,mode);
integer edges;
integer tc;
integer rc;
wire CPOL,CPHA;
assign CPOL = (mode==2'b00||mode==2'b01)?0:1;
assign CPHA = (mode==2'b00||mode==2'b10)?0:1;
always @ (posedge iclk, posedge rst) begin
	if(rst) begin
	CSN = 1'b1;
	rv = 1'b0;
	r= 8'b00000000;
	st = 1'b1;
	MOSI = 1'b0;
	edges = 15;
	tc = 8;
	rc = 8;
	end
	
	else if (tv) begin
	CSN = 1'b0;
	st = 1'b0;
	end
end

always @ (edge SCK) begin
 if(CSN==0) begin
 if(edges==0) begin
 st = 1'b1;
 CSN = 1'b1;
 rv = 1'b1;
 end
 else
 edges = edges-1;
 end
 else
 MOSI = 1'b0;
 end
 
always @ (negedge SCK) begin
 if(CSN==0) begin
 case(CPHA^CPOL)
 1'b0 : begin
         tc = tc-1;
		 if(tc<0)
		 tc =0;
         MOSI = t[tc];
		 end
 1'b1 : begin
         rc = rc-1;
		 r[rc] = MISO;
		 end
 default : MOSI = 1'b0;
 endcase
 end
 else
 MOSI = 1'b0;
 end
 
 always @ (posedge SCK) begin
 if(CSN==0) begin
 case(CPHA^CPOL)
 1'b1 : begin
         tc = tc-1;
		 if(tc<0)
		 tc =0;
         MOSI = t[tc];
		 end
 1'b0 : begin
         rc = rc-1;
		 r[rc] = MISO;
		 end
 default : MOSI = 1'b0;
 endcase
 end
 else
 MOSI = 1'b0;
 end
 
 always @ (negedge CSN) begin
 if(mode==2'b00||mode==2'b10) begin
	tc = tc-1;
	MOSI = t[tc];
	end
 else MOSI = 1'b0;
 end
 

 endmodule

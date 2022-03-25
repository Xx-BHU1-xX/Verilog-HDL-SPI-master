module SPI_tb ;
reg clk,rst,tv,MISO;
reg [1:0] mode,ps;
reg [7:0] t;
wire [7:0] r;
wire rv,SCK,CSN,MOSI;
SPI s0 (tv,t,MISO,clk,rst,mode,ps,SCK,CSN,MOSI,rv,r);
always #2 clk <= ~clk;
initial begin
$dumpfile("SPI_tb.vcd");
$dumpvars(0,SPI_tb);
$monitor("Received vector %xh\n",r);
clk <= 1'b0;
rst <= 1'b1;
mode <= 2'b11;
MISO <= 1'b0;
tv <= 1'b0;
t <= 8'b11111111;
ps <= 2'b01;
#1 rst = 1'b0;
$display("Value being transmitted is %xh\n",t);
#10 tv = 1'b1;
#15 tv = 1'b0;
#100 $display("Final received value is %xh\n",r);
     $finish;
end
always @ *
MISO <= MOSI;
endmodule

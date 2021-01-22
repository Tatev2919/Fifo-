module fifo_tb;

parameter ad_w = 4'd4;
parameter d_w = 8'd8;

reg clk,rst,write,read;
wire full,empty;
reg [d_w-1:0] data_in;
wire [d_w-1:0] data_out;

fifo #(d_w,ad_w) f1
(clk,rst,write,read,full,empty,data_in,data_out);

initial begin
	$dumpfile("v.vcd");
	$dumpvars();
end

initial begin
	clk = 1'b1; 
	rst = 1'b1;
	read = 1'b0;
	data_in = 0;
	#18;
	rst = 1'b0;
	read = 1'b0;
	write = 1'b1;
	while (!full) begin 
		@(posedge clk) data_in = data_in + 1;
	end
	#200;
	write = 1'b0;
	read = 1'b1;
	repeat (6) begin	
		@(posedge clk) #10 read = ~read;write = ~write;
	end
	#150;
       	write = 1'b0;read = 1'b1;	
	#100;
	while (!empty)
		@(posedge clk);
	read = 1'b0;
	#200;
	$finish;
end

always #10 clk = ~clk;

endmodule

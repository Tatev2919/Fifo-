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

integer i;

initial begin
	clk = 1'b1; 
	rst = 1'b1;
	write = 1'b0;
	read = 1'b0;
	#18;
	rst = 1'b0;
	write = 1'b1;
	read = 1'b0;
	data_in = 8'b1;
	if (!full) begin 
		for (i = 0 ; i < 2**ad_w+10; i = i+1) begin
				@(posedge clk) data_in = data_in + 8'd1;
		end
	end

	write = 1'b0;
	read = 1'b1;
//	wait(full);
	#100;
	read = 1'b0;
	write = 1'b1;
	for (i = 0 ; i < 2**ad_w+10; i = i+1) begin
       			@(posedge clk) data_in = data_in + 8'd2;
	end
	write = 1'b0;
	#25;
	read = 1'b1;
	#500;
	read = 1'b0;
	#200;
	$finish;
end

always #10 clk = ~clk;

endmodule

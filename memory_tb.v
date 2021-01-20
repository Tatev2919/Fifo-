module memory_tb;
	parameter d_width = 4'd4;
	parameter a_heigth = 4'd4;

	reg  clk,read,write;
	reg  [d_width-1:0] data_in;
	wire [d_width-1:0] data_out;
	reg  [(1<<a_heigth)-1:0] read_pointer,write_pointer;
		
   	memory #(d_width,a_heigth) m1(clk,read,write,data_in,data_out,read_pointer,write_pointer);

	initial begin
		$dumpfile("w.vcd");
		$dumpvars();
	end

	initial begin
		clk = 0;
		write = 1'b1;
		write_pointer = 16'b1; 
		data_in = 4'd10;
		#25;
		write_pointer = 16'd2;
		data_in = 4'd5;
		#25;
		write_pointer = 16'd3;
		data_in = 4'd6;
		#25;
		write = 1'b0;
		read = 1'b1;
		read_pointer = 16'b1;
		#25;
		read_pointer = 16'd2;
		#25;
		read_pointer = 16'd3;
		read = 1'b0;
		#150;
		$finish;
	end

	always #10 clk = ~clk;
endmodule

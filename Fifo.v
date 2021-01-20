`include "memory.v" 
module fifo #
( parameter data_width = 4'd4,
  parameter ad_width = 4'd4)
(clk,rst,write,read,full,empty,data_in,data_out);

input clk,rst,write,read;
input [data_width-1:0] data_in;
output [data_width-1:0] data_out;
output reg full,empty;

reg [ad_width-1:0] read_pointer,write_pointer;

memory #(data_width,ad_width) m1 (
		clk,read,write,data_in,data_out,read_pointer,write_pointer);
reg write_r;

always @(posedge clk or negedge rst) begin 
	if(rst) begin
		read_pointer <= 1'b0;
		write_pointer <= 1'b0;
		empty <= 1'b0;
		full <= 1'b0;
	end
	else begin
		write_r <= write;
		if(write) begin
			empty <= 1'b0;
			if(!full) 
				write_pointer <= write_pointer + 1;
			if(write_pointer == read_pointer ) begin
				full <= 1'b1;	
			end
		end
		else if (read) begin
			full <= 1'b0;
			if(!empty) 
				read_pointer <= read_pointer + 1;
			if(read_pointer == write_pointer) 
				empty <= 1'b1;
		end
	end
end
endmodule

`include "memory.v" 

module fifo #
( parameter data_width = 4'd4,
  parameter ad_width = 4'd4)
(clk,rst,write,read,full,empty,data_in,data_out);

input                       clk,rst,write,read;
input      [data_width-1:0] data_in;
output     [data_width-1:0] data_out;
output reg                  full,empty;

reg [ad_width-1:0] read_pointer,write_pointer;

memory #(data_width,ad_width) m1 (
		write,data_in,data_out,read_pointer,write_pointer,full,empty);

reg write_r,read_r,ex_reg_w,ex_reg_r;

always @(*) begin 
	if(write_pointer == read_pointer) begin 
		if(!read && ex_reg_w) 
			full = 1'b1;
		if(!write && ex_reg_r) 
			empty = 1'b1;
	end
	else begin
		empty = 1'b0;
		full = 1'b0;
	end

end

always @(posedge clk or posedge rst) begin 
	if(rst) begin
		read_pointer <= 1'b0;
		write_pointer <= 1'b0;
	end
	else begin
		write_r <= write;
		read_r <= read;
		ex_reg_w <= write_r;
		ex_reg_r <= read_r;
		if(write_r) begin
			if(!full) 
				write_pointer <= write_pointer + 1;
		end
		else if (read_r) begin
			if(!empty) 
				read_pointer <= read_pointer + 1;
		end
	end
end

endmodule

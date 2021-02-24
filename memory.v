module memory
 #(parameter d_width=8,
   parameter a_height=10 )
   (clk,wr,rd,data_in,data_out,read_pointer,write_pointer);

localparam depth = (1 << a_height);
input  wire clk,wr,rd;
input  wire [a_height-1:0] read_pointer,write_pointer;
input  wire [d_width-1:0] data_in;
output      [d_width-1:0] data_out;

reg [d_width-1:0] mem [depth-1:0];
reg [d_width-1:0] data_out_r;
assign data_out = rd ? mem[read_pointer]:data_out_r;
	
always @(posedge clk) 
	if (wr) begin
			mem[write_pointer] <= data_in;
	end
	else 
			data_out_r <= mem[read_pointer];

endmodule

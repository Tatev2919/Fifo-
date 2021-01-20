module memory
 #(parameter d_width=8,
   parameter a_height=10 )
   (clk,read,wr,data_in,data_out,read_pointer,write_pointer);

localparam depth = (1 << a_height);
input  wire clk,wr,read;
input  wire [a_height-1:0] read_pointer,write_pointer;
input  wire [d_width-1:0] data_in;
output wire [d_width-1:0] data_out;

reg [d_width-1:0] mem [depth-1:0];

assign data_out = read ? mem[read_pointer]:{d_width{1'bZ}}; 

always @(posedge clk) 
	if (wr)  begin
		mem[write_pointer] <= data_in;
	end
	
endmodule

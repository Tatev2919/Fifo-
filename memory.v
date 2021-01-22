module memory
 #(parameter d_width=8,
   parameter a_height=10 )
   (wr,data_in,data_out,read_pointer,write_pointer,full,empty);

localparam depth = (1 << a_height);
input  wire wr,full,empty;
input  wire [a_height-1:0] read_pointer,write_pointer;
input  wire [d_width-1:0] data_in;
output reg  [d_width-1:0] data_out;

reg [d_width-1:0] mem [depth-1:0];

always @(*) 
	if (wr)  begin
		if(!full)
			mem[write_pointer] <= data_in;
	end
	else begin
		if(!empty) 
			data_out <= mem[read_pointer];
	end
endmodule

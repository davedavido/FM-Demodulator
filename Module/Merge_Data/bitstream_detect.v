module bitstream_detect(
	clk,
	rst,
	data_i,
	start_o
);

input clk, rst;
input data_i;
output reg start_o;

reg [31:0] count;
reg [31:0] pattern;

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
        start_o <= 0;
		pattern <= 32'b01010101010101010101010101010101;
    end 
	else if (data_i == pattern[count]) begin
	
        count <= count + 1;
        if (count == 31) begin
            start_o <= 1;
            count <= 0;
        end
    end
	else begin
        count <= 0;
    end
end

endmodule
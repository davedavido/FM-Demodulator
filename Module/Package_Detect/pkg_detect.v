module pkg_detect  #(parameter WIDTH = 16) (clk, 
            rst,
            data_i,  
			start_o,
			valid_o);

/* Delay zu Python Demod = 7 Samples */

/* Ein - und Ausgänge */		
input clk, rst;

input signed [2*WIDTH-1:0] data_i;

output start_o, valid_o;

/* Intern */

localparam IDLE = 2'd0;
localparam START = 2'd1;
localparam STOP = 2'd2;

reg signed [2*WIDTH-1:0] data_i_r;
reg start_o_r, valid_o_r;

/*Controller*/
reg [1:0] current_state, next_state;

always @ (posedge clk) begin
	if(rst) begin
		data_i_r <= 0;
		current_state <= IDLE;
	end
	else begin
		data_i_r <= data_i;
		current_state <= next_state;
	end
end

always @ (*) begin
	next_state = current_state;
	start_o_r = 0;
	valid_o_r = 0;
	
	case(current_state)
		IDLE: begin
			start_o_r = 0;
			if (data_i_r == 32'h7FFFFFFF) begin /* 2147483647 */
				next_state = START;
			end
		end
		
		START: begin
			start_o_r = 1;
			if (data_i_r == 32'h80000000) begin /* -2147483648 */
				next_state = STOP;
			end
		end
		
		STOP: begin
			start_o_r = 0;
			valid_o_r = 1;
			next_state = IDLE;
		end
	endcase
end
assign start_o = start_o_r;
assign valid_o = valid_o_r;
			
endmodule
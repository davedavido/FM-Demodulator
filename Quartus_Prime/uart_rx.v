module uart_rx(
	clk,
	rst,
	uart_i,
	uart_data_o,
	valid_o
	);

	
	
localparam IDLE 	= 5'd0;	
localparam B0 		= 5'd1;
localparam B1 		= 5'd2;
localparam B2 		= 5'd3;
localparam B3 		= 5'd4;
localparam B4 		= 5'd5;
localparam B5 		= 5'd6;
localparam B6 		= 5'd7;
localparam B7 		= 5'd8;
localparam STOP 	= 5'd9;
localparam W0 		= 5'd10;
localparam W1 		= 5'd11;
localparam W2 		= 5'd12;
localparam W3 		= 5'd13;
localparam W4 		= 5'd14;
localparam W5 		= 5'd15;
localparam W6 		= 5'd16;
localparam W7 		= 5'd17;
localparam WI 		= 5'd18;	
	
input clk, rst;
input uart_i;
output reg [7:0] uart_data_o;
output reg valid_o;

reg 			uart_r;
reg [7:0] uart_data_r, uart_data_temp;
reg [4:0] current_state, next_state;

always @ (posedge clk) begin
	if(rst) begin
		uart_r 			<= 1'd1;
		current_state 	<= IDLE;
		uart_data_r 	<= 8'd0;
	end
	else begin
		uart_r 			<= uart_i;
		current_state 	<= next_state;
		uart_data_r 	<= uart_data_temp;
	end
end	

always @ (*) begin
		uart_data_temp = uart_data_r;
		uart_data_o 	= uart_data_r;
		next_state 		= current_state;
		valid_o 			= 1'b0;
		case(current_state)
			IDLE: begin
				uart_data_temp = 8'd0;
				if(uart_r == 1'b0 & !(rst)) begin
					next_state = WI;
				end
			end
			
			B0: begin
				next_state = W0;
				uart_data_temp[0] = uart_r;
			end
			
			WI: next_state = B0;
			W0: next_state = B1;
			W1: next_state = B2;
			W2: next_state = B3;
			W3: next_state = B4;
			W4: next_state = B5;
			W5: next_state = B6;
			W6: next_state = B7;
			W7: next_state = STOP;
			
			
			B1: begin
				next_state = W1;
				uart_data_temp[1] = uart_r;
			end			
			
			B2: begin
				next_state = W2;
				uart_data_temp[2] = uart_r;
			end			
			
			B3: begin
				next_state = W3;
				uart_data_temp[3] = uart_r;
			end	
	
			B4: begin
				next_state = W4;
				uart_data_temp[4] = uart_r;
			end
			
			B5: begin
				next_state = W5;
				uart_data_temp[5] = uart_r;
			end				
			
			B6: begin
				next_state = W6;
				uart_data_temp[6] = uart_r;
			end
		
			B7: begin
				next_state = W7;
				uart_data_temp[7] = uart_r;
			end	
			
			STOP: begin
				next_state = IDLE;
				if(uart_r == 1'b1) begin
					valid_o 			= 1'b1;
				end
			end
			
		endcase
	
end


	
	
endmodule
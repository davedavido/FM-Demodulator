module uart_tx(
	clk,
	rst,
	uart_o,
	uart_data_i,
	valid_i,
	ready_o,
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
localparam STOP2 	= 5'd19;	
	
input clk, rst;
output  reg uart_o;
output reg ready_o;
input [7:0] uart_data_i;
input valid_i;

reg 			 valid_r;
reg [7:0] uart_data_r, uart_data_temp, uart_data_input_r;
reg [4:0] current_state, next_state;

always @ (posedge clk) begin
	if(rst) begin
		current_state 		<= IDLE;
		uart_data_r 		<= 8'd0;
		uart_data_input_r <= 8'd0;
		valid_r 				<= 1'b0;
	end
	else begin
		current_state 		<= next_state;
		uart_data_r 		<= uart_data_temp;
		uart_data_input_r <= uart_data_i;
		valid_r 				<= valid_i;
	end
end	

always @ (*) begin
		uart_data_temp = uart_data_r;
		next_state 		= current_state;
		uart_o 			= 1'b1;
		ready_o 			= 1'b0;
		case(current_state)
			IDLE: begin
				uart_data_temp = uart_data_input_r;
				ready_o 			= 1'b1;
				if(valid_r == 1'b1) begin
					next_state 		= WI;
					uart_o 			= 1'b0;
					ready_o 			= 1'b0;
				end
			end
			
			B0: begin
				next_state = W0;
				uart_o 			= uart_data_r[0];
			end
			
			WI: begin next_state = B0; uart_o 			= 1'b0; end
			W0: begin next_state = B1; uart_o 			= uart_data_r[0]; end
			W1: begin next_state = B2; uart_o 			= uart_data_r[1]; end
			W2: begin next_state = B3; uart_o 			= uart_data_r[2]; end
			W3: begin next_state = B4; uart_o 			= uart_data_r[3]; end
			W4: begin next_state = B5; uart_o 			= uart_data_r[4]; end
			W5: begin next_state = B6; uart_o 			= uart_data_r[5]; end
			W6: begin next_state = B7; uart_o 			= uart_data_r[6]; end
			W7: begin next_state = STOP;  uart_o 			= uart_data_r[7]; end
			
			
			B1: begin
				next_state = W1;
				uart_o 			= uart_data_r[1];
			end			
			
			B2: begin
				next_state = W2;
				uart_o 			= uart_data_r[2];
			end			
			
			B3: begin
				next_state = W3;
				uart_o 			= uart_data_r[3];
			end	
	
			B4: begin
				next_state = W4;
				uart_o 			= uart_data_r[4];
			end
			
			B5: begin
				next_state = W5;
				uart_o 			= uart_data_r[5];
			end				
			
			B6: begin
				next_state = W6;
				uart_o 			= uart_data_r[6];
			end
		
			B7: begin
				next_state = W7;
				uart_o 			= uart_data_r[7];
			end	
			
			STOP: begin
				next_state 		= STOP2;
				uart_o 			= 1'b1;
				
			end
			
			STOP2: begin
				next_state 		= IDLE;
				uart_o 			= 1'b1;
				ready_o 			= 1'b1;
				if(valid_r == 1'b1) begin
					uart_data_temp = uart_data_input_r;
					next_state 		= WI;
					uart_o 			= 1'b0;
					ready_o 			= 1'b0;
				end
			end
			
		endcase
	
end


	
	
endmodule
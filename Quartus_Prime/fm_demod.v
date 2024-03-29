module fm_demod(
	clk,
	btn_i,
	uart_i,
	uart_o,
);

input 					clk;
input 					btn_i, uart_i;
output wire 			uart_o;


reg 	[7:0]				uart_rx_r, uart_rx_temp;
wire 	[7:0]				uart_rx;
wire  [7:0]				uart_tx;
wire 						clk_logic;
wire 						uart_rx_valid;
wire						merge_finished;
reg 						uart_tx_send;

wire [31:0]				data_complex;
wire [15:0]				mult_to_avg, avg_to_fir, fir_to_split;

/* Reset Definition */
wire 						rst_p;
assign 					rst_p = ~btn_i; /* user button is high if not pressed*/

/* PLL Instantiation */
logic_pll PLL(
	.inclk0(clk),
	.c0(clk_logic)
);


/* UART Rx Instantiation */
uart_rx RX(
	.clk				(clk_logic),
	.rst				(rst_p),
	.uart_i			(uart_i),
	.uart_data_o	(uart_rx),
	.valid_o			(uart_rx_valid)
	);

/* UART Tx Instantiation */
uart_tx TX(
	.clk				(clk_logic),
	.rst				(rst_p),
	.uart_o			(uart_o),
	.uart_data_i	(uart_tx),
	.valid_i			(uart_tx_send)
	);

/* merge_data Instantiation */	
merge_data MERGE(
	.clk					(clk_logic),
	.rst					(rst_p),
	.data_uart_i		(uart_rx),
	.start_i				(uart_rx_valid),
	.merge_finished_o	(merge_finished),
	.data_o				(data_complex)
);

/* conj_c_mult Instantiation */
conj_c_mult MULT(
	.clk					(clk_logic),      
   .rst					(rst_p),
   .start_i				(uart_rx_valid),
	.merge_finished_i	(merge_finished),				
   .real_i				(data_complex[31:16]),
	.imag_i				(data_complex[15:0]),
   .demod_o				(mult_to_avg)
);

/* avg_128 Instantiation*/
avg_128 AVG(
	.clk					(clk_logic),
	.rst					(rst_p),
   .start_i				(uart_rx_valid),
	.merge_finished_i	(merge_finished),	
	.data_i				(mult_to_avg),
	.data_o				(avg_to_fir)
);

/* fir_17 Instantiation*/
fir_17 FIR(
	.clk					(clk_logic),
	.rst					(rst_p),
   .start_i				(uart_rx_valid),
	.merge_finished_i	(merge_finished),
	.data_i				(avg_to_fir),
	.data_o				(fir_to_split)
);

/* split_data Instantiation*/
split_data SPLIT(
	.clk					(clk_logic),
	.rst					(rst_p),
	.start_i				(uart_rx_valid),
	.merge_finished_i	(merge_finished),
	.data_i				(fir_to_split),
	.data_uart_o		(uart_tx)
);
	
/* Sequential Logic */
	
always @ (posedge clk_logic) begin
	if(rst_p) begin // synchronous reset
		uart_rx_r 	<= 8'd0;
	end
	else begin
		uart_rx_r <= uart_rx_temp;
	end
end

always @ (*) begin
	uart_rx_temp 	= uart_rx_r;
	 uart_tx_send 	= 1'b0;
	if(uart_rx_valid) begin
		uart_rx_temp = uart_rx;
		uart_tx_send = 1'b1;
	end
end



endmodule
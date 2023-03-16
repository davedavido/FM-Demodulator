module top (clk, 
            rst,
            data_i,
			start_i,
            data_o,
			valid_o);

/* Delay zu Python Demod = 7 Samples */

/* Parameter */
parameter WIDTH = 16;

/* Ein - und Ausgänge */		
input clk, rst;
input start_i;
input signed [7:0] data_i;
output wire	signed [15:0] data_o; //nichtmehr signed, da bytes sonst falsch formatiert
output wire valid_o;

/* Intern */
wire [2*WIDTH-1:0] merge_to_mult;
wire [WIDTH-1:0] mult_to_avg;
wire [WIDTH-1:0] avg_to_fir;
wire [WIDTH-1:0] fir_to_split;
wire merge_finished;
wire start;

merge_data MERGE_DATA(
    .clk				(clk),
	.rst				(rst),
	.data_uart_i		(data_i),
	.start_i			(start_i),
    .merge_finished_o	(merge_finished),
    .data_o				(merge_to_mult)
);



/* pkg_detect PKG_DETECT(
.clk			(clk),
.rst			(rst),
.data_i			(data_i),
.start_o		(start),
.valid_o		(valid_o)
); */

conj_c_mult CONJ_C_MULT(
.clk				(clk),
.rst				(rst),
.start_i			(start_i),
.merge_finished_i 	(merge_finished),
.real_i				(merge_to_mult[31:16]), /*Upper 16 Bits of Input Data*/
.imag_i				(merge_to_mult[15:0]), /*Lower 16 Bits of Input Data*/
.demod_o			(mult_to_avg)
);

avg_128 AVG_128(
.clk				(clk),
.rst				(rst),
.start_i			(start_i),
.merge_finished_i	(merge_finished),
.data_i				(mult_to_avg),
.data_o				(data_o)
);

fir_17 FIR_17(
.clk				(clk),
.rst				(rst),
.start_i			(start_i),
.merge_finished_i 	(merge_finished),
.data_i				(avg_to_fir),
.data_o				(fir_to_split)
); 

/* split_data SPLIT_DATA(
.clk				(clk),
.rst				(rst),
.start_i			(start_i),
.merge_finished_i 	(merge_finished),
.data_i				(fir_to_split),
.data_uart_o		(data_o)
);
	 */		
			
endmodule
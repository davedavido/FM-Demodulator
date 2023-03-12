module top (clk, 
            rst,
            data_i,  
            data_o,
			valid_o);

/* Delay zu Python Demod = 7 Samples */

/* Parameter */
parameter WIDTH = 16;

/* Ein - und Ausgänge */		
input clk, rst;

input signed [2*WIDTH-1:0] data_i;
output wire signed [WIDTH-1:0] data_o;
output wire valid_o;

/* Intern */
wire [WIDTH-1:0] mult_to_avg;
wire [WIDTH-1:0] avg_to_fir;
wire start;

pkg_detect PKG_DETECT(
.clk			(clk),
.rst			(rst),
.data_i			(data_i),
.start_o		(start),
.valid_o		(valid_o)
);

conj_c_mult CONJ_C_MULT(
.clk			(clk),
.rst			(rst),
.start_i		(start),
.real_i			(data_i[31:16]), /*Upper 16 Bits of Input Data*/
.imag_i			(data_i[15:0]), /*Lower 16 Bits of Input Data*/
.demod_o		(mult_to_avg)
);

avg_128 AVG_128(
.clk			(clk),
.rst			(rst),
.start_i		(start),
.data_i			(mult_to_avg),
.data_o			(avg_to_fir)
);

fir_17 FIR_17(
.clk			(clk),
.rst			(rst),
.start_i		(start),
.data_i			(avg_to_fir),
.data_o			(data_o)
);
			
			
endmodule
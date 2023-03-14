module merge_data #(parameter WIDTH = 16) (clk, 
            rst,
            data_uart_i,
			start_i,
			merge_finished_o,
			data_o);

/* Ein- und Ausgänge */		
input clk, rst;
input start_i;
input data_uart_i;  /* 1-Bit from UART Streaming */ 

output  reg merge_finished_o; /*32-Bit value ready */
output reg signed [2*WIDTH-1:0] data_o;

/*Buffer*/
reg buff [0:31];		

reg	[4:0] count_r, count;                    // Zähler für die Anzahl der Samples 0-31

reg merge_finished_r;

always @ (posedge clk) begin

        if (rst) begin
            /* reset buffer*/
            buff[0] <= 0;
            buff[1] <= 0;       
            buff[2] <= 0;       
            buff[3] <= 0;
			buff[4] <= 0;
			buff[5] <= 0;
			buff[6] <= 0;
			buff[7] <= 0;
			buff[8] <= 0;
			buff[9] <= 0;
			buff[10] <= 0;
			buff[11] <= 0;
			buff[12] <= 0;
			buff[13] <= 0;
			buff[14] <= 0;
			buff[15] <= 0;
			buff[16] <= 0;
			buff[17] <= 0;
			buff[18] <= 0;
			buff[19] <= 0;
			buff[20] <= 0;
			buff[21] <= 0;
			buff[22] <= 0;
			buff[23] <= 0;
			buff[24] <= 0;
			buff[25] <= 0;
			buff[26] <= 0;
			buff[27] <= 0;
			buff[28] <= 0;
			buff[29] <= 0;
			buff[30] <= 0;
			buff[31] <= 0;
			
			count_r  <= 0;
			
			merge_finished_r <= 0;
		end
		
		else begin
			count_r  <= count;
			
			if (count_r==31) begin   /* count_r ist um 1 verzögert, count_r ==0 ,  sonst count ==31 */
				merge_finished_r <= 1;
			end
			else begin 
				merge_finished_r <= 0;
			end
			
			/* Update Buffer */
			buff[0]   <= data_uart_i;
			buff[1]   <= buff[0];        
			buff[2]   <= buff[1];         
			buff[3]   <= buff[2];
			buff[4]   <= buff[3];
			buff[5]   <= buff[4];
			buff[6]   <= buff[5];
			buff[7]   <= buff[6];
			buff[8]   <= buff[7];
			buff[9]   <= buff[8];
			buff[10]  <= buff[9];
			buff[11]  <= buff[10];
			buff[12]  <= buff[11];
			buff[13]  <= buff[12];
			buff[14]  <= buff[13];
			buff[15]  <= buff[14];
			buff[16]  <= buff[15];
			buff[17]  <= buff[16];
			buff[18]  <= buff[17];
			buff[19]  <= buff[18];
			buff[20]  <= buff[19];
			buff[21]  <= buff[20];
			buff[22]  <= buff[21];
			buff[23]  <= buff[22];
			buff[24]  <= buff[23];
			buff[25]  <= buff[24];
			buff[26]  <= buff[25];
			buff[27]  <= buff[26];
			buff[28]  <= buff[27];
			buff[29]  <= buff[28];
			buff[30]  <= buff[29];
			buff[31]  <= buff[30];	
		end 
end

always @(*) begin
	count = count_r;
	data_o = {buff[31], buff[30], buff[29], buff[28],buff[27], buff[26], buff[25], buff[24],buff[23], buff[22], buff[21], buff[20],buff[19], buff[18], buff[17], buff[16],buff[15], buff[14], buff[13], buff[12],buff[11], buff[10], buff[9], buff[8],buff[7], buff[6], buff[5], buff[4], buff[3], buff[2], buff[1], buff[0]};  /* MSB comes first -Last in Buffer*/
	merge_finished_o = merge_finished_r;
	
	if (start_i) begin
		count = count_r +1;
	end
end		

/* assign data_o = {buff[31], buff[30], buff[29], buff[28],buff[27], buff[26], buff[25], buff[24],buff[23], buff[22], buff[21], buff[20],buff[19], buff[18], buff[17], buff[16],buff[15], buff[14], buff[13], buff[12],buff[11], buff[10], buff[9], buff[8],buff[7], buff[6], buff[5], buff[4], buff[3], buff[2], buff[1], buff[0]};  /* MSB comes first -Last in Buffer
assign merge_finished_o = merge_finished_r; */
endmodule

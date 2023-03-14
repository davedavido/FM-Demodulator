module split_data #(parameter WIDTH = 16) (clk, 
            rst,
			start_i,
			merge_finished_i,
			data_i,
			data_uart_o);

/* Ein- und Ausgänge */		
input clk, rst;
input start_i, merge_finished_i;
input signed [2*WIDTH-1:0] data_i;

output reg data_uart_o;


/*Buffer*/
reg	buff [0:31];		

reg			[4:0] count_r, count;                    // Zähler für die Anzahl der Samples


always @ (posedge clk) begin

        if (rst) begin
            /* reset buffer*/
            buff[0]  <= 0;
            buff[1]  <= 0;       
            buff[2]  <= 0;       
            buff[3]  <= 0; 
			buff[4]  <= 0;
			buff[5]  <= 0;
			buff[6]  <= 0;
			buff[7]  <= 0;
			buff[8]  <= 0;
			buff[9]  <= 0;
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
			
			count_r <= 0;
		end
		
		else begin
			count_r  <= count;
			
			if (merge_finished_i) begin
				/* Update Buffer
/* 				buff[0]  <= 0;
				buff[1]  <= 0;    
				buff[2]  <= data_i[15:8]; High Byte     
				buff[3]  <= data_i[7:0];  Low Byte   */
				
				buff[0]  <= data_i[31];
				buff[1]  <= data_i[30];
				buff[2]  <= data_i[29];
				buff[3]  <= data_i[28];
				buff[4]  <= data_i[27];
				buff[5]  <= data_i[26];
				buff[6]  <= data_i[25];
				buff[7]  <= data_i[24];
				buff[8]  <= data_i[23];
				buff[9]  <= data_i[22];
				buff[10] <= data_i[21];
				buff[11] <= data_i[20];
				buff[12] <= data_i[19];
				buff[13] <= data_i[19];
				buff[14] <= data_i[17];
				buff[15] <= data_i[16];
				buff[16] <= data_i[15];
				buff[17] <= data_i[14];
				buff[18] <= data_i[13];
				buff[19] <= data_i[12];
				buff[20] <= data_i[11];
				buff[21] <= data_i[10];
				buff[22] <= data_i[9];
				buff[23] <= data_i[8];
				buff[24] <= data_i[7];
				buff[25] <= data_i[6];
				buff[26] <= data_i[5];
				buff[27] <= data_i[4];
				buff[28] <= data_i[3];
				buff[29] <= data_i[2];
				buff[30] <= data_i[1];
				buff[31] <= data_i[0];
			end
		end 
end

always @(*) begin
	count = count_r;
	data_uart_o = {buff[count_r]};  /*Sends Highest Byte first*/
	
	if (start_i) begin
		count = count_r + 1;
	end
end		

//assign data_uart_o = {buff[count_r]};  /*Sends Highest Byte first*/


endmodule
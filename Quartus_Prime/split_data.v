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

output [7:0] data_uart_o;	


/*Buffer*/
reg			[7:0] buff [0:3];		

reg			[1:0] count_r, count;                    // Zähler für die Anzahl der Samples


always @ (posedge clk) begin

        if (rst) begin
            /* reset buffer*/
            buff[0]<= 0;
            buff[1]<= 0;       
            buff[2]<= 0;       
            buff[3]<= 0; 
			
				count_r <= 0;
		end
		
		else begin

			count_r  <= count;

			if (merge_finished_i) begin
				/* Update Buffer */
				buff[0]  <= data_i[31:24]; /*High Byte*/ 
				buff[1]  <= data_i[23:16];    
				buff[2]  <= data_i[15:8];      
				buff[3]  <= data_i[7:0];  /*Low Byte*/  
			end
		end 
end

always @(*) begin
	count = count_r;
	if (start_i) begin
		count = count_r + 1;
	end
end		

assign data_uart_o = {buff[count_r]};  /*Sends Lowest Byte first*/


endmodule
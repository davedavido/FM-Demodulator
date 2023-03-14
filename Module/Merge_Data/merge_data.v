module merge_data #(parameter WIDTH = 16) (clk, 
            rst,
            data_uart_i,
			start_i,
			merge_finished_o,
			data_o);

/* Ein- und Ausgänge */		
input clk, rst;
input start_i;
input signed [7:0] data_uart_i;

output merge_finished_o;
output signed [2*WIDTH-1:0] data_o;

/*Buffer*/
reg signed 	[7:0] buff [0:3];		

reg			[1:0] count_r, count;                    // Zähler für die Anzahl der Samples

reg merge_finished_r;

always @ (posedge clk) begin

        if (rst) begin
            /* reset buffer*/
            buff[0]<= 0;
            buff[1]<= 0;       
            buff[2]<= 0;       
            buff[3]<= 0; 
			
			count_r <= 0;
			merge_finished_r <= 0;
		end
		
		else begin
			count_r  <= count;
			
			/* Update Buffer */
            buff[0]  <= data_uart_i;
            buff[1]  <= buff[0];        
            buff[2]  <= buff[1];         
            buff[3]  <= buff[2];  
		end 
end

always @(*) begin
	count = count_r;
	merge_finished_r = 0;
	
	if (start_i) begin
		count = count_r +1;
		
		if (!count_r) begin   /* count_r ist um 1 verzögert, count_r ==0 ,  sonst count ==3 */
			merge_finished_r = 1;
		end
	end
end		

assign data_o = {buff[3], buff[2], buff[1], buff[0]};  /* MSB comes first -Last in Buffer*/
assign merge_finished_o = merge_finished_r;
endmodule
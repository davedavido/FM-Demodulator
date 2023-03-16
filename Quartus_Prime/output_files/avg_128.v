module avg_128 #(parameter WIDTH = 16, 
                parameter SAMPLES = 128)   
                (clk,      
                rst,
                start_i,
					 merge_finished_i,
                data_i,   
                data_o);


/*Ein- und Ausgänge */
input clk, rst;
input start_i;
input merge_finished_i;
input signed [WIDTH-1:0] data_i;       // Eingangssignal
output wire signed [WIDTH-1:0] data_o;   // Ausgangssignal

/*Intern*/

reg signed [WIDTH-1:0] buff [0:SAMPLES-1];       
reg signed [WIDTH+2:0] sum; 			//19-Bit for adding 3 16-Bit Vals
reg signed [WIDTH+2:0] sum_r; 		//19-Bit for adding 3 16-Bit Vals
reg signed [WIDTH-1:0] data_i_r;              
reg              [6:0] count;                    
reg              [6:0] count_r; 

integer i;

always @(posedge clk) begin
    if (rst) begin
    sum_r 		<= 0;
    count_r 	<= 0;
	 data_i_r 	<= 0;
	
		for (i = 0; i < SAMPLES; i = i + 1) begin
			buff[i] <= 0;
		end
    end

    else begin
		count_r 			<= count;
        sum_r 			<= sum;
		
		if (merge_finished_i & start_i) begin
			data_i_r		<= data_i;
			buff [count_r] 	<= data_i_r;
		end
    end
end

always @(*) begin
	count = count_r;
	sum   = sum_r;
	
    if (merge_finished_i & start_i) begin
		count 	= count_r + 1;
		sum 	= sum_r + data_i_r - buff[count_r];
    end
end

assign data_o = (sum[18]) 	? (data_i_r - (sum >>> 7) - 1) : (data_i_r - (sum >>> 7)) ;
//assign data_o = (data_i_r - (sum >>> 7));  /* Wenn jetztiges Sample mit betrachtet wird*/
//assign data_o = data_i_r - mean_r; /* Ohne das jetzige Sample */

endmodule
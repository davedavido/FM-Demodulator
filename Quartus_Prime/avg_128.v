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
input signed [WIDTH-1:0] data_i;       
output wire signed [WIDTH-1:0] data_o;   

/*Intern*/

/*Buffer*/
reg signed [WIDTH-1:0] buff [0:SAMPLES-1]; 

/*20-Bit um 3 16-Bit Werte zu addieren*/      
reg signed [WIDTH+3:0] sum; 			
reg signed [WIDTH+3:0] sum_r;

/* Eingangsdatenregister*/ 		
reg signed [WIDTH-1:0] data_i_r; 

/* Zählregister*/             
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
			data_i_r				<= data_i;
			buff [count_r] 	<= data_i_r;
		end
    end
end

always @(*) begin
	count = count_r;
	sum   = sum_r;
	
    if (merge_finished_i & start_i) begin
		count 	= count_r + 1;
		sum 		= sum_r + data_i_r - buff[count_r];
    end
end

/* Offset Korrektur für das Shiften Negativer Zahlen*/
assign data_o = (sum_r[19]) 	? (data_i_r - (sum_r >>> 7) - 1) : (data_i_r - (sum_r >>> 7)) ;

endmodule
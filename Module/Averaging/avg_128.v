module avg_128 #(parameter WIDTH = 16, 
                parameter SAMPLES = 128)   
                (clk,      
                rst,
                start_i,     
                data_i,   
                data_o);


/*Ein- und Ausgänge */
input clk, rst;
input start_i;
input signed [WIDTH-1:0] data_i;       // Eingangssignal
output wire signed  [WIDTH-1:0] data_o;   // Ausgangssignal

/*Intern*/

reg signed [WIDTH-1:0] buff [0:SAMPLES-1];       // Array für die Samples
reg signed [WIDTH+6:0] sum;                // Variable für die Summe der Samples
reg signed [WIDTH-1:0] mean;               // Variable für den Mittelwert
reg              [7:0] count;                    // Zähler für die Anzahl der Samples


reg signed [WIDTH+6:0] sum_r;                // Variable für die Summe der Samples
reg signed [WIDTH-1:0] mean_r;               // Variable für den Mittelwert
reg              [7:0] count_r;                    // Zähler für die Anzahl der Samples
reg signed [WIDTH-1:0] data_i_r;

integer i;

always @(posedge clk) begin
    if (rst) begin
    sum_r 		<= 0;
    mean_r 		<= 0;
    count_r 	<= 0;
	data_i_r 	<= 0;
	
    for (i = 0; i < SAMPLES; i = i + 1) begin
        buff[i] <= 0;
    end
	
    end

    else begin
		data_i_r		<= data_i;
        count_r 		<= count;
        buff [count_r] 	<= data_i_r;
        sum_r 			<= sum;
        mean_r 			<= mean;
    end
end

always @(*) begin
	count = count_r;
	sum   = sum_r;
	mean  = mean_r;
    if (start_i) begin
        sum 	= sum_r + data_i_r - buff[count_r];
        count 	= (count == SAMPLES-1) ? 0: count + 1;
        mean	= sum >> 7;
    end
end

assign data_o = data_i_r - mean;  /* Wenn jetztiges Sample mit betrachtet wird*/
//assign data_o = data_i_r - mean_r; /* Ohne das jetzige Sample */

endmodule
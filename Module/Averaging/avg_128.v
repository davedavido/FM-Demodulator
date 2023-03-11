module avg_128 #(parameter WIDTH = 16, 
                parameter SAMPLES = 3)   
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
reg signed [WIDTH+6:0] sum = 0;                // Variable für die Summe der Samples
reg signed [WIDTH-1:0] mean = 0;               // Variable für den Mittelwert
reg              [7:0] count = 0;                    // Zähler für die Anzahl der Samples


reg signed [WIDTH+6:0] sum_r = 0;                // Variable für die Summe der Samples
reg signed [WIDTH-1:0] mean_r = 0;               // Variable für den Mittelwert
reg              [7:0] count_r = 0;                    // Zähler für die Anzahl der Samples

always @(posedge clk) begin
    if (rst) begin
    sum_r <= 0;
    mean_r <= 0;
    count_r <= 0;
    for (integer i = 0; i < SAMPLES; i = i + 1) begin
        buff[i] <= 0;
    end
    end

    else begin
        count_r <= count;
        buff [count_r] <= data_i;
        sum_r <= sum;
        mean_r <= mean;
    end
end

always @(*) begin
    if (start_i) begin
        sum = sum_r + data_i -buff[count];
        count = (count == SAMPLES-1) ? 0: count + 1;
        mean = sum_r >> 7;
    end
end

assign data_o = data_i - mean_r;

endmodule
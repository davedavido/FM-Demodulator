module conj_c_mult #(parameter WIDTH = 16)   
                (clk,      
                rst,
                start_i,     
                real_i,
				imag_i,
                demod_o);


/*Ein- und Ausgänge */
input clk, rst;
input start_i;
input signed [WIDTH-1:0] real_i, imag_i;       		// Eingangssignal
output wire signed  [WIDTH-1:0] demod_o;   	  	    // Ausgangssignal

/*Intern*/

reg signed [WIDTH-1:0] last_in_real_r;       		// Last Input real
reg signed [WIDTH-1:0] last_in_imag_r;       		// Last Input imag

reg signed [WIDTH-1:0] real_i_r;
reg signed [WIDTH-1:0] imag_i_r;

reg signed [WIDTH-1:0] k1;
reg signed [WIDTH-1:0] k3;

reg signed [2*WIDTH-1:0] k1_r;
reg signed [2*WIDTH-1:0] k3_r;



always @(posedge clk) begin
    if (rst) begin
		last_in_real_r 		<= 0;
		last_in_imag_r 		<= 0;
		real_i_r 			<= 0;
		imag_i_r 			<= 0;
		k1_r 				<= 0;
		k3_r 				<= 0;	
	end

    else begin
		last_in_real_r	<= real_i_r;
		last_in_imag_r	<= -imag_i_r;
		real_i_r		<= real_i;
		imag_i_r		<= imag_i;
		k1_r			<= k1;
		k3_r			<= k3;
    end
end

always @(*) begin

	k1 = k1_r;
	k3 = k3_r;
	
    if (start_i) begin
		k1 = real_i_r * (last_in_real_r + last_in_imag_r);    // k1 = a*(c + conj(d)) = a* (c - d)	
		k3 = last_in_real_r  * (imag_i_r - real_i_r);   		  // k3 = c * (b - a)
    end
end


assign demod_o = k1_r + k3_r;

endmodule
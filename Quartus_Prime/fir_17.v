module fir_17#(parameter WIDTH = 32) 
			(clk, 
            rst,
			start_i,
			merge_finished_i,
            data_i,  
            data_o);


/* Ein - und Ausgänge */	
input clk, rst;
input start_i, merge_finished_i;
input signed [WIDTH-1:0] data_i;
output wire signed [WIDTH-1:0] data_o;

/* Intern */
/* FIR-Filter Taps*/
reg signed [WIDTH-1:0] h_0 ; 
reg signed [WIDTH-1:0] h_1 ;     
reg signed [WIDTH-1:0] h_2 ;    
reg signed [WIDTH-1:0] h_3 ; 
reg signed [WIDTH-1:0] h_4 ;      
reg signed [WIDTH-1:0] h_5 ;      
reg signed [WIDTH-1:0] h_6 ;      
reg signed [WIDTH-1:0] h_7 ;      
reg signed [WIDTH-1:0] h_8 ;     
reg signed [WIDTH-1:0] h_9 ; 
reg signed [WIDTH-1:0] h_10;     
reg signed [WIDTH-1:0] h_11;     
reg signed [WIDTH-1:0] h_12; 
reg signed [WIDTH-1:0] h_13;
reg signed [WIDTH-1:0] h_14; 
reg signed [WIDTH-1:0] h_15;
reg signed [WIDTH-1:0] h_16;

/*Buffer*/ 
reg signed [WIDTH-1:0] buff [0:16];

/*Multiply Stage 32-Bit * 0.16 = 48-Bit*/
reg signed [47:0] acc [0:16];
reg signed [47:0] acc_r [0:16];

/*Adder Stage*/
reg signed[47:0] sum;
reg signed[47:0] sum_r;

always @ (posedge clk) begin
        if (rst) begin

            sum_r     <= 0;

            /* reset buffer*/
            buff[0]<= 0;
            buff[1]<= 0;       
            buff[2]<= 0;       
            buff[3]<= 0;     
            buff[4]<= 0;     
            buff[5]<= 0;     
            buff[6]<= 0;   
            buff[7]<= 0;       
            buff[8]<= 0;       
            buff[9]<= 0;       
            buff[10] <= 0;        
            buff[11] <= 0;       
            buff[12] <= 0;      
            buff[13] <= 0;       
            buff[14] <= 0; 
            buff[15] <= 0; 
            buff[16] <= 0;

            /* reset multiply stage*/
            acc_r[0] <= 0;
            acc_r[1] <= 0;
            acc_r[2] <= 0;
            acc_r[3] <= 0;
            acc_r[4] <= 0;
            acc_r[5] <= 0;
            acc_r[6] <= 0;
            acc_r[7] <= 0;
            acc_r[8] <= 0;
            acc_r[9] <= 0;
            acc_r[10] <= 0;
            acc_r[11] <= 0;
            acc_r[12] <= 0;
            acc_r[13] <= 0;
            acc_r[14] <= 0;
            acc_r[15] <= 0;
            acc_r[16] <= 0;
            
            /* Set Coeffs FKF 0.16 - Cutoff: 10kHz fs: 200kHz*/
            h_0  = 16'd166;
            h_1  = 16'd376;     
            h_2  = 16'd964;     
            h_3  = 16'd2062;
            h_4  = 16'd3636;     
            h_5  = 16'd5468;    
            h_6  = 16'd7202;    
            h_7  = 16'd8445;   
            h_8  = 16'd8897;     
            h_9  = 16'd8445;
            h_10 = 16'd7202;    
            h_11 = 16'd5468;     
            h_12 = 16'd3636;
            h_13 = 16'd2062;
            h_14 = 16'd964;
            h_15 = 16'd376;
            h_16 = 16'd166;
                       
        end

        else begin
		  
				sum_r <= sum;
          
            /* Update Buffer if data_i valid */
				if (merge_finished_i & start_i) begin
					buff[0]  <= data_i;
					buff[1]  <= buff[0];        
					buff[2]  <= buff[1];         
					buff[3]  <= buff[2];      
					buff[4]  <= buff[3];      
					buff[5]  <= buff[4];       
					buff[6]  <= buff[5];    
					buff[7]  <= buff[6];       
					buff[8]  <= buff[7];       
					buff[9]  <= buff[8];       
					buff[10] <= buff[9];        
					buff[11] <= buff[10];       
					buff[12] <= buff[11];       
					buff[13] <= buff[12];       
					buff[14] <= buff[13];
					buff[15] <= buff[14];
					buff[16] <= buff[15]; 
				end
			
			

           /* Register Multiplication */
					acc_r[0]    <= acc[0];
					acc_r[1]    <= acc[1];
					acc_r[2]    <= acc[2];
					acc_r[3]    <= acc[3];
					acc_r[4]    <= acc[4];
					acc_r[5]    <= acc[5];
					acc_r[6]    <= acc[6];
					acc_r[7]    <= acc[7];
					acc_r[8]    <= acc[8];
					acc_r[9]    <= acc[9];
					acc_r[10]   <= acc[10];
					acc_r[11]   <= acc[11];
					acc_r[12]   <= acc[12];
					acc_r[13]   <= acc[13];
					acc_r[14]   <= acc[14];
					acc_r[15]   <= acc[15];
					acc_r[16]   <= acc[16];
        end
    end

    
/* Kombinatorische Logik */
always @ (*)begin

	sum = sum_r;
	
	acc[0] = acc_r[0];  
	acc[1] = acc_r[1];   
	acc[2] = acc_r[2];   
	acc[3] = acc_r[3];   
	acc[4] = acc_r[4];   
	acc[5] = acc_r[5];   
	acc[6] = acc_r[6];   
	acc[7] = acc_r[7];   
	acc[8] = acc_r[8];   
	acc[9] = acc_r[9];   
	acc[10]= acc_r[10]; 
	acc[11]= acc_r[11]; 
	acc[12]= acc_r[12]; 
	acc[13]= acc_r[13]; 
	acc[14]= acc_r[14]; 
	acc[15]= acc_r[15]; 
	acc[16]= acc_r[16]; 
	
    if (merge_finished_i & start_i) begin
	
        /* Multiply Stage */
        acc[0]    = h_0 * buff[0];
        acc[1]    = h_1 * buff[1];
        acc[2]    = h_2 * buff[2];
        acc[3]    = h_3 * buff[3];
        acc[4]    = h_4 * buff[4];
        acc[5]    = h_5 * buff[5];
        acc[6]    = h_6 * buff[6];
        acc[7]    = h_7 * buff[7];
        acc[8]    = h_8 * buff[8];
        acc[9]    = h_9 * buff[9];
        acc[10]   = h_10 * buff[10];
        acc[11]   = h_11 * buff[11];
        acc[12]   = h_12 * buff[12];
        acc[13]   = h_13 * buff[13];
        acc[14]   = h_14 * buff[14];
        acc[15]   = h_15 * buff[15];
        acc[16]   = h_16 * buff[16];

        /* Accumulate stage of FIR */
		sum = acc_r[0]  +  acc_r[1]  +  acc_r[2]  +  acc_r[3]  +  acc_r[4]  +  acc_r[5]  +  acc_r[6]  +  acc_r[7]  +  acc_r[8]  +  acc_r[9]  +  acc_r[10] +  acc_r[11] +  acc_r[12] +  acc_r[13] +  acc_r[14] +  acc_r[15] +  acc_r[16];
		
    end
end 

/* Output Format = 16.0 */

assign data_o = sum_r >> 16;

endmodule
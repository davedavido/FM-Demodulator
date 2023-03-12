module top_tb;


reg					clk;
reg					rst;
reg signed [31:0]	data_i;
reg 				tmp;

integer				fd_i, fd_o;

wire signed [15:0]	data_o;
wire				valid_o;
				
top DUT(
    .clk				(clk),
	.rst				(rst),
    .data_i				(data_i),
    .data_o				(data_o),
	.valid_o			(valid_o)
);

always
	#1 	clk=!clk;
	 
initial begin
	fd_i = $fopen("Input_Merged_32.txt", "r");
	fd_o = $fopen("Output_Demod_Verilog.txt", "w");
	
	if (fd_i)     $display("File was opened successfully : %0d", fd_i);
    else      	  $display("File was NOT opened successfully : %0d", fd_i);

    if (fd_o)     $display("File was opened successfully : %0d", fd_o);
    else      	  $display("File was NOT opened successfully : %0d", fd_o);
	#10
	clk				=	0;
	data_i			=	0;
	tmp 			= 	0;
	rst				=	1;
	#10;
	rst				=	0;

end		

always @ (posedge clk) begin
	if(!rst) begin
		if (!valid_o) begin
			tmp = $fscanf(fd_i, "%d\n", data_i);
			$fwrite(fd_o, "%d\n", data_o);
		end
		else begin
			$fclose(fd_i);
			$fclose(fd_o);
			$finish;
		end
	end
end
endmodule	
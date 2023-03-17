module merge_data_tb;

// Parameter
parameter WIDTH = 16;
	

reg					clk;
reg					rst;
reg 		[7:0]	data_i;
reg 				tmp;
reg					start_i;

integer				fd_i, fd_o;

wire signed [2*WIDTH-1:0]	data_o;
wire finished_o;
				
merge_data #(.WIDTH(WIDTH)) DUT(
    .clk				(clk),
	.rst				(rst),
	.data_uart_i		(data_i),
	.start_i			(start_i),
    .merge_finished_o	(merge_finished_o),
    .data_o				(data_o)
);

always
	#1 	clk=!clk;
	 
initial begin
	fd_i = $fopen("Input_Bytes.txt", "r");
	fd_o = $fopen("Output_Merged.txt", "w");
	
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
	start_i 		=	1;

end		

always @ (posedge clk) begin
	if(start_i) begin
		if (!($feof(fd_i))) begin
			tmp = $fscanf(fd_i, "%d\n", data_i);
			if(merge_finished_o)
				$fwrite(fd_o, "%d\n", data_o);
		end else begin
			$fclose(fd_i);
			$fclose(fd_o);
			$finish;
		end
end
end
endmodule
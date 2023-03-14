module merge_data_tb;

// Parameter
parameter WIDTH = 16;
	

reg					clk;
reg					rst;
reg signed 			data_i;
reg 				tmp;
reg 				start_i;

wire signed data_o;
wire merge_finished;
wire  [2*WIDTH-1:0] merge_to_split;
wire				start;

integer				fd_i, fd_o;


/* bitstream_detect DUT0(
    .clk				(clk),
	.rst				(rst),
	.data_i				(data_i),
	.start_o			(start)
); */

				
merge_data #(.WIDTH(WIDTH)) DUT1(
    .clk				(clk),
	.rst				(rst),
	.data_uart_i		(data_i),
	.start_i			(start_i),
    .merge_finished_o	(merge_finished),
    .data_o				(merge_to_split)
);

split_data #(.WIDTH(WIDTH)) DUT2(
	.clk				(clk),
	.rst				(rst),
	.start_i			(start_i),
	.merge_finished_i	(merge_finished),
	.data_i				(merge_to_split),
	.data_uart_o 		(data_o)
);	 
initial begin
	fd_i = $fopen("input_Bits.txt", "r");
	fd_o = $fopen("Output_Loopback.txt", "w");
	
	if (fd_i)     $display("File was opened successfully : %0d", fd_i);
    else      	  $display("File was NOT opened successfully : %0d", fd_i);

    if (fd_o)     $display("File was opened successfully : %0d", fd_o);
    else      	  $display("File was NOT opened successfully : %0d", fd_o);
	
	#10
	clk				=	0;
	data_i			=	0;
	tmp 			= 	0;
	start_i			= 	0;
	rst				=	1;
	#20;
	rst				=	0;
	start_i			=	1;

end	

always
	#1 	clk=!clk;	

always @ (posedge clk) begin
	if(start_i) begin
		if (!($feof(fd_i))) begin
				tmp = $fscanf(fd_i, "%b\n", data_i);
				$fwrite(fd_o, "%b\n", data_o);
		end else begin
			$fclose(fd_i);
			$fclose(fd_o);
			$finish;
		end
end
end
endmodule
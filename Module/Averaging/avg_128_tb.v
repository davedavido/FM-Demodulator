module avg_128_tb;

  // Parameter
  parameter WIDTH = 16;
  parameter SAMPLES = 128;

  // Signale
  reg               clk;
  reg               rst;
  reg signed [WIDTH-1:0]   data_i;
  wire signed [WIDTH-1:0]  data_o;

  reg start_i;

  integer			fd_i, fd_o;

  reg 				tmp;

  // Instanz des zu testenden Moduls
  avg_128 #(.WIDTH(WIDTH), .SAMPLES(SAMPLES)) DUT (
    .clk(clk),
    .rst(rst),
    .start_i (start_i),
    .data_i(data_i),
    .data_o(data_o)
  );

always
	#1 	clk=!clk;
	 
initial begin
	fd_i = $fopen("Input.txt", "r");
	fd_o = $fopen("Output.txt", "w");
	
	if (fd_i)     $display("File was opened successfully : %0d", fd_i);
    else      	  $display("File was NOT opened successfully : %0d", fd_i);

    if (fd_o)     $display("File was opened successfully : %0d", fd_o);
    else      	  $display("File was NOT opened successfully : %0d", fd_o);
	#10
	clk				=	0;
    start_i         =   0;
	data_i			=	0;
	tmp 			= 	0;
	rst				=	1;
	#10;
	rst				=	0;
    start_i         =   1;

end		

always @ (posedge clk) begin
	if(start_i) begin
		if (!($feof(fd_i))) begin
			tmp = $fscanf(fd_i, "%d\n", data_i);
			$fwrite(fd_o, "%d\n", data_o);
		end else begin
			$fclose(fd_i);
			$fclose(fd_o);
			$finish;
		end
end
end

endmodule

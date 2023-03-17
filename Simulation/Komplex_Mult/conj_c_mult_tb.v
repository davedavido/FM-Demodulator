module conj_c_mult_tb;

  // Parameter
  parameter WIDTH = 16;

  // Signale
  reg               clk;
  reg               rst;
  reg signed [WIDTH-1:0]   real_i, imag_i;
  wire signed [WIDTH-1:0]  demod_o;

  reg start_i;

  integer			fd_i_real, fd_i_imag, fd_o;

  reg 				tmp;

  // Instanz des zu testenden Moduls
  conj_c_mult #(.WIDTH(WIDTH)) DUT (
    .clk(clk),
    .rst(rst),
	.start_i(start_i),
    .real_i (real_i),
    .imag_i(imag_i),
    .demod_o(demod_o)
  );

always
	#1 	clk=!clk;
	 
initial begin
	fd_i_real = $fopen("Real.txt", "r");
	fd_i_imag = $fopen("Imag.txt", "r");
	fd_o = $fopen("Output_Demod.txt", "w");
	
	if (fd_i_real)     $display("File was opened successfully : %0d", fd_i_real);
    else      	  $display("File was NOT opened successfully : %0d", fd_i_real);
	
	if (fd_i_imag)     $display("File was opened successfully : %0d", fd_i_imag);
    else      	  $display("File was NOT opened successfully : %0d", fd_i_imag);

    if (fd_o)     $display("File was opened successfully : %0d", fd_o);
    else      	  $display("File was NOT opened successfully : %0d", fd_o);
	#10
	clk				=	0;
    start_i         =   0;
	real_i			=	0;
	imag_i			=	0;
	tmp 			= 	0;
	rst				=	1;
	#10;
	rst				=	0;
    start_i         =   1;

end		

always @ (posedge clk) begin
	if(start_i) begin
		if (!($feof(fd_i_real))) begin
			tmp = $fscanf(fd_i_real, "%d\n", real_i);
			tmp = $fscanf(fd_i_imag, "%d\n", imag_i); 
			$fwrite(fd_o, "%d\n", demod_o);
		end else begin
			$fclose(fd_i_real);
			$fclose(fd_i_imag);
			$fclose(fd_o);
			$finish;
		end
end
end

endmodule
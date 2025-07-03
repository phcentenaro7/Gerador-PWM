
module microcontrolador (
	clk_clk,
	reset_reset_n,
	pio_d_external_connection_export,
	pio_max_external_connection_export,
	pio_div_external_connection_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[31:0]	pio_d_external_connection_export;
	output	[31:0]	pio_max_external_connection_export;
	output	[2:0]	pio_div_external_connection_export;
endmodule

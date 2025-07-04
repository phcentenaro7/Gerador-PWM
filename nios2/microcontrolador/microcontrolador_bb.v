
module microcontrolador (
	clk_clk,
	pinos_entrada_external_connection_export,
	pinos_saida_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	input	[7:0]	pinos_entrada_external_connection_export;
	output	[7:0]	pinos_saida_external_connection_export;
	input		reset_reset_n;
endmodule

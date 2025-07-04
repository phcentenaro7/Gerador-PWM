	component microcontrolador is
		port (
			clk_clk                                  : in  std_logic                    := 'X';             -- clk
			pinos_entrada_external_connection_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			pinos_saida_external_connection_export   : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n                            : in  std_logic                    := 'X'              -- reset_n
		);
	end component microcontrolador;

	u0 : component microcontrolador
		port map (
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                               clk.clk
			pinos_entrada_external_connection_export => CONNECTED_TO_pinos_entrada_external_connection_export, -- pinos_entrada_external_connection.export
			pinos_saida_external_connection_export   => CONNECTED_TO_pinos_saida_external_connection_export,   --   pinos_saida_external_connection.export
			reset_reset_n                            => CONNECTED_TO_reset_reset_n                             --                             reset.reset_n
		);


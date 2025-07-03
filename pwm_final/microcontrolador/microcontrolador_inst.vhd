	component microcontrolador is
		port (
			clk_clk                            : in  std_logic                     := 'X'; -- clk
			reset_reset_n                      : in  std_logic                     := 'X'; -- reset_n
			pio_d_external_connection_export   : out std_logic_vector(31 downto 0);        -- export
			pio_max_external_connection_export : out std_logic_vector(31 downto 0);        -- export
			pio_div_external_connection_export : out std_logic_vector(2 downto 0)          -- export
		);
	end component microcontrolador;

	u0 : component microcontrolador
		port map (
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                         clk.clk
			reset_reset_n                      => CONNECTED_TO_reset_reset_n,                      --                       reset.reset_n
			pio_d_external_connection_export   => CONNECTED_TO_pio_d_external_connection_export,   --   pio_d_external_connection.export
			pio_max_external_connection_export => CONNECTED_TO_pio_max_external_connection_export, -- pio_max_external_connection.export
			pio_div_external_connection_export => CONNECTED_TO_pio_div_external_connection_export  -- pio_div_external_connection.export
		);


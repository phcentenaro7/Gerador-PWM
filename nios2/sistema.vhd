library ieee;
use ieee.std_logic_1164.all;

entity sistema is
  port(SW: in std_logic_vector(17 downto 0);
       CLOCK_50: in std_logic;
		 LEDR: out std_logic_vector(17 downto 0);
		 KEY: in std_logic_vector(3 downto 0));
end sistema;

architecture behavior of sistema is

  -- declaração dos componentes
  component microcontrolador
		port (
			clk_clk                                  : in  std_logic                    := '0';             --                               clk.clk
			pinos_entrada_external_connection_export : in  std_logic_vector(7 downto 0) := (others => '0'); -- pinos_entrada_external_connection.export
			pinos_saida_external_connection_export   : out std_logic_vector(7 downto 0);                    --   pinos_saida_external_connection.export
			reset_reset_n                            : in  std_logic                    := '0'              --                             reset.reset_n
		);
  end component;
 

begin

  L0: microcontrolador port map(CLOCK_50, SW(7 downto 0), LEDR(7 downto 0), KEY(0));


end behavior; 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
	generic(N: integer := 8);
	port(reset: in std_logic;
		  max: in unsigned(N-1 downto 0);
		  clk: in std_logic;
		  y: out unsigned(N-1 downto 0));
end contador;

architecture comportamento of contador is

signal contagem: unsigned(N-1 downto 0) := (others => '0');

begin
process(clk, reset, contagem, max)
begin
	if rising_edge(clk) then
		if reset = '0' or contagem = max - 1 then
			contagem <= to_unsigned(0, N);
			y <= to_unsigned(0, N);
		else
			y <= contagem + 1;
			contagem <= contagem + 1;
		end if;
	end if;
end process;

end comportamento;
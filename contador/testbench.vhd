library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

constant N: integer := 8;
signal reset: std_logic := '1';
constant max: unsigned(N-1 downto 0) := to_unsigned(6, N);
signal clk: std_logic := '0';
signal y: unsigned(N-1 downto 0) := to_unsigned(0, N);

signal tb_cycles: integer := 12;

component contador is
	generic(N: integer := 8);
	port(reset: in std_logic;
		  max: in unsigned(N-1 downto 0);
		  clk: in std_logic;
		  y: out unsigned(N-1 downto 0));
end component;

begin

C: contador generic map(N) port map(reset, max, clk, y);

process
begin
	-- Comportamento esperado:
	-- * Contador completa um ciclo de contagem (k = 1:5);
	-- * Contagem retorna a 0 (k = 6);
	-- * Contador conta até 3 (k = 7:9);
	-- * Sinal de reset é zerado, levando contagem a 0 (k = 10);
	-- * Sinal de reset volta a 1, e contagem volta a incrementar (k = 11:tb_cycles).
	for k in 1 to tb_cycles loop
		if k = 10 then
			reset <= '0';
		else
			reset <= '1';
		end if;
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
	end loop;
	report "done" severity error;
	wait;
end process;

end test;
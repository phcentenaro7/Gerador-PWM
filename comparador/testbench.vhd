library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

constant N: integer := 8;
signal reset: std_logic := '1';
signal max: unsigned(7 downto 0) := to_unsigned(100, N);
signal clk: std_logic := '0';
signal contagem: unsigned(7 downto 0) := to_unsigned(0, N);
signal duty_cycle: unsigned(7 downto 0) := to_unsigned(50, N);
signal y: std_logic;

signal tb_cycles: integer := 500;

component contador is
	generic(N: integer := 8);
	port(reset: in std_logic;
		  max: in unsigned(N-1 downto 0);
		  clk: in std_logic;
		  y: out unsigned(N-1 downto 0));
end component;

component comparador is
	generic(N: integer := 8);
	port(clk: in std_logic;
		  contagem: in unsigned(N-1 downto 0);
		  duty_cycle: in unsigned(N-1 downto 0);
		  y: out std_logic);
end component;

begin

	cont: contador port map(reset, max, clk, contagem);
	comp: comparador port map(clk, contagem, duty_cycle, y);
	
process
begin
	-- Comportamento esperado:
	-- * Gera onda 50% ON por 100 ciclos de clock (k = 0:99);
	-- * Gera onda 20% ON por 100 ciclos de clock (k = 100:199);
	-- * Gera onda 70% ON por 100 ciclos de clock (k = 200:299);
	-- * Zera reset, ocasionando onda 0% ON por 100 ciclos de clock (k = 300:399);
	-- * Gera 10 ondas 50% ON ao longo de 100 ciclos de clock (k = 400:500).
	for k in 0 to tb_cycles loop
		if k = 100 then
			duty_cycle <= to_unsigned(20, N);
		elsif k = 200 then
			duty_cycle <= to_unsigned(70, N);
		elsif k = 300 then
			reset <= '0';
		elsif k = 400 then
			reset <= '1';
			max <= to_unsigned(10, N);
			duty_cycle <= to_unsigned(5, N);
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
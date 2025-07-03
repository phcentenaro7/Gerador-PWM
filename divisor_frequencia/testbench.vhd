library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity testbench is
end testbench;

architecture test of testbench is

constant N: integer := 8;
signal reset: std_logic := '1';
signal clk_in: std_logic := '0';
signal max: unsigned(N-1 downto 0) := to_unsigned(100, N);
signal div: unsigned(integer(floor(log2(real(N)))) + 1 downto 0) := to_unsigned(3, integer(floor(log2(real(N)))) + 2);
signal clk_out: std_logic := '0';

signal tb_cycles: integer := 500;

component divisor_frequencia is
	generic(N: integer := 8);
	port(reset: in std_logic;
		  clk_in: in std_logic;
		  max: in unsigned(N-1 downto 0);
		  div: in unsigned(integer(floor(log2(real(N)))) + 1 downto 0);
		  clk_out: out std_logic);
end component;

begin
	div_freq: divisor_frequencia generic map(N) port map(reset, clk_in, max, div, clk_out);
process
begin
	for k in 0 to tb_cycles loop
		if k = 100 then
			div <= div + 1;
		elsif k = 200 then
			div <= div + 1;
		elsif k = 300 then
			div <= div + 1;
		elsif k = 400 then
			div <= div + 1;
		end if;
		wait for 10 ns;
		clk_in <= '1';
		wait for 10 ns;
		clk_in <= '0';
	end loop;
	report "done" severity error;
	wait;
end process;

end test;
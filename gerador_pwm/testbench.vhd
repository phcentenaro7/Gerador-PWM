library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity testbench is
end testbench;

architecture test of testbench is

constant N: integer := 8;
signal D: unsigned(N-1 downto 0) := to_unsigned(90, N);
signal max: unsigned(N-1 downto 0) := to_unsigned(100, N);
signal reset: std_logic := '1';
signal clk_in: std_logic := '0';
signal div: unsigned(integer(floor(log2(real(N)))) + 1 downto 0) := to_unsigned(2, integer(floor(log2(real(N)))) + 2);
signal y_pwm: std_logic := '0';

signal tb_cycles: integer := 5000;

component gerador_pwm is
	generic(N: integer := 8);
	port(D: in unsigned(N-1 downto 0);
		  max: in unsigned(N-1 downto 0);
		  reset: in std_logic;
		  clk_in: in std_logic;
		  div: in unsigned(integer(floor(log2(real(N)))) + 1 downto 0);
		  y_pwm: out std_logic);
end component;

begin

	PWM: gerador_pwm generic map(N) port map(D, max, reset, clk_in, div, y_pwm);
	
process
begin
	for k in 0 to tb_cycles loop
		wait for 10 ns;
		clk_in <= '1';
		wait for 10 ns;
		clk_in <= '0';
	end loop;
	report "done" severity error;
	wait;
end process;
	
end test;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity divisor_frequencia is
	generic(N: integer := 8);
	port(reset: in std_logic;
		  clk_in: in std_logic;
		  max: in unsigned(N-1 downto 0);
		  div: in unsigned(integer(floor(log2(real(N)))) + 1 downto 0);
		  clk_out: out std_logic);
end divisor_frequencia;

architecture comportamento of divisor_frequencia is

signal bits: unsigned(N downto 0);

component contador is
	generic(N: integer := 8);
	port(reset: in std_logic;
		  max: in unsigned(N-1 downto 0);
		  clk: in std_logic;
		  y: out unsigned(N-1 downto 0));
end component;

component mux is
	generic(N: integer := 8);
	port(i: in unsigned(N downto 0);
		  sel: in unsigned(integer(floor(log2(real(N)))) + 1 downto 0);
		  y: out std_logic);
end component;

begin
	C: contador generic map(N) port map(reset, max, clk_in, bits(N downto 1));
	M: mux generic map(N) port map(i => bits, sel => div, y => clk_out);
	bits(0) <= clk_in;
	
end comportamento;
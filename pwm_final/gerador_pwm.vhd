-- O gerador PWM gera uma onda com dois valores lógicos possíveis: '0' e '1'.
-- Esta onda tem como parâmetro o duty cycle, que indica em qual porcentagem do tempo o valor de saída é '1'.
-- Por exemplo, um duty cycle de 70% indica que a saída é '1' por 70% do período da onda.
-- O gerador PWM tem 3 componentes internos, nesta ordem de operação:
-- (1) Divisor de frequência: Mantém ou reduz a frequência de clock do sistema, permitindo controlar a frequência de onda do PWM.
-- (2) Contador: Indica quantos ciclos de clock já se passaram desde o início do período atual.
-- (3) Comparador: Se baseia no valor do contador para decidir se o valor de saída é '0' ou '1'.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity gerador_pwm is
	generic(N: integer := 8);
	port(D: in unsigned(N-1 downto 0);
		  max: in unsigned(N-1 downto 0);
		  reset: in std_logic;
		  clk_in: in std_logic;
		  div: in unsigned(2 downto 0);
		  y_pwm: out std_logic);
end gerador_pwm;

architecture comportamento of gerador_pwm is

signal y_div_freq: std_logic;
signal y_contador: unsigned(N-1 downto 0);

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

component divisor_frequencia is
	port(reset: in std_logic;
		  clk_in: in std_logic;
		  div: in unsigned(2 downto 0);
		  clk_out: out std_logic);
end component;

begin

	DF: divisor_frequencia port map(reset, clk_in, div, y_div_freq);
	CT: contador generic map(N) port map(reset, max, y_div_freq, y_contador);
	CMP: comparador generic map(N) port map(clk_in, y_contador, D, y_pwm);
	
end comportamento;
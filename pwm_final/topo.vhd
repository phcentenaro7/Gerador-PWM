library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity topo is
	port(CLOCK_50: in std_logic;
		  KEY: in std_logic_vector(3 downto 0);
		  y: out std_logic);
end topo;

architecture comportamento of topo is

signal micro_D: std_logic_vector(31 downto 0);
signal micro_max: std_logic_vector(31 downto 0);
signal micro_div: std_logic_vector(2 downto 0);
signal gpwm_D: unsigned(31 downto 0);
signal gpwm_max: unsigned(31 downto 0);
signal gpwm_div: unsigned(2 downto 0);

component gerador_pwm is
	generic(N: integer := 8);
	port(D: in unsigned(N-1 downto 0);
		  max: in unsigned(N-1 downto 0);
		  reset: in std_logic;
		  clk_in: in std_logic;
		  div: in unsigned(2 downto 0);
		  y_pwm: out std_logic);
end component;

component microcontrolador is
	port (
		clk_clk                            : in  std_logic                     := '0'; --                         clk.clk
		pio_d_external_connection_export   : out std_logic_vector(31 downto 0);        --   pio_d_external_connection.export
		pio_div_external_connection_export : out std_logic_vector(2 downto 0);         -- pio_div_external_connection.export
		pio_max_external_connection_export : out std_logic_vector(31 downto 0);        -- pio_max_external_connection.export
		reset_reset_n                      : in  std_logic                     := '0'  --                       reset.reset_n
	);
end component;

begin
	MICRO: microcontrolador port map(CLOCK_50, micro_D, micro_div, micro_max, KEY(0));
	GPWM: gerador_pwm generic map(32) port map(gpwm_D, gpwm_max, KEY(0), CLOCK_50, gpwm_div, y);
	gpwm_D <= unsigned(micro_D);
	gpwm_max <= unsigned(micro_max);
	gpwm_div <= unsigned(micro_div);
	
end comportamento;
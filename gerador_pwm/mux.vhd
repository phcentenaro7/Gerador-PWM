-- O mux (multiplexador) é utilizado no divisor de frequência do gerador PWM.
-- Seu papel é obter o valor atual de um dos bits do contador interno do divisor de frequência.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity mux is
	generic(N: integer := 8);
	port(i: in unsigned(N downto 0);
		  sel: in unsigned(integer(floor(log2(real(N)))) + 1 downto 0);
		  y: out std_logic);
end mux;

architecture comportamento of mux is

begin
	y <= i(to_integer(sel));

end comportamento;
-- O comparador é o componente final do gerador PWM. Ele define se a saída é ativada ('1') ou desativada ('0').
-- Para tomar esta decisão, o comparador se baseia no sinal recebido do contador. Se este sinal for menor do que
-- o duty cycle, a saída é '1'. Senão, a saída é '0'.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparador is
	generic(N: integer := 8);
	port(clk: in std_logic;
		  contagem: in unsigned(N-1 downto 0);
		  duty_cycle: in unsigned(N-1 downto 0);
		  y: out std_logic);
end comparador;

architecture comportamento of comparador is
begin
process(clk)
begin
	if rising_edge(clk) then
		if contagem < duty_cycle then
			y <= '1';
		else
			y <= '0';
		end if;
	end if;
end process;
end comportamento;
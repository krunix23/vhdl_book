entity FREQ_TEIL is
	port(	CLK, RESET: in bit;
			COUNT: out bit_vector(2 downto 0); -- Johnson Zaehlbits
			FTEIL: out bit_vector(1 downto 0)); -- MSB: 2:1, LSB: 6:1
end FREQ_TEIL;

architecture ARCH1 of FREQ_TEIL is
signal TEMP: bit_vector(2 downto 0);
begin
P1: process(CLK, RESET)
begin
	if RESET = '1' then
		TEMP <= "000";
		FTEIL <= "00";
	elsif CLK = '1' and CLK'event then
		case TEMP is
			when "000" => TEMP <= "001";
						  FTEIL <= "01";
			when "001" => TEMP <= "011";
						  FTEIL <= "11";
			when "011" => TEMP <= "111";
						  FTEIL <= "00";
			when "111" => TEMP <= "110";
						  FTEIL <= "10";
			when "110" => TEMP <= "100";
						  FTEIL <= "00";
			when "100" => TEMP <= "000";
						  FTEIL <= "11";
			when others => TEMP <= "111";
						  FTEIL <= "11";
		end case;
	end if;
end process P1;
COUNT <= TEMP;
end ARCH1;

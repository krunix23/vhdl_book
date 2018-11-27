entity AND_V is
generic(WB		: positive := 4; -- default Wert
		DELAY	: time := 10ns); -- symbolische Signallaufzeit
port(	I		: in bit_vector(WB - 1 downto 0);
		A		: out bit);
end AND_V;

architecture UND_V of AND_V is
signal TEMP: bit;
begin
	process(I)
	begin
		TEMP <= '1';
		for k in I'range loop
			if I(k) = '0' then
				TEMP <= '0';
			end if;
		end loop;
	end process;
	A <= TEMP after DELAY;
end UND_V;

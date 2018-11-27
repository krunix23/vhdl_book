entity OR_V is
generic(WB		: positive := 4; -- default Wert
		DELAY	: time := 10ns); -- symbolische Signallaufzeit
port(	I		: in bit_vector(WB - 1 downto 0);
		A		: out bit);
end OR_V;

architecture ODER_V of OR_V is
begin
	process(I)
	begin
		A <= '0' after DELAY;
		for k in I'range loop
			if I(k) = '1' then
				A <= '1' after DELAY;
			end if;
		end loop;
	end process;
end ODER_V;


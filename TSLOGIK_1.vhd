library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity TSLOGIC_1 is
	port(	SEL: in bit_vector(1 downto 0);
			A, B: in bit;
			Y: out std_logic);
end TSLOGIC_1;

architecture ARCH1 of TSLOGIC_1 is
signal A1, B1: bit_vector(0 downto 0);
signal Y1: std_logic_vector(0 downto 0);
begin
	A1(0) <= A;
	B1(0) <= B;
	Y <= Y1(0);
	Y1 <= To_StdLogicVector(A1 and B1) when SEL(0) = '1' else "Z";
	Y1 <= To_StdLogicVector(A1 or B1) when SEL(1) = '1' else "Z";
end ARCH1;

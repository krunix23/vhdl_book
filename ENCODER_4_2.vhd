entity ENCODER_4_2 is
	port(	I_E	: in bit_vector(3 downto 0);
			A_E	: out bit_vector(1 downto 0);
			ANY	 : out bit );
end ENCODER_4_2;

architecture STRUKTUR of ENCODER_4_2 is
signal INT: bit_vector(1 downto 0); -- Interne Koppelsignal
-- Komponenten Deklaration:
component AND_V
	generic(WB		: positive;
			DELAY	: time);
	port(	I	: in bit_vector(WB - 1 downto 0);
			A	: out bit );
end component;
component OR_V
	generic(WB		: positive;
			DELAY	: time);
	port(	I		: in bit_vector(WB - 1 downto 0);
			A		: out bit );
end component;


-- Konfiguration:
for I_0: AND_V use entity WORK.AND_V(UND_V);
for all: OR_V use entity WORK.OR_V(ODER_V);

-- Instanzierung der Komponenten:
begin
I_0:	AND_V	generic map(WB => 2, DELAY => 10ns)
				port map(I_E(1 downto 0), INT(1));
I_1:	OR_V	generic map(WB => 2, DELAY => 10ns)
				port map(INT, A_E(0));
I_2:	OR_V	generic map(WB => 2, DELAY => 10ns)
				port map(I_E(3 downto 2), A_E(1));
I_3:	OR_V	generic map(WB => 4, DELAY => 10ns)
				port map(I_E, ANY);
INT(0) <= I_E(3);
end STRUKTUR;

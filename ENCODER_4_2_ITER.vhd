entity ENCODER_4_2_ITER is
generic(    AK      : positive := 4); -- Anzahl der ODER-Gatter
port(       I_E     : in bit_vector(3 downto 0);
            A_E     : out bit_vector(1 downto 0);
            ANY     : out bit);
end ENCODER_4_2_ITER;

architecture STRUKTUR of ENCODER_4_2_ITER is
signal INT, INT_1: bit_vector(1 downto 0);
-- Komponenten Deklaration
component AND_2
    generic(WB		: positive;
			DELAY	: time);
    port(   I   : in bit_vector(1 downto 0);
            A   : out bit);
end component;
component OR_2
    generic(WB		: positive;
			DELAY	: time);
    port(   I   : in bit_vector(1 downto 0);
            A   : out bit);
end component;

-- Konfiguration
for I_0: AND_2 use entity WORK.AND_V(UND_V);
for all: OR_2 use entity WORK.OR_V(ODER_V);
begin
-- Iterative Instanzierung der Komponenten
I_0:    AND_2   generic map(WB => 2, DELAY => 10ns)
                port map(I_E(2 downto 1), INT(1));
I_G:    for K in 0 to AK-1 generate
        OR_A:   if K = 0 generate
                I_A:    OR_2    generic map(WB => 2, DELAY => 10ns)
                                port map(INT, A_E(0));
                end generate OR_A;
        OR_M:   if K > 0 and K < AK-1 generate
                I_M:    OR_2    generic map(WB => 2, DELAY => 10ns)
                                port map(I_E(2*K-1 downto 2*(K-1)), INT_1(K-1));
                end generate OR_M;
        OR_E:   if K = AK-1 generate
                I_E:    OR_2    generic map(WB => 2, DELAY => 10ns)
                                port map(INT_1, ANY);
                end generate OR_E;
        end generate I_G;
    INT(0) <= I_E(3);
    A_E(1) <= INT_1(1);
end STRUKTUR;

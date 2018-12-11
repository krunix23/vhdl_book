entity ADDERX is
    generic(BREITE: natural := 4);
    port(   A, B: in bit_vector(BREITE-1 downto 0);
            CARRY_IN: in bit;
            SUM: out bit_vector(BREITE-1 downto 0);
            CARRY_OUT: out bit);
end ADDERX;

architecture STRUKT_FUNC of ADDERX is

function SUM_FUNC(AIN, BIN, CIN : bit) return bit is
begin
    return AIN xor BIN xor CIN;
end SUM_FUNC;

function CARRY_FUNC(AIN, BIN, CIN : bit) return bit is
begin
    return (AIN and BIN) or (AIN and CIN) or (BIN and CIN);
end CARRY_FUNC;

begin
    process(A, B, CARRY_IN)
    variable CARRY_VAR: bit_vector(BREITE downto 0);
    variable SUM_VAR: bit_vector(BREITE-1 downto 0);
    begin
        CARRY_VAR := (others => '0');
        SUM_VAR := (others => '0');
        CARRY_VAR(0) := CARRY_IN;
        for I in 0 to BREITE-1 loop
            SUM_VAR(I) := SUM_FUNC(A(I), B(I), CARRY_VAR(I));
            CARRY_VAR(I+1) := CARRY_FUNC(A(I), B(I), CARRY_VAR(I));
        end loop;
        SUM <= SUM_VAR;
        CARRY_OUT <= CARRY_VAR(BREITE);
    end process;
end STRUKT_FUNC;



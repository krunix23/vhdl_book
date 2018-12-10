entity PARGEN8 is
    port(   A           : in bit_vector(3 downto 0);
            B           : in bit_vector(7 downto 0);
            PUA, PUB    : out bit );
end PARGEN8;

architecture VERHALTEN of PARGEN8 is
function PARGEN(AVECT : bit_vector) return bit is
variable PU_VAR: bit;
begin -- der Funktion
    PU_VAR := '1';
    for I in AVECT'range loop
        if AVECT(I) = '1' then
            PU_VAR := not PU_VAR;
         end if;
    end loop;
    return PU_VAR;
end PARGEN; -- der Funktion
begin -- der Architektur
    PUA <= PARGEN(A);
    PUB <= PARGEN(B);
end VERHALTEN;

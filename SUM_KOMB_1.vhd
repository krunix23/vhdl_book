entity SUM_KOMB_1 is
generic(    WB      : positive := 5;
            AK      : positive := 4);
port(       SUM_IN  : in bit_vector((AK*WB)-1 downto 0);
            SUM_AUS : out bit_vector(AK*(WB-1) downto 0));
end SUM_KOMB_1;

architecture SLICES of SUM_KOMB_1 is
begin
process(SUM_IN)
    variable M: integer range 0 to WB; 
    variable L: integer range 0 to (AK-1);
    variable K: integer range 0 to (AK*WB)-2;
    begin
    K := 0; L := 0; M := WB;
    for J in 0 to (AK*(WB-1))-1 loop
        M := M-1;
        if M<1 then
            L := L+1;
            M := WB-1;
        end if;
        K := J+L;
        SUM_AUS(J) <= SUM_IN(K);
    end loop;
    SUM_AUS(AK*(WB-1)) <= SUM_IN((AK*WB)-1); -- Vorzeichenbit
end process;
end SLICES;

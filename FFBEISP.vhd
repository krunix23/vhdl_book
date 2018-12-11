entity FFBEISP is
    port( CLK, RESET, D, J, K: in bit;
          Q: out bit_vector(1 downto 0));
end FFBEISP;

architecture VERHALTEN of FFBEISP is
signal Q1, Q2: bit;

procedure DFF(signal CLK, RESET, D : in bit; signal Q: out bit) is
begin
    if RESET = '1' then
        Q <= '0';
    elsif CLK='1' and CLK'event then
        Q <= D;
    end if;
end DFF;

procedure JKFF(signal CLK, RESET: in bit; signal J, K: in bit; signal Q: inout bit) is
begin
    if RESET = '1' then
        Q <= '0';
    elsif CLK ='1' and CLK'event then
        if J = '1' and K = '1' then
            Q <= not Q;
        elsif J = '1' and K = '0' then
            Q <= '1';
        elsif J = '0' and K = '1' then
            Q <= '0';
        end if;
    end if;
end JKFF;

begin -- der Architektur
    DFF(CLK, RESET, D, Q1);
    JKFF(CLK, RESET, J, K, Q2);
    Q <= (Q2, Q1);
end VERHALTEN;           

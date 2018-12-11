use WORK.TEST_PACK.all;
entity FFBEISP_PACK is
    port( CLK, RESET, D, J, K: in bit;
          Q: out bit_vector(1 downto 0));
end FFBEISP_PACK;

architecture VERHALTEN of FFBEISP_PACK is
signal Q1, Q2: bit;
begin
    DFF(CLK, RESET, D, Q1);
    JKFF(CLK, RESET, J, K, Q2);
    Q <= (Q2, Q1);
end VERHALTEN;
    

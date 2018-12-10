library IEEE;
use IEEE.std_logic_1164.all;
entity AD_SUB_2 is
generic(        W           : positive := 3;
                K           : positive := 3);
port(           A, B        : in bit_vector((K*W)-1 downto 0);
                OP          : in bit;
                SUM_G       : out bit_vector(K*(W-1) downto 0);
                OV_G, C_B_G : out bit);
end AD_SUB_2;

architecture STRUKTUR of AD_SUB_2 is
signal C_R      : bit_vector(K-2 downto 0);
signal SUM_I    : bit_vector((K*W)-1 downto 0);
signal ZERO     : bit;
component V_AD_SUB_2
    generic(WB      : positive);
    port(A_IN, B_IN : in bit_vector(WB-1 downto 0);
         OP, C_IN   : in bit;
         SUM        : out bit_vector(WB-1 downto 0);
         OV, C_B    : out bit);
end component;
component SUM_KOMB_1
    generic(WB      : positive := W;
            AK      : positive := K);
    port(SUM_IN     : in bit_vector((AK*WB)-1 downto 0);
         SUM_AUS    : out bit_vector(AK*(WB-1) downto 0));
end component;

for I_K: SUM_KOMB_1 use entity WORK.SUM_KOMB_1(SLICES);
for all: V_AD_SUB_2 use entity WORK.V_AD_SUB_2(VECTOR_ADD);

begin
ZERO <= '0';
I_A: V_AD_SUB_2 generic map(WB => W)
                port map(A(W-1 downto 0), B(W-1 downto 0), OP, ZERO, SUM_I(W-1 downto 0), open, C_R(0));
I_G:    for n in 1 to K-2 generate
            I_I: V_AD_SUB_2 generic map(WB => W)
                            port map( A((W*(n+1))-1 downto (W*n)),
                                      B((W*(n+1))-1 downto (W*n)),
                                      OP, C_R(n-1),
                                      SUM_I( (W*(n+1))-1 downto (W*n)),
                                      open, C_R(n) );
            end generate;
I_E: V_AD_SUB_2 generic map(WB => W)
                port map( A((K*W-1) downto ((K-1)*W)),
                          B((K*W-1) downto ((K-1)*W)),
                          OP, C_R(K-2),
                          SUM_I((K*W-1) downto ((K-1)*W)),
                          OV_G, C_B_G );
I_K: SUM_KOMB_1 generic map(WB => W, AK => K)
                port map(SUM_I, SUM_G);
end STRUKTUR;


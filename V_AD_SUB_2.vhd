library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity V_AD_SUB_2 is
    generic(    WB          : positive := 3);
    port(       A_IN, B_IN  : in bit_vector(WB-1 downto 0);
                OP, C_IN    : in bit;
                SUM         : out bit_vector(WB-1 downto 0);
                OV, C_B     : out bit);
end V_AD_SUB_2;

architecture VECTOR_ADD of V_AD_SUB_2 is
signal CIN: bit_vector(0 downto 0);
begin
    CIN(0) <= C_IN;
    ADD_SUB: process(OP, CIN, A_IN, B_IN)
        variable ZW, V1, V2, V3     : signed(WB-1 downto 0);
        variable TEMP               : signed(2 downto 0);
        variable NULL_V             : signed(WB-2 downto 0);
        begin
            NULL_V := (others => '0'); -- Nullvektor-Initialisierung
            V1 := signed(To_StdLogicVector(A_IN(WB-1 downto 0)));
            V2 := signed(To_StdLogicVector(B_IN(WB-1 downto 0)));
            V3 := NULL_V & signed(To_StdLogicVector(CIN));
            if OP = '1' then
                ZW := V1 + V2 + V3;
                TEMP := (ZW(WB-1), V2(WB-1), V1(WB-1));
                case TEMP is
                    when "001" => C_B <= '1'; OV <= '0';
                    when "010" => C_B <= '1'; OV <= '0';
                    when "011" => C_B <= '0'; OV <= '1';
                    when "100" => C_B <= '1'; OV <= '1';
                    when "111" => C_B <= '1'; OV <= '0';
                    when others => C_B <= '0'; OV <= '0';
                end case;
            else
                ZW := V1 - V2 - V3;
                TEMP := (ZW(WB-1), V2(WB-1), V1(WB-1));
                case TEMP is
                    when "001" => C_B <= '1'; OV <= '1';
                    when "010" => C_B <= '1'; OV <= '0';
                    when "100" => C_B <= '1'; OV <= '0';
                    when "110" => C_B <= '0'; OV <= '1';
                    when "111" => C_B <= '1'; OV <= '0';
                    when others => C_B <= '0'; OV <= '0';
                end case;
            end if;
            SUM <= To_bitvector(std_logic_vector(ZW(WB-1 downto 0)));
    end process ADD_SUB;
end VECTOR_ADD;
        
    

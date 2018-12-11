library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TEST_RAM is
    port(   CLK     : in bit;
            EN      : in bit;
            WE      : in bit;
            ADDR    : in unsigned(7 downto 0);
            DIN     : in std_logic_vector(15 downto 0);
            DOUT1   : out std_logic_vector(15 downto 0));
end TEST_RAM;

architecture BEHAVE of TEST_RAM is

type RAM_TYPE is array (0 to 255) of std_logic_vector(15 downto 0);

signal BRAM : RAM_TYPE :=
(
X"FFFF", X"FFFE", X"FFFD", X"FFFC", X"FFFB", X"FFFA", X"FFF9", X"FFF8", 
X"FFF7", X"FFF6", X"FFF5", X"FFF4", X"FFF3", X"FFF2", X"FFF1", X"FFF0",
others => X"0000"
);

begin
P1: process(CLK)
    begin
    if CLK'event and CLK = '1' then
        if EN = '1' then
            if WE = '1' then
                BRAM(To_integer(ADDR)) <= DIN;
                DOUT1 <= DIN;
            else
                DOUT1 <= BRAM(To_integer(ADDR));
            end if;
        end if;
    end if;
end process P1;
end BEHAVE;

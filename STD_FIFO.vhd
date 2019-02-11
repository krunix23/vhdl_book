library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO is
    Generic (
           FifoDepth : natural := 8;
           DataWidth : natural := 8
           );
    Port ( DataIn   : in  STD_LOGIC_VECTOR (DataWidth-1 downto 0);
           WriteEn  : in  STD_LOGIC;
           DataOut  : out STD_LOGIC_VECTOR (DataWidth-1 downto 0);
           ReadEn   : in  STD_LOGIC;
           Empty    : out STD_LOGIC;
           Full     : out STD_LOGIC;
           Clk      : in  STD_LOGIC
           );
end FIFO;

architecture Verhalten of FIFO is

type TFifo is array(0 to FifoDepth - 1) of unsigned(DataWidth - 1 downto 0);
signal sigFifo     : TFifo;   
signal sigWriteCnt : unsigned (FifoDepth-1 downto 0) := (others => '0');
signal sigReadCnt  : unsigned (FifoDepth-1 downto 0) := (others => '0');
signal sigFull     : std_logic;
signal sigEmpty    : std_logic;

begin
    process begin
        wait until rising_edge(Clk);
        if (WriteEn='1' and sigFull='0') then
            sigFifo(to_integer(sigWriteCnt)) <= unsigned(DataIn);
            sigWriteCnt <= sigWriteCnt+1;
        end if;
        if (ReadEn='1' and sigEmpty='0') then
            DataOut <= std_logic_vector(sigFifo(to_integer(sigReadCnt))); -- Adresse getaktet --> BRAM
            sigReadCnt <= sigReadCnt+1;
        end if;
    end process;
    
    sigFull  <= '1' when sigReadCnt = sigWriteCnt+1 else '0';
    sigEmpty <= '1' when sigReadCnt = sigWriteCnt   else '0';
    Full  <= sigFull;
    Empty <= sigEmpty;

end Verhalten;
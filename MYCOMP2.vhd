library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MYCOMP2 is
	port(	clk       : in std_logic;
            reset_n   : in  std_logic := 'X';
            reset_ext : in  std_logic := 'X';
			q         : out std_logic_vector(7 downto 0);
            
           	avs_s1_chipselect  : in  std_logic;
            avs_s1_write_n     : in  std_logic;
            avs_s1_read_n      : in  std_logic;
            avs_s1_address     : in  std_logic_vector( 0 downto 0);
            avs_s1_writedata   : in  std_logic_vector(31 downto 0);
            avs_s1_readdata    : out std_logic_vector(31 downto 0));
end MYCOMP2;

architecture ARCH of MYCOMP2 is
signal OUTFREQ: std_logic := '0';
signal QINT: unsigned(7 downto 0) := (others => '0');
signal REGDATA: std_logic_vector(31 downto 0) := x"00000004";
constant FREQDIV : integer := 1000000;
begin

AVALON_IF: process (reset_n, clk)  -- Process to manage interaction between Avalon Interface and local Registers
begin
	if ( reset_n = '0' ) then
		avs_s1_readdata <= (others => '0');
		REGDATA <= (others => '0');

	elsif ( clk='1' and clk'event ) then
		if ( avs_s1_read_n = '0' and avs_s1_chipselect = '1' and avs_s1_address = b"0" ) then      -- Avalon Read Temperature
			avs_s1_readdata <= REGDATA;
		elsif ( avs_s1_write_n = '0' and avs_s1_chipselect = '1' and avs_s1_address = b"0" ) then  -- Avalon Write Enable
			REGDATA <= avs_s1_writedata;
		end if;
	end if;
end process AVALON_IF;

CLKDIV: process(clk)
	variable CNTR: integer range 0 to 2147483647 := 0;
	begin
      if clk='1' and clk'event and reset_ext = '1' then
			CNTR := CNTR + 1;
			if CNTR >= (to_integer(unsigned(REGDATA)) * FREQDIV) then
				OUTFREQ <= not OUTFREQ;
                CNTR := 0;
			end if;
		end if;
	end process CLKDIV;

KNIGHTRIDER: process(OUTFREQ)
	variable LEDNUM : integer range 0 to 26 := 0;
	begin
		if OUTFREQ='1' and OUTFREQ'event and reset_ext = '1' then
            case LEDNUM is
                when        0 => QINT <= "11110000"; LEDNUM := LEDNUM + 1;
                when        1 => QINT <= "11100001"; LEDNUM := LEDNUM + 1;
                when        2 => QINT <= "11000011"; LEDNUM := LEDNUM + 1;
                when        3 => QINT <= "10000111"; LEDNUM := LEDNUM + 1;
                when        4 => QINT <= "00001111"; LEDNUM := LEDNUM + 1;
                when        5 => QINT <= "00011111"; LEDNUM := LEDNUM + 1;
                when        6 => QINT <= "00111111"; LEDNUM := LEDNUM + 1;
                when    7|8|9 => QINT <= "11111111"; LEDNUM := LEDNUM + 1;
                when       10 => QINT <= "01111111"; LEDNUM := LEDNUM + 1;
                when       11 => QINT <= "00111111"; LEDNUM := LEDNUM + 1;
                when       12 => QINT <= "00011111"; LEDNUM := LEDNUM + 1;
                when       13 => QINT <= "00001111"; LEDNUM := LEDNUM + 1;
                when       14 => QINT <= "10000111"; LEDNUM := LEDNUM + 1;
                when       15 => QINT <= "11000011"; LEDNUM := LEDNUM + 1;
                when       16 => QINT <= "11100001"; LEDNUM := LEDNUM + 1;
                when       17 => QINT <= "11110000"; LEDNUM := LEDNUM + 1;
                when       18 => QINT <= "11111000"; LEDNUM := LEDNUM + 1;
                when       19 => QINT <= "11111100"; LEDNUM := LEDNUM + 1;
                when       20 => QINT <= "11111110"; LEDNUM := LEDNUM + 1;
                when 21|22|23 => QINT <= "11111111"; LEDNUM := LEDNUM + 1;
                when       24 => QINT <= "11111110"; LEDNUM := LEDNUM + 1;
                when       25 => QINT <= "11111100"; LEDNUM := LEDNUM + 1;
                when       26 => QINT <= "11111000"; LEDNUM := 0;
                when   others => QINT <= "11110000"; LEDNUM := 0;
            end case;
		end if;
	end process KNIGHTRIDER;
    
	q <= std_logic_vector(QINT);
    
end ARCH;

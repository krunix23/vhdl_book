package TEST_PACK is
    subtype BYTE is integer range 0 to 255;
    type FARBE is (ROT, GRUEN, BLAU);
    type PIXEL is array (ROT to BLAU) of BYTE;
    constant SCREENH: integer := 768;
    constant SCREENW: integer := 1024;
    procedure DFF(signal CLK, RESET, D : in bit; signal Q: inout bit);
    procedure JKFF(signal CLK, RESET: in bit; signal J, K: in bit; signal Q: inout bit);
end TEST_PACK;

package body TEST_PACK is

procedure DFF(signal CLK, RESET, D : in bit; signal Q: inout bit) is
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
end TEST_PACK;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramRomAdd is
    Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
       Instruction : out STD_LOGIC_VECTOR (16 downto 0));
end ProgramRomAdd;

architecture Behavioral of ProgramRomAdd is
    type rom_type is array (0 to 7) of std_logic_vector(16 downto 0);
    signal progam_ROM : rom_type := (
        "01011100000000001", -- MOVI R7, 1 ; R1 ? 1                format: 10 RRR 000 dddd
        "01000100000000010", -- MOVI R1, 2 ; R1 ? 2                 format: 10 RRR 000 dddd
        "00011100100000000", -- ADD R7, R1  ; R7 ? R7 + R1            format: 00 RaRaRa RbRbRb 0000
        "01000100000000011", -- MOVI R1, 10 ; R1 ? 3                 format: 10 RRR 000 dddd
        "00011100100000000", -- ADD R7, R1  ; R7 ? R7 + R1            format: 00 RaRaRa RbRbRb 0000
        "01100000000000110",  -- JZR R0, 6   ; If R0 = 0 jump to line 3 format: 11 RRR 0000 ddd
        "11100000000000000", -- NOP SIGNAL ENABLING                     format: 100 00000000000
        "01100000000000110"  -- JZR R0, 3   ; If R0 = 0 jump to line 3  format: 011 RRR 00000000 ddd
    );
    
    begin
    Instruction <= progam_ROM(to_integer(unsigned(Mem_address)));
end Behavioral;

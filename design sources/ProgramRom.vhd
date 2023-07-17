----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2022 10:01:04 AM
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramRom is
    Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
       Instruction : out STD_LOGIC_VECTOR (16 downto 0));
end ProgramRom;

architecture Behavioral of ProgramRom is
    type rom_type is array (0 to 7) of std_logic_vector(16 downto 0);
    signal progam_ROM : rom_type := (
        "01000100000001010", -- MOVI R1, 10 ; R1 ? 10                   format: 010 RRR 000 dddddddd
        "01001000000000001", -- MOVI R2, 1  ; R2 ? 1                    format: 010 RRR 000 dddddddd
        "00101000000000000", -- NEG R2      ; R2 ? -R2                  format: 001 RRR 000 00000000
        "00000101000000000", -- ADD R1, R2  ; R1 ? R1 + R2              format: 000 RaRaRa RbRbRb 00000000
        "01100100000000111", -- JZR R1, 7   ; If R1 = 0 jump to line 7  format: 011 RRR 00000000 ddd
        "01100000000000011", -- JZR R0, 3   ; If R0 = 0 jump to line 3  format: 011 RRR 00000000 ddd
        
        "11100000000000000", -- NOP SIGNAL ENABLING                     format: 100 00000000000
        "01100000000000110"  -- JZR R0, 3   ; If R0 = 0 jump to line 3  format: 011 RRR 00000000 ddd
    );
    begin
    Instruction <= progam_ROM(to_integer(unsigned(Mem_address)));
end Behavioral;
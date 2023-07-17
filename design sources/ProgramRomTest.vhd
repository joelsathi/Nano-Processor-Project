----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2022 07:50:51 PM
-- Design Name: 
-- Module Name: ProgramRomTest - Behavioral
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

entity ProgramRomTest is
    Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
       Instruction : out STD_LOGIC_VECTOR (16 downto 0));
end ProgramRomTest;

architecture Behavioral of ProgramRomTest is
    type rom_type is array (0 to 7) of std_logic_vector(16 downto 0);
    signal progam_ROM : rom_type := (
        "01000100001100001", -- MOVI R1, HEX 61 => 97 ; R1 ? 1    
        "01001000000010010", -- MOVI R2, HEX 12 => 18; R1 ? 2          
        "10100100000000000", -- INC R1
        "10100100000000000", -- INC R1
        "10100100000000000", -- INC R1
        "11001000000000000", -- DEC R2
        "11100000000000000", -- NOP SIGNAL ENABLING                    
        "01100000000000110"  -- JZR R0, 7   ; If R0 = 0 jump to line 3  
    );
    
    begin
    Instruction <= progam_ROM(to_integer(unsigned(Mem_address)));
end Behavioral;

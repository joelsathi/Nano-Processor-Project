----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 09:06:54 PM
-- Design Name: 
-- Module Name: TB_Program_ROM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Program_ROM is
--  Port ( );
end TB_Program_ROM;

architecture Behavioral of TB_Program_ROM is
component ProgramRomAdd
    Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
   Instruction : out STD_LOGIC_VECTOR (16 downto 0));
end component;

signal address: STD_LOGIC_VECTOR (2 downto 0);
signal data: STD_LOGIC_VECTOR (16 downto 0);

begin
UUT: ProgramRomAdd port map(
    Mem_address => address,
    Instruction => data
    );
    process begin  
        address <= "000";
        wait for 50 ns;
        address <= "001";
        wait for 50 ns;
        address <= "010";
        wait for 50 ns;
        address <= "011";
        wait for 50 ns;
        address <= "100";
        wait for 50 ns;
        address <= "101";
        wait for 50 ns;
        address <= "110";
        wait for 50 ns;
        address <= "111";
        wait;                         
    end process;


end Behavioral;
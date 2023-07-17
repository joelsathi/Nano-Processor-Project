----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 02:24:58 PM
-- Design Name: 
-- Module Name: TB_3_to_8_decoder - Behavioral
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

entity TB_3_to_8_decoder is
--  Port ( );
end TB_3_to_8_decoder;

architecture Behavioral of TB_3_to_8_decoder is
component Decoder_3_to_8 
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;
signal I: STD_LOGIC_VECTOR (2 downto 0);
signal Y: STD_LOGIC_VECTOR (7 downto 0);
begin
UUT: Decoder_3_to_8 port map(
    I=> I,
    Y => Y
);
    process begin
    I <= "000";
    wait for 50 ns;
    I <= "001";
    wait for 50 ns;
    I <= "010";
    wait for 50 ns;
    I <= "011";
    wait for 50 ns;
    I <= "100";
    wait for 50 ns;
    I <= "101";
    wait for 50 ns;
    I <= "110";
    wait for 50 ns;
    I <= "111";
    wait;  
        wait;
        
end process;

end Behavioral;

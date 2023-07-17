----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2022 02:00:24 PM
-- Design Name: 
-- Module Name: Decoder_3_to_8 - Behavioral
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

entity Decoder_3_to_8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is

begin

    PROCESS (I)
    BEGIN
        CASE I IS
            WHEN "000" =>
                Y <= "00000001";
            WHEN "001" =>
                Y <= "00000010";
            WHEN "010" =>
                Y <= "00000100";
            WHEN "011" =>
                Y <= "00001000";
            WHEN "100" =>
                Y <= "00010000";
            WHEN "101" =>
                Y <= "00100000";
            WHEN "110" =>
                Y <= "01000000";
            WHEN "111" =>
                Y <= "10000000";
            WHEN OTHERS =>
                Y <= "00000000";
        END CASE;
    END PROCESS;
   
end Behavioral;

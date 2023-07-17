----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 04:08:47 PM
-- Design Name: 
-- Module Name: TB_MUX_8X8 - Behavioral
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

entity TB_MUX_8X8 is
--  Port ( );
end TB_MUX_8X8;

architecture Behavioral of TB_MUX_8X8 is
component MUX_8_Way_8_Bit
        Port(
            RegSel: in STD_LOGIC_VECTOR(2 downto 0);
            Register_0 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_1 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_2 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_3 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_4 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_5 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_6 : in STD_LOGIC_VECTOR (7 downto 0);
            Register_7 : in STD_LOGIC_VECTOR (7 downto 0);
            AddSubInput: out STD_LOGIC_VECTOR(7 downto 0));
end component;
SIGNAL reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,y_out : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL sel : STD_LOGIC_VECTOR(2 downto 0);
begin
    UUT : MUX_8_Way_8_Bit
        PORT MAP(
            RegSel => sel,
            Register_0 => reg0,
            Register_1 => reg1,
            Register_2 => reg2,
            Register_3 => reg3,
            Register_4 => reg4,
            Register_5 => reg5,
            Register_6 => reg6,
            Register_7 => reg7,
            AddSubInput => y_out
        );
        
        process begin
            -- 11 0000 1111 1111 0110
            -- 110 000 1111 1000 1110 
            -- 110 000 1101 0110 0100
            -- 110 000 1111 0110 1011
            -- 110 001 0000 0001 0111
            reg0 <= "11110110";
            reg1 <= "10001110";
            reg2 <= "01100100";
            reg3 <= "01101011";
            reg4 <= "00010111";
            reg5 <= "11000011";
            reg6 <= "11010100";
            reg7 <= "10101001";
            sel <= "000";
            wait for 100ns;
            sel <= "001";            
            wait for 100ns;
            sel <= "010";            
            wait for 100ns;
            sel <= "011";            
            wait for 100ns;
            sel <= "100";
            wait for 100ns;
            sel <= "101";
            wait for 100ns;
            sel <= "110";
            wait for 100ns;
            sel <= "111";            
            wait;
        end process;

end Behavioral;

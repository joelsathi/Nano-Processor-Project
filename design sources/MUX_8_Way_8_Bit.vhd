----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/20/2022 07:10:21 PM
-- Design Name: 
-- Module Name: MUX_8_Way_8_Bit - Behavioral
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

entity MUX_8_Way_8_Bit is
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
end MUX_8_Way_8_Bit;

architecture Behavioral of MUX_8_Way_8_Bit is
   
begin
    
    PROCESS (RegSel, Register_0, Register_1, Register_2, Register_3, Register_4, Register_5, Register_6, Register_7)
    BEGIN
        CASE RegSel IS
            WHEN "000" => 
                AddSubInput <= Register_0;
            WHEN "001" => 
                AddSubInput <= Register_1;
            WHEN "010" => 
                AddSubInput <= Register_2;
            WHEN "011" => 
                AddSubInput <= Register_3;
            WHEN "100" => 
                AddSubInput <= Register_4;
            WHEN "101" => 
                AddSubInput <= Register_5;
            WHEN "110" => 
                AddSubInput <= Register_6;
            WHEN "111" =>
                AddSubInput <= Register_7;
            WHEN OTHERS =>
                AddSubInput <= (OTHERS => 'X');
        END CASE;
    END PROCESS;   
      
end Behavioral;

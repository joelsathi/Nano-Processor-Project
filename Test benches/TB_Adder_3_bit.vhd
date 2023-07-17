----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 01:36:52 PM
-- Design Name: 
-- Module Name: TB_Adder_3_bit - Behavioral
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

entity TB_Adder_3_bit is
--  Port ( );
end TB_Adder_3_bit;

architecture Behavioral of TB_Adder_3_bit is
    component Adder_3_Bit
        Port ( AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
               AdderOut : out STD_LOGIC_VECTOR (2 downto 0)
               );
    end component;
    
    signal adderIn : STD_LOGIC_VECTOR (2 downto 0);
    signal adderOut : STD_LOGIC_VECTOR (2 downto 0);
    
    begin
    UUT: Adder_3_Bit port map(
        AdderIn => adderIn,
        AdderOut => adderOut
    );
    process begin  
        -- program counter will send in inputs from 1 to 7
        -- adder 3 bit will add one and return the value
        adderIn <= "000";
        wait for 50 ns;
        adderIn <= "001";
        wait for 50 ns;
        adderIn <= "010";
        wait for 50 ns;
        adderIn <= "011";
        wait for 50 ns;
        adderIn <= "100";
        wait for 50 ns;
        adderIn <= "101";
        wait for 50 ns;
        adderIn <= "110";
        wait for 50 ns;
        adderIn <= "111";
        wait;                         
    end process;
end Behavioral;

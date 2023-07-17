----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 04:39:43 PM
-- Design Name: 
-- Module Name: TB_MUX_2X8 - Behavioral
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

entity TB_MUX_2X8 is
--  Port ( );
end TB_MUX_2X8;

architecture Behavioral of TB_MUX_2X8 is
component twoWay8bitMux
    Port(
        S: in STD_LOGIC;
        R0 : in STD_LOGIC_VECTOR (7 downto 0);
        R1 : in STD_LOGIC_VECTOR (7 downto 0);
        Q: out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;
signal r0,r1,q : STD_LOGIC_VECTOR (7 downto 0);
signal s: STD_LOGIC;
begin
    UUT : twoWay8bitMux
        PORT MAP(
            S => s,
            R0 => r0,
            R1 => r1,
            Q => q
        );
    process begin
        r0 <= "11110110";
        r1 <= "10001110";
        s <= 'X';
        wait for 100ns;
        s <= '0';
        wait for 450ns;
        s <= '1';
        wait;
        
    end process;

end Behavioral;

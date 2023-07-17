----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 08:44:15 PM
-- Design Name: 
-- Module Name: TB_Slow_Clk - Behavioral
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

entity TB_Slow_Clk is
--  Port ( );
end TB_Slow_Clk;

architecture Behavioral of TB_Slow_Clk is

    COMPONENT Slow_Clk
        Port ( Clk_in : in STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end COMPONENT;
    
    SIGNAL clk: STD_LOGIC := '0';
    SIGNAL slowClk : STD_LOGIC;

begin

    UUT: Slow_Clk PORT MAP(
        Clk_in => clk,
        Clk_out => slowClk
    );
    
    PROCESS
    BEGIN
        WAIT FOR 5ns;
        clk <= NOT(clk);
    END PROCESS;


end Behavioral;

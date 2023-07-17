----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 01:54:10 PM
-- Design Name: 
-- Module Name: TB_Sev_Seg_Clk - Behavioral
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

entity TB_Sev_Seg_Clk is
--  Port ( );
end TB_Sev_Seg_Clk;

architecture Behavioral of TB_Sev_Seg_Clk is

    COMPONENT SevSegCnt     
        Port ( Clk_in : in STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end COMPONENT;

SIGNAL clk_in : STD_LOGIC := '0';
SIGNAL sevSegClk : STD_LOGIC;

begin

    UUT: SevSegCnt PORT MAP(
        Clk_in => clk_in,
        Clk_out => sevSegClk
    );
    
    PROCESS 
    BEGIN
        WAIT FOR 5ns;
        clk_in <= NOT(clk_in);
    END PROCESS;


end Behavioral;

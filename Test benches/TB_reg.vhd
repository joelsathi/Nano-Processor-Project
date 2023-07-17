----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 02:18:54 PM
-- Design Name: 
-- Module Name: TB_reg - Behavioral
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

entity TB_reg is
--  Port ( );
end TB_reg;

architecture Behavioral of TB_reg is
component reg
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
       En : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Res : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal D : STD_LOGIC_VECTOR (7 downto 0):= "00000000";
    signal Clk : STD_LOGIC:= '0';
    signal Q : STD_LOGIC_VECTOR (7 downto 0);
    signal Res: STD_LOGIC;
    signal En: STD_LOGIC:= '0';

begin
    UUT: reg port map(
        D => D,
        Res => Res,
        En => En,
        Clk => Clk,
        Q => Q
    );
    
    Clk <= not Clk after 50ns;
    
    process begin
            Res <= '0';
            En <= '1';
            -- index no: 200694G (WARNAKULASURIYA AK)
            -- binary Representation 110 000 111 1 1111 0110
            D <= "11110110";
            wait for 150ns;          
            -- index no: 200590J (SATHIYENDRA T.J.)
            -- binary Representation 110 000 111 1 1000 1110 
            D <= "10001110";
            wait for 150ns;          
            -- index no: 200036T (AMPAVILA I.A.)
            -- binary Representation 110 000 110 1 0110 0100
            D <= "01100100";
            wait for 150ns;            
            -- index no: 200555H (SAMARAKOON R.S.A.)
            -- binary Representation 110 000 111 1 0110 1011
            D <= "01101011";
            wait for 150ns;            
            -- index no: 200727M (WIJESINGHE U.M.)
            -- binary Representation 110 001 000 0 0001 0111
            D <= "00010111";
            wait;
                
    end process;
end Behavioral;

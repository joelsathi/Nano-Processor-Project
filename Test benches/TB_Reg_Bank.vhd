----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 01:50:57 PM
-- Design Name: 
-- Module Name: TB_Reg_Bank - Behavioral
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

entity TB_Reg_Bank is
--  Port ( );
end TB_Reg_Bank;


architecture Behavioral of TB_Reg_Bank is
    component Reg_Bank
      Port (
          Reg_En: in STD_LOGIC_VECTOR (2 DOWNTO 0);
          A : in STD_LOGIC_VECTOR (7 downto 0);
          Clk : in STD_LOGIC;
          RESET_REG_BANK : in STD_LOGIC;
          B0 : out STD_LOGIC_VECTOR (7 downto 0);
          B1 : out STD_LOGIC_VECTOR (7 downto 0);
          B2 : out STD_LOGIC_VECTOR (7 downto 0);
          B3 : out STD_LOGIC_VECTOR (7 downto 0);
          B4 : out STD_LOGIC_VECTOR (7 downto 0);
          B5 : out STD_LOGIC_VECTOR (7 downto 0);
          B6 : out STD_LOGIC_VECTOR (7 downto 0);
          B7 : out STD_LOGIC_VECTOR (7 downto 0) 
    );
    end component;
    
    signal A : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal Reg_En : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Clk : STD_LOGIC := '0';
    signal RESET_REG_BANK : STD_LOGIC := '0';
    signal B0, B1, B2, B3, B4, B5, B6, B7 : STD_LOGIC_VECTOR (7 downto 0);
    
begin
    UUT: Reg_Bank port map(
            A => A,
            Reg_En => Reg_En, 
            Clk => Clk, 
            RESET_REG_BANK => RESET_REG_BANK,
            B0 => B0,
            B1 => B1,
            B2 => B2,
            B3 => B3,
            B4 => B4,
            B5 => B5,
            B6 => B6,
            B7 => B7
       );
            
    Clk <= not Clk after 50ns;
       
    process begin
            RESET_REG_BANK <= '1';
            wait for 50ns;
            RESET_REG_BANK <= '0';
            
            -- register 0 is hardcoded as 0 for negation
            -- register 7 is hardcoded as 1 for adder program
            
            -- index no: 200694G (WARNAKULASURIYA AK)
            -- binary Representation 110 000 111 1 1111 0110
            A <= "11110110";
            Reg_En <= "001"; 
            wait for 150ns;          
            -- index no: 200590J (SATHIYENDRA T.J.)
            -- binary Representation 110 000 111 1 1000 1110 
            A <= "10001110";
            Reg_En <= "010"; 
            wait for 150ns;          
            -- index no: 200036T (AMPAVILA I.A.)
            -- binary Representation 110 000 110 1 0110 0100
            A <= "01100100";
            Reg_En <= "011"; 
            wait for 150ns;            
            -- index no: 200555H (SAMARAKOON R.S.A.)
            -- binary Representation 110 000 111 1 0110 1011
            A <= "01101011";
            Reg_En <= "100"; 
            wait for 150ns;            
            -- index no: 200727M (WIJESINGHE U.M.)
            -- binary Representation 110 001 000 0 0001 0111
            A <= "00010111";
            Reg_En <= "101"; 
            wait;
          
    end process;

end Behavioral;

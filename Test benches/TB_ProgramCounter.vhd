----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 03:29:08 PM
-- Design Name: 
-- Module Name: TB_ProgramCounter - Behavioral
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

entity TB_ProgramCounter is
--  Port ( );
end TB_ProgramCounter;

architecture Behavioral of TB_ProgramCounter is
Component ProgramCounter
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res: in STD_LOGIC;  -- SIGNAL TO RESET
           Load : in STD_LOGIC; -- SIGNAL TO LOAD 
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Clk : std_logic := '0';
signal D, Q : std_logic_vector (2 downto 0);
signal Res, Load : std_logic;

begin

UUT: ProgramCounter
    port map(
        Clk => Clk,
        D => D,
        Q => Q,
        Res => Res,
        Load => Load);
        
process
begin
    wait for 5ns;
    Clk <= not(Clk);
end process;

process
begin

    D <= "110";     -- "From Warnakulasuriya Index Last 3 Bits"
    
    Load <= '0';
    Res <= '1';
    
    wait for 100ns;
        
    Res <= '0';
    Load <= '1';
    
    wait for 100ns;
    
    D <= "110";     -- "From Sathiyendra Index Last 3 Bits"
    wait for 100ns;
    
    D <= "100";     -- "From Ampavila Index Last 3 Bits"
    wait for 100ns;
    
    D <= "011";     -- "From Samarakoon Index Last 3 Bits"
    wait for 100ns;
    
    D <= "111";     -- "From Wijesinghe Index Last 3 Bits"
    wait;

end process;


end Behavioral;

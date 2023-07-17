----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 03:59:38 PM
-- Design Name: 
-- Module Name: TB_Mux_2_way_3bit - Behavioral
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

entity TB_Mux_2_way_3bit is
--  Port ( );
end TB_Mux_2_way_3bit;

architecture Behavioral of TB_Mux_2_way_3bit is

component Mux_2_to_3
    Port (
        AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
        JumpAdd : in STD_LOGIC_VECTOR (2 downto 0);
        Jump : in STD_LOGIC;
        PC_in : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal AdderIn, JumpAdd, PC_in : std_logic_vector (2 downto 0);
signal Jump : std_logic; 

begin

UUT: Mux_2_to_3
    port map(
        AdderIn => AdderIn,
        JumpAdd => JumpAdd,
        Jump => Jump,
        PC_in => PC_in);
        
process
begin

    AdderIn <= "110";       -- "From Warnakulasuriya Index Last 3 Bits"
    JumpAdd <= "100";       -- "From Ampavila Index Last 3 Bits"
    
    Jump <= '0';
    wait for 50ns;
    Jump <= '1';
    wait for 50ns;
    
    AdderIn <= "100";       -- "From Ampavila Index Last 3 Bits"
    JumpAdd <= "110";       -- "From Sathiyendra Index Last 3 Bits"
    
    Jump <= '0';
    wait for 50ns;
    Jump <= '1';
    wait for 50ns;
    
    AdderIn <= "110";       -- "From Sathiyendra Index Last 3 Bits"
    JumpAdd <= "011";       -- "From Samarakoon Index Last 3 Bits"
    
    Jump <= '0';
    wait for 50ns;
    Jump <= '1';
    wait for 50ns;
    
    AdderIn <= "011";       -- "From Samarakoon Index Last 3 Bits"
    JumpAdd <= "111";       -- "From Wijesinghe Index Last 3 Bits"
    
    Jump <= '0';
    wait for 50ns;
    Jump <= '1';
    wait for 50ns;
    
    AdderIn <= "111";       -- "From Wijesinghe Index Last 3 Bits"
    JumpAdd <= "110";       -- "From Warnakulasuriya Index Last 3 Bits"
    
    Jump <= '0';
    wait for 50ns;
    Jump <= '1';
    wait;
    
    

end process;


end Behavioral;

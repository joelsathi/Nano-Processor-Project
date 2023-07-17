----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kavindu Warnakulasuriya
-- Create Date: 05/26/2022 05:35:31 PM
-- Design Name: 
-- Module Name: RCA - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder_3_Bit is
    Port ( AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
           AdderOut : out STD_LOGIC_VECTOR (2 downto 0)
           );
end Adder_3_Bit;
architecture Behavioral of Adder_3_Bit is

begin   
      AdderOut <= AdderIn + "001";
end Behavioral;
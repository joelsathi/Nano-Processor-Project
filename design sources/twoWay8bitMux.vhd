----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/20/2022 07:41:59 PM
-- Design Name: 
-- Module Name: twoWay8bitMux - Behavioral
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



----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity twoWay8bitMux is
        Port(
            S: in STD_LOGIC;
            R0 : in STD_LOGIC_VECTOR (7 downto 0);
            R1 : in STD_LOGIC_VECTOR (7 downto 0);
            Q: out STD_LOGIC_VECTOR(7 downto 0)
            );
end twoWay8bitMux;

architecture Behavioral of twoWay8bitMux is
    
begin
    
     PROCESS (S, R0, R1)
     BEGIN
        CASE S IS
            WHEN '0' => 
                Q <= R0;
            WHEN '1' => 
                Q <= R1;
            WHEN OTHERS => 
                Q <= (OTHERS => 'X');
        END CASE;
     END PROCESS;
      
end Behavioral;
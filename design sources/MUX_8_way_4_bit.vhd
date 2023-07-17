----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2022 01:03:06 AM
-- Design Name: 
-- Module Name: MUX_8_way_4_bit - Behavioral
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

entity MUX_8_way_4_bit is
    Port ( Register_0 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_1 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_2 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_3 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_4 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_5 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_6 : in STD_LOGIC_VECTOR (7 downto 0);
           Register_7 : in STD_LOGIC_VECTOR (7 downto 0);
           AddSubInput : out STD_LOGIC_VECTOR (7 downto 0);
           MUX_EN_ADD_SUB : in STD_LOGIC;
           RegSel : in STD_LOGIC_VECTOR (2 downto 0));
end MUX_8_way_4_bit;

architecture Behavioral of MUX_8_way_4_bit is

component Mux_8_to_1
Port ( I : in STD_LOGIC_VECTOR (7 downto 0);
       EN : in STD_LOGIC;
       Y : out STD_LOGIC;
       S : in STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7 : std_logic;

begin

Mux_8_to_1_0 : Mux_8_to_1
port map(
        I(0) => Register_0(0),
        I(1) => Register_1(0),
        I(2) => Register_2(0),
        I(3) => Register_3(0),
        I(4) => Register_4(0),
        I(5) => Register_5(0),
        I(6) => Register_6(0),
        I(7) => Register_7(0),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y0);

Mux_8_to_1_1 : Mux_8_to_1
port map(
        I(0) => Register_0(1),
        I(1) => Register_1(1),
        I(2) => Register_2(1),
        I(3) => Register_3(1),
        I(4) => Register_4(1),
        I(5) => Register_5(1),
        I(6) => Register_6(1),
        I(7) => Register_7(1),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y1);

Mux_8_to_1_2 : Mux_8_to_1
port map(
        I(0) => Register_0(2),
        I(1) => Register_1(2),
        I(2) => Register_2(2),
        I(3) => Register_3(2),
        I(4) => Register_4(2),
        I(5) => Register_5(2),
        I(6) => Register_6(2),
        I(7) => Register_7(2),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y2);
        
Mux_8_to_1_3 : Mux_8_to_1
port map(
        I(0) => Register_0(3),
        I(1) => Register_1(3),
        I(2) => Register_2(3),
        I(3) => Register_3(3),
        I(4) => Register_4(3),
        I(5) => Register_5(3),
        I(6) => Register_6(3),
        I(7) => Register_7(3),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y3);

Mux_8_to_1_4 : Mux_8_to_1
port map(
        I(0) => Register_0(4),
        I(1) => Register_1(4),
        I(2) => Register_2(4),
        I(3) => Register_3(4),
        I(4) => Register_4(4),
        I(5) => Register_5(4),
        I(6) => Register_6(4),
        I(7) => Register_7(4),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y4);

Mux_8_to_1_5 : Mux_8_to_1
port map(
        I(0) => Register_0(5),
        I(1) => Register_1(5),
        I(2) => Register_2(5),
        I(3) => Register_3(5),
        I(4) => Register_4(5),
        I(5) => Register_5(5),
        I(6) => Register_6(5),
        I(7) => Register_7(5),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y5);

Mux_8_to_1_6 : Mux_8_to_1
port map(
        I(0) => Register_0(6),
        I(1) => Register_1(6),
        I(2) => Register_2(6),
        I(3) => Register_3(6),
        I(4) => Register_4(6),
        I(5) => Register_5(6),
        I(6) => Register_6(6),
        I(7) => Register_7(6),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y6);
        
Mux_8_to_1_7 : Mux_8_to_1
port map(
        I(0) => Register_0(7),
        I(1) => Register_1(7),
        I(2) => Register_2(7),
        I(3) => Register_3(7),
        I(4) => Register_4(7),
        I(5) => Register_5(7),
        I(6) => Register_6(7),
        I(7) => Register_7(7),
        S => RegSel,
        EN => MUX_EN_ADD_SUB,
        Y => Y7);
        
        AddSubInput(0) <= Y0;
        AddSubInput(1) <= Y1;
        AddSubInput(2) <= Y2;
        AddSubInput(3) <= Y3;
        AddSubInput(4) <= Y4;
        AddSubInput(5) <= Y5;
        AddSubInput(6) <= Y6;
        AddSubInput(7) <= Y7;
        
                
end Behavioral;

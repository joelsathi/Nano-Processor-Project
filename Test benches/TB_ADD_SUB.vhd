----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/29/2022 12:47:16 AM
-- Design Name: 
-- Module Name: TB_ADD_SUB - Behavioral
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

entity TB_ADD_SUB is
--  Port ( );
end TB_ADD_SUB;

architecture Behavioral of TB_ADD_SUB is

    COMPONENT TESTER
        Port ( AddSubIn_A : in STD_LOGIC_VECTOR (7 downto 0);       -- FIRST INPUT FROM  MUX A
               AddSubIn_B : in STD_LOGIC_VECTOR (7 downto 0);       -- SECOND INPUT FROM MUX B
               AddSubOut : out STD_LOGIC_VECTOR (7 downto 0);       -- OUTPUT OF ADDITION OR SUBTRACTION
               Ctrl: in STD_LOGIC_VECTOR(1 DOWNTO 0);               -- CARRY IN
               Zero_flag : out STD_LOGIC;                           -- ZERO FLAG
               Overflow_flag : out STD_LOGIC;                       -- OVERFLOW FLAG
               Sign_flag : out STD_LOGIC;                           -- SIGN FLAG
               Carry_flag : out STD_LOGIC;                          -- CARRY FLAG
               Parity_flag : out STD_LOGIC);                        -- PARITY FLAG
    end COMPONENT;
    
SIGNAL A, B : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL ALU_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CTRL : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ZERO, OVERFLOW, SIGN, CARRY, PARITY : STD_LOGIC;

begin
    
    UUT: TESTER PORT MAP(
        AddSubIn_A => A,
        AddSubIn_B => B,
        AddSubOut => ALU_OUT,
        Ctrl => CTRL,
        Zero_flag => ZERO,
        Overflow_flag => OVERFLOW,
        Sign_flag => SIGN,
        Carry_flag => CARRY,
        Parity_flag => PARITY
    );
    
    PROCESS 
    BEGIN
        
        -- INDEX NUMBER: Kavindu => 200694G => 11 00001111 11110110
        -- ADDITION
        CTRL <= "00";
        A <= "00001111";
        B <= "11110110";
        WAIT FOR 100ns;
        
        -- INDEX NUMBER: Joel    => 200590J => 11 00001111 10001110
        -- SUBTRACTION
        CTRL <= "01";
        A <= "00001111";
        B <= "10001110";
        WAIT FOR 100ns;
        
        -- INDEX NUMBER : Inuka   => 200036T => 11 00001101 01100100
        -- MULTIPLICATION BY 2
        CTRL <= "10";
        A <= "00001101";
        WAIT FOR 100ns;
        
        -- INDEX NUMBER : Radith  => 200555H => 11 00001111 01101011
        -- DIVISION BY 2
        CTRL <= "11";
        A <= "00001111";
        WAIT FOR 100ns;
        
        -- INDEX NUMBER : Udara   => 200727M => 11 00010000 00010111
        -- CHECK ZERO FLAG
        -- SUBTRACTION
        CTRL <= "01";
        A <= "00010000";
        B <= "00010000";
        
        wait;
    END PROCESS;


end Behavioral;

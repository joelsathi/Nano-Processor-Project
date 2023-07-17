----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2022 08:42:55 PM
-- Design Name: 
-- Module Name: TB_InstructionDecoder - Behavioral
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

entity TB_InstructionDecoder is
--  Port ( );
end TB_InstructionDecoder;

architecture Behavioral of TB_InstructionDecoder is

COMPONENT InstructionDecoder
    Port ( Instruction : in STD_LOGIC_VECTOR (16 downto 0);  -- 17 BIT INSTRUCTION
           -- JUMP FROM 8 BIT VECTOR TO SIGNAL
           JMP_SEL : in STD_LOGIC;                           -- 8 BIT VALUE OF THE CORRESPONDING REGISTER
           Imd_val : out STD_LOGIC_VECTOR (7 downto 0);      -- IMMEDIATE VALUE THAT IS FROM THE INSTRUCTION
           Reg_en : out STD_LOGIC_VECTOR (2 downto 0);       -- ENABLE THE REGISTER TO SAVE IN THE REGISTER BANK
           Reg_selA : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGISTER OF MUX A
           Load_sel : out STD_LOGIC;                         -- LOAD SIGNAL TO LOAD THE VALUE TO REGISTER BANK
           Reg_selB : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGSTER OF MUX B
           Add_sub_sel : out STD_LOGIC_VECTOR(1 DOWNTO 0);   -- SELECT THE ADD/SUB INSTRUCTION
           Jump_address : out STD_LOGIC_VECTOR (2 downto 0); -- ADDRESS OF WHERE TO JUMP
           Jump : out STD_LOGIC);                            -- JUMP SIGNAL
    END COMPONENT;

signal instruction :   STD_LOGIC_VECTOR (16 downto 0);
signal jmp_sel, load_sel, jmp : STD_LOGIC;
signal imd_val: STD_LOGIC_VECTOR (7 downto 0);
signal addSubSel : STD_LOGIC_VECTOR(1 DOWNTO 0);
signal reg_en, reg_selA, reg_selB, jmpAdd : STD_LOGIC_VECTOR(2 downto 0);

begin

UUT: InstructionDecoder
    PORT MAP(
       Instruction => instruction,
       JMP_SEL => jmp_sel,                       -- 8 BIT VALUE OF THE CORRESPONDING REGISTER
       Imd_val => imd_val,
       Reg_en  => reg_en,
       Reg_selA=> reg_selA,     -- SELECT THE REGISTER OF MUX A
       Load_sel=> load_sel,                         -- LOAD SIGNAL TO LOAD THE VALUE TO REGISTER BANK
       Reg_selB=> reg_selB,     -- SELECT THE REGSTER OF MUX B
       Add_sub_sel=> addSubSel,   -- SELECT THE ADD/SUB INSTRUCTION
       Jump_address => jmpAdd, -- ADDRESS OF WHERE TO JUMP
       Jump => jmp);    

process
begin
    instruction <= "01000100011110110";  -- MOVI R1, F6 ; R1 ? 1F6                   format: 010 RRR 000 dddddddd
    jmp_sel <= '0';
    wait for 100ns;
    
    instruction <= "00101000000000000"; -- NEG R2      ; R2 ? -R2                  format: 001 RRR 000 00000000;  -- MOVI R1, 10 ; R1 ? 10                   format: 010 RRR 000 dddddddd
    wait for 100ns;
    
    instruction <= "00000101000000000"; -- ADD R1, R2  ; R1 ? R1 + R2              format: 000 RaRaRa RbRbRb 00000000  -- MOVI R1, 10 ; R1 ? 10                   format: 010 RRR 000 dddddddd
    wait for 100ns;
    
    instruction <= "01100100000000111"; -- JZR R1, 7   ; If R1 = 0 jump to line 7  format: 011 RRR 00000000 ddd
    jmp_sel<='1';
    wait for 100ns;
    
    jmp_sel <= '0';
    instruction <= "11100000000000000"; -- NOP SIGNAL ENABLING                     format: 100 00000000000
    wait for 100ns;
    
    instruction <= "10100100000000000";  --Inc                                          101 RaRaRa 000 00000000    
    
    wait for 100ns;
    
    instruction <= "11001000000000000"; -- 110 RaRaRa 000 00000000    => Dec
    wait for 100ns;
    
    instruction <= "10000101000000000"; -- 100 RaRaRa RbRbRb dddddddd => Sub
    wait for 100ns;
    
    instruction <= "10100110000000111"; -- 101 RaRaRa 100 00000000    => Mul by 2
    wait for 100ns;
    
    instruction <= "11001010000000000"; -- 110 RaRaRa 100 00000000    => Div by 2
    wait for 100ns;
end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_misc.xor_reduce;
use IEEE.NUMERIC_STD.ALL;

entity TESTER is
    Port ( AddSubIn_A : in STD_LOGIC_VECTOR (7 downto 0);       -- FIRST INPUT FROM  MUX A
           AddSubIn_B : in STD_LOGIC_VECTOR (7 downto 0);       -- SECOND INPUT FROM MUX B
           AddSubOut : out STD_LOGIC_VECTOR (7 downto 0);       -- OUTPUT OF ADDITION OR SUBTRACTION
           Ctrl: in STD_LOGIC_VECTOR(1 DOWNTO 0);               -- CARRY IN
           Zero_flag : out STD_LOGIC;                           -- ZERO FLAG
           Overflow_flag : out STD_LOGIC;                       -- OVERFLOW FLAG
           Sign_flag : out STD_LOGIC;                           -- SIGN FLAG
           Carry_flag : out STD_LOGIC;                          -- CARRY FLAG
           Parity_flag : out STD_LOGIC);                        -- PARITY FLAG
end TESTER;

architecture Behavioral of TESTER is
    SIGNAL CUR_OUT : STD_LOGIC_VECTOR(8 DOWNTO 0);

begin
    
    -- ADDING OR SUBTRACTING BASED ON CONTROL SIGNAL
    PROCESS(Ctrl, AddSubIn_A, AddSubIn_B)
    BEGIN
        CASE Ctrl IS
            WHEN "00" => 
                CUR_OUT <= ('0' & AddSubIn_A) + ('0' & AddSubIn_B);
            WHEN "01" =>
                CUR_OUT <= ('0' & AddSubIn_A) - ('0' & AddSubIn_B);
            WHEN "10" => 
                CUR_OUT <= std_logic_vector(shift_left(unsigned(('0' & AddSubIn_A)), 1));
            WHEN "11" => 
                CUR_OUT <= std_logic_vector(shift_right(unsigned(('0' & AddSubIn_A)), 1));
            WHEN OTHERS => 
                CUR_OUT <= (OTHERS => 'X');
        END CASE;
    END PROCESS;
    
    Carry_flag <= CUR_OUT(8);
    AddSubOut <= CUR_OUT(7 DOWNTO 0);
    
    Sign_flag <= CUR_OUT(7);
    Parity_flag <= XOR_Reduce(CUR_OUT(7 DOWNTO 0));
    PROCESS(CUR_OUT, AddSubIn_A, AddSubIn_B)
    BEGIN
        -- ZERO FLAG WILL BE ON WHEN EVERY BIT OF OUTPUT IS ZERO
        IF (CUR_OUT(7 DOWNTO 0) = "00000000") THEN 
            Zero_flag <= '1';
        ELSE
            Zero_flag <= '0';
        END IF;
        --OVERFLOW FLAG => ONLY HAPPENS WHEN ADDING NUMBER OF SAME SIGN
        IF (AddSubIn_A(7) = AddSubIn_B(7)) THEN
            Overflow_flag <= CUR_OUT(8);
        ELSE
            Overflow_flag <= '0';
        END IF;
    END PROCESS;

end Behavioral;
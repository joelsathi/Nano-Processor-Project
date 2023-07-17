library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionDecoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (16 downto 0);  -- 17 BIT INSTRUCTION
           JMP_SEL : in STD_LOGIC;                           -- 8 BIT VALUE OF THE CORRESPONDING REGISTER
           Imd_val : out STD_LOGIC_VECTOR (7 downto 0);      -- IMMEDIATE VALUE THAT IS FROM THE INSTRUCTION
           Reg_en : out STD_LOGIC_VECTOR (2 downto 0);       -- ENABLE THE REGISTER TO SAVE IN THE REGISTER BANK
           Reg_selA : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGISTER OF MUX A
           Load_sel : out STD_LOGIC;                         -- LOAD SIGNAL TO LOAD THE VALUE TO REGISTER BANK
           Reg_selB : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGSTER OF MUX B
           Add_sub_sel : out STD_LOGIC_VECTOR(1 DOWNTO 0);   -- SELECT THE ADD/SUB INSTRUCTION
           Jump_address : out STD_LOGIC_VECTOR (2 downto 0); -- ADDRESS OF WHERE TO JUMP
           Jump : out STD_LOGIC);                            -- JUMP SIGNAL
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is    
    component Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
 
    signal OP_ADD: STD_LOGIC  := '0';
    signal OP_NEG: STD_LOGIC  := '0';
    signal OP_MOVI: STD_LOGIC := '0';
    signal OP_JZR: STD_LOGIC  := '0';
    signal OP_SUB: STD_LOGIC  := '0';
    signal OP_INC: STD_LOGIC  := '0';
    signal OP_DEC: STD_LOGIC  := '0';
    signal OP_NOP: STD_LOGIC  := '0';
    
    signal DECODER_RESULT: std_logic_vector(7 downto 0);
    
begin

    Decoder_3_to_8_0: Decoder_3_to_8
        port map(
            I  => Instruction (16 downto 14),
            Y  => DECODER_RESULT
        );
                     
        OP_ADD  <= DECODER_RESULT(0); 
        OP_NEG  <= DECODER_RESULT(1); 
        OP_MOVI <= DECODER_RESULT(2); 
        OP_JZR  <= DECODER_RESULT(3); 
        OP_SUB  <= DECODER_RESULT(4); 
        OP_INC  <= DECODER_RESULT(5); 
        OP_DEC  <= DECODER_RESULT(6); 
        OP_NOP  <= DECODER_RESULT(7); 

        -- REGISTER A ADDRESS VALUE
        PROCESS (Instruction(13 DOWNTO 11), OP_NEG) 
        BEGIN
            IF (OP_NEG = '0') THEN 
                Reg_selA <= Instruction(13 DOWNTO 11);
            ELSE
                Reg_selA <= "000";
            END IF;
        END PROCESS;
        
      
        -- REGISTER B ADDRESS VALUE
        -- SELECT THE INSTRUCTION FOR NEGATION 
        -- SELECT THE INSTRUCTION FOR INCREMENT AND DECREMENT => SELECT REGISTER 6 (HARD CODED TO 1)
        PROCESS (Instruction(13 DOWNTO 8), OP_NEG, OP_INC, OP_DEC)
        BEGIN
            IF (OP_NEG = '1') THEN
                Reg_selB <= Instruction(13 DOWNTO 11);
            ELSIF (OP_INC = '1' OR OP_DEC = '1') THEN
                Reg_selB <= "110";
            ELSE
                Reg_selB <= Instruction(10 DOWNTO 8);
            END IF;
        END PROCESS;
         
        -- SELECT THE BIT TO SUBTRACT
        PROCESS (OP_NEG, OP_SUB, OP_DEC, OP_INC, Instruction(10))
        BEGIN
            IF (Instruction(10) = '1' AND OP_INC = '1') THEN
                Add_sub_sel <= "10";
            ELSIF (Instruction(10) = '1' AND OP_DEC = '1') THEN
                Add_sub_sel <= "11";
            ELSIF (OP_NEG = '1' OR OP_SUB = '1' OR OP_DEC = '1') THEN
                Add_sub_sel <= "01";
            ELSIF (OP_ADD = '1' OR OP_INC = '1') THEN
                Add_sub_sel <= "00";
            ELSE    
                Add_sub_sel <= (OTHERS => 'X');
            END IF;
        END PROCESS;

        
        -- ENABLE THE REGISTER IN THE REGISTER BANK
        Reg_en <= Instruction(13 downto 11);
        
        -- SELECT THE IMMEDIATE VALUE TO THE REGISTER BANK          
        Load_sel <= OP_MOVI;
        -- DATA IN THE INSTRUCTION
        Imd_val <= Instruction(7 downto 0);
        
        -- JUMP OPERATION 
        -- SELECTING THE JUMP SIGNAL
        process (JMP_SEL, OP_JZR)
        begin
            IF OP_JZR = '1' THEN 
                Jump <= JMP_SEL;
            ELSE
                Jump <= '0';
            END IF;
        end process;
                    
        -- JUMP ADDRESS SELECTION      
        Jump_address <= Instruction(2 DOWNTO 0);

end Behavioral;
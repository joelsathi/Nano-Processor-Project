library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NanoProcessor is
  Port ( Clk: in STD_LOGIC;
         Res : in STD_LOGIC;
         Halt : in STD_LOGIC;
         Zero : out STD_LOGIC;
         Overflow : out STD_LOGIC;
         SignFlag : out STD_LOGIC;
         CarryFlag : out STD_LOGIC;
         ParityFlag : out STD_LOGIC;
         REG0 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG1 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG2 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG3 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG4 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG5 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG6 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
         REG7 : out STD_LOGIC_VECTOR (7 DOWNTO 0)
  );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

    component Adder_3_Bit
        Port ( AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
               AdderOut : out STD_LOGIC_VECTOR (2 downto 0)
               );
    end component;
    
    component ProgramCounter
        Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
               Clk : in STD_LOGIC;
               Res: in STD_LOGIC;  
               Load : in STD_LOGIC; 
               Q : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    component Mux_2_to_3
        Port ( AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
               JumpAdd : in STD_LOGIC_VECTOR (2 downto 0);
               Jump : in STD_LOGIC;
               PC_in : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
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
    
    component twoWay8bitMux
        Port ( 
            S : in STD_LOGIC;
            R0: in STD_LOGIC_VECTOR (7 downto 0);
            R1: in STD_LOGIC_VECTOR (7 downto 0);
            Q: out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    component ProgramRomAdd
        Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (16 downto 0));
    end component;
    
    component InstructionDecoder
        Port ( Instruction : in STD_LOGIC_VECTOR (16 downto 0);  -- 17 BIT INSTRUCTION
               JMP_SEL : in STD_LOGIC;                           -- 8 BIT VALUE OF THE CORRESPONDING REGISTER
               Imd_val : out STD_LOGIC_VECTOR (7 downto 0);      -- IMMEDIATE VALUE THAT IS FROM THE INSTRUCTION
               Reg_en : out STD_LOGIC_VECTOR (2 downto 0);       -- ENABLE THE REGISTER TO SAVE IN THE REGISTER BANK
               Reg_selA : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGISTER OF MUX A
               Load_sel : out STD_LOGIC;                         -- LOAD SIGNAL TO LOAD THE VALUE TO REGISTER BANK
               Reg_selB : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGSTER OF MUX B
               Add_sub_sel : out STD_LOGIC_VECTOR(1 DOWNTO 0);   -- SELECT THE ADD/SUB INSTRUCTION
               Jump_address : out STD_LOGIC_VECTOR (2 downto 0); -- ADDRESS OF WHERE TO JUMP
               Jump : out STD_LOGIC);                                  -- JUMP SIGNAL
    end component;
    
    component TESTER
        Port ( AddSubIn_A : in STD_LOGIC_VECTOR (7 downto 0);
               AddSubIn_B : in STD_LOGIC_VECTOR (7 downto 0);
               AddSubOut : out STD_LOGIC_VECTOR (7 downto 0);
               Ctrl: in STD_LOGIC_VECTOR(1 DOWNTO 0); 
               Zero_flag : out STD_LOGIC;
               Overflow_flag : out STD_LOGIC;
               Sign_flag : out STD_LOGIC;
               Carry_flag : out STD_LOGIC;
               Parity_flag : out STD_LOGIC);
    end component;
    
    component MUX_8_Way_8_Bit is
        Port ( RegSel: in STD_LOGIC_VECTOR(2 downto 0);
                Register_0 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_1 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_2 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_3 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_4 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_5 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_6 : in STD_LOGIC_VECTOR (7 downto 0);
                Register_7 : in STD_LOGIC_VECTOR (7 downto 0);
                AddSubInput: out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    -- PROGRAM COUNTER
    SIGNAL PC_out_sig, MUX_2_to_3_In_sig, ProgCount_Input: STD_LOGIC_VECTOR(2 DOWNTO 0);
    
    -- PROGRAM ROM
    SIGNAL PR_OUT : STD_LOGIC_VECTOR (16 DOWNTO 0);
    SIGNAL Program_ROM_In : STD_LOGIC_VECTOR(2 DOWNTO 0);
    
    -- INSTRUCTION DECODER
    SIGNAL REGBANK_SEL, MUX_A_REGSEL, MUX_B_REGSEL, JMP_ADD : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Load_Sel_Sig : STD_LOGIC;
    SIGNAL ADDSUB_SEL_SIG : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL JMP : STD_LOGIC;
    SIGNAL Immediate_Value : STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    -- REGISTER BANK
    SIGNAL MUX2to8Bit_OutSig : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Iregister_0, Iregister_1, Iregister_2, Iregister_3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Iregister_4, Iregister_5, Iregister_6, Iregister_7 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    
    -- ADD/SUB UNIT
    SIGNAL Add_Sub_Out_Sig : STD_LOGIC_VECTOR (7 DOWNTO 0); 
    SIGNAL MUX_A_OUT, MUX_B_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Zero_Flag : STD_LOGIC;
    
    -- PROGRAM COUNTER
    SIGNAL LoadProgRom : STD_LOGIC;

begin
        
    Adder3Bit0: Adder_3_Bit
        port map(
            AdderIn => PC_out_sig,               -- INPUT FROM THE PC
            AdderOut => MUX_2_to_3_In_sig        -- INCREMENTED VALUE
        );
        
    Mux_2_to_3_0: Mux_2_to_3
        port map(
            AdderIn => MUX_2_to_3_In_sig,        -- INPUT FROM THE 3 BIT ADDER
            JumpAdd => JMP_ADD,                  -- JUMP ADDRESS
            Jump => JMP,                         -- JUMP ENABLE SIGNAL
            PC_in => ProgCount_Input             -- OUTPUT OF MUX 2 TO 3
        );
        
     Mux_2_to_8_0: twoWay8bitMux
        port map(
            S => Load_Sel_Sig,                   -- SELECT THE LOAD 
            R0 => Add_Sub_Out_Sig,               -- ADDER SUBTRACTOR OUTPUT
            R1 => Immediate_Value,               -- IMMEDIATE VALUE FROM ROM
            Q => MUX2to8Bit_OutSig               -- OUTPUT OF MUX 2 TO 1
        );
    
    ProgramCounter0: ProgramCounter
        port map(
            D => ProgCount_Input,                -- INPUT FROM THE MUX 2 TO 1
            Clk => Clk,                          -- SLOW CLOCK
            Q => PC_out_sig,                     -- OUTPUT TO ROM
            Res => Res,                          -- RESET THE VALUE TO 000
            Load => LoadProgRom                  -- SIGNAL TO LOAD THE VALUE TO ROM
        );
    
    Program_ROM0: ProgramRomAdd
        port map(
           Mem_address => Program_ROM_In,        -- ROM SELECTOR
           Instruction => PR_OUT                 -- OUTPUT THE INSTRUCTION 14 BIT
        );
    
    Instruction_decoder0: InstructionDecoder
        port map(
            Instruction => PR_OUT,               -- INPUT FROM THE PROGRAM ROM
            Reg_en => REGBANK_SEL,               -- ENABLE THE REGISTER BANK
            Load_sel => Load_Sel_Sig,            -- SELECT THE LOAD => ADDSUB OR IMMEDIATE VALUE
            Imd_val => Immediate_Value,          -- IMMEDIATE VALUE FROM ROM
            Reg_selA => MUX_A_REGSEL,            -- SELECT THE REGISTER OF MUX_A
            Reg_selB => MUX_B_REGSEL,            -- SELECT THE REGISTER OF MUX_B
            Add_sub_sel => ADDSUB_SEL_SIG,       -- SELECT THE ADDER / SUBTRACTOR
            Jump_address => JMP_ADD,             -- JUMP ADDRESS
            Jump => JMP,                         -- JUMP SIGNAL 
            JMP_SEL => Zero_Flag                 -- INPUT FROM MUX_A
        );
        
     Reg_Bank0: Reg_Bank
        port map(
            Reg_En => REGBANK_SEL,                -- REGISTER SELECT 
            A => MUX2to8Bit_OutSig,               -- OUTPUT FROM THE MUX 2 TO 1
            Clk => Clk,                           -- SLOW CLOCK
            RESET_REG_BANK => Res,                -- RESET THE REG_BANK
            B0 => Iregister_0,                    -- REGISTER 0 
            B1 => Iregister_1,                    -- REGISTER 1
            B2 => Iregister_2,                    -- REGISTER 2
            B3 => Iregister_3,                    -- REGISTER 3
            B4 => Iregister_4,                    -- REGISTER 4
            B5 => Iregister_5,                    -- REGISTER 5
            B6 => Iregister_6,                    -- REGISTER 6
            B7 => Iregister_7                     -- REGISTER 7
        );
        
     AdderSub_8_Bit_0: TESTER
        port map(
            AddSubIn_A => MUX_A_OUT,              -- ADDER SUB INPUT 1 FROM MUX_A
            AddSubIn_B => MUX_B_OUT,              -- ADDER SUB INPUT 2 FROM MUX_B
            Ctrl => ADDSUB_SEL_SIG,               -- SELECT TO ADD / SUB
            AddSubOut => Add_Sub_Out_Sig,         -- OUTPUT RESULT
            Zero_flag => Zero_Flag,                    -- ZERO FLAG
            Overflow_flag => Overflow,            -- OVERFLOW FLAG
            Sign_flag => SignFlag,                -- SIGN FLAG
            Carry_flag => CarryFlag,              -- CARRY FLAG
            Parity_flag => ParityFlag             -- PARITY FLAG
        );
        
     MUX_8_way_8_bit0: MUX_8_Way_8_Bit
        port map(
                Register_0 => Iregister_0,        -- REGISTER 0 INPUT TO MUX_A
                Register_1 => Iregister_1,        -- REGISTER 1 INPUT TO MUX_A
                Register_2 => Iregister_2,        -- REGISTER 2 INPUT TO MUX_A
                Register_3 => Iregister_3,        -- REGISTER 3 INPUT TO MUX_A
                Register_4 => Iregister_4,        -- REGISTER 4 INPUT TO MUX_A
                Register_5 => Iregister_5,        -- REGISTER 5 INPUT TO MUX_A
                Register_6 => Iregister_6,        -- REGISTER 6 INPUT TO MUX_A
                Register_7 => Iregister_7,        -- REGISTER 7 INPUT TO MUX_A
                AddSubInput =>MUX_A_OUT,          -- OUTPUT OF MUX_A TO ADD/SUB
                RegSel =>MUX_A_REGSEL             -- SELECT THE REGISTER FORM MUX_A
                
        );
    MUX_8_way_8_bit1: MUX_8_Way_8_Bit
        port map(Register_0 => Iregister_0,       -- REGISTER 0 INPUT TO MUX_B
                Register_1 => Iregister_1,        -- REGISTER 1 INPUT TO MUX_B
                Register_2 => Iregister_2,        -- REGISTER 2 INPUT TO MUX_B
                Register_3 => Iregister_3,        -- REGISTER 3 INPUT TO MUX_B
                Register_4 => Iregister_4,        -- REGISTER 4 INPUT TO MUX_B
                Register_5 => Iregister_5,        -- REGISTER 5 INPUT TO MUX_B
                Register_6 => Iregister_6,        -- REGISTER 6 INPUT TO MUX_B
                Register_7 => Iregister_7,        -- REGISTER 7 INPUT TO MUX_B
                AddSubInput =>MUX_B_OUT,          -- OUTPUT OF MUX_B TO ADD/SUB
                RegSel =>MUX_B_REGSEL             -- SELECT THE REGISTER FORM MUX_A
        );
        
    Zero <= Zero_Flag;
        
    Program_ROM_In <= PC_out_sig;                 -- GIVE THE PROGRAM COUNTER OUTPUT TO PROGRAM ROM
    
    LoadProgRom <= NOT (Halt);                    -- LOAD INSTRUCTION TO PROGAM COUNTER
    
    REG0 <= Iregister_0;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG0
    REG1 <= Iregister_1;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG1
    REG2 <= Iregister_2;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG2
    REG3 <= Iregister_3;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG3
    REG4 <= Iregister_4;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG4
    REG5 <= Iregister_5;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG5
    REG6 <= Iregister_6;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG6
    REG7 <= Iregister_7;                          -- GIVE THE OUTPUT TO NANO PROCESSOR FROM REG7
    
    
end Behavioral;
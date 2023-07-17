library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MasterNanoProcessor is
 Port ( 
      Clk: in STD_LOGIC;
      Res : in STD_LOGIC;
      Halt : in STD_LOGIC;
      Zero : out STD_LOGIC;
      Overflow : out STD_LOGIC;
      SignFlag : out STD_LOGIC;
      CarryFlag : out STD_LOGIC;
      ParityFlag : out STD_LOGIC;
      DIS_REG : in STD_LOGIC_VECTOR (2 DOWNTO 0);
      S_LED : out STD_LOGIC_VECTOR (7 DOWNTO 0);
      S_7Seg : out STD_LOGIC_VECTOR (6 downto 0);
      Anode : out STD_LOGIC_VECTOR (3 downto 0)
  );
end MasterNanoProcessor;

architecture Behavioral of MasterNanoProcessor is

    component NanoProcessor
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
    end component;
    
    component Slow_Clk
        Port ( Clk_in : in STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end component;
    
    component LUT_16_7
        Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
               data : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
SIGNAL SlowClk, SevSegClk : STD_LOGIC;
SIGNAL SEV_SEG_A, SEV_SEG_B : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL Display_Add, address0, address1, address2, address3, address4, address5, address6, address7 :STD_LOGIC_VECTOR (7 downto 0);

begin
    Clk0: Slow_Clk
        port map(
            Clk_in => Clk,
            Clk_out => slowClk
        );
        
    NanoProcessor0: NanoProcessor
        port map(
                Clk=> slowClk,
                Res => Res,
                Halt => Halt,
                Zero => Zero,
                Overflow => Overflow,
                SignFlag => SignFlag,
                CarryFlag => CarryFlag,
                ParityFlag => ParityFlag,
                REG0 => address0,
                REG1 => address1,
                REG2 => address2,
                REG3 => address3,
                REG4 => address4,
                REG5 => address5,
                REG6 => address6,
                REG7 => address7
        );
        
    LUT_16_7_0: LUT_16_7
            port map( 
                address => Display_Add(3 DOWNTO 0),
                data => SEV_SEG_A
            );
    LUT_16_7_1: LUT_16_7
            port map( 
                address => Display_Add(7 DOWNTO 4),
                data => SEV_SEG_B
            );
            
    process (DIS_REG, slowClk)
    begin
       if rising_edge(slowClk) then
           CASE DIS_REG IS
           when "000" =>
                Display_Add <= address0;
           when "001" =>
                Display_Add <= address1;
           when "010" =>
                Display_Add <= address2;
           when "011" =>
                Display_Add <= address3;
           when "100" =>
                Display_Add <= address4;
           when "101" =>
                Display_Add <= address5;
           when "110" =>
                Display_Add <= address6;
           when "111" =>
                Display_Add <= address7; 
           when others => -- 'U', 'X', '-'
                Display_Add <= "00000000";
           END CASE;
       end if;
    end process;
    S_LED <= Display_Add;
      
--     SEVEN SEGMENT DISPLAY 
--     USING 2 DISPLAYS
    process (slowClk)
    begin
        if (slowClk = '1') then
            Anode <= "1110";
            S_7Seg <= SEV_SEG_A;
        elsif (slowClk = '0') then 
            Anode <= "1101";
            S_7Seg <= SEV_SEG_B;
        end if;
    end process;
    
end Behavioral;

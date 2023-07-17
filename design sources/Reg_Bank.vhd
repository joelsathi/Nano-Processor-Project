library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_Bank is
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
end Reg_Bank;

architecture Behavioral of Reg_Bank is

    component reg
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
               En : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Res : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component Decoder_3_to_8
        Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
               Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    

SIGNAL Y0: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
    
    -- USE SWITCH CASE INSTEAD OF DECODER
    Decoder_3_to_8_0: Decoder_3_to_8 PORT MAP(
        I => Reg_En,
        Y => Y0
    );
    
    Reg1: reg PORT MAP(
        D => A,
        En => Y0(1),
        Clk => Clk,
        Res => RESET_REG_BANK,
        Q => B1
    );
    
    Reg2: reg PORT MAP(
        D => A,
        En => Y0(2),
        Clk => Clk,
        Res => RESET_REG_BANK,
        Q => B2
    );
    
    Reg3: reg PORT MAP(
        D => A,
        En => Y0(3),
        Clk => Clk,
        Res => RESET_REG_BANK,
        Q => B3
    );
    
    Reg4: reg PORT MAP(
        D => A,
        En => Y0(4),
        Clk => Clk,
        Res => RESET_REG_BANK,
        Q => B4
    );
    
    Reg5: reg PORT MAP(
        D => A,
        En => Y0(5),
        Clk => Clk,
        Res => RESET_REG_BANK,
        Q => B5
    );
    
    Reg7: reg PORT MAP(
        D => A,
        En => Y0(7),
        Clk => Clk,
        Res => RESET_REG_BANK,
        Q => B7
    );
    
    B0 <= "00000000";
    B6 <= "00000001";

end Behavioral;

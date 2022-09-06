library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk : in STD_LOGIC;
           an :  out STD_LOGIC_VECTOR (7 downto 0);
           sseg: out std_logic_vector (7 downto 0));
end top;

architecture lab9 of top is

constant N : integer := 49999999; 
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin
counter : entity work.fsm_eg
      port map(
                clk => clk,
                reset => '0',
                enable => enable,
                in7 => "11000000",
                in6 => "11111001",
                in5 => "10100100",
                in4 => "10110000",
                in3 => "10011001",
                in2 => "10010010",
                in1 => "10000010",
                in0 => "11111000",
                sseg=> sseg,
                an  => an
                );
    
    enable <= '1' when divide_clk = N else '0';
     
     PROCESS (clk)
        BEGIN
            IF (clk'EVENT AND clk='1') THEN
                divide_clk <= divide_clk+1;
                IF divide_clk = N THEN
                    divide_clk <= 0;
                END IF;
            END IF;
     END PROCESS;

end lab9;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity eq_top is
   port(
     clk : in std_logic;
     sw  : in  std_logic_vector(1 downto 0);
     an: out std_logic_vector(7 downto 0);
     sseg : out std_logic_vector(7 downto 0)
   );
end eq_top;


architecture arch of eq_top is
  constant N : integer := 49999999; 
  signal enable : std_logic;
  signal divide_clk : integer range 0 to N;
begin
  
  agoravai : entity work.fsm_eg 
  port map(
    clk => clk,
    reset => '0',
    a => sw(0),
    b => sw(1),
    in0 => "10011100",
    in1 => "10100011",
    enable => enable,
    an => an,
    sseg => sseg
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

 
end arch;
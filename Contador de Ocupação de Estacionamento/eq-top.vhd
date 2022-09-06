library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity eq_top is
   port(
     clk : in  std_logic;
--     btn : in  std_logic_vector(4 downto 0);
     sw  : in  std_logic_vector(1 downto 0);
     led : out std_logic_vector(15 downto 0);
     an  : out std_logic_vector(7 downto 0);
     sseg: out std_logic_vector(7 downto 0)
   );
end eq_top;


architecture arch of eq_top is
  constant N : integer := 49999999; 
  signal enable, inc_enter, dec_exit : std_logic;
  signal divide_clk : integer range 0 to N;
  signal q_out : std_logic_vector(3 downto 0);
begin
  
  agoravai : entity work.fsm_eg 
  port map(
    clk => clk,
    reset => '0',
    a => sw(0),
    b => sw(1),
    enable => enable,
    car_enter => inc_enter,
    car_exit => dec_exit
  );
  led(15) <= inc_enter;
  led(14) <= dec_exit;
  
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

  counter : entity work.free_run_bin_counter
  port map(
    clk     => clk,
    reset   => '0',
    enable => enable,
    inc     => inc_enter,
    dec     => dec_exit,
    q       => q_out
  );
  
 led(13 downto 10) <= q_out;

  display_out : entity work.disp_hex_mux
  port map(
    clk   => clk,
    reset => '0',
    hex0  => q_out,
    dp_in => "1111",
    an    => an(7 downto 0),
    sseg  => sseg(7 downto 0)
  );

end arch;
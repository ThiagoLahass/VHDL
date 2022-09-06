library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity eq_top is
   port(
     clk : in  std_logic;
     sw  : in  std_logic_vector(15 downto 0);
     led : out std_logic_vector(15 downto 0)
   );
end eq_top;


architecture arch of eq_top is
  constant  N : integer := 49999999;
  signal    L, s, inc : std_logic_vector(3 downto 0);
  signal    SHR_in, cLD, cINC, CSHR, enable : std_logic;
  signal    Q3, Q2, Q1, Q0 : std_logic;
  signal    c : std_logic_vector(1 downto 0);
begin
  
  L       <= sw(3 downto 0);
  SHR_in  <= sw(4);
  cLD     <= sw(15);
  cINC    <= sw(14);
  CSHR    <= sw(13);

  prioridade: entity work.cod_prio
  port map(
    r(2) => cLD,
    r(1) => cINC,
    r(0) => CSHR,
    pcode => c
  );

  incrementador: entity work.inc_4bits
  port map(
    inc_in(0)  => Q0,
    inc_in(1)  => Q1,
    inc_in(2)  => Q2,
    inc_in(3)  => Q3,
    inc_out => inc
  );

  mux1: entity work.mux_4x1
  port map(
    i(3) => L(3),
    i(2) => inc(3),
    i(1) => SHR_in,
    i(0) => Q3,
    c    => c,
    s    => s(3)
  );

  mux2: entity work.mux_4x1
  port map(
    i(3) => L(2),
    i(2) => inc(2),
    i(1) => Q3,
    i(0) => Q2,
    c    => c,
    s    => s(2)
  );

  mux3: entity work.mux_4x1
  port map(
    i(3) => L(1),
    i(2) => inc(1),
    i(1) => Q2,
    i(0) => Q1,
    c    => c,
    s    => s(1)
  );

  mux4: entity work.mux_4x1
  port map(
    i(3) => L(0),
    i(2) => inc(0),
    i(1) => Q1,
    i(0) => Q0,
    c    => c,
    s    => s(0)
  );

  divisor_clk : entity work.div_clk
  port map(
    clk   => clk,
    en    => enable
  );

  flipflop1: entity work.FF_D
  port map(
    clk => clk,
    e   => enable,
    D   => s(3),
    Q   => Q3
  );

  flipflop2: entity work.FF_D
  port map(
    clk => clk,
    e   => enable,
    D   => s(2),
    Q   => Q2
  );

  flipflop3: entity work.FF_D
  port map(
    clk => clk,
    e   => enable,
    D   => s(1),
    Q   => Q1
  );

  flipflop4: entity work.FF_D
  port map(
    clk => clk,
    e   => enable,
    D   => s(0),
    Q   => Q0
  );

  led(0) <= Q0;
  led(1) <= Q1;
  led(2) <= Q2;
  led(3) <= Q3;


end arch;
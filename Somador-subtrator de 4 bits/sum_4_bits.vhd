library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity sum_4 is
   port(
      sw                : in  std_logic_vector(15 downto 0);
      led               : out std_logic_vector(15 downto 0)
   );
end sum_4;

                  

architecture arch of sum_4 is
signal sub, overflow, c0, c1, c2, c3: std_logic;
signal notb, a, b, s, bout: std_logic_vector(3 downto 0);
begin
      a                 <= sw(3 downto 0);
      b	                <= sw(7 downto 4);
      sub               <= sw(15);
      led(3 downto 0)   <= s;
      led(4)            <= overflow ;
      notb              <= not (b);
      
     mux1: entity work.mux2_1_1bit(cond_arch)
         port map(
               i0  =>   b,
               i1  =>   notb,
               sel =>   sub,
               y   =>   bout
      );
      
      sum0: entity work.sumcomplete(direct_arch)
          port map(
              ain   => a(0),
              bin   => bout(0),
              cin   => sub,
              sout  => s(0),
              cout  => c0
      );
      
      sum1: entity work.sumcomplete(direct_arch)
           port map(
                 ain   => a(1),
                 bin   => bout(1),
                 cin   => c0,
                 sout  => s(1),
                 cout  => c1
        );
  
        sum2: entity work.sumcomplete(direct_arch)
           port map(
                 ain   => a(2),
                 bin   => bout(2),
                 cin   => c1,
                 sout  => s(2),
                 cout  => c2
        );
  
        sum3: entity work.sumcomplete(direct_arch)
           port map(
                 ain   => a(3),
                 bin   => bout(3),
                 cin   => c2,
                 sout  => s(3),
                 cout  => c3
        );
        
        overflow <= ( a(3) and bout(3) and (not(s(3)))) or ( (not(a(3))) and (not(bout(3))) and s(3));
       
       
end arch;


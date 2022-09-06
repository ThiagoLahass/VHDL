library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity shifter is
   port(
      sw                : in  std_logic_vector(15 downto 0);
      led               : out std_logic_vector(2 downto 0)
   );
end shifter;

architecture arch of shifter is
begin
      sh_1: entity work.shift3mode(direct_arch)
            port map(
                  a           => sw(4 downto 0),
                  lar	       => sw(15 downto 13),
                  y           => led(2 downto 0)
            );
end arch;


library ieee;
use ieee.std_logic_1164.all;
entity shift3mode is
   port(
      a:       in std_logic_vector(4 downto 0);
      lar:     in std_logic_vector(2 downto 0);
      y:       out std_logic_vector(2 downto 0)
   );
end shift3mode ;

architecture direct_arch of shift3mode is
begin
		y <=  	a(4 downto 2)  	       when (lar(2)='1') else --direita
         		a(1) & a(3 downto 2)   when (lar(1)='1') else --circular direita
         		a(2 downto 0)  	       when (lar(0)='1') else --esquerda
         		a(3 downto 1);

end direct_arch;


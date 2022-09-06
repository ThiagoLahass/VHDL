library ieee;
use ieee.std_logic_1164.all;
entity sumcomplete is
   port(
      ain:       in std_logic;
      bin:       in std_logic;
      cin:      in std_logic;
      sout:       out std_logic;
      cout:      out std_logic
   );
end sumcomplete ;

architecture direct_arch of sumcomplete is
begin
    
    sout <= ain xor bin xor cin;

    cout <= (bin and cin) or (ain and cin) or (ain and bin);

end direct_arch;

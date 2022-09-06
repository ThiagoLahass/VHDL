-- Listing 5.1
library ieee;
use ieee.std_logic_1164.all;
entity fsm_eg is
   port(
      clk, reset           : in  std_logic;
      enable               : in  std_logic;
      in0, in1, in2, in3   : in std_logic_vector( 7 downto 0 );
      in4, in5, in6, in7   : in std_logic_vector( 7 downto 0 );
      an                   : out std_logic_vector( 7 downto 0 );
      sseg                 : out std_logic_vector( 7 downto 0 )
   );
end fsm_eg;

architecture mult_seg_arch of fsm_eg is
   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
   signal state_reg, state_next : eg_state_type;
begin
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s0;
      elsif (clk'event and clk = '1') then
         state_reg <= state_next;
      end if;
   end process;
   
   process(state_reg)
   begin
      case state_reg is
         when s0 =>
            sseg <= in0;
            an <= "11111110";
            state_next <= s1;
         
         when s1 =>
            sseg <= in1;
            an <= "11111101";
            state_next <= s2;

         when s2 =>
            sseg <= in2;
            an <= "11111011";
            state_next <= s3;
         
         when s3 =>
            sseg <= in3;
            an <= "11110111";
            state_next <= s4;

         when s4 =>
            sseg <= in4;
            an <= "11101111";
            state_next <= s5;

         when s5 =>
            sseg <= in5;
            an <= "11011111";
            state_next <= s6;

         when s6 =>
            sseg <= in6;
            an <= "10111111";
            state_next <= s7;

         when s7 =>
            sseg <= in7;
            an <= "01111111";
            state_next <= s0;

         
      end case;
   end process;
end mult_seg_arch;
-- Listing 5.1
library ieee;
use ieee.std_logic_1164.all;
entity fsm_eg is
   port(
      clk, reset     : in  std_logic;
      a, b, enable   : in  std_logic;
      in0, in1       : in  std_logic_vector(7 downto 0 );
      an, sseg       : out std_logic_vector(7 downto 0 )
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
            if enable = '1' then
               state_reg <= state_next;
            end if;
      end if;
   end process;
   -- next-state logic
   process(state_reg, a, b, in0, in1)
   begin
      case state_reg is
         when s0 =>
            an <= "11110111";
            sseg <= in0;
            if a = '1' then
               if b = '1' then
                  state_next <= s1;
               else
                  state_next <= s7;
               end if;
            else
               state_next <= s0;
            end if;
         when s1 =>
            an <= "11111011";
            sseg <= in0;
            if a = '1' then
               if b = '1' then
                  state_next <= s2;
               else
                  state_next <= s0;
               end if;
            else
               state_next <= s1;
            end if;
         when s2 =>
            an <= "11111101";
            sseg <= in0;
            if a = '1' then
               if b = '1' then
                  state_next <= s3;
               else
                  state_next <= s1;
               end if;
            else
               state_next <= s2;
            end if;
         when s3 =>
            an <= "11111110";
            sseg <= in0;
            if a = '1' then
               if b = '1' then
                  state_next <= s4;
               else
                  state_next <= s2;
               end if;
            else
               state_next <= s3;
            end if;
         when s4 =>
            an <= "11111110";
            sseg <= in1;
            if a = '1' then
               if b = '1' then
                  state_next <= s5;
               else
                  state_next <= s3;
               end if;
            else
               state_next <= s4;
            end if;
         when s5 =>
            an <= "11111101";
            sseg <= in1;
            if a = '1' then
               if b = '1' then
                  state_next <= s6;
               else
                  state_next <= s4;
               end if;
            else
               state_next <= s5;
            end if;
         when s6 =>
            an <= "11111011";
            sseg <= in1;
            if a = '1' then
               if b = '1' then
                  state_next <= s7;
               else
                  state_next <= s5;
               end if;
            else
               state_next <= s6;
            end if;
         when s7 =>
            an <= "11110111";
            sseg <= in1;
            if a = '1' then
               if b = '1' then
                  state_next <= s0;
               else
                  state_next <= s6;
               end if;
            else
               state_next <= s7;
            end if;
      end case;
   end process;

end mult_seg_arch;

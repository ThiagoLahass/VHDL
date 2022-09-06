-- Listing 5.1
library ieee;
use ieee.std_logic_1164.all;
entity fsm_eg is
   port(
      clk, reset           : in  std_logic;
      a, b, enable         : in  std_logic;
      car_enter, car_exit  : out std_logic
   );
end fsm_eg;

architecture mult_seg_arch of fsm_eg is
   type eg_state_type is (s0_start, s1_A_ativo, s2_A_e_B_ativos, s3_B_ativo, s4_enter, s5_B_ativo2, s6_A_e_B_ativos2, s7_A_ativo2, s8_exit);
   signal state_reg, state_next : eg_state_type;
begin
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s0_start;
      elsif (clk'event and clk = '1') then
               state_reg <= state_next;
      end if;
   end process;
   -- next-state logic
   process(state_reg, a, b)
   begin
      case state_reg is
         when s0_start =>
            car_enter <= '0';
            car_exit  <= '0';
            if a = '1' then
               state_next <= s1_A_ativo;
            elsif b = '1' then
                  state_next <= s5_B_ativo2;
            else
               state_next <= s0_start;
            end if;
         when s1_A_ativo =>
            car_enter <= '0';
            car_exit  <= '0';
            if a = '1' then
               if b = '1' then
                  state_next <= s2_A_e_B_ativos;
               else
                  state_next <= s1_A_ativo;
               end if;
            else
               state_next <= s0_start;
            end if;
         when s2_A_e_B_ativos =>
            car_enter <= '0';
            car_exit  <= '0';
            if b = '1' then
               if a = '0' then
                  state_next <= s3_B_ativo;
               else
                  state_next <= s2_A_e_B_ativos;
               end if;
            else
               state_next <= s1_A_ativo;
            end if;
         when s3_B_ativo =>
            car_enter <= '0';
            car_exit  <= '0';
            if b = '1' then
               if a = '1' then
                  state_next <= s2_A_e_B_ativos;
               else
                  state_next <= s3_B_ativo;
               end if;
            else
               state_next <= s4_enter;
            end if;
         when s4_enter =>
            car_enter <= '1';
            car_exit  <= '0';
            state_next <= s0_start;
         when s5_B_ativo2 =>
            car_enter <= '0';
            car_exit  <= '0';
            if b = '1' then
               if b = '1' then
                  state_next <= s6_A_e_B_ativos2;
               else
                  state_next <= s5_B_ativo2;
               end if;
            else
               state_next <= s0_start;
            end if;
         when s6_A_e_B_ativos2 =>
            car_enter <= '0';
            car_exit  <= '0';
            if a = '1' then
               if b = '0' then
                  state_next <= s7_A_ativo2;
               else
                  state_next <= s6_A_e_B_ativos2;
               end if;
            else
               state_next <= s5_B_ativo2;
            end if;
         when s7_A_ativo2 =>
            car_enter <= '0';
            car_exit  <= '0';
            if a = '1' then
               if b = '0' then
                  state_next <= s7_A_ativo2;
               else
                  state_next <= s6_A_e_B_ativos2;
               end if;
            else
               state_next <= s8_exit;
            end if;
         when s8_exit =>
            car_enter <= '0';
            car_exit  <= '1';
            state_next <= s0_start;
      end case;
   end process;

end mult_seg_arch;

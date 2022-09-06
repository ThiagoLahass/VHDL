----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:03 09/30/2020 
-- Design Name: 
-- Module Name:    mux2_1_1bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2_1_1bit is
    Port ( i0 : in  STD_LOGIC_VECTOR(3 downto 0);
           i1 : in  STD_LOGIC_VECTOR(3 downto 0);
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(3 downto 0));
end mux2_1_1bit;

architecture cond_arch of mux2_1_1bit is
begin
   y <= i0 when sel = '0' else
	    i1;
end cond_arch;


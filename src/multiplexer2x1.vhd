----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Mux2x1  
-- Project Name: MIPS MultiCycle
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
use IEEE.std_logic_1164.all;

entity multiplexer2x1 is 
   generic(width: natural := 8);
   port(
      input0, input1:  in std_logic_vector(width-1 downto 0);
      selection:       in std_logic;
      output:          out std_logic_vector(width-1 downto 0)
	);
	
end entity;

architecture multiplexer2x1_arch of multiplexer2x1 is
begin
	output <= input0 when (selection = '0') else
			    input1;

end architecture;

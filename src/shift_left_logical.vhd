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

entity shift_left_logical is
	generic(
		width: natural := 8;
		shift_amount: natural := 2
	);
	
	port(
		input:  in std_logic_vector(width-1 downto 0);
		output: out std_logic_vector(width-1 downto 0)
	);

end entity;


architecture shift_left_arch of shift_left_logical is
begin
	output <= to_stdLogicVector(to_bitvector(input) sll shift_amount);
	
end architecture;
----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Mux4x1  
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

entity multiplexer4x1 is
	generic(width: natural := 8);
	port(
		input0, input1, input2, input3: in std_logic_vector(width-1 downto 0);
		selection:                      in std_logic_vector(1 downto 0);
		output: 								  out std_logic_vector(width-1 downto 0)
	);
	
end entity;

architecture multiplexer4x1_arch of multiplexer4x1 is
begin 
	output <= input0 when (selection = "00") else
				 input1 when (selection = "01") else
				 input2 when (selection = "10") else
				 input3;
				 
end architecture;	
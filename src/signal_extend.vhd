----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Signal Extend
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

entity signal_extend is
	generic(
		width_input:  natural := 8;
		width_output: natural := 16
	);
	
	port(
		input:  in  std_logic_vector(width_input-1 downto 0);
		output: out std_logic_vector(width_output-1 downto 0)
	);
	
end entity;

architecture signal_extend_arch of signal_extend is
	signal aux: std_logic_vector (width_output-1 downto 0);
begin
	aux(width_input-1 downto 0) <= input;
	aux(width_output-1 downto width_input) <= (others => input(width_input-1));

	output <= aux;
	
end architecture;
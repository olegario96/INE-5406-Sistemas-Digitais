----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
--
-- Create Date:    07/27/2016
-- Design Name:
-- Module Name:  Register
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
--! Use standard library
library IEEE;
--! Use logic elements.
use IEEE.std_logic_1164.all;

--! Register description: a simple implementation of a register using a clock
--! to manage the events.

entity reg is
	generic(width: natural := 8);
	port(
		clock, reset, enable:    in std_logic; --! Signals to control the register
		input: 					 in std_logic_vector(width-1 downto 0); --! Data that will be saved on the register
		output: 			     out std_logic_vector(width-1 downto 0) --! Output of the register
	);

end entity;

--! @brief Implementation of the register. It uses the process keyword to set
--! the 'states'. If reset is enable, then reset the data. If is a rising edge
--! clock and the switch of 'enable' is equal to '1' then save the data.
--! Otherwise, nothing happens.
architecture reg_arch of reg is
begin
	process(clock, input, enable, reset)
	begin
		if (reset = '1') then
			output <= (others => '0');
		elsif (rising_edge (clock) and enable = '1') then
			output <= input;
		end if;
	end process;

end architecture;

----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
--
-- Create Date:    07/27/2016
-- Design Name:
-- Module Name:  OR Logic Gate
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
--! Use logic elements
use IEEE.std_logic_1164.all;

--! Logic gate OR description: a simple implementation of the or logic operation.

entity logic_gate_or is
	port(
		input0, input1:      in std_logic; --! Operands.
		output: 			 out std_logic --! Result
	);

end entity;

--! @brief: Implementation of the logic operation, using the keyword OR.
architecture logic_gate_or_arch of logic_gate_or is
begin
	output <= input0 or input1;

end architecture;
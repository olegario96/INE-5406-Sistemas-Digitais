----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
--
-- Create Date:    07/27/2016
-- Design Name:
-- Module Name:  Shift Left Logical
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

--! Shift left logical description: a simple shifleft logcial implementation,
--! using the reserved word 'sll'. The operation of shift left logical is
--! the same as multplying the number by 2. (Example: 0010 -> 0100)

entity shift_left_logical is
	generic(
		width: natural := 8;
		shift_amount: natural := 2 --! Amount of digits that the number will be shifted
	);

	port(
		input:  in std_logic_vector(width-1 downto 0); --! Number that will be shifted
		output: out std_logic_vector(width-1 downto 0) --! Result from operation
	);

end entity;

--! @brief Using the reserved word 'sll' we shift the operand.
architecture shift_left_arch of shift_left_logical is
begin
	output <= to_stdLogicVector(to_bitvector(input) sll shift_amount);

end architecture;
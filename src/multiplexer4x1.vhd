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
--! Use standard library
library IEEE;
--! Use logic elements
use IEEE.std_logic_1164.all;

--! Multiplexer 3x1 description: a simple mux 3x1 implementation. Depending
-- what is the value of the selection input, one operand will be transmitted.

entity multiplexer4x1 is
	generic(width: natural := 8);
	port(
		input0, input1, input2, input3: in std_logic_vector(width-1 downto 0); --! Operands that will be transmitted.
		selection:                      in std_logic_vector(1 downto 0); --! Switch to select an operand.
		output: 						out std_logic_vector(width-1 downto 0) --! Operand selected.
	);

end entity;

--! @brief If the value of selection is '00', input0 will be transmitted.
--! If is equal to '01', input1 will be. If is equal to '10', input2 will be
--! transmitted. Otherwise, input3 will be.
architecture multiplexer4x1_arch of multiplexer4x1 is
begin
	output <= input0 when (selection = "00") else
				 input1 when (selection = "01") else
				 input2 when (selection = "10") else
				 input3;

end architecture;
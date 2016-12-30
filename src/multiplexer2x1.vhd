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
--! Use standard library
library IEEE;
--! Use logic elements
use IEEE.std_logic_1164.all;

--! Multiplexer 2x1 description: a simple mux 2x1 implementation. Depending
-- what is the value of the selection input, one operand will be transmitted.

entity multiplexer2x1 is
   generic(width: natural := 8);
   port(
      input0, input1:  in std_logic_vector(width-1 downto 0); --! Operands that will be transmitted.
      selection:       in std_logic; --! Switch to select an operand.
      output:          out std_logic_vector(width-1 downto 0) --! Operand selected.
	);

end entity;


--! @brief If the value of selection is '0', input0 will be transmitted.
--! Otherwise, input1 will be.
architecture multiplexer2x1_arch of multiplexer2x1 is
begin
	output <= input0 when (selection = '0') else
			    input1;

end architecture;

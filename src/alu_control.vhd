----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  ALU (Arithmetic Logic Unity)  
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

--! ALU_control brief descriptio: The ALU control. It receives 2 bits from the control block and the 5 final bits from the
--! word.

entity ALU_control is
	port(
		funct:   in std_logic_vector(5 downto 0); --! 5 final bits from the word.
		ULAOp:   in std_logic_vector(1 downto 0); --! 2 bits from the control block.
		output:  out std_logic_vector(2 downto 0) --! ALU_op
	);
	
end entity;

--! @brief The ULAOp and funct will define witch operation will be done. This choose was made using a table of states 
--! from the book Computer Organization and Design 3rd edition.
architecture ALU_control_arch of ALU_control is 
begin
	output <= "010" when ((ULAOp = "10") and (funct = "100000")) else 
				 "110" when ((ULAOp = "10") and (funct = "100010")) else
				 "000" when ((ULAOp = "10") and (funct = "100100")) else 
				 "001" when ((ULAOp = "10") and (funct = "100101")) else 
				 "111" when ((ULAOp = "10") and (funct = "101010")) else 
				 "010" when (ULAOp = "00") else 
				 "110" when (ULAOp = "01");
				 
end architecture;

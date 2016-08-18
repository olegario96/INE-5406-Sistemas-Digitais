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
------------------------------------------------------------------------------
--! Use standard library
library IEEE;
--! Use logic elements
use IEEE.std_logic_1164.all;
--! Use numeric elements
use IEEE.numeric_std.all;

--! ALU brief description: ALU for didatic MIPS MultiCycle from Patterson.
--! It's possible to `sum`, `sub`, `and`, `or` the operands and use set less than.    

entity ALU is
	generic(width: natural := 8);
	port(
		input0, input1: in std_logic_vector(width-1 downto 0); --! Operands.
		ALU_op:  		 in std_logic_vector(2 downto 0); --! Operation select.
		output: 			 out std_logic_vector(width-1 downto 0); --! Result
		zero: 			 out std_logic --! Comp. between the input0 and input1.
	);

end entity;

--! @brief The ALU_op will define witch operantion do. See ALU brief descrip.
architecture ALU_arch of ALU is
	signal comp: boolean;
	signal sum, dif, slt0, slt1: std_logic_vector(width-1 downto 0);
	signal dif_integer: integer;
begin
	comp <= to_integer(signed(input0)) < to_integer(signed(input1));
	
	sum  <= std_logic_vector(to_signed(to_integer(signed(input0))
			  + to_integer(signed(input1)), width));
			  
	dif_integer <= to_integer(signed(input0)) - to_integer(signed(input1));
	
	dif  <= std_logic_vector(to_signed(dif_integer, width));
			  
	slt0 <= (0 => '1', others => '0');
	slt1 <= (others => '0');
	
	output <= input0 and input1  when (ALU_op = "000") else
				 input0 or  input1  when (ALU_op = "001") else 
				 sum                when (ALU_op = "010") else
				 dif                when (ALU_op = "110") else
				 slt0 when (comp and ALU_op = "111") else 
			    slt1 when (ALU_op = "111");
				 
	zero <= '1' when ((dif_integer = 0) and ALU_op = "110") else
			  '0';
				 
end architecture;
				 

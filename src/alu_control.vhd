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
library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_control is
	port(
		funct:   in std_logic_vector(5 downto 0);
		ULAOp:  in std_logic_vector(1 downto 0);
		output: out std_logic_vector(2 downto 0)
	);
	
end entity;

architecture ALU-control_arch of ALU_control is 
begin
	output <= "010" when ((ULAOp = "10") and (funct = "100000")) else 
				 "110" when ((ULAOp = "10") and (funct = "100010")) else
				 "000" when ((ULAOp = "10") and (funct = "100100")) else 
				 "001" when ((ULAOp = "10") and (funct = "100101")) else 
				 "111" when ((ULAOp = "10") and (funct = "101010")) else 
				 "010" when (ULAOp = "00") else 
				 "110" when (ULAOp = "01");
				 
end architecture;
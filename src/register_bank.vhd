----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Register Bank
-- Project Name: MIPS Multicycle
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
use IEEE.numeric_std.all;

entity register_bank is
	port(
		wrt_enable, clk: in std_logic;
		read_reg_a, read_reg_b, wrt_reg: in std_logic_vector(4 downto 0);
		wrt_data: in std_logic_vector(31 downto 0);
		reg_out_a, reg_out_b: out std_logic_vector(31 downto 0)
	);
	
end entity;

architecture register_bank_arch of register_bank is
	type register_file is array(0 to 31) of std_logic_vector(32 downto 0);
	signal registers: register_file;
begin
	regFile: process(clk) is
	begin
		if (rising_edge(clk)) then
			reg_out_a <= registers(to_integer(unsigned(read_reg_a)));
			reg_out_b <= registers(to_integer(unsigned(read_reg_b)));
			
			if (wrt_enable = '1') then
				registers(to_integer(unsigned(wrt_reg))) <= wrt_data;
				if (read_reg_a = wrt_reg) then
					reg_out_a <= wrt_data;
				end if;
				if (read_reg_b = wrt_reg) then
					reg_out_b <= wrt_data;
				end if;
			end if;
		end if;
	end process;
	
end architecture;

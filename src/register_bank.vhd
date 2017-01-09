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
--! Use standard library
library IEEE;
--! Use logic elements
use IEEE.std_logic_1164.all;
--! Use numeric elements
use IEEE.numeric_std.all;

--! Register bank description: a register bank based implementation based
--! on finite state machines. It uses the clock to save the data. The idea
--! is to have an array of 32 registers of 32 bits.

entity register_bank is
	port(
		wrt_enable, clk: in std_logic; --! wrt_enable is the switch to save the data.
		read_reg_a, read_reg_b, wrt_reg: in std_logic_vector(4 downto 0); -- Register where the data will be saved.
		wrt_data: in std_logic_vector(31 downto 0); --! Data to be saved
		reg_out_a, reg_out_b: out std_logic_vector(31 downto 0) --! Auxiliar registers
	);

end entity;


--! @brief First, we create an array of 32 register of 32 bits. Next we use
--! the clock process to manage the write on the registers. We save the data
--! on the auxiliar registers. Then, we take the right register using the
--! 'wrt_reg' which indicates the number of the register inside the array.
--! Finally, we just compare the number of the register and save the data.
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

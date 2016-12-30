----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Memory
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
use std.textio.all;
use work.all;

entity memory is 
	port(
		clk, reset, wrt_mem, read_mem: in std_logic;
		address, wrt_data: in std_logic_vector(31 downto 0);
		mem_data: out std_logic_vector(31 downto 0)	
	);
	
end entity;

architecture memory_arch of memory is
	signal data: std_logic_vector(31 downto 0);
	signal nwe, noe, ncs: std_logic;
begin
	memory: entity work.sram64kx8(sram_behaviour)
			  port map (ncs, address, data, nwe, noe);
			  
	nwe <= not wrt_mem;
	noe <= not read_mem;
	ncs <= not (wrt_mem or read_mem) or (not reset);
	
	GEN_memtris: for n in 31 downto 0 generate
		data(n) <= wrt_data(n) when (wrt_mem = '1') else
					  'Z';
	end generate;
	
	mem_data <= data;
	
end architecture;
	
	
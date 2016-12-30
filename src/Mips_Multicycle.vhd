----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  MIPS Multicycle (Top-level entity)
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

entity Mips_Multicycle is
	port(
		clock, reset: in std_logic;
		gpio: inout std_logic_vector(31 downto 0)
	);
	
end entity;

architecture Mips_Multicycle_arch of Mips_Multicycle is
	component control_unity is
	port(
		clk, reset: in std_logic;
		opcode: in std_logic_vector(5 downto 0);
		pc_source, alu_source_b, alu_op: out std_logic_vector(1 downto 0);
		alu_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
		wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond: out std_logic
	);
	
	end component;
	
	component data_path is
	port(
		clock, reset: in std_logic;
		pc_source, alu_source_b, alu_op: in std_logic_vector(1 downto 0);
		alu_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
		wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond: in std_logic;
		opcode: out std_logic_vector(5 downto 0)
	);
	
	end component;
	
	signal pc_source, alu_source_b, alu_op: std_logic_vector(1 downto 0);
	signal alu_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
		wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond: std_logic;
	signal opcode: std_logic_vector(5 downto 0);
	
begin
	control: control_unity
				port map(clock, reset, opcode, pc_source, alu_source_b, alu_op,
							alu_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
							wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond);
							
	data: data_path
			port map(clock, reset, pc_source, alu_source_b, alu_op,
							alu_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
							wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond, opcode);
							
end architecture;
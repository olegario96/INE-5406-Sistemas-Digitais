----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Control Unity
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

entity control_unity is
	port(
		clock, reset: in std_logic;
		opcode: in std_logic_vector(5 downto 0);
		pc_source, ula_source_b, ula_op: out std_logic_vector(1 downto 0);
		ula_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
		wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond: out std_logic
	);
	
end entity;

architecture control_unity_arch of control_unity is
	type State is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
	signal actualState, nextState: State;
begin
	process(clock, reset)
	begin
		if (reset = '1') then
			actualState <= S0;
		elsif (rising_edge(clock)) then
			actualState <= nextState;
		end if;
	end process;
	
	process (actualState)
	begin
		case actualState is
			when S0 => read_mem <= '1';
						  ula_source_a <= '0';
						  i_or_d <= '0';
						  wrt_inst <= '1';
						  ula_source_b <= "01";
						  ula_op <= "00";
						  wrt_pc <= '1';
						  pc_source <= "00";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';
						  
			when S1 => read_mem <= '0';
						  ula_source_a <= '0';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "11";
						  ula_op <= "00";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';
						  
						  if ((opcode = "100011") or (opcode = "101011")) then
						      nextState <= S2;
						  elsif (opcode = "000000") then
						      nextState <= S6;
						  elsif (opcode = "000100") then
						      nextState <= S8;
						  elsif (opcode = "000010") then
						      nextState <= S9;
						  end if;
							
			when S2 => read_mem <= '0';
						  ula_source_a <= '1';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "10";
						  ula_op <= "00";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';
						  
						  if (opcode = "100011") then
						      nextState <= S3;
						  elsif (opcode = "101011") then
								nextState <= S5;
						  end if;
						  
			when S3 => read_mem <= '1';
						  ula_source_a <= '0';
						  i_or_d <= '1';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "00";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';
						  
						  nextState <= S4;
						  
			when S4 => read_mem <= '0';
						  ula_source_a <= '0';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "00";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '1';
						  reg_dst <= '0';
						  mem_to_reg <= '1';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';			
						  
						  nextState <= S0;
						  
			when S5 => read_mem <= '0';
						  ula_source_a <= '0';
						  i_or_d <= '1';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "00";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '1';
						  wrt_pc_cond <= '0';			
						  
						  nextState <= S0;
						  
			when S6 => read_mem <= '0';
						  ula_source_a <= '1';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "10";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';			
						  
						  nextState <= S7;
						  
			when S7 => read_mem <= '0';
						  ula_source_a <= '0';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "00";
						  wrt_pc <= '0';
						  pc_source <= "00";
						  wrt_reg <= '1';
						  reg_dst <= '1';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';			
						  
						  nextState <= S0;
						  
			when S8 => read_mem <= '0';
						  ula_source_a <= '1';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "01";
						  wrt_pc <= '0';
						  pc_source <= "01";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '1';			
						  
						  nextState<= S0;
			
			when S9 => read_mem <= '0';
						  ula_source_a <= '0';
						  i_or_d <= '0';
						  wrt_inst <= '0';
						  ula_source_b <= "00";
						  ula_op <= "00";
						  wrt_pc <= '1';
						  pc_source <= "10";
						  wrt_reg <= '0';
						  reg_dst <= '0';
						  mem_to_reg <= '0';
						  wrt_mem <= '0';
						  wrt_pc_cond <= '0';			
						  
						  nextState<= S0;
						  
		end case;
	end process;
	
end architecture;
						  


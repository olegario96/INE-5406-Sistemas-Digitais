----------------------------------------------------------------------------------
-- Company:   Federal University of Santa Catarina
-- Engineer:  Gustavo Figuera Olegario
-- 
-- Create Date:    07/27/2016
-- Design Name: 
-- Module Name:  Datapath
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

entity data_path is
	port(
		clock, reset: in std_logic;
		pc_source, alu_source_b, alu_op: in std_logic_vector(1 downto 0);
		alu_source_a, wrt_reg, reg_dst, wrt_inst, mem_to_reg,
		wrt_mem, read_mem, i_or_d, wrt_pc, wrt_pc_cond: in std_logic;
		opcode: out std_logic_vector(5 downto 0)
	);

end entity;

architecture data_path_arch of data_path is
	component multiplexer2x1 is
		generic(width: natural := 32);
		
		port(
			input0, input1:  in std_logic_vector(width-1 downto 0);
			selection:       in std_logic;
			output:          out std_logic_vector(width-1 downto 0)
		);
		
	end component;
	
	component multiplexer3x1 is
		generic(width: natural := 32);
		
		port(
			input0, input1, input2: in std_logic_vector(width-1 downto 0);
			selection:					in std_logic_vector(1 downto 0);
			output:						out std_logic_vector(width-1 downto 0)
		);
		
	end component;
	
	component multiplexer4x1 is 
		generic(width: natural := 32);
		
		port(
			input0, input1, input2, input3: in std_logic_vector(width-1 downto 0);
			selection:                      in std_logic_vector(1 downto 0);
			output: 								  out std_logic_vector(width-1 downto 0)
		);
		
	end component;
	
	component shift_left_logical is
		generic(
			width: natural := 32;
			shift_amount: natural := 2
		);
	
	port(
		input:  in std_logic_vector(width-1 downto 0);
		output: out std_logic_vector(width-1 downto 0)
	);
	
	end component;
	
	component logic_gate_and is
		port(
			input0, input1: in std_logic;
			output: 			 out std_logic
		);
		
	end component;
	
	component logic_gate_or is
		port(
			input0, input1: in std_logic;
			output: 			 out std_logic
		);
		
	end component;
	
	component alu is
		generic(width: natural := 32);
		
		port(
			input0, input1: in std_logic_vector(width-1 downto 0);
			ALU_op:  		 in std_logic_vector(2 downto 0);
			output: 			 out std_logic_vector(width-1 downto 0);
			zero: 			 out std_logic
		);
		
	end component;
	
	component reg is
		generic(width: natural := 32);
		
		port(
			clock, reset, enable: in std_logic;
			input: 					 in std_logic_vector(width-1 downto 0);
			output: 					 out std_logic_vector(width-1 downto 0)
		);
		
	end component;
	
	component signal_extend is
		generic(
			width_input: natural := 16;
			width_output: natural := 32	
		);
		
		port(
			input:  in  std_logic_vector(width_input-1 downto 0);
			output: out std_logic_vector(width_output-1 downto 0)
		);
		
	end component;
	
	component register_bank is
		port(
			wrt_enable, clk: in std_logic;
			read_reg_a, read_reg_b, wrt_reg: in std_logic_vector(4 downto 0);
			wrt_data: in std_logic_vector(31 downto 0);
			reg_out_a, reg_out_b: out std_logic_vector(31 downto 0)
		);
		
	end component;
	
	component memory is
		port(
			clk, reset, wrt_mem, read_mem: in std_logic;
			address, wrt_data: in std_logic_vector(31 downto 0);
			mem_data: out std_logic_vector(31 downto 0)	
		);
		
	end component;
	
	component alu_control is
		port(
			funct:   in std_logic_vector(5 downto 0);
			ULAOp:  in std_logic_vector(1 downto 0);
			output: out std_logic_vector(2 downto 0)
		);
	
	end component;
	
	signal out_or, out_and, out_zero: std_logic;
	signal out_op_alu: std_logic_vector(2 downto 0);
	signal out_mux_reg: std_logic_vector(4 downto 0);
	signal in_unity_control: std_logic_vector(5 downto 0);		 
	signal out_reg_ins_26, out_shift_up: std_logic_vector (25 downto 0);
	signal out_shift_up_28: std_logic_vector (27 downto 0);
	signal out_pc, out_mux_pc, out_memory, out_reg_ins, out_reg_data,
			 out_mux_data, out_bank_reg_a, out_bank_reg_b,
			 out_signal_extend, out_reg_a, out_reg_b, out_shift_down,
			 out_mux_alu_a, out_mux_alu_b, out_alu, out_reg_alu,
			 out_mux_3x1: std_logic_vector(31 downto 0);
		
	begin	
	pc: reg generic map(32)
			  port map(clock, reset, out_or, out_mux_3x1, out_pc);
	
	mux_out_pc: multiplexer2x1 generic map(32)
					port map(out_pc, out_reg_alu, i_or_d, out_mux_pc);
					
	mem: memory
		  port map(clock, reset, wrt_mem, read_mem, out_mux_pc, out_reg_b,
					  out_memory);
					  
	instrucion_reg: reg generic map(32)
						 port map(clock, reset, wrt_inst, out_memory, out_reg_ins);
						 
	data_reg: reg generic map(32)
				 port map(clock, reset, '1', out_memory, out_reg_data);
				 
	in_unity_control <= out_reg_ins(31 downto 26);
	
	opcode <= in_unity_control;
	
	out_reg_ins_26 <= out_reg_ins(25 downto 0);
				 
	mux_in_wrt_reg: multiplexer2x1 generic map(5)
						 port map(out_reg_ins_26(20 downto 16), 
									 out_reg_ins_26(15 downto 11),
									 reg_dst, out_mux_reg);
									 
	mux_in_wrt_data: multiplexer2x1 generic map(32)
						  port map(out_reg_alu, out_reg_data, mem_to_reg,
									  out_mux_data);
									  
	reg_bank: register_bank
				 port map(wrt_reg, clock, out_reg_ins_26(25 downto 21),
							 out_reg_ins_26(20 downto 16), out_mux_reg, out_mux_data,
							 out_bank_reg_a, out_bank_reg_b);
							 
	signal_ext: signal_extend generic map(16, 32)
					port map(out_reg_ins_26(15 downto 0), out_signal_extend);
					
	reg_a: reg generic map(32)
				  port map(clock, reset, '1', out_bank_reg_a, out_reg_a);
				  
	reg_b: reg generic map(32)
				  port map(clock, reset, '1', out_bank_reg_b, out_reg_b);
				  
	shift_down: shift_left_logical generic map(32, 2)
					port map(out_signal_extend, out_shift_down);
					
	mux_in_alu_a: multiplexer2x1 generic map(32)
					  port map(out_pc, out_reg_a, alu_source_a, out_mux_alu_a);
					  
	mux_in_alu_b: multiplexer4x1 generic map(32)
					  port map(out_reg_b, std_logic_vector(to_signed(4, 32)), out_signal_extend, out_shift_down,
								  alu_source_b, out_mux_alu_b);
								  
	shift_up: shift_left_logical generic map(26, 2)
				 port map(out_reg_ins_26, out_shift_up);
				 
	out_shift_up_28 <= "00"&out_shift_up;
				 							  
	alu_0: alu generic map(32)
			port map(out_mux_alu_a, out_mux_alu_b, out_op_alu, out_alu, out_zero);
			
	op_alu: alu_control
			  port map(out_reg_ins_26(5 downto 0), alu_op, out_op_alu);
			  
	reg_ula: reg generic map(32)
				    port map(clock, reset, '1', out_alu, out_reg_alu);
					 
	mux_out_alu: multiplexer3x1 generic map(32)
					 port map(out_alu, out_reg_alu, out_pc(31 downto 28)&out_shift_up_28, pc_source);
					 
	gate_and: logic_gate_and
				 port map(out_zero, wrt_pc_cond, out_and);
				 
	gate_or: logic_gate_or
				port map(out_and, wrt_pc, out_or);
	
end architecture;
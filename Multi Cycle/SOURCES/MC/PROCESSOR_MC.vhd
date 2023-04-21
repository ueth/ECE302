----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:05 05/17/2022 
-- Design Name: 
-- Module Name:    PROCESSOR_MC - Structural 
-- Project Name: 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PROCESSOR_MC is
	Port ( 	Rst 			: in STD_LOGIC;
				Clk 			: in STD_LOGIC;
				Instr 		: in STD_LOGIC_VECTOR (31 downto 0);
				MM_WrEn		: out STD_LOGIC;
				MM_RdData	: in STD_LOGIC_VECTOR (31 downto 0);
				MM_Addr		: out STD_LOGIC_VECTOR (31 downto 0);
				MM_WrData  	: out STD_LOGIC_VECTOR (31 downto 0);
				PC				: out STD_LOGIC_VECTOR (31 downto 0));
end PROCESSOR_MC;

architecture Structural of PROCESSOR_MC is

	---------------------DEFINE COMPONENTS---------------------
	
	component DATAPATH_MC
		Port ( Instr 				: in  STD_LOGIC_VECTOR (31 downto 0);
				 RF_WrEn 			: in  STD_LOGIC;
				 RF_WrData_sel 	: in  STD_LOGIC;
				 RF_B_sel 			: in  STD_LOGIC;
				 ImmExt 				: in  STD_LOGIC_VECTOR (1 downto 0);
				 Clk 					: in  STD_LOGIC;
				 ALU_Bin_sel 		: in  STD_LOGIC;
				 ALU_func 			: in  STD_LOGIC_VECTOR (3 downto 0);
				 ALU_zero 			: out  STD_LOGIC;
				 PC_sel 				: in  STD_LOGIC;
				 PC_LdEn 			: in  STD_LOGIC;
				 Rst 					: in  STD_LOGIC;
				 PC 					: out STD_LOGIC_VECTOR (31 downto 0);
				 ByteOp 				: in  STD_LOGIC;
				 Mem_WrEn 			: in  STD_LOGIC;
				 MM_WrEn 			: out  STD_LOGIC;
				 MM_Addr 			: out  STD_LOGIC_VECTOR (31 downto 0);
				 MM_WrData 			: out  STD_LOGIC_VECTOR (31 downto 0);
				 MM_RdData 			: in  STD_LOGIC_VECTOR (31 downto 0);
				 
				 RF_A_WrEnReg		: in  STD_LOGIC;
				 RF_B_WrEnReg		: in  STD_LOGIC;
				 MEM_WrEnReg		: in  STD_LOGIC;
				 ALUout_WrEnReg	: in  STD_LOGIC;
				 Instr_WrEnReg		: in  STD_LOGIC);
	end component;
	
	component CONTROL_MC
		Port ( Opcode 				: in STD_LOGIC_VECTOR (5 downto 0);
				 Func   				: in STD_LOGIC_VECTOR (5 downto 0);
				 ImmExt 				: out STD_LOGIC_VECTOR (1 downto 0);
				 ALU_zero 			: in STD_LOGIC;
				 ALU_Bin_sel		: out STD_LOGIC;
				 ALU_func			: out STD_LOGIC_VECTOR (3 downto 0);
				 RF_WrEn				: out STD_LOGIC;
				 MEM_WrEn			: out STD_LOGIC;
				 PC_LdEn				: out STD_LOGIC;
				 ByteOp				: out STD_LOGIC;
				 RF_B_sel			: out STD_LOGIC;
				 RF_WrData_sel		: out STD_LOGIC;
				 PC_sel				: out STD_LOGIC;
				 Rst					: in STD_LOGIC;
				 Clk					: in STD_LOGIC;
			 
				 RF_A_WrEnReg		: out  STD_LOGIC;
				 RF_B_WrEnReg		: out  STD_LOGIC;
				 MEM_WrEnReg		: out  STD_LOGIC;
				 ALUout_WrEnReg	: out  STD_LOGIC;
				 Instr_WrEnReg		: out  STD_LOGIC);
	end component;
	
	-----------------------------------------------------------
	
	signal Instr_sig 				: STD_LOGIC_VECTOR (31 downto 0);
	signal RF_WrEn_sig			: STD_LOGIC;
	signal Rf_WrData_sel_sig	: STD_LOGIC;
	signal RF_B_sel_sig			: STD_LOGIC;
	signal ImmExt_sig				: STD_LOGIC_VECTOR (1 downto 0);
	signal ALU_Bin_sel_sig		: STD_LOGIC;
	signal ALU_func_sig			: STD_LOGIC_VECTOR (3 downto 0);
	signal ALU_zero_sig			: STD_LOGIC;
	signal PC_sel_sig				: STD_LOGIC;
	signal PC_LdEn_sig			: STD_LOGIC;
	signal ByteOp_sig				: STD_LOGIC;
	signal MEM_WrEn_sig			: STD_LOGIC;
	signal RF_A_WrEnReg_sig		: STD_LOGIC;
	signal RF_B_WrEnReg_sig		: STD_LOGIC;
	signal MEM_WrEnReg_sig		: STD_LOGIC;
	signal ALUout_WrEnReg_sig	: STD_LOGIC;
	signal Instr_WrEnReg_sig	: STD_LOGIC;

begin

	DATAPATH_MC_1 : DATAPATH_MC port map ( Instr				=> Instr,
														RF_WrEn			=> RF_WrEn_sig,
														RF_WrData_sel	=> Rf_WrData_sel_sig,
														RF_B_sel			=> RF_B_sel_sig,
														ImmExt			=> ImmExt_sig,
														Clk				=> Clk,
														ALU_Bin_sel		=> ALU_Bin_sel_sig,
														ALU_func			=> ALU_func_sig,
														ALU_zero			=> ALU_zero_sig,
														PC_sel			=> PC_sel_sig,
														PC_LdEn			=> PC_LdEn_sig,
														Rst				=> Rst,
														PC					=> PC,
														ByteOp			=> ByteOp_sig,
														Mem_WrEn			=> MEM_WrEn_sig,
														MM_WrEn			=> MM_WrEn,
														MM_Addr			=> MM_Addr,
														MM_WrData		=> MM_WrData,
														MM_RdData		=> MM_RdData,
														RF_A_WrEnReg	=> RF_A_WrEnReg_sig,
														RF_B_WrEnReg	=> RF_B_WrEnReg_sig,
														MEM_WrEnReg		=> MEM_WrEnReg_sig,
														ALUout_WrEnReg	=> ALUout_WrEnReg_sig,
														Instr_WrEnReg	=> Instr_WrEnReg_sig);
												
	CONTROL_MC_1 : CONTROL_MC port map ( Opcode 			=> Instr(31 downto 26),
													 Func   			=> Instr(5 downto 0),
													 ImmExt 			=> ImmExt_sig,
													 ALU_zero 		=> ALU_zero_sig,
													 ALU_Bin_sel	=> ALU_Bin_sel_sig,
													 ALU_func		=> ALU_func_sig,
													 RF_WrEn			=> RF_WrEn_sig,
													 MEM_WrEn		=> MEM_WrEn_sig,
													 PC_LdEn			=> PC_LdEn_sig,
													 ByteOp			=> ByteOp_sig,
													 RF_B_sel		=> RF_B_sel_sig,
													 RF_WrData_sel => Rf_WrData_sel_sig,
													 PC_sel			=> PC_sel_sig,
													 Rst				=> Rst,
													 Clk				=> Clk,
													 RF_A_WrEnReg	=> RF_A_WrEnReg_sig,
													 RF_B_WrEnReg	=> RF_B_WrEnReg_sig,
													 MEM_WrEnReg	=> MEM_WrEnReg_sig,
												    ALUout_WrEnReg=> ALUout_WrEnReg_sig,
													 Instr_WrEnReg	=> Instr_WrEnReg_sig);

end Structural;


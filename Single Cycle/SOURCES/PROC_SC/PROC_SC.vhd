----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:02:02 04/09/2022 
-- Design Name: 
-- Module Name:    PROC_SC - Structural 
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

entity PROC_SC is
	Port ( 	Rst : in STD_LOGIC;
				Clk : in STD_LOGIC);
end PROC_SC;

architecture Structural of PROC_SC is

	---------------------DEFINE COMPONENTS---------------------
	
	component DATAPATH
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
				 MM_RdData 			: in  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component CONTROL
		Port ( Opcode 			: in STD_LOGIC_VECTOR (5 downto 0);
				 Func   			: in STD_LOGIC_VECTOR (5 downto 0);
				 ImmExt 			: out STD_LOGIC_VECTOR (1 downto 0);
				 ALU_zero 		: in STD_LOGIC;
				 ALU_Bin_sel	: out STD_LOGIC;
				 ALU_func		: out STD_LOGIC_VECTOR (3 downto 0);
				 RF_WrEn			: out STD_LOGIC;
				 MEM_WrEn		: out STD_LOGIC;
				 PC_LdEn			: out STD_LOGIC;
				 ByteOp			: out STD_LOGIC;
				 RF_B_sel		: out STD_LOGIC;
				 RF_WrData_sel	: out STD_LOGIC;
				 PC_sel			: out STD_LOGIC;
				 Rst				: in STD_LOGIC);
	end component;
	
	component RAM
		Port ( clk 			: in  STD_LOGIC;
				 inst_addr 	: in  STD_LOGIC_VECTOR (10 downto 0);
				 inst_dout 	: out  STD_LOGIC_VECTOR (31 downto 0);
				 data_we 	: in  STD_LOGIC;
				 data_addr 	: in  STD_LOGIC_VECTOR (10 downto 0);
				 data_din 	: in  STD_LOGIC_VECTOR (31 downto 0);
				 data_dout 	: out  STD_LOGIC_VECTOR (31 downto 0));
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
	signal PC_sig					: STD_LOGIC_VECTOR (31 downto 0);
	signal ByteOp_sig				: STD_LOGIC;
	signal MEM_WrEn_sig			: STD_LOGIC;
	signal MM_WrEn_sig			: STD_LOGIC;
	signal MM_Addr_sig			: STD_LOGIC_VECTOR (31 downto 0);
	signal MM_WrData_sig			: STD_LOGIC_VECTOR (31 downto 0);
	signal MM_RdData_sig			: STD_LOGIC_VECTOR (31 downto 0);

begin
	
	DATAPATH_1 : DATAPATH port map ( Instr				=> Instr_sig,
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
												PC					=> PC_sig,
												ByteOp			=> ByteOp_sig,
												Mem_WrEn			=> MEM_WrEn_sig,
												MM_WrEn			=> MM_WrEn_sig,
												MM_Addr			=> MM_Addr_sig,
												MM_WrData		=> MM_WrData_sig,
												MM_RdData		=> MM_RdData_sig);
												
	CONTROL_1 : CONTROL port map ( Opcode 			=> Instr_sig(31 downto 26),
											 Func   			=> Instr_sig(5 downto 0),
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
											 Rst				=> Rst);
											 
	RAM_1 : RAM port map ( clk 			=> Clk,
								  inst_addr 	=> PC_sig(12 downto 2),
								  inst_dout 	=> Instr_sig,
								  data_we 		=> MM_WrEn_sig,
								  data_addr 	=> MM_Addr_sig(12 downto 2),
								  data_din 		=> MM_WrData_sig,
								  data_dout 	=> MM_RdData_sig);
	

end Structural;


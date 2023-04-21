----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:01:01 04/04/2022 
-- Design Name: 
-- Module Name:    DATAPATH - Structural 
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

entity DATAPATH is
	Port ( 	 Instr 				: in  STD_LOGIC_VECTOR (31 downto 0);
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
				 MM_RdData 		: in  STD_LOGIC_VECTOR (31 downto 0));
end DATAPATH;

architecture Structural of DATAPATH is

	---------------------DEFINE COMPONENTS---------------------
	
	component DECSTAGE
		Port ( Instr 				: in  STD_LOGIC_VECTOR (31 downto 0);
				 RF_WrEn 			: in  STD_LOGIC;
				 ALU_out 			: in  STD_LOGIC_VECTOR (31 downto 0);
				 MEM_out 			: in  STD_LOGIC_VECTOR (31 downto 0);
				 RF_WrData_sel 	: in  STD_LOGIC;
				 RF_B_sel 			: in  STD_LOGIC;
				 Rst					: in 	STD_LOGIC;
				 ImmExt 				: in  STD_LOGIC_VECTOR (1 downto 0);
				 Clk 					: in  STD_LOGIC;
				 Immed 				: out  STD_LOGIC_VECTOR (31 downto 0);
				 RF_A 				: out  STD_LOGIC_VECTOR (31 downto 0);
				 RF_B 				: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component EXSTAGE
		Port ( RF_A 			: in  STD_LOGIC_VECTOR (31 downto 0);
				 RF_B 			: in  STD_LOGIC_VECTOR (31 downto 0);
				 Immed 			: in  STD_LOGIC_VECTOR (31 downto 0);
				 ALU_Bin_sel 	: in  STD_LOGIC;
				 ALU_func 		: in  STD_LOGIC_VECTOR (3 downto 0);
				 ALU_out 		: out  STD_LOGIC_VECTOR (31 downto 0);
				 ALU_zero 		: out  STD_LOGIC);
	end component;
	
	component IFSTAGE
		Port ( PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
				 PC_sel 		: in  STD_LOGIC;
				 PC_LdEn 	: in  STD_LOGIC;
				 Rst 			: in  STD_LOGIC;
				 Clk 			: in  STD_LOGIC;
				 PC 			: out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MEMSTAGE
		Port ( ByteOp 			: in  STD_LOGIC;
				 Mem_WrEn 		: in  STD_LOGIC;
				 ALU_MEM_Addr 	: in  STD_LOGIC_VECTOR (31 downto 0);
				 MEM_DataIn 	: in  STD_LOGIC_VECTOR (31 downto 0);
				 MEM_DataOut 	: out  STD_LOGIC_VECTOR (31 downto 0);
				 MM_WrEn 		: out  STD_LOGIC;
				 MM_Addr 		: out  STD_LOGIC_VECTOR (31 downto 0);
				 MM_WrData 		: out  STD_LOGIC_VECTOR (31 downto 0);
				 MM_RdData 		: in  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	
	-----------------------------------------------------------

	signal ALU_out_sig 	: STD_LOGIC_VECTOR (31 downto 0);
	signal Immed_sig 		: STD_LOGIC_VECTOR (31 downto 0);
	signal RF_A_sig		: STD_LOGIC_VECTOR (31 downto 0);
	signal RF_B_sig		: STD_LOGIC_VECTOR (31 downto 0);
	signal MEM_out_sig	: STD_LOGIC_VECTOR (31 downto 0);
	
begin

	DECSTAGE_1 : DECSTAGE port map ( Instr 				=> Instr,
												RF_WrEn 				=> RF_WrEn,
												ALU_out 				=> ALU_out_sig,
												RF_WrData_sel 		=> RF_WrData_sel,
												RF_B_sel 			=> RF_B_sel,
												Rst					=> Rst,
												ImmExt				=> ImmExt,
												Clk               => Clk,
												Immed 				=> Immed_sig,
												RF_A					=> RF_A_sig,
												RF_B					=> RF_B_sig,
												MEM_out				=> MEM_out_sig);
												
	EXSTAGE_1 : EXSTAGE port map ( RF_A		 		=> RF_A_sig,
											 RF_B 	 		=> RF_B_sig,
											 Immed 	 		=> Immed_sig,
											 ALU_Bin_sel	=> ALU_Bin_sel,
											 ALU_func		=> ALU_func,
											 ALU_out			=> ALU_out_sig,
											 ALU_zero		=> ALU_zero);

	IFSTAGE_1 : IFSTAGE port map ( PC_Immed 	=> Immed_sig,
											 PC_sel 		=> PC_sel,
											 PC_LdEn 	=> PC_LdEn,
											 Rst 			=> Rst,
											 PC 			=> PC,
											 Clk			=> Clk);
											 
	MEMSTAGE_1 : MEMSTAGE port map ( ByteOp			=> ByteOp,
												Mem_WrEn 		=> Mem_WrEn,
												ALU_MEM_Addr	=> ALU_out_sig,
												MEM_DataIn		=> RF_B_sig,
												MEM_DataOut		=> MEM_out_sig,
												MM_WrEn			=> MM_WrEn,
												MM_Addr			=> MM_Addr,
												MM_WrData 		=> MM_WrData,
												MM_RdData		=> MM_RdData);
												
end Structural;


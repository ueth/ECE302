----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:29:41 04/08/2022 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
    Port ( Opcode 		: in STD_LOGIC_VECTOR (5 downto 0);
			  Func   		: in STD_LOGIC_VECTOR (5 downto 0);
			  ImmExt 		: out STD_LOGIC_VECTOR (1 downto 0);
			  ALU_zero 		: in STD_LOGIC;
			  ALU_Bin_sel	: out STD_LOGIC;
			  ALU_func		: out STD_LOGIC_VECTOR (3 downto 0);
			  RF_WrEn		: out STD_LOGIC;
			  MEM_WrEn		: out STD_LOGIC;
			  PC_LdEn		: out STD_LOGIC;
			  ByteOp			: out STD_LOGIC;
			  RF_B_sel		: out STD_LOGIC;
			  RF_WrData_sel: out STD_LOGIC;
			  PC_sel			: out STD_LOGIC;
			  Rst				: in STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is



begin

	process(Opcode, Func, ALU_zero, Rst)
	begin
		if Rst = '1' then
			ImmExt 		<= "00";
			ALU_Bin_sel <= '0';
			ALU_func 	<= "0000";
			RF_WrEn		<= '0';
			MEM_WrEn		<= '0';
			PC_LdEn		<= '0';
			ByteOp		<= '0';
			RF_B_sel		<= '0';
			PC_sel		<= '0';
		else
			case Opcode is
				when "100000" => -- R Type
					ALU_func 		<= Func(3 downto 0); -- Pass function to Datapath
					ALU_Bin_sel 	<= '0'; -- SELECT RF_B_sel (R TYPE)
					RF_B_sel			<= '0'; -- rd = rt rs (Selecting rt)  opcode   rs	     rd	     rt	   shift 	func
--																					     6 bits	5 bits	5 bits	5 bits	5 bits  6 bits
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					
				when "111000" => -- I Type [ li ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed (I TYPE)
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					ImmExt			<= "00"; -- Signed Extend
					
				when "111001" => -- I Type [ lui ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed (I TYPE)
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					ImmExt			<= "10"; -- Fill 31 to 16 with zeros
					
				when "110000" => -- I Type [ addi ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed (I TYPE)
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					ImmExt			<= "00"; -- Signed Extend
				
				when "110010" => -- I Type [ nandi ]
					ALU_func 		<= "0101"; -- NOT (A AND B)
					ALU_Bin_sel 	<= '1'; -- SELECT Immed (I TYPE)
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					ImmExt			<= "10"; -- Fill 31 to 16 with zeros
					
				when "110011" => -- I Type [ ori ]
					ALU_func 		<= "0011"; -- OR
					ALU_Bin_sel 	<= '1'; -- SELECT Immed (I TYPE)
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					ImmExt			<= "10"; -- Fill 31 to 16 with zeros
					
				when "111111" => -- I Type [ b ]
					ALU_Bin_sel 	<= '1'; -- SELECT Immed (I TYPE)
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					ImmExt			<= "01"; -- Shift left 2 sign extend
					
				when "000000" => -- [ beq ]
					ALU_func 		<= "0001"; -- SUB
					RF_B_sel			<= '1'; -- SELECT rd
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '0'; -- SELECT B
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					ImmExt			<= "01"; -- Shift left 2 sign extend
					
				when "000001" => -- [ bne ]
					ALU_func 		<= "0001"; -- SUB
					RF_B_sel			<= '1'; -- SELECT rd
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '0'; -- SELECT B
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					ImmExt			<= "01"; -- Shift left 2 sign extend
					
				when "000011" => -- [ lb ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '1'; -- SELECT MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					ImmExt			<= "00"; -- Sign Extend
					ByteOp			<= '1'; -- Loads Byte
					
				when "000111" => -- [ sb ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '0'; -- SELECT ALU
					RF_B_sel			<= '1'; -- B out goes into MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '1'; -- Writing to MEM
					ImmExt			<= "00"; -- Sign Extend
					ByteOp			<= '1'; -- Stores Byte
					
				when "001111" => -- [ lw ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '1'; -- SELECT MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					ImmExt			<= "00"; -- Sign Extend
					ByteOp			<= '0'; -- Loads Word
				
				when "011111" => -- [ sw ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '0'; -- SELECT ALU
					RF_B_sel			<= '1'; -- B out goes into MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '1'; -- Writing to MEM
					ImmExt			<= "00"; -- Sign Extend
					ByteOp			<= '0'; -- Stores Word
				
				when others =>
					ImmExt 		<= "00";
					ALU_Bin_sel <= '0';
					ALU_func 	<= "0000";
					RF_WrEn		<= '0';
					MEM_WrEn		<= '0';
					PC_LdEn		<= '0';
					ByteOp		<= '0';
					RF_B_sel		<= '0';
					PC_sel		<= '0';
			end case;
		end if;
		
		case Opcode is
			when "000000" => -- [ beq ]
				if ALU_zero = '1' then
					PC_sel <= '1'; -- A equals B -> A-B = 0 -> ALU_zero = 1
				else
					PC_sel <= '0'; -- Not equal
				end if;
				
			when "000001" => -- [ bne ]
				if ALU_zero = '0' then
					PC_sel <= '1'; -- A not equal B -> A-B != 0 -> ALU_zero = 0
				else
					PC_sel <= '0'; -- Not equal
				end if;
				
			when "111111" => -- [ b ]
				PC_sel <= '1'; -- Jump SELECT ADDER + 4 + Immed
				
			when others =>
				PC_sel <= '0'; -- SELECT ADDER + 4
		end case;

	end process;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:22:35 05/15/2022 
-- Design Name: 
-- Module Name:    CONTROL_MC - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL_MC is
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
end CONTROL_MC;

architecture Behavioral of CONTROL_MC is

	type state is (state1, state2, state3, state4, state5, state6, state7, state8, state9, state10, state11);

	signal currentState 	: state;
	signal nextState	  	: state;

begin

	process(currentState, Opcode, Func, ALU_zero, Rst)
		begin
			case currentState is
				
				when state1	=> -- Resset
					ImmExt 			<= "10";
					ALU_Bin_sel 	<= '0';
					ALU_func 		<= "0000";
					RF_WrEn			<= '0';
					MEM_WrEn			<= '0';
					PC_LdEn			<= '0';
					ByteOp			<= '0';
					RF_B_sel			<= '0';
					PC_sel			<= '0';
					RF_A_WrEnReg	<= '0';
					RF_B_WrEnReg	<= '0';
					MEM_WrEnReg		<= '0';
					ALUout_WrEnReg	<= '0';
					Instr_WrEnReg	<= '0';
					nextState		<= state2;
					
				when state2	=> -- IF stage
					PC_LdEn			<= '0';
					Instr_WrEnReg	<= '1';
					PC_sel			<= '0';
					nextState		<= state3;
					
				when state3	=> -- Decode Opcode
					ImmExt 			<= "10";
					PC_LdEn			<= '0';
					RF_WrEn			<= '0';
					Instr_WrEnReg	<= '0';
					PC_sel 			<= '0';
					MEM_WrEn			<= '0';
					RF_A_WrEnReg	<= '1';
					RF_B_WrEnReg	<= '1';
					ALUout_WrEnReg	<= '1';
					
					if Opcode = "000000" or Opcode = "000001" or Opcode = "000111" or Opcode = "011111" then -- Selecting Data from rd
						RF_B_sel <= '1';
					else
						RF_B_sel <= '0';
					end if;
					
					if Opcode = "000011" or Opcode = "001111" then -- For load enable MEM register 
						MEM_WrEnReg	<= '1';
					else
						MEM_WrEnReg	<= '0';
					end if;
					
					if Opcode = "100000" then -- ALU command R type
						nextState <= state4;
					elsif Opcode = "110000" or Opcode = "110010" or Opcode = "110011" or Opcode = "111000" or Opcode = "111001" then -- I type
						nextState <= state6;	
					elsif Opcode = "000000" or Opcode = "000001" or Opcode = "111111" then -- beq, bne, b
						nextState <= state7;
					elsif Opcode = "011111" or Opcode = "001111" or Opcode = "000111" or Opcode = "000011" then -- Load, store
						nextState <= state8;	
					end if;
					
				when state4 => -- ALU R type
					ALU_Bin_sel		<= '0';
					ALU_func			<= Func(3 downto 0);
					nextState		<= state5;
					
				when state5 => -- Write data to Register file
					RF_WrData_sel	<= '0'; -- Select ALU
					RF_WrEn			<= '1'; -- Enable Register File
					PC_LdEn			<= '1';
					nextState		<= state2;
				
				when state6 => -- ALU I type
					ALU_Bin_sel 	<= '1'; -- Select Immed in ALU
					
					if Opcode = "111000" or Opcode = "110000" then -- li, addi
						ImmExt 	<= "00"; -- Sign extend
						ALU_func <= "0000"; -- ADD
					elsif Opcode = "111001" then -- lui
						ImmExt	<= "10"; -- Fill 31 to 16 with zeros
						ALU_func <= "0000"; -- ADD
					elsif Opcode = "110011" then -- ori
						ImmExt	<= "10"; -- Fill 31 to 16 with zeros
						ALU_func <= "0011"; -- OR
					else -- nandi
						ImmExt	<= "10"; -- Fill 31 to 16 with zeros
						ALU_func <= "0101"; -- NOT (A AND B)
					end if;
					nextState <= state5;
					
				when state7 => -- Branch beq, bne, b
					ALU_func 	<= "0001"; -- SUB
					PC_LdEn 		<= '1';
					
					case Opcode is
						when "000000" => -- [ beq ]
							ALU_Bin_sel <= '0'; -- SELECT B
							if ALU_zero = '1' then
								PC_sel <= '1'; -- A equals B -> A-B = 0 -> ALU_zero = 1
							else
								PC_sel <= '0'; -- Not equal
							end if;
							
						when "000001" => -- [ bne ]
							ALU_Bin_sel <= '0'; -- SELECT B
							if ALU_zero = '0' then
								PC_sel <= '1'; -- A not equal B -> A-B != 0 -> ALU_zero = 0
							else
								PC_sel <= '0'; -- Not equal
							end if;
							
						when others => -- [ b ]
								ALU_Bin_sel <= '1'; -- SELECT Immed
								PC_sel <= '1';
					end case;
					PC_LdEn			<= '1';
					nextState <= state2;
					
				when state8 => -- load, store
					ImmExt		<= "00"; -- Sign extend
					ALU_Bin_sel <= '1'; -- Select Immed
					ALU_func 	<= "0000"; -- ADD
					if Opcode = "000011" or Opcode = "001111" then
						nextState <= state9; -- Load
					else
						nextState <= state10; -- Store
					end if;
					
				when state9 => -- Load
					if Opcode = "000011" then -- Load byte
						ByteOp <= '1';
					else
						ByteOp <= '0';
					end if;
					nextState		<= state11;
				
				when state11 => -- Load to Register File
					RF_WrData_sel	<= '1'; -- Select MEM out 
					RF_WrEn			<= '1'; -- Enable RF
					PC_LdEn			<= '1';
					nextState 		<= state2;
				
				when state10 => -- Store
					MEM_WrEn			<= '1';
					if Opcode = "000111" then -- Store byte
						ByteOp <= '1';
					else
						ByteOp <= '0';
					end if;
					PC_LdEn			<= '1';
					nextState 		<= state2;
			end case;
		end process;


	process(Clk, Rst)
		begin
			if rising_edge(Clk) then
				if Rst = '1' then
					currentState <= state1;
				else 
					currentState <= nextState;
				end if;
			end if;
		end process;
end Behavioral;


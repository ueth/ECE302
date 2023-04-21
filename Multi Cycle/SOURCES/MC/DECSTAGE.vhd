----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:02:23 03/23/2022 
-- Design Name: 
-- Module Name:    DECSTAGE - Structural 
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

entity DECSTAGE is
    Port ( Instr 				: in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn 			: in  STD_LOGIC;
           ALU_out 			: in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out 			: in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel 	: in  STD_LOGIC;
           RF_B_sel 			: in  STD_LOGIC;
			  Rst					: in 	STD_LOGIC;
           ImmExt 			: in  STD_LOGIC_VECTOR (1 downto 0);
           Clk 				: in  STD_LOGIC;
           Immed 				: out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A 				: out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 				: out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Structural of DECSTAGE is

	---------------------DEFINE COMPONENTS---------------------
	
	component Multiplexer2To1
		Port ( Input1 	: in  STD_LOGIC_VECTOR (31 downto 0);
				 Input2 	: in  STD_LOGIC_VECTOR (31 downto 0);
				 Output 	: out  STD_LOGIC_VECTOR (31 downto 0);
				 Slct 	: in  STD_LOGIC);
	end component;
	
	component Multiplexer5Bit2To1
		Port ( Input1 	: in  STD_LOGIC_VECTOR (4 downto 0);
				 Input2 	: in  STD_LOGIC_VECTOR (4 downto 0);
				 Output 	: out  STD_LOGIC_VECTOR (4 downto 0);
				 Slct 	: in  STD_LOGIC);
	end component;
	
	component Immed_extend
		Port ( Input  	: in  STD_LOGIC_VECTOR (15 downto 0);
				 Output 	: out  STD_LOGIC_VECTOR (31 downto 0);
				 Slct	  	: in STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	component RegisterFile
		Port ( Ard1	 	: in std_logic_vector(4 downto 0);
				 Ard2 	: in std_logic_vector(4 downto 0);
				 Awr  	: in std_logic_vector(4 downto 0);
				 Din		: in std_logic_vector(31 downto 0);
				 WrEn		: in std_logic;
				 Clk 		: in std_logic;
				 Rst		: in std_logic;
				 Dout1	: out std_logic_vector(31 downto 0);
				 Dout2 	: out std_logic_vector(31 downto 0));
	end component;
	
	-----------------------------------------------------------
	
	signal OutputMUX5Bit_sig 	: STD_LOGIC_VECTOR (4 downto 0);
	signal OutputMUX32Bit_sig 	: STD_LOGIC_VECTOR (31 downto 0);
	
begin
	
	Multiplexer5Bit2To1_1 : Multiplexer5Bit2To1 port map( Input1 => Instr(15 downto 11),
																			Input2 => Instr(20 downto 16),
																			Output => OutputMUX5Bit_sig,
																			Slct   => RF_B_sel);
																			
	Multiplexer2To1_1 : Multiplexer2To1 port map( Input1 => ALU_out,
																 Input2 => MEM_out,
																 Output => OutputMUX32Bit_sig,
																 Slct   => RF_WrData_sel);
	
	Immed_extend_1 : Immed_extend port map( Input  => Instr(15 downto 0),
														 Output => Immed,
														 Slct   => ImmExt);
														 
	RegisterFile_1 : RegisterFile port map ( Clk 	=> Clk,
														  Ard1	=> Instr(25 downto 21),
														  Ard2	=> OutputMUX5Bit_sig,
														  Awr		=> Instr(20 downto 16),
														  Din 	=> OutputMUX32Bit_sig,
														  Dout1 	=> RF_A,
														  Dout2 	=> RF_B,
														  WrEn 	=> RF_WrEn,
														  Rst		=> Rst);

end Structural;


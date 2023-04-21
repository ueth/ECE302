----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:20:00 03/24/2022 
-- Design Name: 
-- Module Name:    EXSTAGE - Structural 
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

entity EXSTAGE is
    Port ( RF_A 			: in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 			: in  STD_LOGIC_VECTOR (31 downto 0);
           Immed 			: in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel 	: in  STD_LOGIC;
           ALU_func 		: in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out 		: out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero 		: out  STD_LOGIC);
end EXSTAGE;

architecture Structural of EXSTAGE is

	---------------------DEFINE COMPONENTS---------------------
	
		component ALU 
			Port ( A 			: in  STD_LOGIC_VECTOR (31 downto 0);
					 B 			: in  STD_LOGIC_VECTOR (31 downto 0);
					 Op 			: in  STD_LOGIC_VECTOR (3 downto 0);
					 OutPut 		: out  STD_LOGIC_VECTOR (31 downto 0);
					 Zero 		: out  STD_LOGIC := '0';
					 Cout 		: out  STD_LOGIC := '0';
					 Ovf 			: out  STD_LOGIC := '0');
		end component;
		
		component Multiplexer2To1
			Port ( Input1 	: in  STD_LOGIC_VECTOR (31 downto 0);
					 Input2 	: in  STD_LOGIC_VECTOR (31 downto 0);
					 Output 	: out STD_LOGIC_VECTOR (31 downto 0);
					 Slct 	: in  STD_LOGIC);
		end component;
		
	-----------------------------------------------------------
	
	signal MuxOutput_sig : STD_LOGIC_VECTOR (31 downto 0);

begin
	
	Multiplexer2To1_1 : Multiplexer2To1 port map ( Input1 => RF_B,
																  Input2 => Immed,
																  Slct	=> ALU_Bin_sel,
																  Output => MuxOutput_sig);
																		
	ALU_1 : ALU port map ( A 		=> RF_A,
								  B 		=> MuxOutput_sig,
								  Op		=> ALU_func,
								  OutPut => ALU_out,
								  Zero 	=> ALU_zero);

end Structural;


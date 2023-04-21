----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:57:27 03/22/2022 
-- Design Name: 
-- Module Name:    IFSTAGE - Structural 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel 	: in  STD_LOGIC;
           PC_LdEn 	: in  STD_LOGIC;
           Rst 		: in  STD_LOGIC;
           Clk 		: in  STD_LOGIC;
           PC 			: out STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Structural of IFSTAGE is

	---------------------DEFINE COMPONENTS---------------------

	component Register32Bit
		Port ( Clk 			 : in  STD_LOGIC;
				 Rst 			 : in  STD_LOGIC;
				 WriteEnable : in  STD_LOGIC;
				 DataIn 		 : in  STD_LOGIC_VECTOR (31 downto 0);
				 DataOut		 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Adder32Bit
		Port ( Input1 : in std_logic_vector(31 downto 0);
				 Input2 : in std_logic_vector(31 downto 0);
				 Output : out std_logic_vector(31 downto 0));
	end component;
	
	component Multiplexer2To1
		Port ( Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
				 Input2 : in  STD_LOGIC_VECTOR (31 downto 0);
				 Output : out  STD_LOGIC_VECTOR (31 downto 0);
				 Slct 	: in  STD_LOGIC);
	end component;
	
	-----------------------------------------------------------
	
	signal OutputAdder2_sig : std_logic_vector(31 downto 0);
	signal OutputAdder1_sig : std_logic_vector(31 downto 0);
	signal OutputPC_sig : std_logic_vector(31 downto 0);
	signal OutputMUX_sig : std_logic_vector(31 downto 0);

begin
	
	Adder32Bit_1: Adder32Bit port map( Input1 	=> PC_Immed,
												  Input2		=> OutputAdder2_sig,
												  Output		=> OutputAdder1_sig);
												  
	Adder32Bit_2: Adder32Bit port map( Input1 	=> OutputPC_sig,
												  Input2		=> x"0000_0004",
												  Output		=> OutputAdder2_sig);
												  
	Multiplexer2To1_1: Multiplexer2To1 port map( Input1 => OutputAdder2_sig,
																Input2 => OutputAdder1_sig,
																Slct	 => PC_sel,
																Output => OutputMUX_sig);
																
	Register32Bit_1 : Register32Bit port map ( Clk => Clk,
															 Rst => Rst,
															 WriteEnable => PC_LdEn,
															 DataIn => OutputMUX_sig,
															 DataOut => OutputPC_sig);
	PC <= OutputPC_sig;

end Structural;


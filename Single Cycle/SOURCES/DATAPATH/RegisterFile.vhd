----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:34:58 03/13/2022 
-- Design Name: 
-- Module Name:    RegisterFile - Structural 
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
use work.Array_of_vectors.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is

	port( Ard1	 	: in std_logic_vector(4 downto 0);
	      Ard2 		: in std_logic_vector(4 downto 0);
			Awr  		: in std_logic_vector(4 downto 0);
			Din		: in std_logic_vector(31 downto 0);
			WrEn		: in std_logic;
			Clk 		: in std_logic;
			Rst		: in std_logic;
			Dout1		: out std_logic_vector(31 downto 0);
			Dout2 	: out std_logic_vector(31 downto 0));
			
	
end RegisterFile;

architecture Structural of RegisterFile is

	---------------------DEFINE COMPONENTS---------------------

	component Decoder5To32
		Port ( Input 	: in STD_LOGIC_VECTOR (4 downto 0);
				 Output 	: out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Register32Bit
		Port ( Clk 			 : in  STD_LOGIC;
				 Rst 			 : in  STD_LOGIC;
				 WriteEnable : in  STD_LOGIC;
				 DataIn 		 : in  STD_LOGIC_VECTOR (31 downto 0);
				 DataOut		 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Multiplexer32To1
		Port ( Slct 		: in std_logic_vector(4 downto 0);
				 Datain 		: in ArrayOfVectors;
				 Dataout 	: out std_logic_vector(31 downto 0));
	end component;
	
	-----------------------------------------------------------
	
	signal we_sig 					: std_logic_vector(31 downto 0);
	signal decoderOutput_sig 	: std_logic_vector(31 downto 0);
	signal registerOutput_sig 	: ArrayOfVectors;

begin

	Decoder5To32_1: Decoder5To32 port map( Input 	=> Awr,
													   Output	=> decoderOutput_sig);
												  
	WriteEnable: for i in 1 to 31 generate
						we_sig(i) <= WrEn and decoderOutput_sig(i) after 2 ns;
					 end generate;	
	we_sig(0) <= '0' after 2 ns; -- $Zero register must always be 0
	
	Registers: for i in 0 to 31 generate
						Register32Bit_1:	Register32Bit port map( WriteEnable => we_sig(i),
																				Clk 			=> Clk,
																				DataIn		=> Din,
																				Rst			=> Rst,
																				DataOut 		=> registerOutput_sig(i));
				  end generate;
	
	Multiplexer32To1_1: Multiplexer32To1 port map ( Slct 		=> Ard1,
																	Datain 	=> registerOutput_sig,
																	Dataout	=> Dout1);
																 
	Multiplexer32To1_2: Multiplexer32To1 port map ( Slct 		=> Ard2,
																	Datain 	=> registerOutput_sig,
																	Dataout	=> Dout2);

end Structural;


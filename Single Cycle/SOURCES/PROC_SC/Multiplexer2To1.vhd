----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:42 03/22/2022 
-- Design Name: 
-- Module Name:    Multiplexer2To1 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplexer2To1 is
    Port ( Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Slct 	: in  STD_LOGIC);
end Multiplexer2To1;

architecture Behavioral of Multiplexer2To1 is

	signal Output_sig : STD_LOGIC_VECTOR (31 downto 0);

begin

		Output_sig <= Input1 when Slct = '0' else
						  Input2 when Slct = '1';
						  
	Output <= Output_sig after 10 ns;
	
end Behavioral;


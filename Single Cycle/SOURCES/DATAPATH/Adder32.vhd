----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:45:58 03/22/2022 
-- Design Name: 
-- Module Name:    Adder32Bit - Behavioral 
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

entity Adder32Bit is
	Port( Input1 : in std_logic_vector(31 downto 0);
			Input2 : in std_logic_vector(31 downto 0);
			Output : out std_logic_vector(31 downto 0));
	
end Adder32Bit;

architecture Behavioral of Adder32Bit is

begin

	Output <= Input1 + Input2 after 5 ns;

end Behavioral;


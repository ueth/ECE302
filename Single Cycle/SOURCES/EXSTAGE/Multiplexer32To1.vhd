----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:47:25 03/13/2022 
-- Design Name: 
-- Module Name:    Multiplexer32To1 - Behavioral 
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
use work.Array_of_vectors.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplexer32To1 is
	Port ( 	Slct 		: in std_logic_vector(4 downto 0);
				Datain 	: in ArrayOfVectors;
				Dataout 	: out std_logic_vector(31 downto 0));
end Multiplexer32To1;

architecture Behavioral of Multiplexer32To1 is

begin

	Dataout <= Datain(to_integer(unsigned(Slct))) after 10 ns;

end Behavioral;


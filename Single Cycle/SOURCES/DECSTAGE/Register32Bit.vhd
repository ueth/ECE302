----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:11 03/10/2022 
-- Design Name: 
-- Module Name:    Register32Bit - Behavioral 
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
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register32Bit is
	Port ( Clk 				: in  STD_LOGIC;
          Rst 				: in  STD_LOGIC;
          WriteEnable 	: in  STD_LOGIC;
			 DataIn 			: in  STD_LOGIC_VECTOR (31 downto 0);
          DataOut 		: out  STD_LOGIC_VECTOR (31 downto 0));
end Register32Bit;

architecture Behavioral of Register32Bit is
	
begin
	
	process(Clk, Rst)
		begin
			if rising_edge(Clk) then
				if Rst = '1' then --Synchronus reset
					DataOut <= x"0000_0000" after 10 ns;
				else
					if WriteEnable = '1' then --Write Enable needs to be 1 in order for register to work
						DataOut <= DataIn after 10 ns;
					end if;
				end if;
			end if;
	end process;

end Behavioral;


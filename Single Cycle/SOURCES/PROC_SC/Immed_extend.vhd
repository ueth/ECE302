----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:08 03/23/2022 
-- Design Name: 
-- Module Name:    Immed_extend - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Immed_extend is
    Port ( Input  : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
			  Slct	: in STD_LOGIC_VECTOR (1 downto 0));
end Immed_extend;

architecture Behavioral of Immed_extend is

	signal Output_sig : STD_LOGIC_VECTOR (31 downto 0);
	
begin

	process(Output_sig, Slct, Input)
		begin
			if Slct = 0 then -- Sign extention
				Output_sig(15 downto 0) <= Input; 
				if Input(15) = '1' then
					Output_sig(31 downto 16) <= x"ffff";
				else
					Output_sig(31 downto 16) <= x"0000";
				end if;
				
			elsif Slct = 1 then -- Sign Extend Shift Left Input << 2
				if Input(15)= '1' then 
					Output_sig(31 downto 16) <= x"ffff";
				else
					Output_sig(31 downto 16) <= x"0000";
				end if;	
				Output_sig(17 downto 2) <= Input;
				Output_sig(1 downto 0)  <= "00";
				
			elsif Slct = 2 then -- Fill 31 to 16 with zeros
				Output_sig(31 downto 16) <= x"0000";
				Output_sig(15 downto 0)  <= Input;
				
			else -- Input << 2
				Output_sig(17 downto 2) <= Input;
				Output_sig(1 downto 0)  <= "00";
				Output_sig(31 downto 18)<= "00000000000000";
			end if;
		end process;
	
	Output <= Output_sig after 5 ns;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:11:28 03/26/2022 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( ByteOp 		: in  STD_LOGIC;
           Mem_WrEn 		: in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn 	: in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut 	: out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn 		: out  STD_LOGIC;
           MM_Addr 		: out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData 	: out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData 	: in  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

begin

	process(ByteOp, Mem_WrEn, ALU_MEM_Addr, MEM_DataIn, MM_RdData)
		begin
			MM_WrEn <= Mem_WrEn after 10 ns;
			MM_Addr <= ALU_MEM_Addr +x"400" after 10 ns;
			
			case ByteOp is
				when '0' => -- In this case we need the whole word (32 bits)
					MM_WrData 	<= MEM_DataIn after 10 ns; -- Store word
					MEM_DataOut <= MM_RdData after 10 ns; -- Load a word
				when others => -- In this case we need a byte (8 bits)
					MM_WrData 	<= "000000000000000000000000" & MEM_DataIn(7 downto 0) after 10 ns; -- Store byte
					MEM_DataOut <= "000000000000000000000000" & MM_RdData(7 downto 0) after 10 ns; -- Load byte
			end case;
			
	end process;

end Behavioral;


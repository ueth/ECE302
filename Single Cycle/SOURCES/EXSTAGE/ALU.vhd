----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:59:12 03/07/2022 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A 			: in  STD_LOGIC_VECTOR (31 downto 0);
           B 			: in  STD_LOGIC_VECTOR (31 downto 0);
           Op 			: in  STD_LOGIC_VECTOR (3 downto 0);
           OutPut 	: out  STD_LOGIC_VECTOR (31 downto 0);
           Zero 		: out  STD_LOGIC := '0';
           Cout 		: out  STD_LOGIC := '0';
           Ovf 		: out  STD_LOGIC := '0');
end ALU;

architecture Behavioral of ALU is
	signal OutPut_sig : STD_LOGIC_VECTOR (32 downto 0);
	signal Zero_sig 	: STD_LOGIC;
	signal Cout_sig 	: STD_LOGIC;
   signal Ovf_sig 	: STD_LOGIC;
begin

	process(Op , A, B, OutPut_sig, Ovf_sig, Cout_sig)
	begin
		case Op is
			when "0000" => --add
				OutPut_sig <= ('0' & A) + ('0' & B); --('0' & A)-> extends the A to a 33 bit vector in order to make possible to add 2 32bit vectors into a 33bit vector
				Cout_sig <= OutPut_sig(32);
				
				--Here we check if the 2 inputs have the same sign bit
				--If they do and they are both negative we have overflow if:
				--The sign bit of the output is 0, same for 
				--2 positive inputs but the sign bit needs to be 1.
				--In the case where we have 2 different signed inputs
				--we can't have overflow because our inputs have same length
				if(A(31) = '1' and B(31) = '1' and OutPut_sig(31) = '0') then
					Ovf_sig <= '1';
				elsif (A(31) = '0' and B(31) = '0' and OutPut_sig(31) = '1') then
					Ovf_sig <= '1';
				else
					Ovf_sig <= '0';
				end if;
				
				
			when "0001" => --sub
				OutPut_sig <= ('0' & A) - ('0' & B);
				Cout_sig <= OutPut_sig(32);
				
				--Here we check if the 2 inputs have the different sign bit
				--If they do, then we could have overflow if:
				--First input is a positive number and second is a negative number
				--we basicaly have an addition of 2 positive numbers (same case as above)
				--First input is a negative number and second is a positive number
				--we have an addition of 2 negative numbers (same case as above)
				if(A(31) = '0' and B(31) = '1' and OutPut_sig(31) = '1') then
					Ovf_sig <= '1';
				elsif (A(31) = '1' and B(31) = '0' and OutPut_sig(31) = '0') then
					Ovf_sig <= '1';
				else
					Ovf_sig <= '0';
				end if;
				
			when "0010" => --and
				OutPut_sig <= ('0' & A) and ('0' & B);
				
			when "0011" => --or
				OutPut_sig <= ('0' & A) or ('0' & B);
				
			when "0100" => --not A
				OutPut_sig <= not ('0' & A);
				
			when "0101" => --not AandB
				OutPut_sig <= not (('0' & A) and ('0' & B));
				
			when "0110" => --not AorB
				OutPut_sig <= not (('0' & A) or ('0' & B));
				
			when "1000" => --shift right arithmetic of A
				OutPut_sig(31) <= A(31);
				OutPut_sig(30 downto  0) <= A(31 downto 1);
			
			when "1001" => --shift right logical of A
				OutPut_sig(31) <= '0';
				OutPut_sig(30 downto  0) <= A(31 downto 1);
				
			when "1010" => --shift left logical of A
				OutPut_sig(31 downto  1) <= A(30 downto 0);
				OutPut_sig(0) <= '0';
				
			when "1100" => --rotate left of A
				OutPut_sig(31 downto 1) <= A(30 downto 0);
				OutPut_sig(0) <= A(31);
				
			when "1101" => --rotate right of A
				OutPut_sig(31) <= A(0);
				OutPut_sig(30 downto 0) <= A(31 downto 1);
			
			when others =>
				OutPut_sig(32 DOWNTO 0) <= '0' & x"0000_0000";
		end case;
		
		--Zero is active when OutPut_sig is 0
		if OutPut_sig = 0 then
			Zero_sig <= '1';
		else
			Zero_sig <= '0';
		end if;
		
		OutPut(31 downto 0) <= OutPut_sig(31 downto 0) after 10 ns;
		Zero <= Zero_sig after 10 ns;
		Cout <= Cout_sig after 10 ns;
		Ovf <= Ovf_sig after 10 ns;
	end process;
end Behavioral;


--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:51:46 03/09/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/ALU_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         OutPut : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal OutPut : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          OutPut => OutPut,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
    begin
	 
		--4000ns IN TOTAL
		
		-------ADD-------
		--Add for zero
		Op<="0000";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		--Add with same sign inputs for overflow
		Op<="0000";
		A<=x"0000_0010";
		B<=x"7fff_ffff";
		wait for 100 ns;
		
		--Add for carry out
		Op<="0000";
		A<=x"f000_0000";
		B<=x"f000_0000";
		wait for 100 ns;
		
		--Add for overflow and Cout
		Op<="0000";
		A<=x"8000_0000";
		B<=x"8000_0000";
		wait for 100 ns;
		
		--Add for zero no cout no overflow (random inputs)
		Op<="0000";
		A<=x"8af0_abcd";
		B<=x"0000_54dc";
		wait for 100 ns;
		
		-------SUB-------
		--Sub for zero
		Op<="0001";
		A<=x"0001_abcd";
		B<=x"0001_abcd";
		wait for 100 ns;
		
		--Sub with different sign inputs for overflow
		Op<="0001";
		A<=x"8fff_0010";
		B<=x"7000_afff";
		wait for 100 ns;

		--Sub for carry out
		Op<="0001";
		A<=x"0000_0000";
		B<=x"7fff_ffff";
		wait for 100 ns;
		
		--Sub for overflow and Cout
		Op<="0001";
		A<=x"7000_0000";
		B<=x"8000_0000";
		wait for 100 ns;
		
		--Sub for zero no cout no overflow (random inputs)
		Op<="0001";
		A<=x"7afc_b000";
		B<=x"20f0_84ab";
		wait for 100 ns;

		-------AND-------
		Op<="0010";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		Op<="0010";
		A<=x"aaaa_aaaa";
		B<=x"5555_5555";
		wait for 100 ns;
		
		Op<="0010";
		A<=x"ffff_ffff";
		B<=x"ffff_ffff";
		wait for 100 ns;		

		-------OR-------
		Op<="0011";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		Op<="0011";
		A<=x"aaaa_aaaa";
		B<=x"5555_5555";
		wait for 100 ns;
		
		Op<="0011";
		A<=x"ffff_ffff";
		B<=x"ffff_ffff";
		wait for 100 ns;	
		
		-------NOT A-------
		Op<="0100";
		A<=x"0000_0000";
		wait for 100 ns;
		
		Op<="0100";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		Op<="0100";
		A<=x"ffff_ffff";
		wait for 100 ns;	
		
		-------NOT (A AND B)-------
		Op<="0110";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		Op<="0110";
		A<=x"aaaa_aaaa";
		B<=x"0000_0000";
		wait for 100 ns;
		
		Op<="0110";
		A<=x"ffff_ffff";
		B<=x"ffff_ffff";
		wait for 100 ns;	

		-------SRA-------
		Op<="1000";
		A<=x"8000_0000";
		wait for 100 ns;
		
		Op<="1000";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		Op<="1000";
		A<=x"7fff_ffff";
		wait for 100 ns;	
		
		-------SRL-------
		Op<="1001";
		A<=x"0000_0000";
		wait for 100 ns;
		
		Op<="1001";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		Op<="1001";
		A<=x"ffff_ffff";
		wait for 100 ns;	
		
		-------SLL-------
		Op<="1010";
		A<=x"0000_0000";
		wait for 100 ns;
		
		Op<="1010";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		Op<="1010";
		A<=x"ffff_ffff";
		wait for 100 ns;				

		-------ROTATE LEFT-------
		Op<="1100";
		A<=x"8000_0001";
		wait for 100 ns;
		
		Op<="1100";
		A<=x"0000_0000";
		wait for 100 ns;
		
		Op<="1100";
		A<=x"f000_0000";
		wait for 100 ns;
		
		-------ROTATE RIGHT-------
		Op<="1101";
		A<=x"8000_0001";
		wait for 100 ns;
		
		Op<="1101";
		A<=x"0000_0000";
		wait for 100 ns;
		
		Op<="1101";
		A<=x"0000_000f";
		wait for 100 ns;			
		
		-------NON VALID OPERATIONS-------
		Op<="1111";
		A<=x"abcd_1234";
		B<=x"abcd_1234";
		wait for 100 ns;
		
		Op<="1110";
		A<=x"abcd_1234";
		B<=x"abcd_1234";
		wait for 100 ns;
		
		Op<="0111";
		A<=x"abcd_1234";
		B<=x"abcd_1234";
		wait for 100 ns;	

      wait;
   end process;

END;

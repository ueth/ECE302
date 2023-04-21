--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:28:30 03/13/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/RegisterFile_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;
use work.Array_of_vectors.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegisterFile_tb IS
END RegisterFile_tb;
 
ARCHITECTURE behavior OF RegisterFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst,
          Dout1 => Dout1,
          Dout2 => Dout2
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 
   stim_proc: process
   begin		
	
		Rst<='1';
      wait for Clk_period;	
		wait for 10 ns;	
		
		--Attempt to write into register zero
		Rst<='0';
		WrEn<='1';
		Ard1<="00001";
		Ard2<="00000";
		Awr<="00000";
		Din<=x"abcd_aaaa";
		wait for Clk_period;

		--Attempt to write when write enable is '0'
		WrEn<='0';		
		Din<=x"8888_8888";
      wait for Clk_period;
		
		--Writing to the 3rd register and getting both outputs
		WrEn<='1';
		Ard1<="00010";
		Ard2<="00010";
		Awr<="00010";
		Din<=x"0000_0001";
		wait for Clk_period;
		
		--Writing to the second register and getting the first output
		Ard1<="00001";
		Ard2<="00010";
		Awr<="00001";
		Din<=x"0000_0002";
		wait for Clk_period;
		
		--Writing to the second register and getting the second output
		Ard1<="00000";
		Ard2<="00001";
		Awr<="00001";
		Din<=x"0000_0003";
		wait for Clk_period;
		
		--Checking reset
		Rst<='1';
		Ard1<="00000";
		Ard2<="00001";
		Awr<="00001";
		Din<=x"0000_0003";
		wait for Clk_period;
		
		--Random register
		Rst<='0';
		WrEn<='1';
		Ard1<="00111";
		Ard2<="00111";
		Awr<="00111";
		Din<=x"0000_ffff";
		wait for Clk_period;

		Ard1<="00000";
		Ard2<="00000";
		Awr<="00000";
		Din<=x"0000_0001";
		-- Writing to all registers
		for i in 1 to 31 loop
			Ard1<=Ard1 + 1;
			Ard2<=Ard2 + 1;
			Awr<=Awr +1;
			Din<= Din + 1;
			wait for Clk_period;
		end loop;
		
      wait;
   end process;

END;

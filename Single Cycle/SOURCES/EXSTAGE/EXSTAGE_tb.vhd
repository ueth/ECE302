--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:28:31 04/03/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/EXSTAGE_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGE
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY EXSTAGE_tb IS
END EXSTAGE_tb;
 
ARCHITECTURE behavior OF EXSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		
		-- RF_B-Immed -> 0
		-- ADD
		RF_A			<= x"0000_0001";
		RF_B			<= x"0000_0001";
		Immed			<= x"0000_0000";
		ALU_Bin_sel	<= '0';
		ALU_func 	<= "0000";
		wait for 100 ns;
		
		-- RF_B-Immed -> 0
		-- SUB
		RF_A			<= x"0000_0001";
		RF_B			<= x"0000_0001";
		Immed			<= x"0000_0000";
		ALU_Bin_sel	<= '0';
		ALU_func 	<= "0001";
		wait for 100 ns;
		
		-- RF_B-Immed -> 0
		-- AND
		RF_A			<= x"0000_0001";
		RF_B			<= x"0000_0001";
		Immed			<= x"0000_0000";
		ALU_Bin_sel	<= '0';
		ALU_func 	<= "0010";
		wait for 100 ns;
		
		-- RF_B-Immed -> 0
		-- OR
		RF_A			<= x"0000_00f1";
		RF_B			<= x"0000_0001";
		Immed			<= x"0000_0000";
		ALU_Bin_sel	<= '0';
		ALU_func 	<= "0011";
		wait for 100 ns;
		
		-- RF_B-Immed -> 0
		-- NOT A
		RF_A			<= x"0000_0001";
		RF_B			<= x"0000_0001";
		Immed			<= x"0000_0000";
		ALU_Bin_sel	<= '0';
		ALU_func 	<= "0100";
		wait for 100 ns;
		
		-- RF_B-Immed -> 1
		-- NOT A AND B
		RF_A			<= x"0000_00ff";
		RF_B			<= x"0000_000f";
		Immed			<= x"0000_00ff";
		ALU_Bin_sel	<= '1';
		ALU_func 	<= "0101";
		wait for 100 ns;

		-- RF_B-Immed -> 1
		-- NOT A OR B
		RF_A			<= x"0000_f001";
		RF_B			<= x"0000_f001";
		Immed			<= x"0000_0000";
		ALU_Bin_sel	<= '1';
		ALU_func 	<= "0110";
		wait for 100 ns;
		
		-- Shift A right arithmetic
		RF_A			<= x"c000_f001";
		RF_B			<= x"0000_f001";
		Immed			<= x"0000_ffff";
		ALU_func 	<= "1000";
		wait for 100 ns;
		
		-- Shift A right logical
		RF_A			<= x"c000_f001";
		RF_B			<= x"0000_f001";
		Immed			<= x"0000_ffff";
		ALU_func 	<= "1001";
		wait for 100 ns;
		
		-- Shift A left logical
		RF_A			<= x"0000_f001";
		RF_B			<= x"0000_f001";
		Immed			<= x"0000_ffff";
		ALU_func 	<= "1010";
		wait for 100 ns;
		
		-- Rotate A left
		RF_A			<= x"8000_f003";
		RF_B			<= x"0000_f001";
		Immed			<= x"0000_ffff";
		ALU_func 	<= "1100";
		wait for 100 ns;
		
		-- Rotate A right
		RF_A			<= x"c000_f001";
		RF_B			<= x"0000_f001";
		Immed			<= x"0000_ffff";
		ALU_func 	<= "1101";
		wait for 100 ns;
		
      wait;
   end process;

END;

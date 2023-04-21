--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:32:31 04/09/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/CONTROL_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROL_tb IS
END CONTROL_tb;
 
ARCHITECTURE behavior OF CONTROL_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Opcode : IN  std_logic_vector(5 downto 0);
         Func : IN  std_logic_vector(5 downto 0);
         ImmExt : OUT  std_logic_vector(1 downto 0);
         ALU_zero : IN  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         RF_WrEn : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         ByteOp : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         PC_sel : OUT  std_logic;
         Rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Opcode : std_logic_vector(5 downto 0) := (others => '0');
   signal Func : std_logic_vector(5 downto 0) := (others => '0');
   signal ALU_zero : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal ImmExt : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal RF_WrEn : std_logic;
   signal MEM_WrEn : std_logic;
   signal PC_LdEn : std_logic;
   signal ByteOp : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal PC_sel : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Opcode => Opcode,
          Func => Func,
          ImmExt => ImmExt,
          ALU_zero => ALU_zero,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          RF_WrEn => RF_WrEn,
          MEM_WrEn => MEM_WrEn,
          PC_LdEn => PC_LdEn,
          ByteOp => ByteOp,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          PC_sel => PC_sel,
          Rst => Rst
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		Rst <= '1';
		wait for 100 ns;
		Rst <= '0';
		
		Opcode <= "100000"; -- R TYPE
		Func	 <= "110000"; -- ADD
		wait for 100 ns;
		
		Func	 <= "110001"; -- SUB
		wait for 100 ns;
		
		Func	 <= "110001"; -- AND
		wait for 100 ns;
		
		Opcode <= "111000"; -- li
		wait for 100 ns;
		
		Opcode <= "111001"; -- lui
		wait for 100 ns;
		
		Opcode <= "110000"; -- addi
		wait for 100 ns;
		
		Opcode <= "110010"; -- nandi
		wait for 100 ns;
		
		Opcode <= "110011"; -- ori
		wait for 100 ns;
		
		Opcode <= "111111"; -- b
		wait for 100 ns;
		
		Opcode <= "000000"; -- beq
		wait for 100 ns;
		
		Opcode <= "000001"; -- bne
		wait for 100 ns;
		
		Opcode <= "000011"; -- lb
		wait for 100 ns;
		
		Opcode <= "000111"; -- sb
		wait for 100 ns;
		
		Opcode <= "001111"; -- lw
		wait for 100 ns;
		
		Opcode <= "011111"; -- sw
		wait for 100 ns;
		
      wait;
   end process;

END;

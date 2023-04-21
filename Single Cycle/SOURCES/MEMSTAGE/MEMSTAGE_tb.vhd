--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:27:45 04/03/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/MEMSTAGE_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGE_tb IS
END MEMSTAGE_tb;
 
ARCHITECTURE behavior OF MEMSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		ByteOp		<= '1'; -- Load/Store Byte
		MEM_WrEn		<= '0';
		ALU_MEM_Addr<= x"0000_0000"; -- ALU gives address
		MEM_DataIn  <= x"abcd_00ff"; -- Data in
		MM_RdData   <= x"0000_ffbd"; -- Load byte
      wait for 100 ns;	
		
		MEM_WrEn		<= '1';
		MEM_DataIn  <= x"abcd_00bd"; -- Data in
		MM_RdData   <= x"0000_ffff"; -- Load byte
		wait for 100 ns;
		
		ByteOp		<= '0'; -- Load/Store Word
		MEM_WrEn		<= '0';
		ALU_MEM_Addr<= x"0000_0000"; -- ALU gives address
		MEM_DataIn  <= x"abcd_00ff"; -- Data in
		MM_RdData   <= x"0000_ffbd"; -- Load Word
      wait for 100 ns;	
		
		MEM_WrEn		<= '1';
		MEM_DataIn  <= x"abcd_00bd"; -- Data in
		MM_RdData   <= x"0000_ffff"; -- Load Word
		wait for 100 ns;
		

      wait;
   end process;

END;

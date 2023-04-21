--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:14:38 05/17/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/PROCESSOR_MC_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROCESSOR_MC
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
 
ENTITY PROCESSOR_MC_tb IS
END PROCESSOR_MC_tb;
 
ARCHITECTURE behavior OF PROCESSOR_MC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROCESSOR_MC
    PORT(
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_RdData : IN  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT RAM
		PORT ( clk 			: IN  STD_LOGIC;
				 inst_addr 	: IN  STD_LOGIC_VECTOR (10 downto 0);
				 inst_dout 	: OUT  STD_LOGIC_VECTOR (31 downto 0);
				 data_we 	: IN  STD_LOGIC;
				 data_addr 	: IN  STD_LOGIC_VECTOR (10 downto 0);
				 data_din 	: IN  STD_LOGIC_VECTOR (31 downto 0);
				 data_dout 	: OUT  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
    

   --Inputs
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
	signal Instr_sig 		: std_logic_vector(31 downto 0);
   signal MM_RdData_sig : std_logic_vector(31 downto 0);
	signal MM_WrEn_sig 	: std_logic;
   signal MM_Addr_sig 	: std_logic_vector(31 downto 0);
   signal MM_WrData_sig : std_logic_vector(31 downto 0);
   signal PC_sig 			: std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROCESSOR_MC PORT MAP (
          Rst => Rst,
          Clk => Clk,
          Instr => Instr_sig,
          MM_WrEn => MM_WrEn_sig,
          MM_RdData => MM_RdData_sig,
          MM_Addr => MM_Addr_sig,
          MM_WrData => MM_WrData_sig,
          PC => PC_sig
        );
		  
	RAM_1: RAM PORT MAP (
				 clk 			=> Clk,
				 inst_addr 	=> PC_sig(12 downto 2),
				 inst_dout 	=> Instr_sig,
				 data_we 	=> MM_WrEn_sig,
				 data_addr 	=> MM_Addr_sig(12 downto 2),
				 data_din 	=> MM_WrData_sig,
				 data_dout 	=> MM_RdData_sig
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		Rst <= '1';
		wait for Clk_period*5;
		Rst <= '0';
		wait for Clk_period*20;


      wait;
   end process;

END;

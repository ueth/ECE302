--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:37:22 04/02/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/IFSTAGE_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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
 
ENTITY IFSTAGE_tb IS
END IFSTAGE_tb;
 
ARCHITECTURE behavior OF IFSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Rst => Rst,
          Clk => Clk,
          PC => PC
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
      wait for Clk_period + 20 ns;
		Rst <= '0';
		
		-- Write Enable 0
		PC_LdEn 	<= '0';
		PC_Sel	<= '0';
		PC_Immed	<= x"0000_0000";
		wait for Clk_period;
		
		-- Write Enable 1
		PC_LdEn 	<= '1';
		PC_Sel	<= '0';
		PC_Immed	<= x"0000_0000";
		wait for Clk_period;
		
		-- Write Enable 1
		PC_Sel	<= '0';
		PC_Immed	<= x"0000_0000";
		wait for Clk_period*3;
		
		-- Passing PC_Immed
		PC_Sel	<= '1';
		PC_Immed	<= x"0000_0fff";
		wait for Clk_period;
		
		PC_Sel	<= '0';
		
      wait;
   end process;

END;

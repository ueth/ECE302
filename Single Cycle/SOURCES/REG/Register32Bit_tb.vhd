--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:30:00 03/11/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/Register32Bit_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Register32Bit
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
 
ENTITY Register32Bit_tb IS
END Register32Bit_tb;
 
ARCHITECTURE behavior OF Register32Bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register32Bit
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         WriteEnable : IN  std_logic;
         DataIn : IN  std_logic_vector(31 downto 0);
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal WriteEnable : std_logic := '0';
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register32Bit PORT MAP (
          Clk => Clk,
          Rst => Rst,
          WriteEnable => WriteEnable,
          DataIn => DataIn,
          DataOut => DataOut
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
	
		wait for 100 ns;
	
		--WriteEnable 0 to have no dataout
		Rst<='0';
		WriteEnable<='0';	
		DataIn <=x"ab11_ab11";
		wait for clk_period;

		--WriteEnable changed to 1 to have dataout
		WriteEnable<='1';	
		DataIn <=x"ab11_ab11";
		wait for clk_period;
		
		--WriteEnable 1 with different datain
		WriteEnable<='1';	
		DataIn <=x"8111_aaaa";
		wait for clk_period;
		
		--WriteEnable 0 with different datain
		WriteEnable<='0';	
		DataIn <=x"0000_ffff";
		wait for clk_period;
		
		--Reset 1 to reset dataout to 0
		Rst<='1';
		wait for clk_period;
		
		Rst<='0';
		WriteEnable<='1';
		DataIn <=x"aaaa_aaaa";
		wait for clk_period;
		
		Rst<='1';
		WriteEnable<='0';
		DataIn <=x"0101_0101";
		wait for clk_period;

      wait;
   end process;

END;

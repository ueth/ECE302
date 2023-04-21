--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:26:41 03/29/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/DECSTAGE_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_tb IS
END DECSTAGE_tb;
 
ARCHITECTURE behavior OF DECSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Rst : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Rst : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Rst => Rst,
          ImmExt => ImmExt,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
      -- hold reset state for 100 ns.
      -- Waiting 40ns to set inputs at the negative edge
		
		Rst <= '1';
      wait for Clk_period + 20 ns;
		Rst <= '0';
		
		-- Instr(25 downto 21) RegisterOut1
		-- RF_B_sel 0 -> Instr(15-11) RegisterOut2 // 1 -> Instr(20-16) RegisterOut2
		-- Write to register -> Instr(20-16)
		
		-- Write Enable -> 0, 
      Instr				<=x"0000_0000";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"0000_0001"; -- Write data
		RF_B_sel 		<= '1'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '0'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '0';
		wait for Clk_period;
		
		-- Write Enable -> 1
		--	Writting data to Register File [Register #2]
		-- Reading data from Register File [Register #2]
		-- Getting output from RF_A
		-- Getting input from ALU
      Instr				<=x"f042_0198";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"f000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '0'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Write Enable -> 1
		--	Writting data to Register File [Register #2]
		-- Reading data from Register File [Register #2]
		-- Getting output from RF_A
		-- Getting input from MEM
      Instr				<=x"f042_0198";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"f000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '1'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Write Enable -> 1
		--	Writting data to Register File [Register #2]
		-- Reading data from Register File [Register #2]
		-- Getting output from RF_A and RF_B (15-11)
		-- Getting input from ALU
      Instr				<=x"f042_1098";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"f000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '0'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Write Enable -> 1
		--	Writting data to Register File [Register #2]
		-- Reading data from Register File [Register #2]
		-- Getting output from RF_A and RF_B (15-11)
		-- Getting input from MEM
      Instr				<=x"f042_1098";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"f000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '1'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Sign extension ones
      Instr				<=x"f041_f098";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"f000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '1'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Sign extension zeros
      Instr				<=x"f042_1098";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"f000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "00"; -- Sign extension
		RF_WrData_sel 	<= '1'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Shift 16 bits
		Instr				<=x"fe22_2298";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"0000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "01"; -- Shift 16 bits
		RF_WrData_sel 	<= '0'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Fill 31 to 16 bits with zeros
		Instr				<=x"ffff_ffff";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"0000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "10"; -- Fill 31 to 16 bits with zeros
		RF_WrData_sel 	<= '0'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;
		
		-- Shift immed << 2
		Instr				<=x"ffff_ffff";
		ALU_out 			<=x"0000_0002"; -- Write data
      MEM_out 			<=x"0000_0001"; -- Write data
		RF_B_sel 		<= '0'; -- 0 -> Instr(15-11), 1 -> Instr(20-16)
		ImmExt 			<= "11"; -- Shift immed << 2
		RF_WrData_sel 	<= '0'; -- 0 -> ALU, 1 -> MEM
		RF_WrEn 			<= '1';
		wait for Clk_period;

      wait;
   end process;

END;

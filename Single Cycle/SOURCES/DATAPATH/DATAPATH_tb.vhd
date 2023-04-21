--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:10:11 04/06/2022
-- Design Name:   
-- Module Name:   D:/HMMY/Organosi/Project_1/DATAPATH_tb.vhd
-- Project Name:  Project_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_tb IS
END DATAPATH_tb;
 
ARCHITECTURE behavior OF DATAPATH_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_zero : OUT  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Rst : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0);
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         MM_WrEn : OUT  std_logic;
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	COMPONENT RAM
	PORT ( 
			clk : in  STD_LOGIC;
         inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
         inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
         data_we : in  STD_LOGIC;
         data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
         data_din : in  STD_LOGIC_VECTOR (31 downto 0);
         data_dout : out  STD_LOGIC_VECTOR (31 downto 0)
			);
	END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Rst : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALU_zero : std_logic;
   signal PC : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
	signal data_out : std_logic_vector(31 downto 0) := (others => '0');
	signal Instr_sig : std_logic_vector(31 downto 0);
   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          Clk => Clk,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Rst => Rst,
          PC => PC,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );
	
	RAM_1: RAM PORT MAP(
				clk 			=> Clk,
				inst_addr 	=> PC(12 downto 2),
				inst_dout 	=> Instr_sig,
				data_we 		=> MM_WrEn,
				data_addr 	=> MM_Addr(12 downto 2),
				data_din 	=> MM_WrData,
				data_dout 	=> MM_RdData
			);
	Instr <= Instr_sig; -- Delay the instruction to be aligned with other delays
				

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
      wait for Clk_period*10;
		RST <= '0';
		
		RF_WrEn 			<= '1'; -- DECSTAGE RegisterFile ENABLED
		PC_LdEn 			<= '1'; -- IFSTAGE REGISTER ENABLED
		
		-- 00: addi r5, r0, 8 
		PC_sel  			<= '0'; -- Select First ADDER (PC+4)
		ALU_Bin_sel 	<= '1'; -- EXSTAGE Select Immed (I type)
		ALU_Func 		<="0000"; -- ADD
		MEM_WrEn 		<= '0'; -- Do not store value in RAM
		ByteOp			<= '0'; -- We don't care about load/store
		Rf_WrData_sel	<= '0'; -- Read ALU_out to store the addition to the r5
		wait for Clk_period;
		
		-- 04: ori r3,r0,ABCD
		ALU_Bin_sel 	<= '1'; -- EXSTAGE Select Immed (I type)
		ALU_Func 		<="0011"; -- OR
		Rf_WrData_sel	<= '0'; -- Read ALU_out to store the ORI to the r3
		MEM_WrEn 		<= '0'; -- Do not store value in RAM
		ImmExt			<= "10"; -- Fill 31-16 with zeros
		wait for Clk_period;
		
		-- 08: sw r3,4(r0)
		RF_WrEn 			<= '0';
		MEM_WrEn 		<= '1'; -- Write to memory
		Rf_WrData_sel	<= '0'; -- Read ALU_out
		RF_B_sel 		<= '1'; -- Select rd [20-16] Data that's in r3 -> RF_B -> MEM_DataIn
		ALU_Func 		<="0000"; -- ADD (r0 and Immed)
		ALU_Bin_sel 	<= '1'; -- EXSTAGE Select Immed (I type)
		wait for Clk_period;
		
		-- 0C: lw r10,-4(r5)
		-- r5  - rs [25-21]
		-- r10 - rd [20-16]
		RF_B_sel 		<= '0';
		RF_WrEn 			<= '1'; -- DECSTAGE RegisterFile WRITE ENABLED
		MEM_WrEn 		<= '0'; -- Do not Write to memory (LOAD)
		Rf_WrData_sel	<= '1'; -- Read MEM_out
		ALU_Func 		<="0000"; -- ADD (r5 and Immed)
		ALU_Bin_sel 	<= '1'; -- EXSTAGE Select Immed (I type)
		ImmExt			<= "00"; -- Sign Extend
		wait for Clk_period;
		
		-- 10: lb r16, 4(r0)
		RF_WrEn 			<= '1'; -- DECSTAGE RegisterFile WRITE ENABLED
		RF_WrData_sel 	<= '1'; -- Read MEM_out
		ALU_Func 		<="0000"; -- ADD (r0 and Immed)
		ALU_Bin_sel 	<= '1'; -- EXSTAGE Select Immed (I type)
		ByteOP 			<= '1'; -- Load Byte
		wait for Clk_period;
		
		-- 14: nand r4, r10, r16
		RF_B_sel 		<= '0'; -- rt (For second register)
		RF_WrData_sel 	<= '0'; -- Read ALU_out
		RF_WrEn 			<= '1'; -- DECSTAGE RegisterFile WRITE ENABLED
		ALU_Func 		<="0101"; -- NOT (A AND B)
		ALU_Bin_sel 	<= '0'; -- EXSTAGE Select B (R type)
		MEM_WrEn 		<= '0'; -- Do not store data in MEM
		wait for Clk_period;	
		
      wait;
   end process;

END;

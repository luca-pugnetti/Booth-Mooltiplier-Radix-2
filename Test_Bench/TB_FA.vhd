
library ieee;
use ieee.std_logic_1164.all;

 
ENTITY TB_FA IS
END TB_FA;
 
ARCHITECTURE behavior OF TB_FA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FA
    PORT(
         X 		: IN  std_logic;
         Y 		: IN  std_logic;
         CIN 	: IN  std_logic;
         S 		: OUT  std_logic;
         COUT 	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X 	: 		std_logic := '0';
   signal Y 	: 		std_logic := '0';
   signal CIN 	: 	std_logic := '0';
	

 	--Outputs
   signal S 	: std_logic;
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FA PORT MAP (
          X 	=> X,
          Y 	=> Y,
          CIN 	=> CIN,
          S 	=> S,
          COUT => COUT
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		X 		<= '0';
		Y 		<= '0';
		CIN	<= '0';
		wait for 20 ns;
		
		X 		<= '1';
		Y 		<= '0';
		CIN	<= '0';
		wait for 20 ns;
		
		X 		<= '1';
		Y 		<= '1';
		CIN	<= '0';
		wait for 20 ns;
		
		X 		<= '1';
		Y 		<= '1';
		CIN	<= '1';
		wait for 20 ns;
		
		X 		<= '1';
		Y 		<= '0';
		CIN	<= '1';
		wait for 20 ns;

      wait;
   end process;

END;
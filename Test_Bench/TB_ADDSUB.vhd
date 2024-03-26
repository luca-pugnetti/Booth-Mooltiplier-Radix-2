
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_ADDSUB IS
END TB_ADDSUB;
 
ARCHITECTURE behavior OF TB_ADDSUB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADDSUB
    PORT(
         OP			: in	std_logic;
			X			: in	std_logic_vector(31 downto 0);
			Y			: in	std_logic_vector(31 downto 0);
			RESULT	: out std_logic_vector(31 downto 0);
			COUT		: out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal OP : std_logic := '0';
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal Y : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal RESULT : std_logic_vector(31 downto 0);
   signal COUT : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADDSUB PORT MAP (
          OP => OP,
          X => X,
			 Y => Y,
          RESULT => RESULT,
          COUT => COUT
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		OP		<= '0';
		X 		<= "00000000000000000000000000000000";
		Y		<= "00000000000000000000000000000000";
      wait for 100 ns;
		
		OP		<= '0';	
		X 		<= "00000000111110000000000000000000";
		Y		<= "00000000000000000000111100000000";
      wait for 100 ns;	
		
		OP		<= '1';
		X 		<= "00000000000000000000000110000000";
		Y		<= "00100111000001100000000000000000";	

      wait for 100 ns;
		
		OP		<= '1';
		X 		<= "11100100010001000110010001001001";
		Y		<= "11100100011111010110010001001001";	
		
		wait;
		
		
   end process;

END;

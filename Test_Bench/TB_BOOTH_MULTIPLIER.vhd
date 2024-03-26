
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_BOOTH_MULTIPLIER IS
END TB_BOOTH_MULTIPLIER;
 
ARCHITECTURE behavior OF TB_BOOTH_MULTIPLIER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BOOTH_MULTIPLIER
    PORT(
         
         MULTIPLICAND : IN  std_logic_vector(15 downto 0);
         MULTIPLIER : IN  std_logic_vector(15 downto 0);
         PRODUCT : OUT  std_logic_vector(31 downto 0)
			
        );
    END COMPONENT;
    

   --Inputs
   signal MULTIPLICAND : std_logic_vector(15 downto 0);
   signal MULTIPLIER : std_logic_vector(15 downto 0);

 	--Outputs
   signal PRODUCT : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BOOTH_MULTIPLIER PORT MAP (
          MULTIPLICAND => MULTIPLICAND,
          MULTIPLIER => MULTIPLIER,
          PRODUCT => PRODUCT
        );

 

   -- Stimulus process
   process
   begin	

		
		MULTIPLICAND <= "0111111100011111";
		MULTIPLIER 	 <= "1000000001000100";
		wait for 75 ns;
		
		MULTIPLICAND <= "0000000000001111";
		MULTIPLIER 	 <= "0000000011000000";
		wait for 75 ns;
		
		MULTIPLICAND <= "0000000000000000";
		MULTIPLIER 	 <= "0000000011100000";
		wait for 75 ns;
		
		MULTIPLICAND <= "1111111111111111";
		MULTIPLIER 	 <= "1111111111111111";
		wait for 75 ns;
		
		MULTIPLICAND <= "1000000000000000";
		MULTIPLIER 	 <= "0111111111111111";
		wait;
		
   end process;
	

END;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_BOOTH_ADD IS
END TB_BOOTH_ADD;
 
ARCHITECTURE behavior OF TB_BOOTH_ADD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BOOTH_ADD
    PORT(
         BA_MULTIPLIER : IN  std_logic_vector(16 downto 0);
         BA_MULTIPLICAND : IN  std_logic_vector(31 downto 0);
         BA_PARTIAL_PRODUCT : IN  std_logic_vector(31 downto 0);
         BA_MULTIPLIER_NEXT : OUT  std_logic_vector(16 downto 0);
         BA_MULTIPLICAND_NEXT : OUT  std_logic_vector(31 downto 0);
         BA_PARTIAL_PRODUCT_NEXT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal BA_MULTIPLIER : std_logic_vector(16 downto 0) := (others => '0');
   signal BA_MULTIPLICAND : std_logic_vector(31 downto 0) := (others => '0');
   signal BA_PARTIAL_PRODUCT : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal BA_MULTIPLIER_NEXT : std_logic_vector(16 downto 0);
   signal BA_MULTIPLICAND_NEXT : std_logic_vector(31 downto 0);
   signal BA_PARTIAL_PRODUCT_NEXT  : std_logic_vector(31 downto 0);
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BOOTH_ADD PORT MAP (
          BA_MULTIPLIER => BA_MULTIPLIER,
          BA_MULTIPLICAND => BA_MULTIPLICAND,
          BA_PARTIAL_PRODUCT => BA_PARTIAL_PRODUCT,
          BA_MULTIPLIER_NEXT => BA_MULTIPLIER_NEXT,
          BA_MULTIPLICAND_NEXT => BA_MULTIPLICAND_NEXT,
			 BA_PARTIAL_PRODUCT_NEXT  => BA_PARTIAL_PRODUCT_NEXT 
			 
        );

 

   -- Stimulus process
   stim_proc: process
   begin	

		BA_MULTIPLIER 					<= "00000000000000011";	-- two lastbits 11, do nothing
		BA_MULTIPLICAND				<= "11100100010001000110010001001001"; -- -465.279.927
		BA_PARTIAL_PRODUCT			<= "11100100011111010110010001001001"; -- -461.544.375
		-- BA_PARTIAL_PRODUCT_NEXT = -461.544.375
		wait for 70ns;
		
		BA_MULTIPLIER 					<= "00000000000000001";	-- two lastbits 01, do sum
		BA_MULTIPLICAND				<= "11100100010001000110010001001001"; -- -465.279.927
		BA_PARTIAL_PRODUCT			<= "11100100011111010110010001001001"; -- -461.544.375
		-- BA_PARTIAL_PRODUCT_NEXT = -926.824.302
		wait for 70ns;
      
		BA_MULTIPLIER 					<= "00000000000000010";	-- two lastbits 10, do sub
		BA_MULTIPLICAND				<= "11100100010001000110010001001001"; -- -465.279.927
		BA_PARTIAL_PRODUCT			<= "11100100011111010110010001001001"; -- -461.544.375
		-- BA_PARTIAL_PRODUCT_NEXT = 3.735.552
		wait for 70 ns;
		
		BA_MULTIPLIER 					<= "00000000000000010";	-- two lastbits 10, do sub
		BA_MULTIPLICAND				<= "11111111111111111111111111111111"; -- -1
		BA_PARTIAL_PRODUCT			<= "00000000000000000000000000000001"; -- +1
		-- BA_PARTIAL_PRODUCT_NEXT = 2
		wait;
		
   end process;

END;

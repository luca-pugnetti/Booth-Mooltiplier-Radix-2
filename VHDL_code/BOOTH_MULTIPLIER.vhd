library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BOOTH_MULTIPLIER is
  port (
    MULTIPLICAND : in  std_logic_vector(15 downto 0);
    MULTIPLIER   : in  std_logic_vector(15 downto 0);
    PRODUCT      : out std_logic_vector(31 downto 0)
  );
end BOOTH_MULTIPLIER;


architecture RTL of BOOTH_MULTIPLIER is

	-- BOOTH ADD
	
	component BOOTH_ADD is
	
		port(
		
			BA_MULTIPLIER				: in 	std_logic_vector(16 downto 0);
			BA_MULTIPLICAND			: in 	std_logic_vector(31 downto 0);
			BA_PARTIAL_PRODUCT		: in 	std_logic_vector(31 downto 0);
			BA_MULTIPLIER_NEXT		: out std_logic_vector(16 downto 0);
			BA_MULTIPLICAND_NEXT		: out std_logic_vector(31 downto 0);
			BA_PARTIAL_PRODUCT_NEXT	: out	std_logic_vector(31 downto 0)
		
		);

	end component;
	
	-- MUX 2 TO 1
	
	component MUX_2TO1 is
	
		 generic(
		 
			N: integer :=16
			
		 );
		 
		 port ( 
		 
					SEL : in  STD_LOGIC;
					A   : in  STD_LOGIC_VECTOR (N-1 downto 0);
					B   : in  STD_LOGIC_VECTOR (N-1 downto 0);
					O   : out STD_LOGIC_VECTOR (N-1 downto 0)
				);
				
					
	end component;

 -- signals
  
	signal MUX_OUT														: std_logic_vector(15 downto 0);
	type   FIXED_MULTIPLICAND_ARRAY is array(0 to 16)   of  std_logic_vector(31 downto 0);
	signal FIXED_MULTIPLICAND										: FIXED_MULTIPLICAND_ARRAY;				
	type   FIXED_MUTLTIPLIER_ARRAY is array(0 to 16)  	 of  std_logic_vector(16 downto 0);
	signal FIXED_MULTIPLIER											: FIXED_MUTLTIPLIER_ARRAY;
	type   PARTIAL_PRODUCT_ARRAY is array(0 to 16) 	    of  std_logic_vector(31 downto 0);
	signal PARTIAL_PRODUCT 											: PARTIAL_PRODUCT_ARRAY;
	
begin


	 MUX_2TO1_INST: MUX_2TO1 port map(
		
			SEL => MULTIPLICAND(15),
			A	 => "0000000000000000",
			B	 => "1111111111111111",
			O	 => MUX_OUT
	 
	 );
	 
	 FIXED_MULTIPLICAND(0) <= MUX_OUT & MULTIPLICAND;
												  
	 FIXED_MULTIPLIER(0)	<= MULTIPLIER & '0';
	 
	 PARTIAL_PRODUCT(0)	<= (others => '0');


    GEN: for I in 0 to 15 generate
	 
	
			BOOTH_ADD_INST: BOOTH_ADD port map(
	 
				BA_MULTIPLIER				=> FIXED_MULTIPLIER(I),
				BA_MULTIPLICAND			=> FIXED_MULTIPLICAND(I),
				BA_PARTIAL_PRODUCT		=> PARTIAL_PRODUCT(I),
				BA_MULTIPLIER_NEXT		=> FIXED_MULTIPLIER(I+1),
				BA_MULTIPLICAND_NEXT		=> FIXED_MULTIPLICAND(I+1),
				BA_PARTIAL_PRODUCT_NEXT => PARTIAL_PRODUCT(I+1)			
	 
			);

		
    end generate;
	 
	 PRODUCT <= PARTIAL_PRODUCT(16);
 
	 
end RTL;

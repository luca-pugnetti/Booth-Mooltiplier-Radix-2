
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BOOTH_ADD is
	
	port(
	
		BA_MULTIPLIER				: in 	std_logic_vector(16 downto 0);
		BA_MULTIPLICAND			: in 	std_logic_vector(31 downto 0);
		BA_PARTIAL_PRODUCT		: in 	std_logic_vector(31 downto 0);
		BA_MULTIPLIER_NEXT		: out std_logic_vector(16 downto 0);
		BA_MULTIPLICAND_NEXT		: out std_logic_vector(31 downto 0);
		BA_PARTIAL_PRODUCT_NEXT : out	std_logic_vector(31 downto 0)
	
	);

end BOOTH_ADD;

architecture RTL of BOOTH_ADD is

	-- ADDSUB

	component ADDSUB is
		generic(
			N: integer :=32
		);

		port(
			OP			: in	std_logic;
			X			: in	std_logic_vector(N-1 downto 0);
			Y			: in	std_logic_vector(N-1 downto 0);
			RESULT	: out std_logic_vector(N-1 downto 0);
			COUT		: out std_logic
		);
	end component;	
	
	
  -- LEFT SHIFTER

   component LSHIFT is
     generic (
       N: integer := 32
     );
     port (
       X: in  std_logic_vector(N-1 downto 0);
       Y: out std_logic_vector(N-1 downto 0)
     );
   end component;

  -- RIGHT SHIFTER

   component RSHIFT is
     generic (
       N: integer := 17
     );
     port (
       X: in  std_logic_vector(N-1 downto 0);
       Y: out std_logic_vector(N-1 downto 0)
     );
   end component;
	
	-- MUX 2 TO 1
	
	component MUX_2TO1 is
	
		 generic(
		 
			N: integer :=32
			
		 );
		 
		 port ( 
		 
					SEL : in  STD_LOGIC;
					A   : in  STD_LOGIC_VECTOR (N-1 downto 0);
					B   : in  STD_LOGIC_VECTOR (N-1 downto 0);
					O   : out STD_LOGIC_VECTOR (N-1 downto 0)
				);
				
					
	end component;
	
	-- signals
	
	signal FIRST_SUPPORT_PRODUCT:		std_logic_vector(31 downto 0);
	signal MUX_SEL:						std_logic;
	
begin

	
															  
	ADDSUB_INST : ADDSUB port map(
		
			OP			=> BA_MULTIPLIER(1),
			X			=> BA_PARTIAL_PRODUCT,
			Y			=> BA_MULTIPLICAND,
			RESULT	=> FIRST_SUPPORT_PRODUCT
			
		);
		
	MUX_SEL <= BA_MULTIPLIER(1) xor BA_MULTIPLIER(0);
		
	MUX_2TO1_INST : MUX_2TO1 port map(
	
			SEL => MUX_SEL,
			A	 => BA_PARTIAL_PRODUCT,
			B	 => FIRST_SUPPORT_PRODUCT,
			O	 => BA_PARTIAL_PRODUCT_NEXT
		
	   );	
		
		
	LEFT_SHIFTER_INST: LSHIFT port map(
	
			X => BA_MULTIPLICAND,
			Y => BA_MULTIPLICAND_NEXT
		
		);
		
	RIGHT_SHIFTER_INST: RSHIFT port map(
	
			X => BA_MULTIPLIER,
			Y => BA_MULTIPLIER_NEXT
		
		);
		
							  
end RTL;

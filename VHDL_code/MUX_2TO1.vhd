
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2TO1 is
	 generic(
	 
		N: integer :=16
		
	 );
	 
    Port ( 
	 
				SEL : in  STD_LOGIC;
				A   : in  STD_LOGIC_VECTOR (N-1 downto 0);
				B   : in  STD_LOGIC_VECTOR (N-1 downto 0);
				O   : out STD_LOGIC_VECTOR (N-1 downto 0));
				
end MUX_2TO1;

architecture Behavioral of MUX_2TO1 is
begin
    O <= A when (SEL = '0') else B;
end Behavioral;

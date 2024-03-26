
library ieee;
use ieee.std_logic_1164.ALL;


entity RSHIFT is

	generic(
		N: integer :=16
	);
	
	port(	X:	in		std_logic_vector(N-1 downto 0);
			Y:	out	std_logic_vector(N-1 downto 0)
		 );
end RSHIFT;

architecture STRUCT of RSHIFT is

begin
	  Y <= '0' & X(N-1 downto 1);

end STRUCT;

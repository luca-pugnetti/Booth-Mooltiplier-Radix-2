
library ieee;
use ieee.std_logic_1164.ALL;


entity LSHIFT is

	generic(
		N: integer :=16
	);

	port(	X:	in		std_logic_vector(N-1 downto 0);
			Y:	out	std_logic_vector(N-1 downto 0)
		 );
end LSHIFT;

architecture STRUCT of LSHIFT is

begin
	  Y <= X(N-2 downto 0) & '0';

end STRUCT;

library IEEE;
-- Please add necessary libraries:


entity timebase is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;

		count_out	: out	std_logic_vector (?? downto 0)  -- Please enter upper bound
	);
end entity timebase;
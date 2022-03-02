library IEEE;
-- Please add necessary libraries:

entity motorcontrol is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in	std_logic_vector (?? downto 0);  -- Please enter upper bound

		pwm		: out	std_logic
	);
end entity motorcontrol;

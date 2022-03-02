library IEEE;
use ieee.std_logic_1164.all
use ieee.numeric_std.all

entity motorcontrol is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in	std_logic_vector (20 downto 0);  -- Please enter upper bound

		pwm		: out	std_logic
	);
end entity motorcontrol;

architecture behavioral of motorcontrol is
	
	type
	signal state, new_state: std_logic_vector (2 downto 0);

	begin
	process(state, direction)
	begin
		case state is
			when "00" => 
				pwm <= '0';
			when '01' =>
				pwm <= '1' after 0 ms,
				pwm <= '0' after 1 ms;
			when '10'=>
				pwm <= '1' after 1 ms,
				pwm <= '0' after 2 ms;
			
			
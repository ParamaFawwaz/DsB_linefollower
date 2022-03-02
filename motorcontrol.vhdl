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
	
	type motor_state is (reset_state, clockwise_state, anticlockwise_state);

	signal state, new_state: motor_state;

	begin
	process(state, direction)
	begin
		case state is
			when  reset_state=> 
				pwm <= '0';
			when  clockwise_state=>
				pwm <= '1' after 0 ms,
				pwm <= '0' after 1 ms;
			when  anticlockwise_state=>
				pwm <= '1' after 1 ms,
				pwm <= '0' after 2 ms;
		end case;
	end process;
end architecture behavioral;
			
			
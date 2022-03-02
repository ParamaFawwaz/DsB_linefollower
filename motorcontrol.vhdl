library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motorcontrol is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in	std_logic_vector (20 downto 0);

		pwm		: out	std_logic
	);
end entity motorcontrol;

architecture behavioral of motorcontrol is
	
	type motor_state is (reset_state, clockwise_state, anticlockwise_state);

	signal state, new_state: motor_state;
	begin

		-- need to make process that changes state (see manual)
		-- on it! -Parama :)

	process(state, direction, reset)
	begin
		case state is
			when  reset_state=>
			pwm <= '0';
				if  (reset = '1') then 
					new_state <= reset_state;
				elsif (direction = '1' and reset = '0') then
					new_state <= clockwise_state;
				else
					new_state <= clockwise_state;
				end if;

				
			when  clockwise_state=>
				pwm <= '1' after 0 ms,
				pwm <= '0' after 1 ms;
				
				if  (reset = '1') then 
					new_state <= reset_state;
				elsif (direction = '1' and reset = '0') then
					new_state <= clockwise_state;
				else 
					new_state <= clockwise_state;
				end if;

			when  anticlockwise_state=>
				pwm <= '1' after 1 ms,
				pwm <= '0' after 2 ms;

				if  (reset = '1') then 
					new_state <= reset_state;
				elsif (direction = '1' and reset = '0') then
					new_state <= clockwise_state;
				else 
					new_state <= clockwise_state;
				end if;
		end case;
	end process;
end architecture behavioral;
			
			
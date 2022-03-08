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
		procedure state_manipulation(
			signal reset : in;
			signal set_state_to : in)
		begin
			if (reset = '1') then
				new_state <= reset_state;
			else
				new_state <= set_state_to;
			end if;
		end procedure;
	begin
		case state is
			when  reset_state=>
			pwm <= '0';
				state_manipulation(reset, clockwise_state);
				
			when  clockwise_state=>
				pwm <= '1' after 0 ms,
				pwm <= '0' after 1 ms;
				
				state_mainupulation(reset, clockwise_state);

			when  anticlockwise_state=>
				pwm <= '1' after 1 ms,
				pwm <= '0' after 2 ms;

				state_manipulation(reset, anticlockwise_state);
		end case;
	end process;
end architecture behavioral;
			
			
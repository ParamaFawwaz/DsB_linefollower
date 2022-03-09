library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motorcontrol is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in	std_logic_vector (19 downto 0);

		pwm		: out	std_logic
	);
end entity motorcontrol;

architecture behavioral of motorcontrol is
	type motor_state is (low, high, Reset_state);

	signal state, new_state: motor_state;
	begin

	process(clk)
		begin
			if (rising_edge (clk)) then
				if (reset = '1') then
					state <= Reset_state;	
				else
					state <= new_state;
				end if;
			end if;
		end process;
	
	process (state, direction)
	begin
		case state is
			when Reset_state =>
			new_state <= high;

			when  low =>
				pwm <= '0';


		
			when  high =>
				pwm <= '1';

			if (to_integer(unsigned(count_in)) = 50000 and direction = '0') then
				new_state <= low;
			elsif (to_integer(unsigned(count_in)) = 100000) then
				new_state <= low;
			else 
				new_state <= state;
			end if;

		end case;
	end process;
end architecture behavioral;
			
			
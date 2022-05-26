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
	
	process (state, direction, clk, count_in)
	begin
		case state is
			when Reset_state =>
			pwm <= '0';

				if(to_integer(unsigned(count_in)) > 999999) then
					new_state <= low;
				else
					new_state <= reset_state;
				end if;
				
			when  low =>
				pwm <= '0';
		

					if(reset = '0') then
						new_state <= high;
					else
						new_state <= reset_state;
					end if;

			when  high =>
				pwm <= '1';

				
				if (direction = '0') then
					if (to_integer(unsigned(count_in)) < 50000) then
						new_state <= high;
					else
						new_state <= reset_state;
					end if;
				else 
					if (to_integer(unsigned(count_in)) < 100000) then
						new_state <= high;
					else
						new_state <= reset_state;
					end if;
				end if;
		

				

		end case;
	end process;
end architecture behavioral;
			
			
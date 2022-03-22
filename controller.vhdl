library IEEE;
-- Please add necessary libraries:
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity controller is
	port (	clk			: in	std_logic;
		reset			: in	std_logic;

		sensor_l		: in	std_logic;
		sensor_m		: in	std_logic;
		sensor_r		: in	std_logic;

		count_in		: in	std_logic_vector (19 downto 0); 
		count_reset		: out	std_logic; --send to the timebase 

		motor_l_reset		: out	std_logic;
		motor_l_direction	: out	std_logic;

		motor_r_reset		: out	std_logic;
		motor_r_direction	: out	std_logic
	);
end entity controller;

-- here we assumed sensor = 1 -> white, and sensor 0 -> black

architecture behavioral of controller is

    type controller_state is (reset_state, gentle_left, sharp_left, gentle_right, sharp_right, forward);

    signal state, new_state : controller_state;

    begin
		process(clk, count_in) -- forces reset state when reset = '1'

		begin

			if (to_integer(unsigned(count_in)) < 1000000) then 
					count_reset <= '0';
			else 
					count_reset <= '1'; 
			end if;

			if (to_integer(unsigned(count_in)) = 0 and rising_edge(clk)) then 
	
				if (reset = '1') then
					state <= reset_state;
					-- count_reset <= '1'; -- potentially a solution to a future problem.
				else
					state <= new_state;
				end if;
	
			end if;
		end process;
	
	
	
		process(sensor_l, sensor_m, sensor_r, clk, state) -- changes state according to input signals
	
			-- case statement for determining state
			begin

			case state is

				when reset_state =>
					--motor left is stationary
					motor_l_reset <= '1';
					motor_l_direction <= '0';   	--I assume that this doesnt matter, as long as we fill something in to make it synthesizable (might be handy to check later)
												-- from now I will denote such values as dummy

					
					--motor right is stationary
					motor_r_reset <= '1';
					motor_r_direction <= '1'; --dummy

					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						new_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						new_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						new_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						new_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						new_state <= sharp_right;
					else 
						new_state <= forward;	
					end if;
	
				when gentle_left =>
	
					--motor left is stationary
					motor_l_reset <= '1';
					motor_r_direction <= '0';   --dummy

					
					--motor right is going forward
					motor_r_reset <= '0';
					motor_r_direction <= '1';

			
				
					
					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						new_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						new_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						new_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						new_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						new_state <= sharp_right;
					else 
						new_state <= forward;	
					end if;
		



				when sharp_left =>
		
					--motor left is going backwards
					motor_l_reset <= '0';
					motor_l_direction <= '0';

			
			
					--motor right is going forwards
					motor_r_reset <= '0';
					motor_r_direction <= '1';

					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						new_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						new_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						new_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						new_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						new_state <= sharp_right;
					else 
						new_state <= forward;	
					end if;
				
	
				when gentle_right =>

					--motor left is going forwards
					motor_l_reset <= '0';
					motor_l_direction <= '1';

			
					--motor right is stationary
					motor_r_reset <= '1';
					motor_r_direction <= '0'; --dummy

					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						new_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						new_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						new_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						new_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						new_state <= sharp_right;
					else 
						new_state <= forward;	
					end if;

				when sharp_right =>

					--motor left is going forwards
					motor_l_reset <= '0';
					motor_l_direction <= '1';


					--motor right is going backwards

					motor_r_reset <= '0';
					motor_r_direction <= '0';


					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						new_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						new_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						new_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						new_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						new_state <= sharp_right;
					else 
						new_state <= forward;	
					end if;



				when forward =>

					-- motor left is forwards

					motor_l_reset <= '0';
					motor_l_direction <= '1';
					
					-- motor right is forwards
					
					motor_r_reset <= '0';
					motor_r_direction <= '1';

					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						new_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						new_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						new_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						new_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						new_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						new_state <= sharp_right;
					else 
						new_state <= forward;	
					end if;

			end case;
		end process;
	
	   
	
	end architecture behavioral;

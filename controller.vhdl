library IEEE;
-- Please add necessary libraries:


entity controller is
	port (	clk			: in	std_logic;
		reset			: in	std_logic;

		sensor_l		: in	std_logic;
		sensor_m		: in	std_logic;
		sensor_r		: in	std_logic;

		count_in		: in	std_logic_vector (19 downto 0);  -- Please enter upper bound
		count_reset		: out	std_logic;

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
		process(count_in) -- forces reset state when reset = '1'

		begin
	
			if (integer(unsigned(count_in)) = 0) then -- this might be wrong
	
				if (reset = '1') then
	
					state <= reset_state;  
	
				elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '0')
	
					state <= forward;
				
				elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1')

				state <= gentle_left;

				elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0')

				state <= forward;

				elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1')

				state <= sharp_left;

				elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0')

				state <= gentle_right;

				elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1')
	
				state <= forward;

				elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0')
	
				state <= sharp_right;

				elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '1')
	
				state <= forward;
					
				end if;
	
			end if;
	
			
	
			if (to_integer(unsigned(count_in)) < 100000) then --reset timebase
					count_reset = '1';
			else 
					count_reset = '0'; --to make it synthesizable
			end if;

	
		end process;
	
	
	
		process(sensor_l, sensor_m, sensor_r) -- changes state according to input signals
	
			-- case statement for determining state
	
			case state is
	
				when gentle_left =>
	
				--motor left is stationary
				motor_l_reset = '1';
				
				--motor right is going forward
				motor_r_reset = '0';
				motor_r_direction = '1';
				
	
				when sharp_left =>
	
				--motor left is going backwards
				motor_l_reset = '0';
				motor_l_direction = '0';

	
				--motor right is going forwards
				motor_r_reset = '0';
				motor_r_direction = '1';
				
	
				when gentle_right =>

				--motor left is going forwards
				motor_l_reset = '0';
				motor_l_direction = '1';


				--motor right is stationary
				motor_r_reset = '1';

				when sharp_right =>

				--motor left is going forwards
				motor_l_reset = '0';
				motor_l_direction = '1';


				--motor right is going backwards

				motor_r_reset = '0';
				motor_r_direction = '0';



				when forwards =>

				-- motor left is forwards

				motor_l_reset = '0';
				motor_l_direction = '1';

				
				-- motor right is forwards
				
				motor_r_reset = '0';
				motor_r_direction = '1';


			end case;
		end process;
	
	   
	
	end architecture behavioral;

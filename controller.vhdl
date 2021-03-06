library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	port (	clk			: in	std_logic;
		reset			: in	std_logic;

		sensor_l		: in	std_logic; -- here we assumed sensor = 1 -> white, and sensor 0 -> black
		sensor_m		: in	std_logic;
		sensor_r		: in	std_logic;

		count_in		: in	std_logic_vector (19 downto 0);  -- counts every 20 ns
		count_reset		: out	std_logic; --send to the timebase every 20ms, ie when count_in = 10^6

		motor_l_reset		: out	std_logic;
		motor_l_direction	: out	std_logic;

		motor_r_reset		: out	std_logic;
		motor_r_direction	: out	std_logic
	);
end entity controller;

architecture behavioral of controller is
    type controller_state is (reset_state, gentle_left, sharp_left, gentle_right, sharp_right, forward);
    signal state, next_state : controller_state;

    begin
		

		process(clk)
			begin
			if(clk'event and clk = '1') then 
				if(reset = '1') then
					state <= reset_state;
				else
					state <= next_state;
				end if;
			end if ;
		end process;
		
			
		process(state, count_in, sensor_l, sensor_m, sensor_r)
			begin
			case state is
				when reset_state =>
					--motor left is stationary
					motor_l_reset <= '1';
					motor_l_direction <= '1';  -- for synthesizing. Henceforth denoted as 'dummy'
					
					--motor
					motor_r_reset <= '1';
					motor_r_direction <= '1'; --dummy

					count_reset <= '1'; -- reset timebase

					if (sensor_l = '0' and sensor_m = '0' and sensor_r = '0') then
						next_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '0' and sensor_r = '1') then
						next_state <= gentle_left;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '0') then
						next_state <= forward;
					elsif (sensor_l = '0' and sensor_m = '1' and sensor_r = '1') then
						next_state <= sharp_left;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '0') then
						next_state <= gentle_right;
					elsif (sensor_l = '1' and sensor_m = '0' and sensor_r = '1') then
						next_state <= forward;
					elsif (sensor_l = '1' and sensor_m = '1' and sensor_r = '0') then
						next_state <= sharp_right;
					else 
						next_state <= forward;	
					end if;

					
				when gentle_left =>
					--motor left is stationary
					motor_l_reset <= '1';
					motor_l_direction <= '0';   --dummy
					--motor right is going forward
					motor_r_reset <= '0';
					motor_r_direction <= '0';

					count_reset <= '0';

					if(to_integer(unsigned(count_in)) > 999999) then
						next_state <= reset_state;
					else
						next_state <= gentle_left;
					end if;

				when sharp_left =>
					--motor left is going backwards
					motor_l_reset <= '0';
					motor_l_direction <= '0';
					--motor right is going forwards
					motor_r_reset <= '0';
					motor_r_direction <= '0';

					count_reset <= '0';

					if(to_integer(unsigned(count_in)) > 999999) then
						next_state <= reset_state;
					else
						next_state <= sharp_left;
					end if;

				when gentle_right =>
					--motor left is going forwards
					motor_l_reset <= '0';
					motor_l_direction <= '1';
					--motor right is stationary
					motor_r_reset <= '1';
					motor_r_direction <= '0'; --dummy

					count_reset <= '0';

					if(to_integer(unsigned(count_in)) > 999999) then
						next_state <= reset_state;
					else
						next_state <= gentle_right;
					end if;

				when sharp_right =>
					--motor left is going forwards
					motor_l_reset <= '0';
					motor_l_direction <= '1';
					--motor right is going backwards
					motor_r_reset <= '0';
					motor_r_direction <= '1';

					count_reset <= '0';

					if(to_integer(unsigned(count_in)) > 999999) then
						next_state <= reset_state;
					else
						next_state <= sharp_right;
					end if;

				when forward =>
					-- motor left is forwards
					motor_l_reset <= '0';
					motor_l_direction <= '1';
					-- motor right is forwards
					motor_r_reset <= '0';
					motor_r_direction <= '0';


					count_reset <= '0';
					
					if(to_integer(unsigned(count_in)) > 999999) then
						next_state <= reset_state;
					else
						next_state <= forward;
					end if;

			end case;
		end process;
	end architecture behavioral;

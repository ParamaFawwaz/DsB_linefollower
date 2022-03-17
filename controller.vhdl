library IEEE;
use std_logic_1164.all;


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

architecture behavioral of controller is
	type controller_state is (reset_state, gentle_left, hard_left, gentle_right, hard_right, forward);
	signal state, new_state : controller_state;
	
	begin
	

	process(count_in) -- forces reset state when reset = '1'
	begin
		if (integer(unsigned(count_in)) = 0) then -- this might be wrong
			if (reset = '1') then
				state <= reset_state;	
			else
				state <= new_state;
			end if;
		end if;

		--if (count_in = 20ms) then reset timebase; 
	end process;

	process(sensor_l, sensor_m, sensor_r) -- changes state according to input signals
		-- case statement for determining state
		case state is
			when gentle_left =>
			--motor left is stationary
			--motor right is going forward
			when hard_left =>
			--motor left is going backwards
			--motor right is going forwards
			when gentle_left =>
	
end architecture behavioral;

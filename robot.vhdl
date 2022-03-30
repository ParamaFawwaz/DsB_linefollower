library ieee;
use ieee.std_logic_1164.all;

entity robot is
	port (  clk             : in    std_logic;
		reset           : in    std_logic;

		sensor_l_in     : in    std_logic;
		sensor_m_in     : in    std_logic;
		sensor_r_in     : in    std_logic;

		motor_l_pwm     : out   std_logic;
		motor_r_pwm     : out   std_logic
		);
end entity robot;

architecture structural of robot is

	component inputbuffer is
		port (	clk		: in	std_logic;

		sensor_l_in	: in	std_logic;
		sensor_m_in	: in	std_logic;
		sensor_r_in	: in	std_logic;

		sensor_l_out	: out	std_logic;
		sensor_m_out	: out	std_logic;
		sensor_r_out	: out	std_logic
		);
	end component inputbuffer;

	component controller is
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
	end component controller;

	component timebase is 
		port (	clk		: in	std_logic; -- every 20ns
		reset		: in	std_logic; -- reset every 20 ms

		count_out	: out	std_logic_vector (19 downto 0)  -- 20ms/20ns = 10^6 < 2^20
		);
	end component timebase;

	component motorcontrol is
		port (	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in	std_logic_vector (19 downto 0);

		pwm		: out	std_logic
		);
	end component motorcontrol;

	-- a note on reading signal names. i2c means input_buffer to controller. mL is motor left
	signal i2c_sensor_l, i2c_sensor_m, i2c_sensor_r : std_logic;
	
	signal c2mL_reset, c2mL_direction : std_logic;
	signal c2mR_reset, c2mR_direction : std_logic;
	signal c2t_reset : std_logic;

	signal timebase_count : std_logic_vector(19 downto 0);

	begin
		lbl_inbuf: inputbuffer port map (clk 		=> clk, 
								sensor_l_in => sensor_l_in, 
								sensor_m_in => sensor_m_in, 
								sensor_r_in => sensor_r_in,
								sensor_l_out =>	i2c_sensor_l,
								sensor_m_out =>	i2c_sensor_m,
								sensor_r_out => i2c_sensor_r);
								
		
		lbl_controller: controller port map(clk				=> clk,
								reset			    => reset,
								sensor_l 			=> i2c_sensor_l,
								sensor_m			=> i2c_sensor_m,
								sensor_r			=> i2c_sensor_r,
								count_in 			=> timebase_count,
								count_reset 		=> c2t_reset,
								motor_l_reset 		=> c2mL_reset,
								motor_l_direction 	=> c2mL_direction,
								motor_r_reset 		=> c2mR_reset,
								motor_r_direction	=> c2mR_direction);
		
		lbl_timebase: timebase port map( clk 		=> clk,
								reset		=> c2t_reset,
								count_out 	=> timebase_count);
							

		lbl_motorcontrol_L: motorcontrol port map( clk			=> clk,
							reset		=> c2mL_reset,
							direction 	=> c2mL_direction,
							count_in 	=> timebase_count,
							pwm 		=> motor_l_pwm);
		
		lbl_motorcontrol_R: motorcontrol port map( clk			=> clk,
							reset		=> c2mR_reset,
							direction 	=> c2mR_direction,
							count_in 	=> timebase_count,
							pwm 		=> motor_r_pwm);

	end architecture structural;
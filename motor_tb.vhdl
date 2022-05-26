library IEEE;
use IEEE.std_logic_1164.all;

entity motor_tb is
end entity motor_tb;

architecture structural of motor_tb is

	component timebase is
		port (	clk			: in	std_logic;
			reset			: in	std_logic;

			count_out		: out	std_logic_vector (20 downto 0)
		);
	end component timebase;

	component motorcontrol is
		port (	clk			: in	std_logic;
			reset			: in	std_logic;
			direction		: in	std_logic;
			count_in		: in	std_logic_vector (20 downto 0);

			pwm			: out	std_logic
		);
	end component motorcontrol;

	signal	clk, reset, direction		: std_logic;
	signal	count				: std_logic_vector (20 downto 0);
	signal	pwm				: std_logic;

begin

	lbl0: timebase port map	(	clk			=> clk,
					reset			=> reset,
					count_out		=> count
				);
					
	lbl1: motorcontrol port map (	clk			=> clk,
					reset			=> reset,
					direction		=> direction,
					count_in		=> count,
					pwm			=> pwm
				);

	-- 20 ns = 50 MHz
	clk			<=	'0' after 0 ns,
					'1' after 10 ns when clk /= '1' else '0' after 10 ns;

	reset <= '1' after 0 ms, 
			'0' after 1 ms;
			

	direction 		<=	'0' after 0 ns,   
					'1' after 30 ms;

end architecture structural;

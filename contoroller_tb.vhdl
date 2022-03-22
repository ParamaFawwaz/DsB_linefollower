library IEEE;
use IEEE.std_logic_1164.all;

entity controller_tb is
end entity controller_tb;

architecture structural of controller_tb is

	component controller is
        port (	clk			: in	std_logic;
            reset			: in	std_logic;
    
            sensor_l		: in	std_logic;
            sensor_m		: in	std_logic;
            sensor_r		: in	std_logic;
    
            count_in		: in	std_logic_vector (19 downto 0); 
            count_reset		: out	std_logic;
    
            motor_l_reset		: out	std_logic;
            motor_l_direction	: out	std_logic;
    
            motor_r_reset		: out	std_logic;
            motor_r_direction	: out	std_logic
        );
    end component controller;

    signal clk			: in	std_logic;
    signal reset		: in	std_logic;

    signal sensor_l		: in	std_logic;
    signal sensor_m		: in	std_logic;
    signal sensor_r		: in	std_logic;

    signal count_in		: in	std_logic_vector (19 downto 0); 
    signal count_reset	: out	std_logic;

    signal motor_l_reset		: out	std_logic;
    signal motor_l_direction	: out	std_logic;

    signal motor_r_reset		: out	std_logic;
    signal motor_r_direction	: out	std_logic

begin

	lbl1: controller port map (	clk			=> clk,
					reset			=> reset,
					s		=> direction,
					count_in		=> count,
					pwm			=> pwm
				);




                
	-- 20 ns = 50 MHz
	clk			<=	'0' after 0 ns,
					'1' after 10 ns when clk /= '1' else '0' after 10 ns;

	reset			<=	'1' after 0 ns,
					'0' after 20 ns,
					'1' after 20000000 ns,
					'0' after 20000020 ns,
					'1' after 40000000 ns,
					'0' after 40000020 ns;

	direction 		<=	'0' after 0 ns,   
					'1' after 20000000 ns;

end architecture structural;

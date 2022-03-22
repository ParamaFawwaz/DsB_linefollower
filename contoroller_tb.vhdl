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

    component timebase is
        port (	clk		: in	std_logic; -- every 20ns
            reset		: in	std_logic; -- reset every 20 ms
    
            count_out	: out	std_logic_vector (19 downto 0)  -- 20ms/20ns = 10^6 < 2^20
        );
    end component timebase;

    signal timebase_count_out    : std_logic_vector(19 downto 0);

    signal clk			: std_logic;
    signal controller_reset		: std_logic;

    signal sig_sensor_l		: std_logic;
    signal sig_sensor_m		: std_logic;
    signal sig_sensor_r		: std_logic;

    signal controller_count_reset	: std_logic;

    signal motor_l_reset		: std_logic;
    signal motor_l_direction	: std_logic;

    signal motor_r_reset		: std_logic;
    signal motor_r_direction	: std_logic;

begin

	lbl1: controller port map (	clk			=> clk, --
                                reset       => controller_reset, --

                                sensor_l    => sig_sensor_l, --
                                sensor_m    => sig_sensor_m, --
                                sensor_r    => sig_sensor_r, --

                                count_in    => timebase_count_out,
                                count_reset => controller_count_reset,

                                motor_l_reset   => motor_l_reset,
                                motor_l_direction => motor_l_direction,
                                motor_r_reset   => motor_r_reset,
                                motor_r_direction   => motor_r_direction);

    lbl2: timebase port map (clk       => clk,
                             reset     => controller_count_reset,
                             count_out  => timebase_count_out );
            
	-- 20 ns = 50 MHz
	clk			<=	'0' after 0 ns,
					'1' after 10 ns when clk /= '1' else '0' after 10 ns;

	controller_reset		<=	'1' after 0 ns,
					'0' after 20 ns,
					'1' after 20000000 ns,
					'0' after 20000020 ns,
					'1' after 40000000 ns,
					'0' after 40000020 ns;

    sig_sensor_r <=     '0' after 0 ns,
                    '1' after 15 ns,
                    '0' after 35 ns,
                    '1' after 55 ns,
                    '0' after 75 ns,
                    '1' after 95 ns,
                    '0' after 115 ns,
                    '1' after 135 ns;

    sig_sensor_m <=     '0' after 0 ns,
                    '1' after 35 ns,
                    '0' after 75 ns,
                    '1' after 115 ns,
                    '0' after 155 ns;
    
    sig_sensor_l <=     '0' after 0 ns,
                    '1' after 75 ns,
                    '0' after 155 ns;
    
    
    

end architecture structural;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

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

    signal clk			: std_logic;
    signal reset		: std_logic;

    signal sig_sensor_l		: std_logic;
    signal sig_sensor_m		: std_logic;
    signal sig_sensor_r		: std_logic;

    signal count_in : std_logic_vector(19 downto 0);
    signal count_reset : std_logic;

    signal motor_l_reset		: std_logic;
    signal motor_l_direction	: std_logic;

    signal motor_r_reset		: std_logic;
    signal motor_r_direction	: std_logic;

    signal current_count: natural:= 1; 
    signal next_count: natural;

begin

	lbl1: controller port map (	clk			=> clk, --
                                reset       => reset, --

                                sensor_l    => sig_sensor_l, --
                                sensor_m    => sig_sensor_m, --
                                sensor_r    => sig_sensor_r, --

                                count_in    => count_in,
                                count_reset => count_reset,

                                motor_l_reset   => motor_l_reset,
                                motor_l_direction => motor_l_direction,
                                motor_r_reset   => motor_r_reset,
                                motor_r_direction   => motor_r_direction);
            
	-- 20 ns = 50 MHz
	clk			<=	'0' after 0 ns,
					'1' after 10 ns when clk /= '1' else '0' after 10 ns;

    process(clk) -- hopefully this simulates the timebase
        begin
        if(clk'event and clk = '1') then
            count_in <= to_std_logic_vector(current_count, 20);
            if (current_count < 1000000) then 
                next_count <= current_count + 1;
            else
                next_count <= 0;
            end if;
        end if;
    end process;
    current_count <= next_count;

	reset <=	'1' after 0 ns,
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
    
    sig_sensor_l <= '0' after 0 ns,
                    '1' after 75 ns,
                    '0' after 155 ns;

end architecture structural;

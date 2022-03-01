library IEEE;
use ieee.std_logic_1164.all;


entity timebase is
	port (	clk		: in	std_logic; -- every 20ns
		reset		: in	std_logic; -- reset every 20 ms

		count_out	: out	std_logic_vector (1000000 downto 0)  -- 20ms/20ns = 10^6
	);
end entity timebase;
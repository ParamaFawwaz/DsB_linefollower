-- credits: Jesse & Abhay © 2021

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity timebase is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;

		count_out	: out	std_logic_vector (20 downto 0)  -- Please enter upper bound
	);
end entity timebase;

architecture timebase_arch of timebase is
	signal count: std_logic_vector(20 downto 0) := "000000000000000000000";
	signal new_count: std_logic_vector(20 downto 0) := "000000000000000000000";
	signal check: std_logic := '0';
begin
process (clk) is
begin
	if (reset = '0' and clk'event and clk = '1') then
	count <= new_count;
	elsif (reset = '1' and clk'event and clk = '1') then
	count <= "000000000000000000000";
	end if;
end process;

Apeshitmode: process(check, reset, count) is
begin
	if (reset = '0' and check = '0') then
	new_count <= count + 1;
	elsif (reset = '0' and check = '1') then
	new_count <= "000000000000000000001";
	elsif (reset = '1') then
	new_count <= "000000000000000000001";
	else
	new_count <= "000000000000000000001";
	end if;

end process;

Checker: process(count) is
begin
	if (count = "011110100001001000000") then
	check <= '1';
	else
	check <= '0';
	end if;
end process;

count_out <= count;

end timebase_arch;

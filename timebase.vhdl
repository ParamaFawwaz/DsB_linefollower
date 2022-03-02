library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timebase is
	port (	clk		: in	std_logic; -- every 20ns
		reset		: in	std_logic; -- reset every 20 ms

		count_out	: out	std_logic_vector (1000000 downto 0)  -- 20ms/20ns = 10^6
	);
end entity timebase;

architecture behavioural of timebase is
	signal count : unsigned(1000000 downto 0);
	signal next_count : unsigned(1000000 downto 0);
begin
	process (clk) -- register
	begin
		if(clk'event and clk = '1') then
			if(reset = '1') then
				count <= '0';
			else
				count <= next_count;
			end if;
		end if;
	end process;

	process(count)
	begin 
		next_count = count + '1';
	end process;
count_out <= std_logic_vector(count);

end architecture behavioural; 
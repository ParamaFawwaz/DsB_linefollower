library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity knightrider is
	port (	clk	: in	std_logic;
		reset	: in	std_logic;
		leds	: out	std_logic_vector (7 downto 0)
	);
end entity knightrider;

architecture behavioural of knightrider is

	-- count, new_count and compare are 25-bit numbers
	signal count, new_count		: unsigned (24 downto 0);
	signal compare			: unsigned (24 downto 0);

	-- leds_out and new_leds_out are std-logic vectors 
	signal leds_out, new_leds_out	: std_logic_vector (13 downto 0);

begin
	-- compare is used to wait 0.1 seconds. The clock frequency is 50 MHz,
	-- so to wait 0.1 seconds, compare must receive the value 5000000.
	compare		<= to_unsigned (5000000, 25);

	leds (0)	<= leds_out(0);
	leds (1)	<= leds_out(1) or leds_out(13);
	leds (2)	<= leds_out(2) or leds_out(12);
	leds (3)	<= leds_out(3) or leds_out(11);
	leds (4)	<= leds_out(4) or leds_out(10);
	leds (5)	<= leds_out(5) or leds_out(9);
	leds (6)	<= leds_out(6) or leds_out(8);
	leds (7)	<= leds_out(7);

	process (clk)
	begin
		if (rising_edge (clk)) then
			if (reset = '1') then
				count 		<= (others => '0');
				leds_out	<= "00000000000001";
			else
				count 		<= new_count;
				leds_out	<= new_leds_out;
			end if;
		end if;
	end process;

	process (count, leds_out)
	begin
		if (count >= compare) then
			new_count	<= (others => '0');
			-- "rol" stands for rotate left.
			new_leds_out	<= std_logic_vector (unsigned (leds_out) rol 1);
		else
			new_count	<= count + 1;
			new_leds_out	<= leds_out;
		end if;
	end process;
end architecture behavioural;

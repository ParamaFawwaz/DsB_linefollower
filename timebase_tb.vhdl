library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture structural of testbench is
    component timebase is
        port(   clk     : in std_logic;
                reset   : in std_logic;
                count_out: out std_logic_vector (20 downto 0)
            );
    end component timebase;

    signal clk      : std_logic;
    signal reset    : std_logic;
    signal count_out: std_logic_vector (20  downto 0);

begin 
        clk     <=  '1' after 0 ns, 
                    '0' after 20 ns when clk /= '0' else '1' after 20 ns;
        reset   <=  '1' after 0 ns, 
                    '0' after 10 ns,
                    '1' after 20 ns, --to test if reset will not affect it 
                    '0' after 30 ns,
                    '1' after 800000 ns; -- to test if reset works after at a later point in time

lbl:    timebase port map (     clk => clk,
                                reset => reset,
                                count_out => count_out
);       
end architecture structural;

        
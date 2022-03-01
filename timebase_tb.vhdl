library ieee;
use ieee.std_logic_1164.all

entity testbench is
end entity testbench;

architecture structural of testbench is
    component timebase is
        port(   clk     : in std_logic;
                reset   : in std_logic;
                count_out: out std_logic);
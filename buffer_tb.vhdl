library ieee;
use ieee.std_logic_1164.all;

entity buffer_tb is
end entity buffer_tb;

architecture structural of buffer_tb is
    component buffer is
        port(clk : in std_logic;
        sensor_L_in : in std_logic;
        sensor_M_in : in std_logic;
        sensor_R_in : in std_logic;

        sensor_L_out : out std_logic;
        sensor_M_out : out std_logic;
        sensor_R_out : out std_logic
        );
    end component buffer;

    signal sensor_L, sensor_M, sensor_R : std_logic;
    signal clk : std_logic;

begin
    PM: buffer port map is (clk => clk,
                            sensor_L_in => sensor_L,
                            sensor_M_in => sensor_M,
                            sensor_R_in	=> sensor_R);
    
    -- one clock cycle is 20 ns
    clk	    <=	'0' after 0 ns, 
                '1' after 10 ns when clk /= '1' else '0' after 10 ns;

    sensor_L <= '0' after 0 ns,
                '1' after 15 ns,
                '0' after 21 ns,
                '1' after 24 ns,
                '0' after 25 ns,
                '1' after 35 ns;
    sensor_M <= '0' after 0 ns;
    sensor_R <= '0' after 0 ns;

end architecture structural;


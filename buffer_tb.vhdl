library ieee;
use ieee.std_logic_1164.all;

entity buffer_tb is
end entity buffer_tb;

architecture structural of buffer_tb is
    
    component inputbuffer is
        port(clk : in std_logic;
        sensor_l_in : in std_logic;
        sensor_m_in : in std_logic;
        sensor_r_in : in std_logic;

        sensor_l_out : out std_logic;
        sensor_m_out : out std_logic;
        sensor_r_out : out std_logic
        );
    end component inputbuffer;

    signal sensor_l, sensor_m, sensor_r : std_logic;
    signal clk : std_logic;

begin
    PM: inputbuffer port map (clk => clk,
                            sensor_l_in => sensor_l,
                            sensor_m_in => sensor_m,
                            sensor_r_in	=> sensor_r);
    
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


library ieee;
use ieee.std_logic_1164.all;

entity buffer is
    port(clk : in std_logic;
        sensor_L_in : in std_logic;
        sensor_M_in : in std_logic;
        sensor_R_in : in std_logic;

        sensor_L_out : out std_logic;
        sensor_M_out : out std_logic;
        sensor_R_out : out std_logic
        );
end entity buffer;

architecture behavioral of buffer is
    signal sL, sM, sR : std_logic := '0';
    signal next_sL, next_sM, next_sR : std_logic := '0';
    begin
        process(clk)
            if(clk'event and clk = '1') then
                sensor_L_out <= next_sL;
                sensor_M_out <= next_sM;
                sensor_R_out <= next_sR;
                sL <= sensor_L_in;
                sM <= sensor_M_in;
                sR <= sensor_R_in;
            else 
                next_sL = sL;
                next_sM = sM;
                next_sR = sR;
            end if;
        end process;
    end architecture behavioral;
        
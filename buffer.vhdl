library IEEE;
use IEEE.std_logic_1164.all;

--flipflops

entity d_flip_flop is
    port (clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
    );
end entity d_flip_flop;

architecture behavioural of d_flip_flop is
begin 

    process (clk)
    begin
        if (rising_edge(clk)) then
            Q <= D;
        end if;
    end process;

end architecture behavioural;


--register

library IEEE;
use IEEE.std_logic_1164.all;


entity three_bit_register is
    port (clk : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            A3 : in std_logic;
            B1 : out std_logic;
            B2 : out std_logic;
            B3 : out std_logic
    );
end entity three_bit_register;

architecture structural of three_bit_register is

    component d_flip_flop is
        port (clk : in std_logic;
                D : in std_logic;
                Q : out std_logic
        );
    end component d_flip_flop;
    
begin
lbl1:    d_flip_flop port map (clk => clk, D => A1, Q => B1);
lbl2:    d_flip_flop port map (clk => clk, D => A2, Q => B2);
lbl3:    d_flip_flop port map (clk => clk, D => A3, Q => B3);
end architecture structural;


--entity system

library IEEE;
use IEEE.std_logic_1164.all;


entity inputbuffer is
	port (	clk		: in	std_logic;

		sensor_l_in	: in	std_logic;
		sensor_m_in	: in	std_logic;
		sensor_r_in	: in	std_logic;

		sensor_l_out	: out	std_logic;
		sensor_m_out	: out	std_logic;
		sensor_r_out	: out	std_logic
	);
end entity inputbuffer;



-- architecture system

architecture structural of inputbuffer is

    component three_bit_register is
        port (clk : in std_logic;
                A1 : in std_logic;
                A2 : in std_logic;
                A3 : in std_logic;
                B1 : out std_logic;
                B2 : out std_logic;
                B3 : out std_logic
        );
    end component three_bit_register;

    signal C1, C2, C3, C_clk : std_logic;

    begin
        lbl4: three_bit_register port map (clk => C_clk, A1 => sensor_l_in, A2=> sensor_m_in, A3 =>sensor_r_in,
                                            B1 => C1, B2=> C2, B3 => C3);
        lbl5: three_bit_register port map (clk => C_clk, A1 => C1, A2 => C2, A3=>C3, 
                                            B1=>sensor_l_out, B2 => sensor_m_out, B3 => sensor_r_out);

        
end architecture structural;



        
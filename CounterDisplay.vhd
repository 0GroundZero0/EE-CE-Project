library ieee;
use ieee.std_logic_1164.all;

entity CounterDisplay is
    port(
    clock, reset, X : IN STD_LOGIC;
    A, B, C, D, E, F, G, R : OUT STD_LOGIC
    );
end CounterDisplay;



architecture arch of CounterDisplay is

component Counter
    port (
        clock, reset, X	:	IN STD_LOGIC;
		U, V, W, R		:	OUT STD_LOGIC
    );
end component;

component DisplayDriver
    port (
        X, Y, Z : IN STD_LOGIC;
        A, B, C, D, E, F, G : OUT STD_LOGIC
    );
end component;

signal U, V, W : STD_LOGIC; 
begin
 u1: DisplayDriver port map (U, V, W, A, B, C, D, E, F, G);
 u2: Counter port map(clock, reset, X, U, V, W, R);

end arch;
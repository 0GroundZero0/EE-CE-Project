library ieee;
use ieee.std_logic_1164.all;

entity FinalProject is
	port(
		clock, reset, X1, X2, fan : IN STD_LOGIC;
		A, B : OUT STD_LOGIC_VECTOR (6 downto 0);
		C : OUT STD_LOGIC
	);
end FinalProject;

architecture arch of FinalProject is

component CounterDisplay
		port(
    clock, reset, X : IN STD_LOGIC;
    A, B, C, D, E, F, G, R : OUT STD_LOGIC
    );
end component;

signal NX1, NX2, R1, R2, Rin : STD_LOGIC;

begin

NX1 <= not X1;
NX2 <= not X2;

C <= fan;

u1: CounterDisplay port map (clock, Rin, NX1, A(6), A(5), A(4), A(3), A(2), A(1), A(0), R1);
u2: CounterDisplay port map (clock, Rin, NX2, B(6), B(5), B(4), B(3), B(2), B(1), B(0), R2);

Rin <= not reset or r1 or r2;

end arch;
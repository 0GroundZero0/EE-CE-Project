library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FinalProject is
	port(
		clock, reset, X1, X2, fan : IN STD_LOGIC;
		A, B, D, E: OUT STD_LOGIC_VECTOR (6 downto 0);
		C, fz, fo : OUT STD_LOGIC
	);
end FinalProject;

architecture arch of FinalProject is

component CounterDisplay
		port(
    clock, reset, X : IN STD_LOGIC;
    A, B, C, D, E, F, G, R : OUT STD_LOGIC
    );
end component;

signal NX1, NX2, R1, R2, Rin, f, h, R : STD_LOGIC;
type state_type is (S0,S1,S2,S3,S4,S5);
signal pr_state, nx_state : state_type;

begin

NX1 <= not X1;
NX2 <= not X2;

C <= fan;

u1: CounterDisplay port map (clock, Rin, NX1, A(6), A(5), A(4), A(3), A(2), A(1), A(0), R1);
u2: CounterDisplay port map (clock, Rin, NX2, B(6), B(5), B(4), B(3), B(2), B(1), B(0), R2);

--R <= '1' when (Asub1 = '1') and (Asub2 = '0') else
--	  '1' when (Bsub1 = '1') and (Bsub2 = '0');
R <= '1' when R1 = '1' or R2 = '1' else
	  '0' when reset = '0' else
	  '0' when clock = '1';
f <= '1' when R1 = '1' else
	  '0' when reset = '0' else
	  '0';
h <= '1' when R2 = '1' else
	  '0' when reset = '0' else
	  '0';

process (reset, clock, R, h, f)
begin
		IF (reset = '0') THEN
			pr_state <= S0;
		ELSIF (R'event and R = '1') THEN
			IF (h= '1' or f= '1') THEN
				pr_state <= nx_state;
			END IF;
		END IF; 
end process;

--f <= '0' when (Asub1 = '1') and (Asub2 = '0') else 
--	  '1' when (Bsub1 = '1') and (Bsub2 = '0');

	  
fo <= h;
fz <= f;
process (pr_state, h, f, reset)
begin
	case pr_state is
		when S0 =>
			IF f='1' THEN
				nx_state <= S1;
			ELSIF h='1' THEN
				nx_state <= S2;
			ELSE
				nx_state <= pr_state;
			END IF;
		when S1 =>
			IF f='1' THEN
				nx_state <= S4;
			ELSIF h='1' THEN
				nx_state <= S3;
			ELSE
				nx_state <= pr_state;
			END IF;
		when S2 =>
			IF f='1' THEN
				nx_state <= S3;
			ELSIF h='1' THEN
				nx_state <= S5;
			ELSE
				nx_state <= pr_state;
			END IF;
		when S3 =>
			IF f='1' THEN
				nx_state <= S4;
			ELSIF h='1' THEN
				nx_state <= S5;
			ELSE
				nx_state <= pr_state;
			END IF;
		when S4 =>
			IF reset='0' THEN
				nx_state <= S0;
			ELSE
				nx_state <= pr_state;
			END IF;
		when S5 =>
			IF reset='0'  THEN
				nx_state <= S0;
			ELSE
				nx_state <= pr_state;
			END IF;
		when others =>
			nx_state <= S1;
	end case;
end process;

D <=  "0000001" when pr_state = S0 else
		"1001111" when pr_state = S1 else
		"0000001" when pr_state = S2 else
		"1001111" when pr_state = S3 else
		"0011000" when pr_state = S4 else
		"0011000" when pr_state = S5;
		
E <=  "0000001" when pr_state = S0 else
		"0000001" when pr_state = S1 else
		"1001111" when pr_state = S2 else
		"1001111" when pr_state = S3 else
		"1001111" when pr_state = S4 else
		"0010010" when pr_state = S5;
Rin <= not reset or R1 or R2;

end arch;
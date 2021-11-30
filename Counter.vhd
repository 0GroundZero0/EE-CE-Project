
LIBRARY ieee;
USE ieee.std_logic_1164.all;			-- For IEEE data types
USE ieee.std_logic_unsigned.all;		-- For + and - operations

-- Entity Declaration

ENTITY Counter IS
	PORT (
		clock, reset, X	:	IN STD_LOGIC;
		U, V, W, R						:	OUT STD_LOGIC
	);
END Counter;



--  Architecture Section

ARCHITECTURE arch OF Counter IS

-- Build an enumerated type for the state machine
-- The states declared here come directly from the state diagram
TYPE state_type IS (A, aa, B, bb, C, cc, D, dd, E, ee, F, ff, G, gg, H, hh);

-- Create a register to hold teh present and next states
SIGNAL pr_state, nx_state	: state_type;

SIGNAL filtered_x : std_logic;

-- Begin the architecture section...
BEGIN



----------------------- PRESENT STATE SECTION (REGISTER) --------------------------------------------
--
--  The function of this section is to assign the next state to the present state at the active clock edge.
--  An asynchronous reset signal should be included to initialize the system to the default first state of the system. 
--  This section is implemented with sequential (behavioral) VHDL code with a PROCESS.
--
	PROCESS (reset,clock)
	BEGIN
		IF (reset = '1') THEN
			pr_state <= A;
		ELSIF (clock'event and clock = '1') THEN 
			pr_state <= nx_state;
		END IF;
	END PROCESS;



	PROCESS (reset, clock)
	VARIABLE cycle_count : INTEGER RANGE 0 to 2047;
	BEGIN
	
		--Active High Reset
		IF (reset = '1') THEN
			cycle_count := 0;
			filtered_x <= '0';
		ELSIF (clock'EVENT AND clock = '1') THEN
			IF (x='1') THEN
				cycle_count := cycle_count + 1;
				IF (cycle_count > 2046) THEN
					filtered_x <= '1';
					cycle_count := cycle_count - 1;
				END IF;
			ELSE
				cycle_count := 0;
				filtered_x <= '0';
			END IF;
		END IF;
	
	END PROCESS;


	--Moore Machine: 1 in State D only

	
	U <= '0' WHEN (pr_state = A) ELSE
							
							'0' WHEN (pr_state = aa) ELSE
							'0' WHEN (pr_state = B) ELSE
							'0' WHEN (pr_state = bb) ELSE
							'0' WHEN (pr_state = C) ELSE
							'0' WHEN (pr_state = cc) ELSE
							'0' WHEN (pr_state = D) ELSE
							'0' WHEN (pr_state = dd) ELSE
							'1' WHEN (pr_state = E) ELSE
							'1' WHEN (pr_state = ee) ELSE
							'1' WHEN (pr_state = F) ELSE
							'1' WHEN (pr_state = ff) ELSE
							'1' WHEN (pr_state = G) ELSE
							'1' WHEN (pr_state = gg) ELSE
							'1' WHEN (pr_state = H) ELSE
							'1' WHEN (pr_state = hh) ELSE'1';
	V <= '0' WHEN (pr_state = A) ELSE
							'0' WHEN (pr_state = aa) ELSE
							'0' WHEN (pr_state = B) ELSE
							'0' WHEN (pr_state = bb) ELSE
							'1' WHEN (pr_state = C) ELSE
							'1' WHEN (pr_state = cc) ELSE
							'1' WHEN (pr_state = D) ELSE
							'1' WHEN (pr_state = dd) ELSE
							'0' WHEN (pr_state = E) ELSE
							'0' WHEN (pr_state = ee) ELSE
							'0' WHEN (pr_state = F) ELSE
							'0' WHEN (pr_state = ff) ELSE
							'1' WHEN (pr_state = G) ELSE
							'1' WHEN (pr_state = gg) ELSE
							'1' WHEN (pr_state = H) ELSE
							'1' WHEN (pr_state = hh) ELSE	'1';
	W <= '0' WHEN (pr_state = A) ELSE
							'0' WHEN (pr_state = aa) ELSE
							'1' WHEN (pr_state = B) ELSE
							'1' WHEN (pr_state = bb) ELSE
							'0' WHEN (pr_state = C) ELSE
							'0' WHEN (pr_state = cc) ELSE
							'1' WHEN (pr_state = D) ELSE
							'1' WHEN (pr_state = dd) ELSE
							'0' WHEN (pr_state = E) ELSE
							'0' WHEN (pr_state = ee) ELSE
							'1' WHEN (pr_state = F) ELSE
							'1' WHEN (pr_state = ff) ELSE
							'0' WHEN (pr_state = G) ELSE
							'0' WHEN (pr_state = gg) ELSE
							'1' WHEN (pr_state = H) ELSE
							'1' WHEN (pr_state = hh) ELSE	'1';
							
	R <= '1' WHEN (pr_state = H) ELSE '0';								--Reset Function for when score reaches 7

	
	

	PROCESS (pr_state, filtered_x)
	BEGIN

		
		CASE pr_state IS
		
			WHEN A =>							
				IF filtered_x='0' THEN
					nx_state <= A;				
				ELSE
					nx_state <= aa;
			END IF;		
					
			WHEN aa =>							
				IF filtered_x='1' THEN
					nx_state <= aa;				
				ELSE
					nx_state <= B;
			END IF;		
					
			WHEN B =>							
				IF filtered_x='0' THEN
					nx_state <= B;				
				ELSE
					nx_state <= bb;
			END IF;		
					
			WHEN bb =>							
				IF filtered_x='1' THEN
					nx_state <= bb;				
				ELSE
					nx_state <= C;
			END IF;						
					
			WHEN C =>							
				IF filtered_x='0' THEN
					nx_state <= C;				
				ELSE
					nx_state <= cc;
			END IF;		
					
			WHEN cc =>							
				IF filtered_x='1' THEN
					nx_state <= cc;				
				ELSE
					nx_state <= D;
			END IF;						
					
			WHEN D =>							
				IF filtered_x='0' THEN
					nx_state <= D;				
				ELSE
					nx_state <= dd;
			End IF;
			
			WHEN dd =>							
				IF filtered_x='1' THEN
					nx_state <= dd;				
				ELSE
					nx_state <= E;
			END IF;				
			
			WHEN E =>							
				IF filtered_x='0' THEN
					nx_state <= E;				
				ELSE
					nx_state <= ee;
			End IF;			
					
			WHEN ee =>							
				IF filtered_x='1' THEN
					nx_state <= ee;				
				ELSE
					nx_state <= F;
			END IF;						
					
			WHEN F =>							
				IF filtered_x='0' THEN
					nx_state <= F;				
				ELSE
					nx_state <= ff;
			End IF;		
			
			WHEN ff =>							
				IF filtered_x='1' THEN
					nx_state <= ff;				
				ELSE
					nx_state <= G;
			END IF;				

			WHEN G =>							
				IF filtered_x='0' THEN
					nx_state <= G;				
				ELSE
					nx_state <= gg;
			End IF;	

			WHEN gg =>							
				IF filtered_x='1' THEN
					nx_state <= gg;				
				ELSE
					nx_state <= H;
			END IF;				
			
			WHEN H =>							
				IF filtered_x='0' THEN
					nx_state <= H;				
				ELSE
					nx_state <= hh;
			End IF;	
			
			WHEN hh =>							
				IF filtered_x='1' THEN
					nx_state <= hh;				
				ELSE
					nx_state <= A;
			END IF;	
					
			WHEN OTHERS =>						--Including WHEN OTHERS is a good habit to cover all cases
				nx_state <= A;
				
			END CASE;
			
						
			
		END PROCESS;


END arch;
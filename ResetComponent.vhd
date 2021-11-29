
LIBRARY ieee;
USE ieee.std_logic_1164.all;			-- For IEEE data types
USE ieee.std_logic_unsigned.all;		-- For + and - operations

-- Entity Declaration

ENTITY ResetComponent IS
	PORT (
		clock, reset, P1, P2		:	IN STD_LOGIC;
		M								:	OUT STD_LOGIC
	);
END ResetComponent;



--  Architecture Section

ARCHITECTURE arch OF ResetComponent IS

-- Build an enumerated type for the state machine
-- The states declared here come directly from the state diagram
TYPE state_type IS (A, aa, B, bb, C, cc, D, dd, E, ee, F, ff, G, gg, H, hh);

-- Create a register to hold teh present and next states
SIGNAL pr_state, nx_state	: state_type;



-- Begin the architecture section...
BEGIN



----------------------- PRESENT STATE SECTION (REGISTER) --------------------------------------------
--
--  The function of this section is to assign the next state to the present state at the active clock edge.
--  An asynchronous reset signal should be included to initialize the system to the default first state of the system. 
--  This section is implemented with sequential (behavioral) VHDL code with a PROCESS.
--


	PROCESS (reset, clock)
	BEGIN
		
		--Active High Reset
		IF (reset = '1') THEN
			pr_state <= A;
			
		ELSIF (clock'EVENT AND clock = '1') THEN
			pr_state <= nx_state;
			
		END IF;
	
	END PROCESS;


	--Moore Machine: 1 in State D only
	M <= '1' WHEN (pr_state = H) ELSE '0';


	PROCESS (pr_state, P1, P2)
	BEGIN

		
		CASE pr_state IS
		
			WHEN A =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= A;				
				ELSE
					nx_state <= aa;
			END IF;		

			WHEN aa =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= B;				
				ELSE
					nx_state <= aa;
			END IF;		
			
			
			WHEN B =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= B;				
				ELSE
					nx_state <= bb;
			END IF;		

			WHEN bb =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= C;				
				ELSE
					nx_state <= bb;
			END IF;		

			
			WHEN C =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= C;				
				ELSE
					nx_state <= cc;
			END IF;		

			WHEN cc =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= D;				
				ELSE
					nx_state <= cc;
			END IF;		

			
			WHEN D =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= D;				
				ELSE
					nx_state <= dd;
			END IF;		

			WHEN dd =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= E;				
				ELSE
					nx_state <= dd;
			END IF;			
			
	
			WHEN E =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= E;				
				ELSE
					nx_state <= ee;
			END IF;		

			WHEN ee =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= F;				
				ELSE
					nx_state <= ee;
			END IF;				
					
					
			WHEN F =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= F;				
				ELSE
					nx_state <= ff;
			END IF;		

			WHEN ff =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= G;				
				ELSE
					nx_state <= ff;
			END IF;						
					
					
			WHEN G =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= G;				
				ELSE
					nx_state <= gg;
			END IF;		

			WHEN gg =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= H;				
				ELSE
					nx_state <= gg;
			END IF;	


			WHEN H =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= H;				
				ELSE
					nx_state <= hh;
			END IF;		

			WHEN hh =>							
				IF (P1='0' AND P2='0') THEN
					nx_state <= A;				
				ELSE
					nx_state <= hh;
			END IF;	
			
					
			WHEN OTHERS =>						--Including WHEN OTHERS is a good habit to cover all cases
				nx_state <= A;
				
			END CASE;
			
		END PROCESS;


END arch;
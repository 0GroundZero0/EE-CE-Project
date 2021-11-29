------------
--
--  Finite State Machine (FSM):
--  with Time Delay in states
--
------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;			-- For IEEE data types
USE ieee.std_logic_unsigned.all;		-- For + and - operations


-- Entity Declaration

ENTITY FSM_with_time_delay IS
	PORT (
		clock, reset, x	:	IN STD_LOGIC;
		z						:	OUT STD_LOGIC_VECTOR(1 downto 0)
	);
END FSM_with_time_delay;



--  Architecture Section

ARCHITECTURE arch OF FSM_with_time_delay IS

	-- Define a set of constants and signals to implement the delays
	CONSTANT times1		:	INTEGER := 05;
	CONSTANT timeS2		:	INTEGER := 2*timeS1;
	CONSTANT timeS3		:	INTEGER := 3*timeS1;
	
	SIGNAL	time_limit	:	INTEGER RANGE 0 TO timeS3;
	

	-- Build an enumerated type for the state machine
	-- The states declared here come directly from the state diagram
	TYPE state_type IS (s1, s2, s3);

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

	-- Add a mechanism to only change state after a certain number of clock cycles
	
	PROCESS (reset, clock)
	
	-- Add a VARIABLE to keep track of the number of clock cycles that have occurred
	VARIABLE cycle_count : INTEGER RANGE 0 to timeS3;
	
	BEGIN
	
		-- Active high reset to State A
		IF reset = '1' THEN
			pr_state <= s1;
			
			-- Reset the number of clock cycles that have occurred
			cycle_count := 0;
			
		-- On rising clock edge... increment the number of clock cycles that have occurred
		ELSIF (clock'EVENT AND clock = '1') THEN
			cycle_count := cycle_count + 1;
			
			-- If we hit the clock cycle limit for the current state,
			-- transition to the next state (nx_state) and reset the number of clock cycles
			IF (cycle_count = time_limit) THEN
				pr_state <= nx_state;
				cycle_count := 0;
			END IF;
		
		END IF;
		
	END PROCESS;



----------------------- OUTPUT LOGIC SECTION ---------------------------------------------------------
--
--  The function of this section is to generate the outputs of the system: 
--  		Determine the output based on current input and present state.
--  This section is implemented with concurrent VHDL code with conditional assignment statements.
--

	-- Moore machine
	z <=  "01" WHEN (pr_state = s1) ELSE 
		   "10" WHEN (pr_state = s2) ELSE 
		   "11";

	

----------------------- NEXT STATE LOGIC SECTION ---------------------------------------------------------
--
--  The function of this section is to establish the next state of the system: 
--  		Determine the next state based on current input and present state.
--  		This section comes directly from following the transitions in the state diagram.
--  This section is implemented with behavioral (sequential) VHDL code with a PROCESS.
--

	PROCESS (pr_state, x)
	BEGIN
	
		-- Use a CASE statement with a case for each present state
		-- and an "IF...THEN" for the x=0 and x=1 transitions out of that state
		
		CASE pr_state IS
		
			WHEN s1 =>					-- State s1
				IF x = '1' THEN
					nx_state <= s3;		
				ELSE
					nx_state <= s2;		
				END IF;
				
				-- Set delay (time limit) in state S1
				time_limit <= timeS1;
				
			WHEN s2 =>					-- State s2
				IF x = '1' THEN
					nx_state <= s1;		
				ELSE
					nx_state <= s3;		
				END IF;
				
				-- Set delay (time limit) in state S2
				time_limit <= timeS2;
					
			WHEN s3 =>					-- State s3
				IF x = '1' THEN
					nx_state <= s2;		
				ELSE
					nx_state <= s1;		
				END IF;
				
				-- Set delay (time limit) in state S3
				time_limit <= timeS3;
				
			END CASE;
			
		END PROCESS;


END arch;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DisplayDriver is
    PORT(
        X, Y, Z : IN STD_LOGIC;
        A, B, C, D, E, F, G : OUT STD_LOGIC
    );
END DisplayDriver;


architecture arch of DisplayDriver is
begin
   a <= (not X and not Y and Z) or (X and not Y and not Z);
   b <= (X and not y and Z) or (X and y and not z);
   c <= (not X and y and not z);
   d <= (not X and not y and z) or (X and not y and not z) or (X and y and z);
   e <= (X and not y) or (not X and not y and z) or (z);
   f <= (not X and z) or (not X and y) or (y and z);
   g <= (X and y and z) or (not X and not y);

end arch;
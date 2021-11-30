LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DisplayDriver is
    PORT(
        X, Y, Z : IN STD_LOGIC;
        A, B, C, D, E, F, G : OUT STD_LOGIC;
    );
END DisplayDriver


architecture arch of DisplayDriver is
begin
   a <= (not X and not Y and Z) or (X and not Y and not Z);
   b <= (x and not y and Z) or (x and y and not z);
   c <= (not x and y and not z);
   d <= (not x and not y and z) or (x and not y and not z) or (x and y and z);
   e <= (x and not y) or (not x and not y and z) or (z);
   f <= (not x and z) or (not x and y) or (y and z);
   g <= (x and y and z) or (not x and not y);

end arch;
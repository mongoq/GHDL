-- https://www.csee.umbc.edu/portal/help/VHDL/samples/samples.html

--use std.textio.all;
 
library IEEE;                                                   
use IEEE.std_logic_1164.all;                                   
use IEEE.numeric_std.all;                                       
use IEEE.std_logic_textio.all;                                  
--use ieee.std_logic_arith.all;

library std;
use std.textio.all;

entity counter is
	port (
	countera : out integer;
	counterb : out integer
	);
end counter;
     
architecture behaviour of counter is

	--https://stackoverflow.com/questions/12951759/how-to-decode-an-unsigned-integer-into-bcd-use-vhdl
	--https://electronics.stackexchange.com/questions/4482/vhdl-converting-from-an-integer-type-to-a-std-logic-vector
	
    function to_bcd ( bin : unsigned(7 downto 0) ) return unsigned is
        variable i : integer:=0;
        variable bcd : unsigned(11 downto 0) := (others => '0');
        variable bint : unsigned(7 downto 0) := bin;

        begin
        for i in 0 to 7 loop  -- repeating 8 times.
        bcd(11 downto 1) := bcd(10 downto 0);  --shifting the bits.
        bcd(0) := bint(7);
        bint(7 downto 1) := bint(6 downto 0);
        bint(0) :='0';


        if(i < 7 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
        bcd(3 downto 0) := bcd(3 downto 0) + "0011";
        end if;

        if(i < 7 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
        bcd(7 downto 4) := bcd(7 downto 4) + "0011";
        end if;

        if(i < 7 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
        bcd(11 downto 8) := bcd(11 downto 8) + "0011";
        end if;

    end loop;
    return bcd;
    end to_bcd;


     begin
        process
           variable l : line;
		   variable counter : integer := 0;
		   variable counterhex : integer := 0;
        begin
		  if counter < 255 then
		   counter := counter + 1;
		   
           -- write (l, String'("DEC: "));
		   -- write (l, counter);
		   -- write (l, String'(" HEX: "));
		   -- write (l, "0x" & to_hstring(to_signed(counter, 32)));
		   -- write (l, String'(" BCD: ");
		   
		   write (l, String'("DEC: "));
		   write (l, counter);
		   write (l, String'(" HEX: "));
		   write (l, "0x" & to_hstring(to_signed(counter, 32)));
		   write (l, String'(" BCD: "));
		   --write (l, String'("TEST"));
		   write(l, to_bcd(to_unsigned(counter,8)));
		   writeline (output, l);
		  end if;
        end process;
end behaviour;
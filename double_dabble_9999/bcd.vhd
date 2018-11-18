library IEEE;                                                   
use IEEE.std_logic_1164.all;                                   
use IEEE.numeric_std.all;                                       
use IEEE.std_logic_textio.all;                                  

library std;
use std.textio.all;

entity bcd is
end bcd;
     
architecture behaviour of bcd is

    --https://www.csee.umbc.edu/portal/help/VHDL/samples/samples.html !?
	--https://stackoverflow.com/questions/12951759/how-to-decode-an-unsigned-integer-into-bcd-use-vhdl <-- function to_bcd
	--https://electronics.stackexchange.com/questions/4482/vhdl-converting-from-an-integer-type-to-a-std-logic-vector

	--https://en.wikipedia.org/wiki/Double_dabble <-- !!! 
	--http://ghdl.free.fr/ghdl/A-full-adder.html <-- Testbench mit GHDL
   
    --http://www.lothar-miller.de/s9y/archives/14-Numeric_Std.html
	
     begin
        process

		 variable l : line;
		 variable counter : integer := 0;

		 variable bcd : unsigned(15 downto 0) := (others => '0'); -- maximal bin: 1001 1001 1001 1001 -> dez: 9999

		 variable thousands : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
		 variable hundreds : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
		 variable tens : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
		 variable ones : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
         variable temp : STD_LOGIC_VECTOR (13 downto 0);
		   
        begin
		  if counter <= 9999 then -- maximal 1001 1001 1001 1001 --> dez. 39321
		    
           temp := std_logic_vector(to_unsigned(counter,14)); 
		   
           for i in 0 to 13 loop -- was 0 to 11
    
			if bcd(3 downto 0) > 4 then 
				bcd(3 downto 0) := bcd(3 downto 0) + 3;
			end if;
      
			if bcd(7 downto 4) > 4 then 
				bcd(7 downto 4) := bcd(7 downto 4) + 3;
			end if;
    
			if bcd(11 downto 8) > 4 then  
				bcd(11 downto 8) := bcd(11 downto 8) + 3;
			end if;
			
    		if bcd(15 downto 12) > 4 then  
				bcd(15 downto 12) := bcd(15 downto 12) + 3;
			end if;
	
			-- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
			-- neu: bcd := bcd(14 downto 0) & temp(13); 
		    bcd := bcd(14 downto 0) & temp(13); 
			
			-- shift temp left by 1 bit
			temp := temp(12 downto 0) & '0'; --temp hat 14 bit 
			
		   --write(l, String'("SHIFT BCD: ")); 
		   --write(l, bcd);
		   --write(l, String'(" temp: ")); 
		   --write(l, temp);
		   --writeline (output, l);
			
		end loop;
 
			ones := STD_LOGIC_VECTOR(bcd(3 downto 0));
			tens := STD_LOGIC_VECTOR(bcd(7 downto 4));
			hundreds := STD_LOGIC_VECTOR(bcd(11 downto 8));
			thousands := STD_LOGIC_VECTOR(bcd(15 downto 12));
	   
		   write (l, String'("DEC: "));
		   write (l, counter);
		   write (l, String'(" HEX: "));
		   write (l, "0x" & to_hstring(to_signed(counter, 16))); -- VHDL 2008 (!)
		   write (l, String'(" BCD: "));
		   write(l, thousands);
		   write(l, String'(" "));
		   write(l, hundreds);
		   write(l, String'(" "));
		   write(l, tens);
		   write(l, String'(" "));
		   write(l, ones);
		   write (l, String'(" BIN: "));
		   write(l, std_logic_vector(to_unsigned(counter,14))); 
		   writeline (output, l);

		   counter := counter + 1;
		   bcd:=(others => '0');
		  end if;
        end process;
end behaviour;
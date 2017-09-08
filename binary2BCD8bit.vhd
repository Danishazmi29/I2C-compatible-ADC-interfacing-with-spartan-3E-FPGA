library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bin2BCD8bit is
						port(bin : in std_logic_vector(7 downto 0);
							unit : out std_logic_vector(3 downto 0);
							tens : out std_logic_vector(3 downto 0);
							hundreds : out std_logic_vector(3 downto 0));
end bin2BCD8bit;

architecture Beh_bin2BCD of bin2BCD8bit is

begin
BinarytoBCD_process: process(bin)

variable z: std_logic_vector(19 downto 0);
variable i: integer := 0;

begin
z := (others => '0');
z(7 downto 0) := bin;

for i in 0 to 7 loop

	z(19 downto 0) := z(18 downto 0) & '0';
	
	if (i < 7 and z(11 downto 8) > "0100") then
		z(11 downto 8) := z(11 downto 8) + "0011";
	end if;
	
	if (i < 7 and z(15 downto 12) > "0100") then
		z(15 downto 12) := z(15 downto 12) + "0011";
	end if;
	
	if (i < 7 and z(19 downto 16) > "0100") then
		z(19 downto 16) := z(19 downto 16) + "0011";
	end if;
	
end loop;

hundreds <= z(19 downto 16);
tens <= z(15 downto 12);
unit <= z(11 downto 8);

end process;
end Beh_bin2BCD;


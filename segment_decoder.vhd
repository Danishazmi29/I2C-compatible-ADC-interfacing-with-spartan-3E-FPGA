----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:25:31 02/24/2017 
-- Design Name: 
-- Module Name:    segment_decoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_decoder is
    Port ( digit : in  STD_LOGIC_VECTOR (3 downto 0);
           segment_A : out  STD_LOGIC;
           segment_B : out  STD_LOGIC;
           segment_C : out  STD_LOGIC;
           segment_D : out  STD_LOGIC;
           segment_E : out  STD_LOGIC;
           segment_F : out  STD_LOGIC;
           segment_G : out  STD_LOGIC);
end segment_decoder;

architecture Behavioral of segment_decoder is

begin
process(digit)
variable decode_data : std_logic_vector(6 downto 0);
begin
case digit is
	when "0000" => decode_data := "1111110";
	when "0001" => decode_data := "0110000";
	when "0010" => decode_data := "1101101";
	when "0011" => decode_data := "1111001";
	when "0100" => decode_data := "0110011";
	when "0101" => decode_data := "1011011";
	when "0110" => decode_data := "1011111";
	when "0111" => decode_data := "1110000";
	when "1000" => decode_data := "1111111";
	when "1001" => decode_data := "1111011";
	when "1010" => decode_data := "1110111";
	when "1011" => decode_data := "0011111";
	when "1100" => decode_data := "1001110";
	when "1101" => decode_data := "0111101";
	when "1110" => decode_data := "1001111";
	when "1111" => decode_data := "1000111";
	when others => decode_data := "0110111";
end case;

segment_A <= not decode_data(6);
segment_B <= not decode_data(5);
segment_C <= not decode_data(4);
segment_D <= not decode_data(3);
segment_E <= not decode_data(2);
segment_F <= not decode_data(1);
segment_G <= not decode_data(0);
end process;

end Behavioral;


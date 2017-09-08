----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:57:09 02/25/2017 
-- Design Name: 
-- Module Name:    segment_driver - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_driver is
    Port ( display_A : in  STD_LOGIC_VECTOR (3 downto 0);
           display_B : in  STD_LOGIC_VECTOR (3 downto 0);
           display_C : in  STD_LOGIC_VECTOR (3 downto 0);
           display_D : in  STD_LOGIC_VECTOR (3 downto 0);
           segA : out  STD_LOGIC;
           segB : out  STD_LOGIC;
           segC : out  STD_LOGIC;
           segD : out  STD_LOGIC;
           segE : out  STD_LOGIC;
           segF : out  STD_LOGIC;
           segG : out  STD_LOGIC;
           select_displayA : out  STD_LOGIC;
           select_displayB : out  STD_LOGIC;
           select_displayC : out  STD_LOGIC;
           select_displayD : out  STD_LOGIC;
           clk : in  STD_LOGIC);
end segment_driver;

architecture Behavioral of segment_driver is

	COMPONENT segment_decoder
	PORT(
		digit : IN std_logic_vector(3 downto 0);          
		segment_A : OUT std_logic;
		segment_B : OUT std_logic;
		segment_C : OUT std_logic;
		segment_D : OUT std_logic;
		segment_E : OUT std_logic;
		segment_F : OUT std_logic;
		segment_G : OUT std_logic
		);
	END COMPONENT;

COMPONENT clock_divider
	PORT(
		clk : IN std_logic;
		enable : IN std_logic;
		reset : IN std_logic;          
		data_clk : OUT std_logic_vector(17 downto 0)
		);
	END COMPONENT;
	
	signal temp_data : std_logic_vector(3 downto 0);
	signal clock_word : std_logic_vector(17 downto 0);
	signal slow_clk : std_logic;
begin
uut1: segment_decoder PORT MAP(
		digit => temp_data,
		segment_A => segA,
		segment_B => segB,
		segment_C => segC,
		segment_D => segD,
		segment_E => segE,
		segment_F => segF,
		segment_G => segG
	);
uut2: clock_divider PORT MAP(
		clk => clk,
		enable => '1' ,
		reset => '0',
		data_clk => clock_word
	);
slow_clk <= clock_word(17);

process(slow_clk)
variable display_selection : std_logic_vector(1 downto 0);
begin
if slow_clk'event and slow_clk='1' then
case display_selection is
	when "00" => temp_data <= display_A;
		select_displayA <= '0';
		select_displayB <= '1';
		select_displayC <= '1';
		select_displayD <= '1';
		
		display_selection := display_selection + '1';
	when "01" => temp_data <= display_B;
		select_displayA <= '1';
		select_displayB <= '0';
		select_displayC <= '1';
		select_displayD <= '1';
		
		display_selection := display_selection + '1';
	when "10" => temp_data <= display_C;
		select_displayA <= '1';
		select_displayB <= '1';
		select_displayC <= '0';
		select_displayD <= '1';
		
		display_selection := display_selection + '1';
	when others => temp_data <= display_D;
		select_displayA <= '1';
		select_displayB <= '1';
		select_displayC <= '1';
		select_displayD <= '0';
		
		display_selection := display_selection + '1';
	end case;
	end if;
end process;

end Behavioral;


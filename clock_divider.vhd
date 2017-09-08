----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:37 02/25/2017 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
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

entity clock_divider is
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           data_clk : out  STD_LOGIC_VECTOR (17 downto 0)); --changed from 15 to 21
end clock_divider;

architecture Behavioral of clock_divider is

begin
process(clk,reset)
variable count : std_logic_vector(17 downto 0) := (others=>'0');

begin
	if reset = '1' then
	count := (others=>'0');
	elsif enable = '1' and clk'event and clk = '1' then
	count := count + 1;
	end if;
	data_clk <= count;
	end process;
end Behavioral;


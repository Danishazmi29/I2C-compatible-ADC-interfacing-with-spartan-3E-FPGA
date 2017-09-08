----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:16:57 03/31/2017 
-- Design Name: 
-- Module Name:    clkdivder - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clkdivder is port(clk_50_MHz : in std_logic;
								clk_100k_Hz : out std_logic);
end clkdivder;

architecture Behavioral of clkdivder is
constant max100k : integer := (50000000)/(100000*2);
signal clockticks100k : integer range 0 to max100k;
begin

clock_divider_100k: process
begin

wait until clk_50_MHz'event and clk_50_MHz = '1' ;
	
	if clockticks100k < max100k then
		clockticks100k <= clockticks100k + 1;
	else
		clockticks100k <= 0;
	end if;
	
	if clockticks100k < max100k / 2 then
		clk_100k_Hz <= '0';
	else
		clk_100k_Hz <= '1';
	end if;
end process;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:58:23 05/02/2017 
-- Design Name: 
-- Module Name:    comparator15cm - Behavioral 
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

entity comparator15cm is
						port(A : in std_logic_vector(15 downto 0);
						  comp : out std_logic;
						  buzz : out std_logic);
end comparator15cm;

architecture Behavioral of comparator15cm is

begin
	comp <= '1' when (A < "0000000000001111") else '0';
	buzz <= '1' when (A < "0000000000001111") else '0';
end Behavioral;


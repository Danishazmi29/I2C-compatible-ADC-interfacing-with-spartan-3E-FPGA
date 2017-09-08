----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:50 03/21/2017 
-- Design Name: 
-- Module Name:    I2C_protocol_proj - Behavioral 
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

entity I2C_protocol_proj is
						port( clk_50_MHz : in std_logic;
								resetN : in std_logic;
								scl : out std_logic;
								sda : inout std_logic;
								data_out : out std_logic_vector(7 downto 0));
end I2C_protocol_proj;

architecture Behavioral of I2C_protocol_proj is

signal state : std_logic_vector(7 downto 0);
signal data : std_logic_vector(7 downto 0);
signal sda01 : std_logic;
signal bitcount : integer range 0 to 7;
constant slave_address_read : std_logic_vector(7 downto 0) := "1001000" & '1';
constant slave_address_write : std_logic_vector(7 downto 0) := "1001000" & '0';
constant control_status_register : std_logic_vector(7 downto 0) := "00000000";
constant max200k : integer := (50000000)/(100000*2);
signal clockticks200k : integer range 0 to max200k;
signal clk_200k_Hz : std_logic;
constant count : integer := 0;

begin

sda <= 'Z' when sda01 = '1' else '0';

output : process(clk_200k_Hz, resetN)

begin
if(resetN = '0') then
	--Idle state
	scl <= '1';
	sda01 <= '1';
	data_out <= "11111111";
	state <= x"00";
elsif( clk_200k_Hz'event and clk_200k_Hz = '1') then
	case state is
			--Idle state
		when x"00" => scl <= '1';
						sda01 <= '1';
						data_out <= "00000000";
						state <= x"01";
			-- Start Condition
		when x"01" => scl <= '1';
						sda01 <= '0';
						bitcount <= 7;
						state <= x"02";
			-- Sending Address of Slave, MSB first
		when x"02" => scl <= '0';
						sda01 <= slave_address_write(bitcount);
						state <= x"03";
		when x"03" => scl <= '1';
						if(bitcount - 1) >= 0 then
							bitcount <= bitcount - 1;
							state <= x"02";
						else
							bitcount <= 7;
							state <= x"12";
						end if;
			-- Send Acknolegdment from slave to master
		when x"12" => scl <= '0';
						sda01 <= '1';
						state <= x"13";
		when x"13" => scl <= '1';
						if sda = '1' then			--changed
							state <= x"EE";      -- Not Acknowledgment
						else
							state <= x"20";		-- Acknowlegement
						end if;
		when x"20" => scl <= '0';
						sda01 <= control_status_register(bitcount);
						state <= x"21";
		when x"21" => scl <= '1';
						if(bitcount - 1) >= 0 then
							bitcount <= bitcount - 1;
							state <= x"20";
						else
							bitcount <= 7;
							state <= x"30";
						end if;
		when x"30" => scl <= '0';
						sda01 <= '1';
						state <= x"31";
		when x"31" => scl <= '1';
						if sda = '1' then				--changed
							state <= x"EE";
						else
							state <= x"70";
						end if;
		when x"70" => scl <= '0';
						sda01 <= '1';
					if sda = '1' then				--changed
						state <= x"EE";
					else
						state <= x"71";
					end if;
		when x"71" => scl <= '1';
						sda01 <= '1';
						state <= x"72";
		when x"72" => scl <= '1';
						sda01 <= '0';
						bitcount <= 7;
						state <= x"82";
		when x"82" => scl <= '0';
						sda01 <= slave_address_read(bitcount);
						state <= x"83";
		when x"83" => scl <= '1';
						if(bitcount - 1) >= 0 then
							bitcount <= bitcount - 1;
							state <= x"82";
						else
							bitcount <= 7;
							state <= x"92";
						end if;
		when x"92" => scl <= '0';
						sda01 <= '1';
						state <= x"93";
		when x"93" => scl <= '1';
						if sda = '1' then		--chnaged
							state <= x"EE";
						else
							bitcount <= 7;
							state <= x"C0";
						end if;
		when x"C0" => scl <= '0';
						sda01 <= '1';
						state <= x"C1";
		when x"C1" => scl <= '1';
						data(bitcount) <= sda;
						if(bitcount - 1) >= 0 then
							bitcount <= bitcount - 1;
							state <= x"C0";
						else
							
							bitcount <= 7;
							state <= x"D0";
						end if;
		when x"D0" => scl <= '0';
						if count > 1 then
							sda01 <= '1';	--chnaged
							state <= x"D2";
						else
						--	count <= count + 1;
							sda01 <= '0';
							state <= x"D1";
						end if;
							data_out <= data;
		when x"D1" => scl <= '1';
						state <= x"C0";
		when x"D2" => scl <= '1';
						state <= x"D3";
		when x"D3" => scl <= '0';
						sda01 <= '0';
						state <= x"D4";
		when x"D4" => scl <= '1';
						sda01 <= '0';
						state <= x"D5";
		when x"D5" => scl <= '1';
						sda01 <= '1';
						state <= x"D5";
		when x"EE" => scl <= '1';
						sda01 <= '1';
						state <= x"EE";
		when x"F0" => scl <= '0';
						bitcount <= 7;
						state <= x"F1";
		when x"F1" => scl <= '1';
						if sda = '0' then				--changed
							bitcount <= 7;
						else
							bitcount <= bitcount - 1;
						end if;
						state <= x"F2";
		when x"F2" => scl <= '0';
						if bitcount = 0 then
							state <= x"00";
						else
							state <= x"F1";
						end if;
		when others => null;
						scl <= '1';
						sda01 <= '1';
	end case;
end if;
end process;


clock_divider_200k: process
begin

wait until clk_50_MHz'event and clk_50_MHz = '1' ;
	
	if clockticks200k < max200k then
		clockticks200k <= clockticks200k + 1;
	else
		clockticks200k <= 0;
	end if;
	
	if clockticks200k < max200k / 2 then
		clk_200k_Hz <= '0';
	else
		clk_200k_Hz <= '1';
	end if;
end process;

						
						

end Behavioral;


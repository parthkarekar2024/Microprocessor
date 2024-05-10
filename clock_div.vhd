--clock_div 
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2024 10:57:49 AM
-- Design Name: 
-- Module Name: clock_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
Port ( 

clk: in std_logic;
en: out std_logic 

);
end clock_div;

architecture Behavioral of clock_div is

signal cnt: std_logic_vector (26 downto 0) := (others => '0'); 

begin

process(clk)
    begin 
       
        if( rising_edge(clk)) then 
        if( unsigned(cnt) < (4)) then
        cnt <= std_logic_vector(unsigned(cnt)+1);
        en <= '0';
        else 
        en <= '1';
        cnt <= (others => '0');
        
 end if;
 end if;
 

end process;


end Behavioral;

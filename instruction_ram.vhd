----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2024 10:17:41 PM
-- Design Name: 
-- Module Name: instruction_ram - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_ram is
Port ( 

         clk :in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(13 downto 0);
         data_out:out STD_LOGIC_VECTOR(31 downto 0)
 
);
end instruction_ram;

architecture Behavioral of instruction_ram is

type data_array_data is array (0 to 9) of STD_LOGIC_VECTOR (31 downto 0);
signal instruction_data_array: data_array_data := (

"10010011000000000000000000000100", --r12 = 2
"10010010110000000000000000000010", --r11 = 1
"00001001100010001011000000000000", --r6 = n-1
"00101001100011000101000000000000", -- r6 = (n-1)d
"00000001100011000011000000000000", --(n-1)d +a
"00000001100011000011000000000000", --(n-1)d +2a

"10010011010000000000000000000100",
"00111001100011001100000000000000", -- divide result by 2
"00101001100011000100000000000000", -- multiply by n

-- send ascii thru uart 

--"01011110010000000000000000000000",
--"01011110100000000000000000000000",
--"01011110110000000000000000000000",
--"01011111000000000000000000000000",
--"01011111010000000000000000000000", 

--infinite loop?
"10000111101111100000000000010010"

);


begin

process(clk) 
begin 

if( rising_edge(clk) ) then 
    
    data_out <= instruction_data_array(to_integer(unsigned(address)));
    
end if; 
end process; 
 
end Behavioral;

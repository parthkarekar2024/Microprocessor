library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--use UNISIM.VComponents.all;

entity debouncer is

port(

btn :in std_logic;
clk:in std_logic;
dbnc:out std_logic

);


end debouncer;


architecture Behavioral of debouncer is 

signal cntr :std_logic_vector (26 downto 0) :=(others => '0');

begin 

process(clk)
begin
 
    if ( rising_edge (clk) ) then 
    if (btn = '1') then 
        if ( unsigned(cntr) < (2500000-1)) then 
        cntr <= std_logic_vector (unsigned(cntr) +1 );
        dbnc <= '0';
        else 
        dbnc <= '1';
    end if;
end if;
    
if( btn = '0') then 
    cntr <= (others => '0');
    dbnc <= '0';
    end if;
    end if;
    
 
end process; 



end Behavioral;

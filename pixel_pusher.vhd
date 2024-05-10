library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
    Port (
            clk, en : in std_logic;
            VS : in std_logic;
            pixel : in std_logic_vector(15 downto 0);
            hcount : in std_logic_vector(9 downto 0);
--            vcount : in std_logic_vector(9 downto 0);
            vid : in std_logic;
            R,B : out std_logic_vector(4 downto 0);
            G : out std_logic_vector(5 downto 0);
            addr : out std_logic_vector(11 downto 0) := (others => '0')
     );
end pixel_pusher;

architecture Behavioral of pixel_pusher is

signal adderT : std_logic_vector(11 downto 0) := (others => '0');

begin

addr <= adderT;

process(clk, vid, hcount)
begin
    if (rising_edge(clk)) then
    
        if (en = '1') then 
    
            if (VS = '0') then 
            
                adderT <= (others => '0');
                
            end if;
    
            if ((vid = '1') and (unsigned(hcount) < 480)) then
            
                adderT <= std_logic_vector(unsigned(adderT) + 1);

             
                R <= pixel(15 downto 11);
                G <= pixel(10 downto 5);
                B <= pixel(4 downto 0);
                
            else
            
                R <= (others => '0');
                G <= (others => '0');
                B <= (others => '0');
                
            end if;
            
        else
            R <= (others => '0');
            G <= (others => '0');
            B <= (others => '0');
        end if;
    end if;
    
end process;

end Behavioral;

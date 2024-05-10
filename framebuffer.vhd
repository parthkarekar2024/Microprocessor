library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity framebuffer is
    Port (
        clk1, en1, en2, ld  : in std_logic;
        addr1, addr2        : in std_logic_vector(11 downto 0);
        wr_en1              : in std_logic;
        din1                : in std_logic_vector(15 downto 0);
        dout1, dout2        : out std_logic_vector(15 downto 0)
    );
end framebuffer;

architecture Behavioral of framebuffer is

    -- memory
    type mem_type is array (0 to 4095) of std_logic_vector(15 downto 0);
    signal mem : mem_type;
    signal count : integer range 0 to 4095 := 0;
    signal ld_temp: std_logic; 

begin

--process(clk1, ld)
--begin 
-- if (ld = '1') then 
   
--   ld_temp <= '1'; 
   
--       if( ld_temp = '1') then 
       
--            if (count < 4096) then 
--                count <= count + 1;
--                mem(count) <= (others => '0');
--            else 
--                ld_temp <= '0'; 
--                count <= 0;
--            end if;         
            
--       end if; 
       
--end if;
--end process; 


process(clk1)
begin 
    if (rising_edge(clk1)) then 
        if ( en1 = '1' ) then 
            if (wr_en1 = '1') then 
                mem(to_integer(unsigned(addr1))) <= din1;
            end if; 
            dout1 <= mem(to_integer(unsigned(addr1)));
        end if;
    end if; 
end process;

process(clk1)
begin 
    if (rising_edge(clk1)) then 
        if (en2 = '1') then 
            dout2 <= mem(to_integer(unsigned(addr2)));
        end if; 
    end if; 
end process;

end Behavioral;


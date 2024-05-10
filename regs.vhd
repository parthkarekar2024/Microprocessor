library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity regs is
    Port (
        clk, en, rst    : in std_logic;
        id1, id2        : in std_logic_vector(4 downto 0); 
        wr_en1, wr_en2  : in std_logic;
        din1, din2      : in std_logic_vector(15 downto 0);
        dout1, dout2    : out std_logic_vector(15 downto 0);
        regsix          : out std_logic_vector (15 downto 0)
        
     );
end regs;

architecture Behavioral of regs is

type str is array (0 to 31) of std_logic_vector(15 downto 0); 


signal registers : str :=
("0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000001010", --a r3, 10
 "0000000000001100", -- n r4,   12
 "0000000000000010",-- d r5,  2
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000",
 "0000000000000000"
                      );

begin

regsix <= registers(6); 
dout1 <= registers(to_integer(unsigned(id1)));
dout2 <= registers(to_integer(unsigned(id2)));

-- Storing ASCII representations into registers 


process(clk)
begin

    if rising_edge(clk) then 
        registers(0) <= (others => '0');
        
        if (rst = '1') then 
            registers <= (others => (others => '0'));
        
        elsif (en = '1') then
            
            if (wr_en1 = '1') then 
                registers(to_integer(unsigned(id1))) <= din1;
            end if;
            
            if (wr_en2 = '1') then 
                registers(to_integer(unsigned(id2))) <= din2;
            end if;
        end if;
    end if;

end process;


end Behavioral;

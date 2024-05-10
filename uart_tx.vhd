library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
    Port (
            clk, en, send, rst : in std_logic;
            char               : in std_logic_vector(7 downto 0);
            ready, tx          : out std_logic
     );
end uart_tx;

architecture Behavioral of uart_tx is

type state_type is (idle, start, data, stop);
signal curr : state_type := idle;
signal d : std_logic_vector (7 downto 0) := (others => '0');
signal count : natural range 0 to 8 := 0; 
signal tx_temp: std_logic := '1'; 

begin

tx <= tx_temp; 
   
    process(clk)
    begin
     
        if rising_edge(clk) then
            if rst = '1' then
                curr <= idle;
                d <= (others => '0');
                count <= 0;
                ready <= '1'; 
                tx_temp <= '1';
           
           
            elsif en = '1' then
           
                case curr is
               
                    when idle =>
                        ready <= '1'; 
                        tx_temp <= '1';
                        if send = '1' then
                            d <= char; 
                            
                            curr <= start; 
                        end if;
                   
                    when start =>
                        ready <= '0'; 
                        tx_temp <= '0'; 
                        curr <= data;   
                   
                    when data => 
                        ready <= '0'; 
                        if count < 8 then
                            tx_temp <= d(count);
                            count <= count + 1;  
                        else
                            count <= 0; 
                            tx_temp <= '1';
                            curr <= idle;
                           
                        end if;
                       
--                 
                       
                    when others =>
                        curr <= idle;
                   
                 end case;
             end if;
         end if;
         
      end process;
                       

end Behavioral;
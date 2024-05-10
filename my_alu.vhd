library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
--use UNISIM.VComponents.all;


entity my_alu is
    Port (
            opcode : in std_logic_vector(3 downto 0); 
            A,B : in std_logic_vector(15 downto 0);
            S : out std_logic_vector(15 downto 0);
            
            clk : in std_logic;
            en  : in std_logic

     );
end my_alu;

architecture Behavioral of my_alu is   

signal A_val : std_logic_vector(15 downto 0) := (others => '0'); --do I need?
signal B_val : std_logic_vector(15 downto 0) := (others => '0'); --do I need?
signal op_val : std_logic_vector(3 downto 0) := (others => '0');
signal tempBit : std_logic := '0';
signal stemp, sdiv :integer := 0; 

begin

op_val <= opcode;
A_val <= A;
B_val <= B; 

alu: process(clk)
begin

    if rising_edge(clk) then
        
        if (en = '1') then
        
         
            case (op_val) is       
                when "0000" =>
                    -- A + B
                    S <= std_logic_vector(unsigned(A_val) + unsigned(B_val));
                
                when "0001" =>
                    -- A - B 
                    S <= std_logic_vector(unsigned(A_val) - unsigned(B_val));
                    
                when "0010" =>
                    -- A + 1
                    S <= std_logic_vector(unsigned(A_val) + 1);
                    
                when "0011" =>
                    -- A - 1 
                    S <= std_logic_vector(unsigned(A_val) - 1);
                    
                when "0100" =>
                    -- 0 - A
                    S <= std_logic_vector(0 - unsigned(A_val));
                    
                when "0101" =>
                    -- A << 1 (shift left logical)
                    S <= std_logic_vector((unsigned(A_val) sll 1));
                    
                when "0110" =>
                    -- A >> 1 (shift right logical)
                    S <= std_logic_vector((unsigned(A_val) srl 1));

                when "0111" =>
                    -- A >>> 1 (shift right arithmetic)
                    S <= std_logic_vector(shift_right(signed(A_val), 1));

                when "1000" =>
                    -- A and B 
                    stemp <= to_integer(unsigned (A_val)) * to_integer(unsigned(B_val));
                    S <= std_logic_vector(to_unsigned(stemp, S'length)); 
                    
                when "1001" => 
                    -- A or B 
                    S <= (A_val or B_val);

                when "1010" =>
                    -- A / B
                    
                 if ( A_val /= "0000000000000000" and B_val /= "0000000000000000") then
                    sdiv  <= to_integer(unsigned (A_val)) / to_integer(unsigned(B_val));
                    S <= std_logic_vector(to_unsigned(sdiv, S'length));
                 end if; 
                 
                when "1011" =>
                    -- A < B (signed) (as bit 0 of output)
                    if (signed(A_val) < signed(B_val)) then     
                        S <= "0000000000000001";
                    else
                        S <= "0000000000000000";
                    end if;
                    
                when "1100" =>
                    -- A > B (signed) (as bit 0 of output)
                    if (signed(A_val) > signed(B_val)) then     
                        S <= "0000000000000001";
                    else
                        S <= "0000000000000000";
                    end if;
                
                when "1101" =>
                    -- A = B (as bit 0 of output)
                    if (signed(A_val) = signed(B_val)) then     
                        S <= "0000000000000001";
                    else
                        S <= "0000000000000000";
                    end if;
                
                when "1110" =>
                    -- A < B (as bit 0 of output)
                    if (unsigned(A_val) < unsigned(B_val)) then     
                        S <= "0000000000000001";
                    else
                        S <= "0000000000000000";
                    end if;
                
                when "1111" =>  
                    -- A > B (as bit 0 of output) 
                    if (unsigned(A_val) > unsigned(B_val)) then    
                        S <= "0000000000000001";
                    else
                        S <= "0000000000000000";
                    end if; 
                
                when others =>
                    S <= (others => '0');
                    
            end case;
        end if;
    end if;
    
end process;

end Behavioral;

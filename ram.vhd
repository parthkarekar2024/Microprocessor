LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is
    port(clk, wr:in STD_LOGIC;
         -- Address size is equal to index + tag
         address:in STD_LOGIC_VECTOR(14 downto 0);
         data_in:in STD_LOGIC_VECTOR(15 downto 0);
         data_out:out STD_LOGIC_VECTOR(15 downto 0);
         ram_ready:out STD_LOGIC := '0'
     );
end ram;

architecture behavorial_data_array of ram is
    type data_array_data is array (0 to 11) of STD_LOGIC_VECTOR (15 downto 0);
    signal data_array : data_array_data := (
   
    "0000000001101000",
    "0000000001100101",
    "0000000001101100",
    "0000000001101100",
    "0000000001101111",
    "0000000001011111",
    "0000000001110111",
    "0000000001101111",
    "0000000001110010",
    "0000000001101100",
    "0000000001100100",
    "0000000000000000"
);

begin
    data_out <= data_array(to_integer(unsigned(address)));

    process(clk)
    begin
        ram_ready <= '0';
        if(wr = '1') then
            data_array(to_integer(unsigned(address))) <= data_in;
        end if;

        ram_ready <= '1';

    end process;

end behavorial_data_array;
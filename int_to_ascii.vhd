library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity int_to_ascii is
    Port ( 
        number  : in  std_logic_vector (15 downto 0);
        tenthou : out std_logic_vector (7 downto 0);
        thou    : out std_logic_vector (7 downto 0);
        hund    : out std_logic_vector (7 downto 0);
        ten     : out std_logic_vector (7 downto 0);
        one     : out std_logic_vector (7 downto 0)
    );
end int_to_ascii;

architecture Behavioral of int_to_ascii is

    signal num_int    : integer range 0 to 99999 := 0;
    signal one_int    : std_logic_vector (7 downto 0) := (others => '0');
    signal ten_int    : std_logic_vector (7 downto 0) := (others => '0');
    signal hund_int   : std_logic_vector (7 downto 0) := (others => '0');
    signal thou_int   : std_logic_vector (7 downto 0) := (others => '0');
    signal tenthou_int: std_logic_vector (7 downto 0) := (others => '0');
    
    signal fortyeight : std_logic_vector (7 downto 0) := "00110000";

begin

    -- Turn number to integer 
    num_int <= to_integer(unsigned(number));

    -- Calculate each place
    one_int     <= std_logic_vector(to_unsigned(num_int mod 10, one'length));
    ten_int     <= std_logic_vector(to_unsigned((num_int / 10) mod 10, ten'length));
    hund_int    <= std_logic_vector(to_unsigned((num_int / 100) mod 10, hund'length));
    thou_int    <= std_logic_vector(to_unsigned((num_int / 1000) mod 10, thou'length));
    tenthou_int <= std_logic_vector(to_unsigned((num_int / 10000) mod 10, tenthou'length));
    
    one <= std_logic_vector (unsigned(one_int) + unsigned(fortyeight));
    ten <= std_logic_vector (unsigned(ten_int) + unsigned(fortyeight));
    hund <= std_logic_vector (unsigned(hund_int) + unsigned(fortyeight));
    thou <= std_logic_vector (unsigned(thou_int) + unsigned(fortyeight));
    tenthou <= std_logic_vector (unsigned(tenthou_int) + unsigned(fortyeight));
    


end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controls is
    Port (
        -- Timing Signals
        clk, en, rst    : in std_logic;
       
        -- Register File IO
        rID1, rID2          : out std_logic_vector(4 downto 0);
        wr_enR1, wr_enR2    : out std_logic;
        regrD1, regrD2      : in std_logic_vector(15 downto 0);
        regwD1, regwD2      : out std_logic_vector(15 downto 0);
       
        -- Framebuffer IO
        fbRST       : out std_logic;
        fbAddr1     : out std_logic_vector(11 downto 0);
        fbDin1      : in std_logic_vector(15 downto 0);
        fbDout1     : out std_logic_vector(15 downto 0);
        fbWr_en     : out std_logic;
       
        -- Instruction Memory IO
        irAddr  : out std_logic_vector(13 downto 0);
        irWord  : in std_logic_vector(31 downto 0);
       
        -- Data Memory IO
        dAddr   : out std_logic_vector(14 downto 0);
        d_wr_en : out std_logic;
        dOut    : out std_logic_vector(15 downto 0);
        dIn     : in std_logic_vector(15 downto 0);
       
        -- ALU IO
        aluA, aluB  : out std_logic_vector(15 downto 0);
        aluOp       : out std_logic_vector(3 downto 0);
        aluResult   : in std_logic_vector(15 downto 0);
       
        -- UART IO
        ready, newChar  : in std_logic;
        send            : out std_logic := '0';
        charRec         : in std_logic_vector(7 downto 0);
        charSend        : out std_logic_vector(7 downto 0) := (others => '0')
     );
end controls;

architecture Behavioral of controls is

type state_type is (fetch, fetch2, decode1, decode2, decode3, Rops, Rops2, Iops, Iops2, Jops, calc, calc2, calc3, jr, recv, recv2, rpix, wpix,
                    send_asip, send2, equals, equals2, equals3, nequal, ori, ori2, ori3, lw, lw2, lw_wait, sw, jmp, jal, clrscr, store, finish, jal1, sw1, mul, mul1, mul2,mul3, div, div1, div2, div3, sub, sub2, sub3);

signal curr : state_type := fetch;

-- get pc from reg into signal
signal pc : std_logic_vector(15 downto 0) := (others => '0');
signal instruction : std_logic_vector(31 downto 0);

signal reg1 : std_logic_vector(15 downto 0);
signal reg1_addr : std_logic_vector(4 downto 0);

signal reg2 : std_logic_vector(15 downto 0);
signal reg2_addr : std_logic_vector(4 downto 0);

signal reg3 : std_logic_vector(15 downto 0);
signal reg3_addr : std_logic_vector(4 downto 0);

signal opcode : std_logic_vector(4 downto 0);
signal imm : std_logic_vector(15 downto 0) := (others => '0');

signal data : std_logic_vector(15 downto 0) := (others => '0');
signal is_lw : std_logic := '0';
signal is_equal, is_nequal, is_rpix, is_sw, is_jal, is_jr: std_logic := '0';

signal char_Rec : std_logic_vector(7 downto 0);
signal is_rec : std_logic := '0';

signal alu_result : std_logic_vector(15 downto 0) := (others => '0') ;

begin
   
    process(clk)
    begin
        if rising_edge(clk) then
       

            if (rst = '1') then
                curr <= fetch;
            end if;
           
            if (en = '1') then
           
                case curr is
                    when fetch =>
                        rID1 <= "00001";
                        curr <= fetch2;
                       
                    when fetch2 =>
                        pc <= regrD1;
                        curr <= decode1;
                   
                    when decode1 =>
                        irAddr <= pc(13 downto 0);
                        curr <= decode2;
                   
           
                    when decode2 =>
                        instruction <= irWord;
                        curr <= decode3;
                           
                    when decode3 =>
                      
                        wr_enR1 <= '1';
                        regwD1 <= std_logic_vector(unsigned(pc) + 1);
                       
                        if (instruction(31 downto 30) = "00" or instruction(31 downto 30) = "01") then
                            reg1_addr <= instruction(26 downto 22);
                            reg2_addr <= instruction(21 downto 17);
                            reg3_addr <= instruction(16 downto 12);
                            curr <= Rops;
                        elsif (instruction(31 downto 30) = "10") then
                            reg1_addr <= instruction(26 downto 22);
                            reg2_addr <= instruction(21 downto 17);
                            curr <= Iops;
                        else
                            imm <= instruction(26 downto 11);
                            curr <= Jops;
                        end if;

                    when Rops =>
                        wr_enR1 <= '0'; 
                       
                        opcode <= instruction(31 downto 27);
                        rID1 <= reg2_addr;
                        rID2 <= reg3_addr;
                        curr <= Rops2;
                       
                    when Rops2 =>      
                       
                        reg2 <= regrD1;
                        reg3 <= regrD2;
                                                
                        if (opcode = "01101") then
                            rID1 <= reg1_addr;
                            curr <= jr;
                        elsif (opcode = "01100") then
                            rID1 <= reg1_addr;
                            curr <= recv;
                        elsif (opcode = "01111") then
                            rID1 <= reg1_addr;
                            curr <= rpix;
                        elsif (opcode = "01110") then
                            rID1 <= reg1_addr;
                            curr <= wpix;
                        elsif (opcode = "01011") then
                            rID1 <= reg1_addr;
                            curr <= send_asip;
                        elsif( opcode ="00101"  ) then
                            curr <= mul; 
                        elsif( opcode = "00111") then 
                            curr <= div;
                        elsif( opcode  = "00001") then
                            curr <= sub;
                        else
                            curr <= calc;
                        end if;
                   
                    when Iops =>
                        wr_enR1 <= '0'; 
                       

                        rID1 <= reg1_addr;
                        rID2 <= reg2_addr;
                        imm <= instruction(16 downto 1);
                        curr <= Iops2;
                       
                    when Iops2 =>
                        reg1 <= regrD1;
                        reg2 <= regrD2;
                        if (instruction(29 downto 27) = "000") then
                            aluOp <= "1101";
                            curr <= equals;
                        elsif (instruction(29 downto 27) = "001") then
                            curr <= nequal;
                        elsif (instruction(29 downto 27) = "010") then
                            curr <= ori;
                        elsif (instruction(29 downto 27) = "011") then
                            aluOp <= "0000";
                            aluA <= regrD2; aluB <= imm;
                          
                            curr <= lw;
                        else
                            curr <= sw;
                        end if;
                   
                    when Jops =>
                        wr_enR1 <= '0'; 
                       
                   
                        if (instruction(31 downto 27) = "11000") then
                            pc <= imm;
                            rID1 <= "00001";
                            curr <= jmp;
                        elsif (instruction(31 downto 27) = "11001") then  
                            rID1 <= "00010";
                            curr <= jal;
                        else  
                            curr <= clrscr;
                        end if;
                        
                    when sub => 
                        aluOp <= "0001";
                        aluA <= reg2;
                        aluB <= reg3;
                        rID2 <= reg1_addr;
                        curr <= sub2;
                   
                    when sub2 => 
                        curr <= sub3; 
                        
                    when sub3 => 
                        reg1 <= aluResult;
                        curr <= store;
                   
                    when calc =>
                        aluOp <= "0000";
                        aluA <= reg2;
                        aluB <= reg3;
                        rID2 <= reg1_addr;
                        curr <= calc2;
                   
                    when calc2 =>
                        curr <= calc3;
                   
                    when calc3 =>
                        reg1 <= aluResult;
                        curr <= store;
                   
                    when jr =>
                    is_jr <= '1'; 
                    rID2 <= "00001";
                    PC <= regrD1; 
                     
                   
                    curr <= store;  
                    when recv =>
                        char_Rec <= charRec;
                       
                        if (newChar = '0') then
                            curr <= recv;
                        else
                            is_rec <= '1';
                            curr <= recv2;
                        end if;    
                       
                    when recv2 =>
                        reg1 <= "00000000" & charRec; 
                        curr <= store;
                   
                    when rpix =>
                    fbAddr1 <= reg2(11 downto 0); 
                    is_rpix <= '1';
                    
                    
                    
                    curr <= store; 
                    when wpix =>
                        fbAddr1 <= regrD1(11 downto 0);
                        fbWr_en <= '1';
                        fbDout1 <= reg2;
                        curr <= finish;
                   
                    when send_asip =>
--     
                        charSend <= regrD1(7 downto 0); 
                        curr <= send2;
                   
                    when send2 =>
                        send <= '1';
                        if (ready = '1') then
                            curr <= finish;
                        else
                            curr <= send_asip;
                        end if;
                   
                    when equals =>
--                      
                        if (reg1 = reg2) then
                            pc <= imm;
                            rID2 <= "00001";
                            is_equal <= '1';
                            curr <= store;
                        else
                            curr <= finish;
                        end if;
                   
                    when nequal=>
                    
                         if (reg1 /= reg2) then
                            pc <= imm;
                            rID2 <= "00001";
                            is_nequal <= '1';
                            curr <= store;
                        else
                            curr <= finish;
                        end if;
                   
                    when ori =>
                        aluOp <= "1001";
                        aluA <= reg2;
                        aluB <= imm;
                        curr <= ori2;
                       
                    when ori2 =>
                        rID2 <= reg1_addr;
                        curr <= ori3;
                       
                    when ori3 =>
                        reg1 <= aluResult;
                        curr <= store;
                                                             
                    when lw =>
                        curr <= lw2;
                   
                    when lw2 =>
                        dAddr <= aluResult(14 downto 0);
                        curr <= lw_wait;
                       
                    when lw_wait =>
                        data <= dIn; 
                        reg1 <= dIn;
                        is_lw <= '1';
                        curr <= store;
                       
                    when sw => 
                    
                    dAddr <= std_logic_vector(unsigned(reg2(14 downto 0)) + unsigned(imm(14 downto 0)));
                    
                    curr <= sw1;
                    when sw1 => 
                    is_sw <= '1'; 
                   
                    curr <= store; 
                    when jmp =>
                       
                        wr_enR1 <= '1';
                        regwD1 <= pc;
                        curr <= finish;
                   
                    when jal =>
                    wr_enR1 <= '1';
                    regwD1 <= PC; 
                    rID2 <= "00001";
                    
                    curr <= jal1;
                    when jal1 => 
                    is_jal <= '1'; 
                    PC <= imm; 
                    curr <= store; 
                    when clrscr =>
                    
                    fbRST <= '1'; 
                    
                    curr <= finish; 
                    when mul => 
                    aluOp <= "1000";
                    aluA <= reg2;
                    aluB <= reg3; 
                    rID2 <= reg1_addr; 
                    curr <= mul1; 
                    
                    when mul1 => 
                    curr <= mul2; 
                    
                    when mul2 => 
                    
                    curr <= mul3; 
                    when mul3 => 
                    
                    reg1 <= aluResult;
                    regwD2 <= reg1;
                    wr_enR2 <= '1';
                    
                    curr <= store; 
                    
                    when div => 
                    aluOp <= "1010";
                    aluA <= reg2;
                    aluB <= reg3; 
                    rID2 <= reg1_addr; 
                    
                    curr <= div1; 
                    when div1 => 
                    
                    curr <= div2; 
                    
                    when div2 => 
                    
                    curr <= div3; 
                    
                    when div3 => 
                    
                    reg1 <= aluResult;
                    regwD2 <= reg1;
                    wr_enR2 <= '1';
                    
                    curr <= store; 
                    when store =>
                   
                        if (is_lw = '1') then
--                            reg1 <= data;
                            regwD1 <= reg1;
                            wr_enR1 <= '1';
                            curr <= finish;
                        elsif(is_equal = '1') then
                            regwD2 <= pc;
                            wr_enR2 <= '1';
                            curr <= finish;
                        elsif( is_nequal = '1') then 
                            regwD2 <= pc;
                            wr_enR2 <= '1';
                            curr <= finish; 
                        elsif (is_rec = '1') then
                            regwD1 <= reg1;
                            wr_enR1 <= '1';
                            curr <= finish;
                            
                        elsif( is_rpix = '1') then 
                            regwD1 <= fbDin1;
                            wr_enR1 <= '1';
                            curr <= finish;
                        
                        elsif( is_sw = '1') then 
                             dOut <= regrD1;
                             wr_enR1 <= '1';
                             curr <= finish; 
                        elsif( is_jal = '1')then 
                            regwD2 <= PC;  
                            wr_enR2 <= '1';   
                            curr <= finish; 
                        elsif( is_jr = '1') then 
                            regwD2 <= PC;  
                            wr_enR2 <= '1';   
                            curr <= finish; 
                        else
                           
                            wr_enR2 <= '1';
                            regwD2 <= reg1;
                            curr <= finish;
                        end if;
                   
                    when finish =>
                        fbRST <= '0'; 
                        wr_enR1 <= '0';
                        wr_enR2 <= '0';
                        reg1_addr <= (others => '0');
                        reg1 <= (others => '0');
                        reg2_addr <= (others => '0');
                        reg2 <= (others => '0');
                        reg3_addr <= (others => '0');
                        reg3 <= (others => '0');
                        is_lw <= '0';
                        is_equal <= '0';
                        is_nequal <= '0'; 
                        is_rec <= '0';
                        is_rpix <= '0';
                        is_sw <= '0';
                        is_jal <= '0';
                        is_jr <= '0'; 
                        aluA <= (others => '0');
                        aluB <= (others => '0');
                        rID1 <= (others => '0');
                        rID2 <= (others => '0');
                        send <= '0';
                        curr <= fetch;
                   
                    when others =>
                        curr <= fetch;
               
                end case;
                   
            end if;
        end if;    
    end process;    

end Behavioral;
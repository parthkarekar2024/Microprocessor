--Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
--Date        : Sun May  5 23:30:46 2024
--Host        : ece18 running 64-bit Ubuntu 20.04.2 LTS
--Command     : generate_target ASIP_wrapper.bd
--Design      : ASIP_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ASIP_wrapper is
  port (
    CS : out STD_LOGIC;
    CTS : out STD_LOGIC;
    DC : out STD_LOGIC;
    RES : out STD_LOGIC;
    RTS : out STD_LOGIC;
    RXD : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    SDIN : out STD_LOGIC;
    TXD : in STD_LOGIC;
    VBAT : out STD_LOGIC;
    VDD : out STD_LOGIC;
    btn_0 : in STD_LOGIC;
    clk : in STD_LOGIC;
    sw_0 : in STD_LOGIC;
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_hs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_vs : out STD_LOGIC
  );
end ASIP_wrapper;

architecture STRUCTURE of ASIP_wrapper is
  component ASIP is
  port (
    clk : in STD_LOGIC;
    btn_0 : in STD_LOGIC;
    vga_hs : out STD_LOGIC;
    vga_vs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    TXD : in STD_LOGIC;
    RXD : out STD_LOGIC;
    CS : out STD_LOGIC;
    SDIN : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    DC : out STD_LOGIC;
    RES : out STD_LOGIC;
    VBAT : out STD_LOGIC;
    VDD : out STD_LOGIC;
    sw_0 : in STD_LOGIC;
    CTS : out STD_LOGIC;
    RTS : out STD_LOGIC
  );
  end component ASIP;
begin
ASIP_i: component ASIP
     port map (
      CS => CS,
      CTS => CTS,
      DC => DC,
      RES => RES,
      RTS => RTS,
      RXD => RXD,
      SCLK => SCLK,
      SDIN => SDIN,
      TXD => TXD,
      VBAT => VBAT,
      VDD => VDD,
      btn_0 => btn_0,
      clk => clk,
      sw_0 => sw_0,
      vga_b(4 downto 0) => vga_b(4 downto 0),
      vga_g(5 downto 0) => vga_g(5 downto 0),
      vga_hs => vga_hs,
      vga_r(4 downto 0) => vga_r(4 downto 0),
      vga_vs => vga_vs
    );
end STRUCTURE;

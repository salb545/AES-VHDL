library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity round is
    Port ( round_in  : in  STD_LOGIC_VECTOR (127 downto 0);
           keyin     : in  STD_LOGIC_VECTOR (127 downto 0);
			     keyout    : inout  STD_LOGIC_VECTOR (127 downto 0);
			     Rcon      : in STD_LOGIC_VECTOR (7 DOWNTO 0);
           round_out : out  STD_LOGIC_VECTOR (127 downto 0)
			  );
end round;

architecture Behavioral of round is
component addroundkey is
  port( addroundkey_in : in std_logic_vector(127 downto 0);
        Key       : in std_logic_vector(127 downto 0);
        addroundkey_out : out std_logic_vector(127 downto 0));
end component;

component subbytes is
port ( subbytes_in : in std_logic_vector (127 downto 0);
       subbytes_out : out std_logic_vector (127 downto 0));
end component;

component shiftrows is
    Port ( a : in  STD_LOGIC_VECTOR (127 downto 0);
           c : out  STD_LOGIC_VECTOR (127 downto 0));
end component;

component mixcolumn is
Port ( a : in  STD_LOGIC_VECTOR (127 downto 0);
       mixout : out  STD_LOGIC_VECTOR (127 downto 0));
end component;

component KeyExpansion is
    Port ( a  :in  STD_LOGIC_VECTOR (127 downto 0);
           Rcon  :  in  STD_LOGIC_VECTOR (7 downto 0);
           b  :  out  STD_LOGIC_VECTOR (127 downto 0));
end component;

signal subout,shiftout,mixcolout:std_logic_vector(127 downto 0);

begin

w1: KeyExpansion port map (keyin,Rcon,keyout);

w2:subbytes port map(round_in,subout);

w3:shiftrows  port map(subout,shiftout);

w4:mixcolumn port map(shiftout,mixcolout);

w5:addroundkey  port map(keyout,mixcolout,round_out);

end Behavioral;


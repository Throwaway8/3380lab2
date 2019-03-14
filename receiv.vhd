library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity receiv is
	port(se: in std_logic;
		  rx: in std_logic;
		  clk: in std_logic;
		  twobe: out std_logic;
		  m: out std_logic_vector(13 downto 0));
end receiv;

architecture char of receiv is
signal count: std_logic_vector(5 downto 0);
signal d: std_logic_vector(18 downto 0);
signal c: std_logic_vector(4 downto 0);
signal c2: std_logic;
signal state: std_logic_vector(1 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			case state is
				when "00" => 
					if rx = '0' then	
						state <= "00";
					elsif rx <= '1' then
						state <= "01";
					end if;
				when "01" =>
					if count <= "10010" then
						d(18) <= se;
						d(17 downto 0) <= d(18 downto 1);
						count <= count + 1;
						state <= "01";
					elsif count > "10010" then
						state <= "10";
					end if;
				when "10" =>
					c(0) <= d(0) xor d(2) xor d(4) xor d(6) xor d(8) xor d(10) xor d(12) xor d(14) xor d(16) xor d(18);
					c(1) <= d(1) xor d(2) xor d(5) xor d(6) xor d(9) xor d(10) xor d(13) xor d(14) xor d(17) xor d(18);
					C(2) <= d(3) xor d(4) xor d(5) xor d(6) xor d(11) xor d(12) xor d(13) xor d(14);
					c(3) <= d(7) xor d(8) xor d(9) xor d(10) xor d(11) xor d(12) xor d(13) xor d(14);
					c(4) <= d(15) xor d(16) xor d(17) xor d(18);
					if c = "00000" then 
						m(0) <= d(2);
						m(1) <= d(4);
						m(2) <= d(5);
						m(3) <= d(6);
						m(4) <= d(8);
						m(5) <= d(9);
						m(6) <= d(10);
						m(7) <= d(11);
						m(8) <= d(12);
						m(9) <= d(13);
						m(10) <= d(14);
						m(11) <= d(16);
						m(12) <= d(17);
						m(13) <= d(18);
						twobe <= '0';
					elsif c > "10010" then
						twobe <= '1';
						m(13 downto 0) <= "00000000000000";
					elsif c > "00000" and c <= "10010" then 
						c2 <= c(0) xor c(1) xor c(2) xor c(3) xor c(4);
						m(0) <= d(2) xor c2;
						m(1) <= d(4) xor c2;
						m(2) <= d(5) xor c2;
						m(3) <= d(6) xor c2;
						m(4) <= d(8) xor c2;
						m(5) <= d(9) xor c2;
						m(6) <= d(10) xor c2;
						m(7) <= d(11) xor c2;
						m(8) <= d(12) xor c2;
						m(9) <= d(13) xor c2;
						m(10) <= d(14) xor c2;
						m(11) <= d(16) xor c2;
						m(12) <= d(17) xor c2;
						m(13) <= d(18) xor c2;
					end if;
					state <= "11";
				when "11" =>
					state <= "00";
			end case;
		end if;
	end process;
end char;	
					
					
					
					
					
						
			
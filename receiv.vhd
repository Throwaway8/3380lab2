library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
	
	entity receiv is
		port(s: in std_logic;
			  rx: in std_logic;
			  clk: in std_logic;
			  twobe: out std_logic;
			  m: out std_logic_vector(13 downto 0));
	end receiv;
architecture char of receiv is

signal state: integer range 0 to 3;
signal m2: std_logic_vector(18 downto 0);
signal c: std_logic_vector(4 downto 0);
signal count: integer range 0 to 19;
signal p:  std_logic;
signal c2: std_logic;
begin
	process(clk, count, rx)
	begin
		if rising_edge(clk) then
		state <= 0;
		count <= 0;
			case state is 
				when 0 =>
					if rx = '0' and count = 0 then
						twobe <= '0';
						state <= 0;
					elsif rx = '1' and count = 0 then	
						twobe <= '0';
						state <= 1;
					end if;
				
				when 1 =>
					if rx = '1' and count <= 19 then
						twobe <= '0';
						m2(18) <= s;
						m2(17 downto 0) <= m2(18 downto 1);
						count <= count + 1;
						state <= 1;
					elsif rx = '1' and count > 19 then
						twobe <= '0';
						state <= 2;
					end if;
				
				when 2 => 
					if rx = '0' and count > 19 then
						twobe <= '0';
						c(0) <= m2(0) xor m2(2) xor m2(4) xor m2(6) xor m2(8) xor m2(10) xor m2(12) xor m2(14) xor m2(16) xor m2(18);
						c(1) <= m2(1) xor m2(2) xor m2(5) xor m2(6) xor m2(9) xor m2(10) xor m2(13) xor m2(14) xor m2(17) xor m2(18);
						c(2) <= m2(3) xor m2(4) xor m2(5) xor m2(6) xor m2(11) xor m2(12) xor m2(13) xor m2(14);
						c(3) <= m2(7) xor m2(8) xor m2(9) xor m2(10) xor m2(11) xor m2(12) xor m2(13) xor m2(14);
						c(4) <= m2(15) xor m2(16) xor m2(17) xor m2(18);
						p <= m2(0) xor m2(1) xor m2(2) xor m2(3) xor m2(4) xor m2(5) xor m2(6) xor m2(7) xor m2(8) xor m2(9) xor m2(10) xor m2(11) xor m2(12) xor m2(13) xor m2(14) xor m2(15) xor m2(16) xor m2(18);
						c2 <= m2(0) xor m2(1) xor m2(2) xor m2(3) xor m2(4) xor m2(5) xor m2(6) xor m2(7) xor m2(8) xor m2(9) xor m2(10) xor m2(11) xor m2(12) xor m2(13) xor m2(14) xor m2(15) xor m2(16) xor m2(18) xor p;
						state <= 3;
					end if;
						
				when 3 => 
					if c = "00000" then	
						m(0) <= m2(2);
						m(1) <= m2(4);
						m(2) <= m2(5);
						m(3) <= m2(6);
						m(4) <= m2(8);
						m(5) <= m2(9);
						m(6) <= m2(10);
						m(7) <= m2(11);
						m(8) <= m2(12);
						m(9) <= m2(13);
						m(10) <= m2(14);
						m(11) <= m2(16);
						m(12) <= m2(17);
						m(13) <= m2(18);
						state <= 0;
					elsif c > "00000" and c2 = '1' then
						if c = "00001" then
							m(0) <= not m2(2);
						elsif c /= "00001"then
							m(0) <= m2(2);
						
						
						elsif c = "00010" then
							m(1) <= not m2(4);
						elsif c /= "00010" then
							m(1) <= m2(4);
						
						
						elsif c = "00011" then
							m(2) <= not m2(5);
						elsif c = "00011" then
							m(2) <= m2(5);
					
						
						elsif c = "00100" then
							m(3) <= not m2(6);
						elsif c /= "00100" then
							m(3) <= m2(6);
					
						
						elsif c = "00101" then
							m(4) <= not m2(8);
						elsif c = "00101" then
							m(4) <= m2(8);
						
							
						elsif c = "00110" then
							m(5) <= not m2(9);
						elsif c /= "00110" then
							m(5) <= m2(9);
						
						elsif c = "00111" then
							m(6) <= not m2(10);
						elsif c /= "00111" then
							m(6) <= not m2(10);
					
						
						elsif c = "01000" then 
							m(7) <= not m2(11);
						elsif c /= "01000" then 
							m(7) <= m2(11);
					
						
						elsif c = "01001" then
							m(8) <= not m2(12);
						elsif c /= "01001" then
							m(8) <= m2(12);
			
						
						elsif c = "01010" then
							m(9) <= not m2(13);
						elsif c /= "01010" then
							m(9) <= m2(13);
					
						
						elsif c = "01011" then
							m(10) <= not m2(14);
						elsif c /= "01011" then
							m(10) <= m2(14);
				
						
						elsif c = "01100" then
							m(11) <= not m2(16);
						elsif c /= "01100" then
							m(11) <= m2(16);
						
						
						elsif c = "01101" then
							m(12) <= not m2(17);
						elsif c /= "01101" then
							m(12) <= m2(17);
						
					
						elsif c = "01110" then
							m(13) <= not m2(18);
						elsif c /= "01110" then
							m(13) <= m2(18);
						
							state <= 0;
						end if;
					elsif c > "00000" and c2 = '0' then
						twobe <= '1';
						m <= "00000000000000";
						state <= 0;
					end if;
				
			end case;
		end if;
	end process;
end char;	
					
					
					
					
					
						
			

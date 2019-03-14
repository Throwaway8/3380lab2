library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity trans is
	port(ld: in std_logic;
		  m: in std_logic_vector(13 downto 0);
		  clk: in std_logic;
		  s: out std_logic;
		  tx: out std_logic);
end trans;

architecture char of trans is

signal state: std_logic_vector(1 downto 0) := "00";
signal count: std_logic_vector(4 downto 0) := "00000";

signal m2: std_logic_vector(18 downto 0);

begin

	
	process(clk, ld, count)
	begin

		if rising_edge(clk) then
			case state is 
				when "00" => 
					if ld = '1' and count = "00000" then
						m2(0) <= m(0) xor m(1) xor m(3) xor m(4) xor m(6) xor m(8) xor m(10) xor m(11) xor m(13);
						m2(1) <= m(0) xor m(2) xor m(3) xor m(5) xor m(6) xor m(9) xor m(10) xor m(12) xor m(13);
						m2(2) <= m(0);
						m2(3) <= m(1) xor m(2) xor m(3) xor m(7) xor m(8) xor m(9) xor m(10);
						m2(4) <= m(1);
						m2(5) <= m(2);
						m2(6) <= m(3);
						m2(7) <= m(4) xor m(5) xor m(6) xor m(7) xor m(8) xor m(9) xor m(10);
						m2(8) <= m(4);
						m2(9) <= m(5);
						m2(10) <= m(6);
						m2(11) <= m(7);
						m2(12) <= m(8);
						m2(13) <= m(9);
						m2(14) <= m(10);
						m2(15) <= m(11) xor m(12) xor m(13);
						m2(16) <= m(11);
						m2(17) <= m(12);
						m2(18) <= m(13);
						tx <= '0';
						end if;
						state <= "01";
						count <= "00000";
				when "01" => 
					if ld = '0' and count = "00000" then
						tx <= '1';
						count <= "00001";
					end if;
					state <= "10";
				when "10" =>
					if ld = '0' and count = "00001" then
						s <= m2(18);
						m2(18 downto 0) <= m2(17 downto 0) & '0';
						count <= count + 1;
						tx <= '1';
					end if;
						state <= "11";
				when "11" =>
					if ld = '0' and count <= "10010" then
						s <= m2(18);
						m2(18 downto 0) <= m2(17 downto 0) & '0';
						tx <= '1';
						count <= count + 1;
						state <= "11";
					elsif ld = '0' and count > "10010" then
						tx <= '0';
						state <= "00";
					end if;
				end case;
		end if;
	end process;
end char;
					
					

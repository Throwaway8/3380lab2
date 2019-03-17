library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity trans is
	port(load: in std_logic;
		  m: in std_logic_vector(13 downto 0);
		  clk: in std_logic;
		  s: out std_logic;
		  tx: out std_logic);
end trans;

architecture char of trans is

signal state: integer range 0 to 2;
signal count: integer range 0 to 20;

signal m2: std_logic_vector(19 downto 0);

begin

	
	process(clk, load, count)
	begin
	
		if rising_edge(clk) then
		state <= 0;
		count <= 0;
		
			case state is 
				when  0 =>
					if load = '0' then
						s <= '0';
						tx <= '0';
						state <= 0 after 1000000000 ns;
					elsif load = '1'then
							tx <= '0';
							m2(0) <= m(2) xor m(4) xor m(6) xor m(8) xor m(10) xor m(12);
							m2(1) <= m(2) xor m(5) xor m(6) xor m(9) xor m(10) xor m(13);
							m2(2) <= m(0);
							m2(3) <= m(4) xor m(5) xor m(6) xor m(11) xor m(12) xor m(13);
							m2(4) <= m(1);
							m2(5) <= m(2);
							m2(6) <= m(3);
							m2(7) <= m(8) xor m(9) xor m(10) xor m(11) xor m(12) xor m(13);
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
							m2(19) <= m2(0) xor m2(1) xor m2(2) xor m2(3) xor m2(4) xor m2(5) xor m2(6) xor m2(7) xor m2(8) xor m2(9)
							xor m2(10) xor m2(11) xor m2(12) xor m2(13) xor m2(14) xor m2(15) xor m2(16) xor m2(17) xor m2(18) xor m2(19);
							state <= 1 after 1000000000 ns;
					end if;
				
				when 1 =>
					if load = '1' then 
						tx <= '0';
						state <= 1 after 1000000000 ns;
					elsif load = '0' then
						tx <= '1';
						state <= 2 after 1000000000 ns;
					end if;
				
				when 2 =>
					if load = '0' and count <= 20 then
						tx <= '1';
						s <= m2(19);
						m2(19 downto 0) <= m2(18 downto 0) & '0';
						count <= count + 1;
						state <= 2 after 1000000000 ns;
					elsif load = '0' and count > 20 then
						tx <= '0';
						state <= 0 after 1000000000 ns;
					end if;
				end case;
		end if;
	end process;
end char;
					
					

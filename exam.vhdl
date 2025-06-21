library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fsm_machine is 
port (
     x , clk , reset : IN std_logic ;
     y : out std_logic   
     ) ;
     end fsm_machine ;
architecture data of fsm_machine is 

type state is (A,B,C,D) ;
signal present_state , next_state : state ;

begin 

process ( clk , reset )
begin 
if (reset = '0') then present_state <= A ;
elsif (rising_edge(clk)) then present_state <= next_state ;
end if ; 
end process ;

process (x,present_state ) 
begin 
case present_state is 
when A => 
 if (x='1') then next_state <= D ; y <= '0' ;
 else next_state <= A ; y <= '0' ;
 end if ;

when B => 
 if (x='1') then next_state <= B ; y <= '0' ;
 else next_state <= A ; y <= '1' ;
 end if ;
 
 when C => 
 if (x='1') then next_state <= B ; y <= '0' ;
 else next_state <= A ; y <= '1' ;
 end if ;

 when D => 
 if (x='1') then next_state <= C ; y <= '0' ;
 else next_state <= A ; y <= '1' ;
 end if ;
 end case ;

end process ;

end data ;     
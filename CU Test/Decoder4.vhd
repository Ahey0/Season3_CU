library Ieee;
use ieee.std_logic_1164.all;
Entity Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
End Entity;
Architecture Decoder4_behave of Decoder4 is
signal  o1 : std_logic_vector(15 downto 0):="0000000000000001";
Begin
 process ( sel , o1 )
   begin
     case sel is
          when "0000" =>
               o1<="0000000000000001" ;
          when "0001" =>
               o1<="0000000000000010" ;
          when "0010" =>
               o1<="0000000000000100" ;
          when "0011" =>
               o1<="0000000000001000" ;
          when "0100" =>
               o1<="0000000000010000" ;
          when "0101" =>
               o1<="0000000000100000" ;
          when "0110" =>      
               o1<="0000000001000000" ;
          when "0111" =>
               o1<="0000000010000000" ;
          when "1000" =>
               o1<="0000000100000000" ;
          when "1001" =>   
               o1<="0000001000000000" ;
          when "1010" =>
               o1<="0000010000000000" ;
          when "1011" =>
               o1<="0000100000000000" ;
          when "1100" =>
               o1<="0001000000000000" ;
          when "1101" =>
               o1<="0010000000000000" ;
          when "1110" =>
               o1<="0100000000000000" ;
          when others =>
               o1<="1000000000000000" ;
     end case;
end process;
o<=o1;
End Architecture;
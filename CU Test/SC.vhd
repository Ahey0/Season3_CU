library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     En    : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
End Entity;
Architecture SC_behave of SC is
Signal S_SCout : std_logic_vector(3 downto 0):="0000" ;
Begin
Process(clk)
variable  SS_SCout : std_logic_vector(3 downto 0):="0000" ;
    Begin
         if clk'event and clk='1' then
            if EN='1' then
             if clear='1' then
                S_SCout <= "0000" ;
                SS_SCout:= "0000" ;
             else
                S_SCout  <=  SS_SCout    ;
                SS_SCout :=  SS_SCout + "0001" ;
             end if;
            elsif EN='0' then
                S_SCout <= "0000" ;
                SS_SCout:= "0000" ;
            End if;
         end if;
	end process;
SCout<= S_SCout;
End Architecture;
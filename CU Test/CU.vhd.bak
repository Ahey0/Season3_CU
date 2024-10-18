library Ieee;
use ieee.std_logic_1164.all;
Entity Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0) ;
      o   : out std_logic_vector(7 downto 0) 
      );
End Entity;
Architecture Decoder3_behave of Decoder3 is
Begin
    o<=
       "00000001" when sel="000" else
       "00000010" when sel="001" else
       "00000100" when sel="010" else
       "00001000" when sel="011" else
       "00010000" when sel="100" else
       "00100000" when sel="101" else
       "01000000" when sel="110" else
       "10000000" when sel="111"       ;
End Architecture;
-------------------------------------------------------------
library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity CU_16 is
 port(
      inir     : in    std_logic_vector(15 downto 0) ;
      DR0      : in    std_logic                     ;
      AC15     : in    std_logic                     ;
      T0,T1    : in    std_logic                     ;
      T2,T3    : in    std_logic                     ; 
      T4,T5,T6 : in    std_logic                     ;
      FGIin    : in    std_logic                     ;
      FGOin    : in    std_logic                     ;
      FGIout   : out   std_logic                     ;
      FGOout   : out   std_logic                     ;
      ALUsel   : out   std_logic_vector(2 downto 0)  ;
      laodar   : out   std_logic                     ;
      loadpc   : out   std_logic                     ;
      laoddr   : out   std_logic                     ;
      loadac   : out   std_logic                     ;
      laodir   : out   std_logic                     ;
      loadtr   : out   std_logic                     ;
      loadoutr : out   std_logic                     ;
      w        : out   std_logic                     ;
      r        : out   std_logic                     ;
      clearar  : out   std_logic                     ;
      clearpc  : out   std_logic                     ;
      clearac  : out   std_logic                     ;
      incrar   : out   std_logic                     ;
      incrpc   : out   std_logic                     ;
      incrdr   : out   std_logic                     ;
      incrac   : out   std_logic                     ;
      clearsc  : out   std_logic                     ;
      selb     : out   std_logic_vector(2 downto 0)  ;
      Rin      : in    std_logic                     ;
      IENin    : in    std_logic                     ;
      Rout     : out   std_logic                     ;
      Ein      : in    std_logic                     ;
      loadE    : out   std_logic                     ;
      NotE     : out   std_logic                     ;
      clearE   : out   std_logic                     ;
      AC0      : in    std_logic                     ;
      IENo,So  : out   std_logic                    
      );
End Entity;
Architecture CU_16_behave of CU_16 is
component Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0 ) ;
      o   : out std_logic_vector(7 downto 0 ) 
      );
End component;
signal I,rs  : std_logic                       ;
signal OPC   : std_logic_vector( 2 downto 0 )  ;
signal B     : std_logic_vector(11 downto 0 )  ;
signal R_s ,p: std_logic                       ;
signal D     : std_logic_vector( 7 downto 0 )  ;
Begin
I     <= inir(15)                  ;
OPC   <= inir(14 downto 12)        ;
B     <= inir(11 downto 0)         ;
U1: Decoder3 port map(OPC,D)       ;
R_s   <= D(7) and (Not I ) and T3  ;
p     <= D(7) and      I   and T3  ;    
      laodar   <=
           ((Not Rin) and T0) or ((Not Rin) and T2) or ((Not D(7)) and I and T3);
      loadpc   <=
           (D(4) and T4) or (D(5) and T5)                                       ;
      laoddr   <=
           (D(0) and T4) or (D(1) and T4) or (D(2) and T4) or (D(6) and T4)     ;
      loadac   <=
           (D(0) and T5) or (D(1) and T5) or (D(2) and T5) or (R_s and B(9)) or  
           (R_s and B(7))or (R_s and B(6))or (p and B(11))                      ;
      laodir   <=
             (Not Rin) and T1                                                   ;
      loadtr   <=
                  Rin  and T0                                                   ;
      loadoutr <=
                   p   and B(10)                                                ;
      w        <=
           (Rin and T1) or (D(3) and T4) or (D(5) and T4) or (D(6) and T6)      ;
      r        <=
           ((Not Rin) and T1) or ((Not D(7)) and I and T3)or (D(0) and T4) or 
           (D(1) and T4) or (D(2) and T4) or (D(6) and T4)                      ;  
      clearar  <=
                  Rin and T0                                                    ;
      clearpc  <=
                  Rin  and T1                                                   ;
      clearac  <= 
                  R_s and B(11)                                                 ;                  
      incrar   <=
                 D(5) and T5                                                    ;
      incrpc   <=
            ((Not Rin) and T1) or (Rin and T2) or (D(6) and T6 and DR0) or 
            (R_s and B(4) and (Not AC15) ) or (R_s and B(3) and AC15 ) or
            (R_s and B(2) and AC0 ) or (R_s and B(1) and (Not Ein)) or
            (p and B(9) and FGIin) or (p and B(8) and FGOin)                    ;   
      incrdr   <=
               D(6) and T5                                                      ;
      incrac   <=
                  R_s and B(5)                                                  ;
      rs       <=
           ((Not Rin) and T1) or ((Not D(7)) and I and T3)or (D(0) and T4) or 
           (D(1) and T4) or (D(2) and T4) or (D(6) and T4)                      ;
      selb     <=
                 "001" when (D(4) and T4)='1' or (D(5) and T5)='1'                   else
                 "010" when (((Not Rin) and T0) or (Rin and T0) or(D(5) and T4))='1' else
                 "011" when ((D(2) and T5) or (D(6) and T6))='1'                     else
                 "100" when (D(3) and T4)='1' or (p and B(10))='1'                   else
                 "101" when (((Not Rin) and T2))='1'                                 else
                 "110" when ( Rin and T2)='1'                                        else
                 "111" when rs='1'                                                   else
                 "000"                                                                   ;
      clearsc  <=
            (Rin  and T2) or (D(0) and T5) or (D(1) and T5) or (D(2) and T5) or
            (D(3) and T4) or (D(4) and T4) or (D(5) and T5) or (D(6) and T6) or
             p or R_s                                                           ;         
      FGIout   <=
                  (Not  (p and B(9)))                                           ;
      FGOout   <=
                  ( Not  (p and B(8)))                                          ;
      loadE    <=
                   (D(1) and T3) or (R_s and B(7)) or (R_s and B(6))            ;
      NOTE     <=
                    R_s and B(8)                                                ;
      clearE   <=
                    R_s and B(10)                                               ;
      IENo     <= 
                   '0' when (Rin and T2)='1' or (p and B(6))='1'   else 
                   '1' when (p and B(7))='1' else                                    
                   '0'                                                          ;
      So       <=
                   '0' when (Rin and B(0))='1' else
                   '1'                                                          ;                                  
      Rout     <=
                   '0' when (Rin and T2)='1' else
                   '1' when ((Not(T0)) and (Not(T1)) and (Not(T2)) and
                             (FGIin or FGOin) and IENin)='1'                   ;
      ALUsel   <=  "000" when (p     and B(11))='1' else
                   "001" when (D(1)  and T5   )='1' else
                   "010" when (D(0)  and T5   )='1' else 
                   "011" when (D(2)  and T5   )='1' else
                   "100" when (R_S and B(9)   )='1' else
                   "101" when (R_S and B(7)   )='1' else
                   "111" when (R_S and B(6)   )='1' else
                   "110"                                 ;
End Architecture ;
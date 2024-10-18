Library Ieee;
Use Ieee.std_logic_1164.All;
Use Ieee.Std_logic_Arith.All;
Entity CU_Test is
      Port(
		      Inp           :  IN   Std_Logic_Vector(7 Downto 0);
				HOL           :  IN   Std_Logic                   ;
				Table_Switch  :  IN   Std_Logic                   ;
				ClkUser       :  IN   Std_Logic                   ;
				Clk           :  IN   Std_Logic                   ;
				ClearTime     :  IN   Std_Logic                   ;
				Dig1          :  OUT  STD_Logic_Vector(6 downto 0);
				Dig2          :  OUT  STD_Logic_Vector(6 downto 0);
				Dig3 	  		  :  OUT  STD_Logic_Vector(6 downto 0);
				Dig4          :  OUT  STD_Logic_Vector(6 downto 0);
				Dig5          :  OUT  STD_Logic_Vector(6 downto 0);
				DigT          :  OUT  STD_Logic_Vector(6 downto 0);
				Table_Led     :  OUT  STD_Logic_Vector(1 Downto 0)
				);
End Entity;
Architecture CU_Test_Behave Of CU_Test Is 
Component SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     En    : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
END Component;
Component IR_16 is
port(
     inir  : in   std_logic_vector(15 downto 0);
	  outir : out  std_logic_vector(15 downto 0);
	  clk   : in   std_logic                    ;
	  load  : in   std_logic                     
	  );
End Component;
Component Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0) ;
      o   : out std_logic_vector(7 downto 0) 
      );
End Component;
Component  Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
End Component;
Component CONVERTER is
port(
     INS    : in  std_logic_vector(15 downto 0)  ;
	  datadig1 : out integer  range 0 to 9          ;
	  datadig2 : out integer  range 0 to 9          ;
	  datadig3 : out integer  range 0 to 9          ;
	  datadig4 : out integer  range 0 to 9          ;
	  datadig5 : out integer  range 0 to 9          
	  ); 
END Component;
Component Disp_CA is
  Port(
       datadig1 : in  integer  range 0 to 9          ;
       datadig2 : in  integer  range 0 to 9          ;
       datadig3 : in  integer  range 0 to 9          ;
    	 datadig4 : in  integer  range 0 to 9          ;
       datadig5 : in  integer  range 0 to 9          ;
       Clk      : in  std_logic                      ;
       dig1     : out std_logic_vector(6 downto 0)   ;
       dig2     : out std_logic_vector(6 downto 0)   ;
    	 dig3     : out std_logic_vector(6 downto 0)   ;
       dig4     : out std_logic_vector(6 downto 0)   ;
       dig5     : out std_logic_vector(6 downto 0)   
       );  
End Component;
Component CU_16 is
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
End Component ;
component Clock_controll_50MHZ_T_50HZ is 
  port(
        clkin   : in  std_logic     ;
        EN      : in  std_logic     ;
        reset   : in  std_logic     ;
        clkout  : out std_logic     
       );
End Component;
Signal     IR_Data_L :  std_logic_vector(7  downto 0)  ;--Lower  8-BIt Data Of IR
Signal     IR_Data_H :  std_logic_vector(7  downto 0)  ;--Higher 8-BIt Data Of IR
Signal     IR_Data_IN:  std_logic_vector(15 downto 0)  ;--In  : Data Of IR
Signal     IR_Data_O :  std_logic_vector(15 downto 0)  ;--Out : Data Of IR
Signal     SC_O      :  std_logic_vector(3  downto 0)  ;--SC OUT 
Signal     SC_Decoded:  std_logic_vector(6  downto 0)  ;--Decoded data of SC 
Signal     SC_15     :  std_logic_vector(15 downto 0)  ;--Decoded data of SC in 16 bit for segment
Signal	  datadig11 :  integer  range 0 to 9          ;--Converted Dig1 for Table1
Signal	  datadig21 :  integer  range 0 to 9          ;--Converted Dig2 for Table1
Signal	  datadig31 :  integer  range 0 to 9          ;--Converted Dig3 for Table1
Signal	  datadig41 :  integer  range 0 to 9          ;--Converted Dig4 for Table1
Signal	  datadig51 :  integer  range 0 to 9          ;--Converted Dig5 for Table1
Signal	  datadig12 :  integer  range 0 to 9          ;--Converted Dig1 for Table2
Signal	  datadig22 :  integer  range 0 to 9          ;--Converted Dig2 for Table2
Signal	  datadig32 :  integer  range 0 to 9          ;--Converted Dig3 for Table2
Signal	  datadig42 :  integer  range 0 to 9          ;--Converted Dig4 for Table2
Signal	  datadig52 :  integer  range 0 to 9          ;--Converted Dig5 for Table2
Signal     DIG_S11   :  std_logic_vector(6  downto 0)  ;--Segment Digit1 Data From Table1
Signal     DIG_S21   :  std_logic_vector(6  downto 0)  ;--Segment Digit2 Data From Table1
Signal     DIG_S31   :  std_logic_vector(6  downto 0)  ;--Segment Digit3 Data From Table1
Signal     DIG_S41   :  std_logic_vector(6  downto 0)  ;--Segment Digit4 Data From Table1
Signal     DIG_S51   :  std_logic_vector(6  downto 0)  ;--Segment Digit5 Data From Table1
Signal     DIG_S12   :  std_logic_vector(6  downto 0)  ;--Segment Digit1 Data From Table2
Signal     DIG_S22   :  std_logic_vector(6  downto 0)  ;--Segment Digit2 Data From Table2
Signal     DIG_S32   :  std_logic_vector(6  downto 0)  ;--Segment Digit3 Data From Table2
Signal     DIG_S42   :  std_logic_vector(6  downto 0)  ;--Segment Digit4 Data From Table2
Signal     DIG_S52   :  std_logic_vector(6  downto 0)  ;--Segment Digit5 Data From Table2
Signal     Table1    :  std_logic_vector(15 downto 0)  ;--Data Of Table 1
Signal     Table2    :  std_logic_vector(15 downto 0)  ;--Data Of Table 2
Signal     Clk0      :  Std_Logic                      ;--Controlled Clk
Signal     CLKUser_N :  Std_Logic                      ;--CLK Of User Inverted
Signal     Clear     :  Std_Logic                      ;--Clear of User Inverted
Signal     Zero      :  Std_Logic:='0'                 ;--Zero Data
--Controller data to assign to Table 1 & 2
Signal     FGIout    :  Std_logic                      ;
Signal     FGOout    :  Std_logic                      ;
Signal     ALUsel    :  Std_logic_vector(2 downto 0)   ;
Signal     laodar    :  Std_logic                      ;
Signal     loadpc    :  Std_logic                      ;
Signal     laoddr    :  Std_logic                      ;
Signal     loadac    :  Std_logic                      ;
Signal     laodir    :  Std_logic                      ;
Signal     loadtr    :  Std_logic                      ;
Signal     loadoutr  :  Std_logic                      ;
Signal     w         :  Std_logic                      ;
Signal     r         :  Std_logic                      ;
Signal     clearar   :  Std_logic                      ;
Signal     clearpc   :  Std_logic                      ;
Signal     clearac   :  Std_logic                      ;
Signal     incrar    :  Std_logic                      ;
Signal     incrpc    :  Std_logic                      ;
Signal     incrdr    :  Std_logic                      ;
Signal     incrac    :  Std_logic                      ;
Signal     clearsc   :  Std_logic                      ;
Signal     selb      :  Std_logic_vector(2 downto 0)   ;
Signal     Rout      :  Std_logic                      ;
Signal     loadE     :  Std_logic                      ;
Signal     NotE      :  Std_logic                      ;
Signal     clearE    :  Std_logic                      ;
Signal     IENo,So   :  Std_logic                      ;
Begin

CC  : Clock_controll_50MHZ_T_50HZ Port Map (Clk,'1','0',Clk0);

CLKUser_N <= Not CLKUser     ;
Clear     <= Not ClearTime   ;
     Process (Clk0)
            Begin 
				     If clk0'event And Clk0='1' Then 
					     If    HOL='0' Then 
						     IR_Data_L  <=  Inp ;
						  Elsif HOL='1' Then 
						      IR_Data_H <=  Inp ;
						  End If;
					  End If;
		End Process;
			    IR_Data_IN <= IR_Data_H & IR_Data_L ;
--IR1 : IR_16     Port Map (IR_Data_IN,IR_Data_O,Clk,'1');
SC1 : SC        Port Map (CLKUser_N,Clear,'1',SC_O);
DEC : Decoder4  Port Map (SC_O,SC_15);
SC_Decoded <= SC_15(6 downto 0);

--CU1 : CU_16     Port Map (IR_Data_O,'0','0',SC_Decoded(0),SC_Decoded(1),SC_Decoded(2),SC_Decoded(3)
--                         ,SC_Decoded(4),SC_Decoded(5),SC_Decoded(6),'0','0',Table2(13),Table2(12),
--								  Table2(0 to 2),Table1(15),Table1(14),Table1(13),Table1(12),Table1(11),Table1(10)
--								  ,Table1(9),Table2(14),Table1(0),Table1(8),Table1(7),Table1(6),Table1(4),Table1(3)
--								  Table1(2),Table1(1),Table1(5),Table2(3 to 5),'0','0',Table2(11),'0',
--								  Table2(10),Table2(9),Table2(8),'0',Table2(7),Table2(6));
CU1 : CU_16     Port Map(IR_Data_IN,Zero,Zero,SC_Decoded(0),SC_Decoded(1),SC_Decoded(2),SC_Decoded(3)
                         ,SC_Decoded(4),SC_Decoded(5),SC_Decoded(6),Zero,Zero,FGIout,FGOout,ALUsel,
								 laodar,loadpc,laoddr,loadac,laodir,loadtr,loadoutr,w,r,clearar,clearpc,clearac,
                         incrar,incrpc,incrdr,incrac,clearsc,selb,Zero,Zero,Rout,Zero,loadE,NotE,clearE,Zero,IENo,So);
								 
								 
                 Table1  <= laodar  & loadpc  & laoddr  & loadac  & laodir & loadtr & loadoutr &
					             clearar & clearpc & clearac & Clearsc & incrar & incrpc & incrdr   & incrac & r ;
									 
									 
                 Table2 <=  Zero & w & FGIout & FGOout & Rout & LoadE & NotE & clearE &  IENo & So & 
					             Selb(0)  & Selb(1)  & Selb(2)  & ALUsel(0) & ALUsel(1) & ALUsel(2)  ;					
CON1 : CONVERTER Port Map (Table1,datadig11,datadig21,datadig31,datadig41,datadig51);--For Table1
CON2 : CONVERTER Port Map (Table2,datadig12,datadig22,datadig32,datadig42,datadig52);--For Table2
DIS1 : Disp_CA   Port Map (datadig11,datadig21,datadig31,datadig41,datadig51,Clk0,DIG_S11,DIG_S21,DIG_S31,DIG_S41,DIG_S51);--For Table1
DIS2 : Disp_CA   Port Map (datadig12,datadig22,datadig32,datadig42,datadig52,Clk0,DIG_S12,DIG_S22,DIG_S32,DIG_S42,DIG_S52);--For Table2
      
		Process(Table_Switch,DIG_S11,DIG_S21,DIG_S31,DIG_S41,DIG_S51,DIG_S12,DIG_S22,DIG_S32,DIG_S42,DIG_S52)
		        Begin
		       If Table_Switch='0' Then 
	              Dig1      <=  DIG_S11  ;			 
					  Dig2      <=  DIG_S21  ;
					  Dig3      <=  DIG_S31  ;
					  Dig4      <=  DIG_S41  ;
					  Dig5      <=  DIG_S51  ;
					  Table_Led <= "01"      ;
				 Elsif Table_Switch='1' Then 
	              Dig1      <=  DIG_S12  ;			 
					  Dig2      <=  DIG_S22  ;
					  Dig3      <=  DIG_S32  ;
					  Dig4      <=  DIG_S42  ;
					  Dig5      <=  DIG_S52  ;
					  Table_Led <= "10"      ;
				 End If;
		End Process;


      Process(SC_Decoded,Clk0)
		    Begin
             If Clk0'Event And Clk0='1' Then
		          Case SC_Decoded is
			            When "0000001" =>
				             digT <=Not "0111111" ;
			            when "0000010" => 
                         digT <=Not "0000110" ;
			            when "0000100" =>
	                    digT   <=Not "1011011" ;
		               when "0001000" =>
	                    digT   <=Not "1001111" ;
		               when "0010000" =>
	                    digT   <=Not "1100110" ;
	     	  	         when "0100000" =>
                       digT   <=Not "1101101" ;
                     when "1000000" =>
         	           digT   <=Not "1111101" ;
							When Others =>
							  DigT   <=Not "0111111" ;
					End Case;
				End If;
		End Process;
End Architecture;
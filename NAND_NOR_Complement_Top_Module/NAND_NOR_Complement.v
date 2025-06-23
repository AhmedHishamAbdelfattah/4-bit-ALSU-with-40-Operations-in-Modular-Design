module NAND_NOR_Complement (
  input [3:0] A , B , 
  output [3:0] Out_1 , Out_2 , Out_3 , Out_4  
);
  
  assign Out_1 = ~( A & B ) ;
  assign Out_2 = ~( A | B ) ;
  assign Out_3 = ~( A ) ;
  assign Out_4 = ~( B ) ;
  
endmodule 

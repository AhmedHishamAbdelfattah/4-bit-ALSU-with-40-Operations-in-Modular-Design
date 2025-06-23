module Logic_Logical_Shift_Unit_Top_Module (
  input [3:0] A , B ,
  input [4:0] Sel ,
  output [3:0] Out
);

wire [3:0] Out_1 , Out_2 , Out_3 , Out_4 ;

AND_OR_XOR_XNOR_Top_Module T_1( .A( A ) ,
                                .B( B ) , 
                                .Sel(Sel[1:0]) , 
                                .Out(Out_1)  
                              );

NAND_NOR_Complement_Top_Module T_2 ( .A( A ) ,
                                     .B( B ) , 
                                     .Sel( Sel[1:0] ) , 
                                     .Out( Out_2 ) 
                                   );

Bypass_Equality_SLT_Top_Module T_3 ( .A( A ) ,
                                     .B( B ) , 
                                     .Sel( Sel[1:0] ) , 
                                     .Out( Out_3 ) 
                                   );

Logic_Shift_Rotate_Top_Module T_4 ( .A( A ) ,
                                    .B( B ) , 
                                    .Sel( Sel[2:0] ) , 
                                    .Out( Out_4 ) 
                                  );

Mux_4_to_1 M1 (.A   (Out_1) ,
               .B   (Out_2) ,
               .C   (Out_3) ,
               .D   (Out_4) ,
               .Sel (Sel[4:3]) ,
               .out (Out) 
              ) ;

endmodule 

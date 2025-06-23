module Arithmetic_Block_Top_Module (
 input [3:0] A , B ,
 input [4:0] Sel ,
 output [3:0] Out ,
 output Carry_Out ,
 output Negative_Sign_Flag
); 

wire [3:0] Out_Sub_1 , Out_Sub_2 , Out_Sub_3 , Out_Sub_4 , Out_Sub_5 , Out_Sub_6 , Out_Sub_7 , Out_Sub_8 ;
wire Carry_Out_Sub_1 , Carry_Out_Sub_2 , Carry_Out_Sub_3 ;
wire Neg_Sign_Sub_Flag_1 ; 

// Adder Top Module Instantiation  
Adder_TOP_Module Adder_1( .A( A ) ,
                          .B( B ) , 
                          .Sel( Sel[4:0] ) ,
                          .Sum( Out_Sub_1 ) ,
                          .carry_out ( Carry_Out_Sub_1 ) ,
                          .Negative_Sign_Adder_Flag( Negative_Sign_Adder_Flag )
                        );

Multiplier_Top_Module Mult_1( .A( A ) ,
                              .B( B ) ,
                              .Sel( Sel[0] ) ,
                              .Out( Out_Sub_2 ) 
                            );

// Divider Top Module Instantiation
Divider_Top_Module Div_1 ( .A( A ) ,
                           .B( B ) ,
                           .Sel( Sel[0] ) ,
                           .Out( Out_Sub_3 ) 
                         );

// Parity Checker Top Module Instantiation 
parity_checker_Top_Module Part_1( .A( A ) ,
                                  .B( B ) ,
                                  .Sel( Sel[0] ) ,
                                  .out( Out_Sub_4 ) 
                                );

// Arithmetic Shifter Top Module Instantiation 
Arithmetic_Shift_Top_Module Arthi_1( .A( A ) ,
                                     .B( B ) ,
                                     .Sel( { Sel[4] , Sel[2] } ) ,
                                     .out(Out_Sub_5) 
                                   );

// Reverser Top Module Instantiation 
Reverser_Top_Module Rev_1( .A( A ) ,
                           .B( B ) , 
                           .Sel( Sel[0] ) ,
                           .Out(Out_Sub_6)  
                         );

// Incrementer Top Module Instantiation 
Incrementer_Top_Module Inc_1 ( .A( A ) ,
                               .B( B ) ,
                               .Sel( Sel[0] ) ,
                               .Out( Out_Sub_7) ,
                               .Carry_Out_Inc( Carry_Out_Sub_2 )  
                             );   

// Decrementer Top Module Instantiation 
Decrementer_Top_Module Dec_1( .A( A ) ,
                              .B( B ) ,
                              .Sel( Sel[0] ) ,
                              .Out( Out_Sub_8 ) ,
                              .Negative_Sign_Flag ( Neg_Sign_Sub_Flag_1 )
                            );

// Carry Out Handling Module Instantiation
Carry_Out_Handling C_O_H ( .Sel( Sel[4:1] ) ,
                           .Carry_Out_From_Adder_Top_Module( Carry_Out_Sub_1 ) ,
                           .Carry_Out_From_Incrementer_Top_Module( Carry_Out_Sub_2 ) ,
                           .Carry_Out( Carry_Out ) 
                         );

// Negative Sign Handling Module Instantiation
Negative_Sign_Handling N_S_H( .Sel( Sel[4:1] ) ,
                              .Negative_Sign_Adder_Flag( Negative_Sign_Adder_Flag ) ,
                              .Negative_Sign_Decrementer_Flag( Neg_Sign_Sub_Flag_1 ) ,
                              .Negative_sign_Flag( Negative_Sign_Flag )
                            );

// Assigning the final output of the Arithmetic & Arithmetical Ahift Unit 
Mux_8_to_1_four_bits Mux_1 ( .A ( Out_Sub_1 ) ,
                             .B ( Out_Sub_2 ) ,
                             .C ( Out_Sub_3 ) ,
                             .D ( Out_Sub_4 ) ,
                             .E ( Out_Sub_5 ) ,
                             .F ( Out_Sub_6 ) ,
                             .G ( Out_Sub_7 ) ,
                             .H ( Out_Sub_8 ) ,
                             .Sel ( Sel[4:1] ) ,
                             .Out ( Out )
                           ); 

endmodule 

module Adder_TOP_Module (
   input [3:0] A , B , 
   input [4:0] Sel ,
   output [3:0] Sum ,
   output carry_out ,
   output Negative_Sign_Adder_Flag
);

wire [3:0] Sum_two_Comp, Out_Sub, Sum_Sub ;

wire [3:0] A_int , B_int , Carry_in_int ;

wire Carry_Out_Sub ;

Mux_4_to_1 M1 (.A   (A) ,
               .B   (A) ,
               .C   ({4{1'b0}}) ,
               .D   (~A) ,
               .Sel (Sel[1:0]) ,
               .out (A_int) ) ;

Mux_4_to_1 M2 (.A   (B)  ,
               .B   (~B) ,
               .C   (~B) ,
               .D   ({4{1'b0}})  ,
               .Sel (Sel[1:0]) ,
               .out (B_int) ) ;

Mux_4_to_1 M3 (.A   ({4{1'b0}})  ,
               .B   ({4{1'b1}})  ,
               .C   ({4{1'b1}})  ,
               .D   ({4{1'b1}})  ,
               .Sel (Sel[1:0])  ,
               .out (Carry_in_int) ) ;

four_bit_adder F2 (.A  (A_int) ,
                   .B  (B_int) ,
                   .carry_in (Carry_in_int[0]) ,
                   .Sum (Sum_Sub) ,
                   .carry_out (carry_Out_Sub) ) ;

second_complement S_1 ( .A ( Sum_Sub ) ,
                        .A_New ( Sum_two_Comp)
                      );

Mux_2_to_1_four_bits Mux_1 ( .A ( Sum_two_Comp ) , 
                             .B ( Sum_Sub ),
                             .Sel ( carry_Out_Sub ) , 
                             .Out ( Out_Sub )
                           );

Carry_Out_Adder_Handling C_O_A_H_1 ( .Sel( Sel[4:1] ) ,
                                     .Carry_Out_From_Adder( carry_Out_Sub ) ,
                                     .Carry_Out_Handled( carry_out )  
                                   );

Negative_Sign_Adder_Handling N_S_A_H ( .Carry_Out_From_Adder_Handling_Carry_Out( carry_out ) ,
                                       .Sel(Sel[0]) ,
                                       .Negative_Sign_Flag_Adder(Negative_Sign_Adder_Flag)   
                                     );

Mux_4_to_1 M4 (.A   ( Sum_Sub ) ,
               .B   ( Out_Sub ) ,
               .C   ( Sum_Sub ) ,
               .D   ( Sum_Sub ) ,
               .Sel (Sel[1:0]) ,
               .out (Sum) 
              );


endmodule 

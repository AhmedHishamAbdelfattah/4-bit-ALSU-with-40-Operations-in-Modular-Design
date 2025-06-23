module Logic_Shift_Rotate_Top_Module (
   input [3:0] A , B , 
   input [2:0] Sel , 
   output [3:0] Out 
);

wire [3:0] Out_1 , Out_2 , Out_3 , Out_4 , Out_5 , Out_6 , Out_7 , Out_8 ;  

Logic_Shift_Rotate_Operations L_S_R_O ( .A( A ) ,
                                        .B( B ) , 
                                        .Out_1( Out_1 ) ,
                                        .Out_2( Out_2 ) ,
                                        .Out_3( Out_3 ) ,
                                        .Out_4( Out_4 ) ,
                                        .Out_5( Out_5 ) ,
                                        .Out_6( Out_6 ) ,
                                        .Out_7( Out_7 ) ,
                                        .Out_8( Out_8 )   
                                     );

Mux_8_to_1 M_1 (.A   ( Out_1 ) ,
                .B   ( Out_2 ) ,
                .C   ( Out_3 ) ,
                .D   ( Out_4 ) ,
                .E   ( Out_5 ) ,
                .F   ( Out_6 ) ,
                .G   ( Out_7 ) ,
                .H   ( Out_8 ) ,
                .Sel ( Sel ) ,
                .out ( Out ) 
               );

endmodule

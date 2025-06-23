module four_bit_divider (
     input [3:0] A , B ,
     output [3:0] Q , R 
);

wire [3:0] Difference_Sec_one ;

wire Borrow_Out_one ;

four_bit_subtractor F1 ( .A ({ 1'b0 , 1'b0 , 1'b0 , A[3]}) , 
                         .B ({ B[3] , B[2] , B[1] , B[0]}) ,
                         .Bin (1'b0) ,
                         .Difference(Difference_Sec_one) ,
                         .BorrowOut(Borrow_Out_one) 
                       );

assign Q[3] = ~ Borrow_Out_one ;

wire [2:0] Mux_Out_One ; 

Multiplexer_2_to_1 M1 ( .A (Difference_Sec_one[0]) , 
                        .B ( A[3] ) , 
                        .Sel (Borrow_Out_one) ,
                        .out (Mux_Out_One[0]) 
                      );

Multiplexer_2_to_1 M2 ( .A (Difference_Sec_one[1]) , 
                        .B ( 1'b0 ) , 
                        .Sel (Borrow_Out_one) ,
                        .out (Mux_Out_One[1]) 
                      );

Multiplexer_2_to_1 M3 ( .A (Difference_Sec_one[2]) , 
                        .B ( 1'b0 ) , 
                        .Sel (Borrow_Out_one) ,
                        .out (Mux_Out_One[2]) 
                      );

// ------------------------------------------------------------

wire [3:0] Difference_Sec_two ;

wire Borrow_Out_two ;

four_bit_subtractor F2 ( .A ({ Mux_Out_One[2:0] , A[2] }) , 
                         .B ({ B[3] , B[2] , B[1] , B[0]}) ,
                         .Bin (1'b0) ,
                         .Difference(Difference_Sec_two) ,
                         .BorrowOut(Borrow_Out_two) 
                       );

assign Q[2] = ~ Borrow_Out_two ;

wire [2:0] Mux_Out_Two ; 

Multiplexer_2_to_1 M4 ( .A (Difference_Sec_two[0]) , 
                        .B ( A[2] ) , 
                        .Sel (Borrow_Out_two) ,
                        .out (Mux_Out_Two[0]) 
                      );

Multiplexer_2_to_1 M5 ( .A (Difference_Sec_two[1]) , 
                        .B ( Mux_Out_One[0] ) , 
                        .Sel (Borrow_Out_two) ,
                        .out (Mux_Out_Two[1]) 
                      );

Multiplexer_2_to_1 M6 ( .A (Difference_Sec_two[2]) , 
                        .B ( Mux_Out_One[1] ) , 
                        .Sel (Borrow_Out_two) ,
                        .out (Mux_Out_Two[2]) 
                      );
// ------------------------------------------------------------
wire [3:0] Difference_Sec_three ;

wire Borrow_Out_three ;

four_bit_subtractor F3 ( .A ({ Mux_Out_Two[2:0] , A[1] }) , 
                         .B ({ B[3] , B[2] , B[1] , B[0]}) ,
                         .Bin (1'b0) ,
                         .Difference(Difference_Sec_three) ,
                         .BorrowOut(Borrow_Out_three) 
                       );

assign Q[1] = ~ Borrow_Out_three ;

wire [2:0] Mux_Out_three ; 

Multiplexer_2_to_1 M7 ( .A (Difference_Sec_three[0]) , 
                        .B ( A[1] ) , 
                        .Sel (Borrow_Out_three) ,
                        .out (Mux_Out_three[0]) 
                      );

Multiplexer_2_to_1 M8 ( .A (Difference_Sec_three[1]) , 
                        .B ( Mux_Out_Two[0] ) , 
                        .Sel (Borrow_Out_three) ,
                        .out (Mux_Out_three[1]) 
                      );

Multiplexer_2_to_1 M9 ( .A (Difference_Sec_three[2]) , 
                        .B ( Mux_Out_Two[1] ) , 
                        .Sel (Borrow_Out_three) ,
                        .out (Mux_Out_three[2]) 
                      );
// -----------------------------

wire [3:0] Difference_Sec_four ;

wire Borrow_Out_four ;

four_bit_subtractor F4 ( .A ({ Mux_Out_three[2:0] , A[0] }) , 
                         .B ({ B[3] , B[2] , B[1] , B[0]}) ,
                         .Bin (1'b0) ,
                         .Difference(Difference_Sec_four) ,
                         .BorrowOut(Borrow_Out_four) 
                       );

assign Q[0] = ~ Borrow_Out_four ;

wire [3:0] Mux_Out_four ; 

Multiplexer_2_to_1 M10 ( .A (Difference_Sec_four[0]) , 
                         .B ( A[0] ) , 
                         .Sel (Borrow_Out_four) ,
                         .out (Mux_Out_four[0]) 
                       );

Multiplexer_2_to_1 M11 ( .A (Difference_Sec_four[1]) , 
                         .B ( Mux_Out_three[0] ) , 
                         .Sel (Borrow_Out_four) ,
                         .out (Mux_Out_four[1]) 
                       );

Multiplexer_2_to_1 M12 ( .A (Difference_Sec_four[2]) , 
                         .B ( Mux_Out_three[1] ) , 
                         .Sel (Borrow_Out_four) ,
                         .out (Mux_Out_four[2]) 
                       );

Multiplexer_2_to_1 M13 ( .A (Difference_Sec_four[3]) , 
                         .B ( Mux_Out_three[2] ) , 
                         .Sel (Borrow_Out_four) ,
                         .out (Mux_Out_four[3]) 
                       );

assign R = Mux_Out_four ;

endmodule 

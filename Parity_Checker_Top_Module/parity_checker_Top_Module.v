module parity_checker_Top_Module (
      input [3:0] A , B ,
      input Sel ,
      output [3:0] out 
); 

wire parity_A_int , parity_B_int ;

parity_checker  P1 ( .A ( A ) ,
                     .B ( B ) ,
                     .parity_A ( parity_A_int ) ,
                     .parity_B ( parity_B_int ) 
);

Mux_2_to_1_four_bits Mux_1 ( .A ( { 3'b000 , parity_A_int } ) , 
                             .B ( { 3'b000 , parity_B_int } ),
                             .Sel ( Sel ) , 
                             .Out ( out )
                           );


endmodule 

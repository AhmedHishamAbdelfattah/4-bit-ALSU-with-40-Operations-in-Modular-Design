module four_bit_subtractor (
     input [3:0] A , B ,
     input Bin ,
     output [3:0] Difference ,
     output BorrowOut 
);
 
wire [2:0] BorrowOut_sec ;

full_subtractor F1 ( .A (A[0]) ,
                     .B (B[0])  ,
                     .BorrowIn  (Bin) ,
                     .Difference(Difference[0]) ,
                     .BorrowOut (BorrowOut_sec[0]) ) ; 

full_subtractor F2 ( .A (A[1]) ,
                     .B (B[1])  ,
                     .BorrowIn  (BorrowOut_sec[0]) ,
                     .Difference(Difference[1]) ,
                     .BorrowOut (BorrowOut_sec[1]) ) ; 

full_subtractor F3 ( .A (A[2]) ,
                     .B (B[2])  ,
                     .BorrowIn  (BorrowOut_sec[1]) ,
                     .Difference(Difference[2]) ,
                     .BorrowOut (BorrowOut_sec[2]) ) ; 

full_subtractor F4 ( .A (A[3]) ,
                     .B (B[3])  ,
                     .BorrowIn  (BorrowOut_sec[2]) ,
                     .Difference(Difference[3]) ,
                     .BorrowOut (BorrowOut) ) ; 

endmodule 

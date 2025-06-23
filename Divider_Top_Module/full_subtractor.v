module full_subtractor (
     input A , B , BorrowIn ,
     output Difference , BorrowOut  
);

assign Difference = A ^ B ^ BorrowIn ;
assign BorrowOut = ( ~A & B ) | ( ~A & BorrowIn ) | ( B & BorrowIn ) ;

endmodule 

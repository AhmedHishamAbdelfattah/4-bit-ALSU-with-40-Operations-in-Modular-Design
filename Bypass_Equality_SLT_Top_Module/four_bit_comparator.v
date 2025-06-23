module four_bit_comparator (
    input [3:0] A,
    input [3:0] B,
    output S,
    output Eq
);
    wire S3, S2, S1, S0;
    wire Eq3, Eq2, Eq1, Eq0;

    comparator comp1 ( A[3], B[3], Eq3, S3 );
    comparator comp2 ( A[2], B[2], Eq2, S2 );
    comparator comp3 ( A[1], B[1], Eq1, S1 );
    comparator comp4 ( A[0], B[0], Eq0, S0 );

    assign Eq = Eq3 & Eq2 & Eq1 & Eq0;
    assign S = S3 | 
           (Eq3 & S2) | 
           (Eq3 & Eq2 & S1) | 
           (Eq3 & Eq2 & Eq1 & S0);

endmodule

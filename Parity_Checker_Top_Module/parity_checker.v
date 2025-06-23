module parity_checker (
    input [3:0] A , B ,
    output parity_A , parity_B  // 1 if odd parity, 0 if even
);
    assign parity_A = ^A ; 
    assign parity_B = ^B ;
endmodule

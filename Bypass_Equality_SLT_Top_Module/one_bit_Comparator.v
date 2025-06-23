module comparator (
    input x,
    input y,
    output Eq,
    output S
);
    assign S = ~x & y;
    assign Eq = ~x & ~y | x & y;
endmodule

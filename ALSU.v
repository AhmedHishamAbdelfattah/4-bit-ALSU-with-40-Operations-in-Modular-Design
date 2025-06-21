`timescale 1ns / 1ps
// Arithmetic, Logic & Shift Unit 
// --------------------------------------------------------------------------------
// -------------- we will start by making the design for each module -------------------------------- 

// -------------------- 4-bit Adder -----------------------------------------------------------

// we will design a 1-bit full adder and we will use it to make 4-bit adder 

module full_adder (
        input a , b , carry_in ,
        output sum , carry_out
);

assign sum = a ^ b ^ carry_in ;
assign carry_out = ( a & b ) | ( a & carry_in ) | ( b & carry_in ) ;

endmodule 

// ------------- four bit adder module -------------------

module four_bit_adder (
       input [3:0] A , B ,
       input carry_in ,
       output [3:0] Sum ,
       output carry_out 
);

wire [0:2] carry_int ;

full_adder f1 ( A[0] , B[0] , carry_in     , Sum[0] , carry_int[0] ) ;
full_adder f2 ( A[1] , B[1] , carry_int[0] , Sum[1] , carry_int[1] ) ;
full_adder f3 ( A[2] , B[2] , carry_int[1] , Sum[2] , carry_int[2] ) ;
full_adder f4 ( A[3] , B[3] , carry_int[2] , Sum[3] , carry_out    ) ;

endmodule 


// --------------- Multiplexer 4 to 1 --------------- 

module Mux_4_to_1 (
    input [3:0] A , B , C , D ,
    input [1:0] Sel ,
    output reg [3:0] out 
);

always @ (*) begin 

case(Sel)
2'b00 : out = A ;
2'b01 : out = B ;
2'b10 : out = C ;
2'b11 : out = D ;
endcase  

end

endmodule 


// -------------------- Adder Top Module ----------------------------------- 

module Adder_TOP_Module (
   input [3:0] A , B , 
   input [1:0] Sel ,
   output [3:0] Sum ,
   output carry_out
);

wire [3:0] A_int , B_int , Carry_in_int ;

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
                   .Sum (Sum) ,
                   .carry_out (carry_out) ) ;

endmodule 


// ----------------------------------------------------------------------------------------- 

// ------------------------- Multiplier Top Module Block -----------------------------------

module four_bit_multiplier (
 input [3:0] A , B ,
 output [7:0] out_multiplier
);

assign out_multiplier[0] = A[0] & B[0] ;
 
wire [4:0] Multiplication_Sec_Out_one ;

four_bit_adder F1 (.A  ({ 1'b0 , (A[3] & B[0]) , (A[2] & B[0]) , (A[1]&B[0]) }) ,
                   .B  ({ (A[3] & B[1]) , (A[2] & B[1]) , (A[1] & B[1]) , (A[0]&B[1]) }) ,
                   .carry_in (1'b0) ,
                   .Sum (Multiplication_Sec_Out_one[3:0]) ,
                   .carry_out (Multiplication_Sec_Out_one[4]) ) ;

assign out_multiplier[1] = Multiplication_Sec_Out_one[0] ;

wire [4:0] Multiplication_Sec_Out_two ;

four_bit_adder F2 (.A  (Multiplication_Sec_Out_one[4:1]) ,
                   .B  ({ (A[3] & B[2]) , (A[2] & B[2]) , (A[1] & B[2]) , (A[0]&B[2]) }) ,
                   .carry_in (1'b0) ,
                   .Sum (Multiplication_Sec_Out_two[3:0]) ,
                   .carry_out (Multiplication_Sec_Out_two[4]) ) ;

assign out_multiplier[2] = Multiplication_Sec_Out_two[0] ;

wire [4:0] Multiplication_Sec_Out_three ;

four_bit_adder F3 (.A  (Multiplication_Sec_Out_two[4:1]) ,
                   .B  ({ (A[3] & B[3]) , (A[2] & B[3]) , (A[1] & B[3]) , (A[0]&B[3]) }) ,
                   .carry_in (1'b0) ,
                   .Sum (Multiplication_Sec_Out_three[3:0]) ,
                   .carry_out (Multiplication_Sec_Out_three[4]) ) ;

assign out_multiplier[7:3] = Multiplication_Sec_Out_three ;

endmodule

module Mux_2_to_1_four_bits (
    input [3:0] A , B ,
    input Sel ,
    output [3:0] Out
);

assign Out = ( Sel == 0 ) ? A : B ;

endmodule 


module Multiplier_Top_Module (
     input [3:0] A , B ,
     input Sel ,
     output [3:0] Out 
);

wire [7:0] Temp ;

four_bit_multiplier Mul_1 ( .A ( A ) , 
                            .B ( B ) ,
                            .out_multiplier ( Temp )
                          );

Mux_2_to_1_four_bits Mux_1 ( .A ( Temp[3:0] ) , 
                             .B ( Temp[7:4] ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

endmodule 


// module Multiplier_Module_TB ();

//    reg [3:0] A , B ; 
//    wire [7:0] Out ;

// four_bit_multiplier M1 ( .A( A ) ,
//                          .B( B ) ,
//                          .out_multiplier( Out )
//                        ); 

// initial begin 
  
//   A = 4'b0101 ;  B = 4'b0100 ;   #10 
//   A = 4'b0101 ;  B = 4'b0011 ;   #10 
//   A = 4'b0000 ;  B = 4'b0000 ;   #10 
//   A = 4'b1111 ;  B = 4'b0011 ;   #10 
//   A = 4'b0011 ;  B = 4'b0101 ;   #10 
//   A = 4'b1010 ;  B = 4'b0001 ;   #10 
//   A = 4'b1100 ;  B = 4'b1101 ;   #10 
//   A = 4'b1111 ;  B = 4'b1111 ;   #10
//   #10 

//   $stop ;
// end

// endmodule 

module Multiplier_Module_TB;

  parameter Width = 4;           
  parameter Output_Width = 8;    
  parameter Delay = 10;    

  reg  [Width-1:0] A, B;      
  wire [Output_Width-1:0] Out;  
  integer error_count = 0;     

  four_bit_multiplier M1 (
    .A(A),
    .B(B),
    .out_multiplier(Out)
  );

  initial begin
    $monitor("Time=%0t A=%b (%0d) B=%b (%0d) Out=%b (%0d)",
             $time, A, A, B, B, Out, Out);
  end

  initial begin
    A = 0;
    B = 0;
    #Delay;

    run_test(4'b0101, 4'b0100, 8'd20);  // 5 * 4 = 20
    run_test(4'b0101, 4'b0011, 8'd15);  // 5 * 3 = 15
    run_test(4'b0000, 4'b0000, 8'd0);   // 0 * 0 = 0
    run_test(4'b0000, 4'b0001, 8'd0);   // 0 * 1 = 0
    run_test(4'b1111, 4'b0011, 8'd45);  // 15 * 3 = 45
    run_test(4'b0011, 4'b0101, 8'd15);  // 3 * 5 = 15
    run_test(4'b1010, 4'b0001, 8'd10);  // 10 * 1 = 10
    run_test(4'b1100, 4'b1101, 8'd156); // 12 * 13 = 156
    run_test(4'b1111, 4'b1111, 8'd225); // 15 * 15 = 225 
    run_test(4'b0000, 4'b0001, 8'd0);   // 0 * 1 = 0

    #Delay;
    if (error_count == 0) begin
      $display("All tests passed successfully!");
    end else begin
      $display("Test completed with %0d errors.", error_count);
    end

    $stop; 
  end

  task run_test(
    input [Width-1:0] a_in,
    input [Width-1:0] b_in,
    input [Output_Width-1:0] expected_out
  );
    begin
      A = a_in;
      B = b_in;
      #Delay; 
      if (Out !== expected_out) begin
        $display("ERROR at time %0t: A=%0d, B=%0d, Expected Out=%0d, Got Out=%0d",
                 $time, A, B, expected_out, Out);
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Out=%0d", A, B, Out);
      end
    end
  endtask

endmodule

module Adder_Top_Module_TB ;

  parameter Width = 4; 
  parameter Width_Sel = 2;          
  parameter Output_Width = 4;    
  parameter Delay = 10;    

  reg [Width-1:0] A , B ; 
  reg [Width_Sel-1:0] Sel ;
  wire [Output_Width-1:0] Out ;
  wire carry_out ;
  integer error_count = 0;

Adder_TOP_Module DUT( .A ( A ) ,
                      .B ( B ) , 
                      .Sel ( Sel ) ,
                      .Sum ( Out ) ,
                      .carry_out ( carry_out )
                    );
  initial begin 
  // when Sel is 00 which indicates A+B 
  run_test(4'b0101, 4'b0100, 2'b00, 4'b1001, 1'b0);
  run_test(4'b0101, 4'b0011, 2'b00, 4'b1000, 1'b0);
  run_test(4'b0000, 4'b0000, 2'b00, 4'b0000, 1'b0);
  run_test(4'b1111, 4'b0011, 2'b00, 4'b0010, 1'b1);
  run_test(4'b0011, 4'b0101, 2'b00, 4'b1000, 1'b0);
  run_test(4'b1010, 4'b0001, 2'b00, 4'b1011, 1'b0);
  run_test(4'b1100, 4'b1101, 2'b00, 4'b1001, 1'b1);
  // when Sel is 01 which indicates A-B
  run_test(4'b0101, 4'b0100, 2'b01, 4'b0000, 1'b1);
  run_test(4'b0101, 4'b0011, 2'b01, 4'b0001, 1'b1);
  run_test(4'b0000, 4'b0000, 2'b01, 4'b1111, 1'b1);
  run_test(4'b1111, 4'b0011, 2'b01, 4'b1100, 1'b1);
  run_test(4'b0011, 4'b0101, 2'b01, 4'b1101, 1'b0);
  run_test(4'b1010, 4'b0001, 2'b01, 4'b1000, 1'b1);
  run_test(4'b1100, 4'b1101, 2'b01, 4'b1110, 1'b0);
  // when Sel is 01 which indicates 2's comp.(B)
  run_test(4'b0101, 4'b1100, 2'b10, 4'b0100, 1'b0);
  run_test(4'b0101, 4'b0101, 2'b10, 4'b1011, 1'b0);
  run_test(4'b0101, 4'b1111, 2'b10, 4'b0001, 1'b0);
  run_test(4'b0101, 4'b0011, 2'b10, 4'b1101, 1'b0);
  run_test(4'b0101, 4'b1010, 2'b10, 4'b0110, 1'b0);
  run_test(4'b0101, 4'b1101, 2'b10, 4'b0011, 1'b0);
  run_test(4'b0101, 4'b0001, 2'b10, 4'b1111, 1'b0);
  run_test(4'b0101, 4'b0010, 2'b10, 4'b1110, 1'b0);
  run_test(4'b0101, 4'b1000, 2'b10, 4'b1000, 1'b0);
  // when Sel is 10 which indicates 2's comp.(A)
  run_test(4'b0101, 4'b1000, 2'b11, 4'b1011, 1'b0);
  run_test(4'b1100, 4'b1000, 2'b11, 4'b0100, 1'b0);
  run_test(4'b0001, 4'b1000, 2'b11, 4'b1111, 1'b0);
  run_test(4'b0011, 4'b1000, 2'b11, 4'b1101, 1'b0);
  run_test(4'b1010, 4'b1000, 2'b11, 4'b0110, 1'b0);
  run_test(4'b1101, 4'b1000, 2'b11, 4'b0011, 1'b0);
  run_test(4'b0001, 4'b1000, 2'b11, 4'b1111, 1'b0);
  run_test(4'b0010, 4'b1000, 2'b11, 4'b1110, 1'b0);
  run_test(4'b1000, 4'b1000, 2'b11, 4'b1000, 1'b0);
  #Delay;

   if (error_count == 0) begin
      $display("All tests passed successfully!");
    end else begin
      $display("Test completed with %0d errors.", error_count);
    end

    $stop; 
   
  end 

  task run_test(
    input [Width-1:0] a_in,
    input [Width-1:0] b_in,
    input [Width_Sel-1:0] Sel_in,
    input [Output_Width-1:0] expected_out,
    input expected_carry_out
  );
    begin
      A = a_in;
      B = b_in;
      Sel = Sel_in;
      #Delay; 
      if ( (Out !== expected_out) && (carry_out !== expected_carry_out )) begin
        $display("ERROR at time %0t: A=%0d, B=%0d, Sel=%b, Expected Out=%0d, Got Out=%0d, Expected Carry=%0d, Got Carry Out=%0d",  
                 $time, A, B, Sel, expected_out, Out, expected_carry_out, carry_out );
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Sel=%b, Out=%0d", A, B, Sel, Out, carry_out);
      end
    end
  endtask

endmodule 

// module Adder_TOP_Module_TB ();

//   parameter Width = 4; 
//   parameter Width_Sel = 2;          
//   parameter Output_Width = 4;    
//   parameter Delay = 10;    

//    reg [Width-1:0] A , B ; 
//    reg [Width_Sel-1:0] Sel ;
//    wire [Output_Width-1:0] Sum ;
//    wire carry_out ;

// Adder_TOP_Module DUT( .A ( A ) ,
//                       .B ( B ) , 
//                       .Sel ( Sel ) ,
//                       .Sum ( Sum ) ,
//                       .carry_out ( carry_out )
//                     );

// initial begin 
  
//   // when Sel is 00 which indicates A+B 
//   A = 4'b0101 ;  B = 4'b0100 ;  Sel = 2'b00 ;  #10 
//   A = 4'b0101 ;  B = 4'b0011 ;  Sel = 2'b00 ;  #10 
//   A = 4'b0000 ;  B = 4'b0000 ;  Sel = 2'b00 ;  #10 
//   A = 4'b1111 ;  B = 4'b0011 ;  Sel = 2'b00 ;  #10 
//   A = 4'b0011 ;  B = 4'b0101 ;  Sel = 2'b00 ;  #10 
//   A = 4'b1010 ;  B = 4'b0001 ;  Sel = 2'b00 ;  #10 
//   A = 4'b1100 ;  B = 4'b1101 ;  Sel = 2'b00 ;  #10 
//   #10 

//   // when Sel is 01 which indicates A-B 
//   A = 4'b1100 ;  B = 4'b1101 ;  Sel = 2'b01 ;  #10 
//   A = 4'b1010 ;  B = 4'b0010 ;  Sel = 2'b01 ;  #10 
//   A = 4'b1110 ;  B = 4'b1000 ;  Sel = 2'b01 ;  #10 
//   A = 4'b0011 ;  B = 4'b0000 ;  Sel = 2'b01 ;  #10 
//   A = 4'b1101 ;  B = 4'b0101 ;  Sel = 2'b01 ;  #10 
//   A = 4'b1111 ;  B = 4'b1000 ;  Sel = 2'b01 ;  #10 
//   A = 4'b0000 ;  B = 4'b0000 ;  Sel = 2'b01 ;  #10 
//   A = 4'b1010 ;  B = 4'b0100 ;  Sel = 2'b01 ;  #10 
//   A = 4'b1010 ;  B = 4'b0101 ;  Sel = 2'b01 ;  #10 
//   #10 

//   // when Sel is 10 which indicates 2's Comp.(B)
//   A = 4'b0101 ;  B = 4'b1100 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b0101 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b1111 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b0011 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b1010 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b1101 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b0001 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b0010 ;  Sel = 2'b10 ;  #10 
//   A = 4'b0101 ;  B = 4'b1000 ;  Sel = 2'b10 ;  #10 
//   #10 

//   // when Sel is 11 which indicates 2's Comp.(A)
//   A = 4'b0101 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b1100 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b0001 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b0011 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b1010 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b1101 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b0001 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b0010 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   A = 4'b1000 ;  B = 4'b1000 ;  Sel = 2'b11 ;  #10 
//   #10 

//   $stop ;
// end

// endmodule 
// ---------------------------------------------------------------------------------------------------------------------------------------------- 
// --------------------------------------------------------- Divider ----------------------------------------------------------------------------

module full_subtractor (
     input A , B , BorrowIn ,
     output Difference , BorrowOut  
);

assign Difference = A ^ B ^ BorrowIn ;
assign BorrowOut = ( ~A & B ) | ( ~A & BorrowIn ) | ( B & BorrowIn ) ;

endmodule 

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

module Multiplexer_2_to_1 (
    input A , B , 
    input Sel ,
    output out 
);

assign out = ( Sel == 0 ) ?  A  :  B ;

endmodule 


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

module Divider_Module_TB;

  parameter Width = 4;           
  parameter Output_Width = 4;    
  parameter Delay = 10;    

  reg  [Width-1:0] A, B;      
  wire [Output_Width-1:0] Q;  
  wire [Output_Width-1:0] R;  

  integer error_count = 0;     

four_bit_divider Div_1 ( .A ( A ) ,
                         .B ( B ) ,
                         .Q ( Q ) ,
                         .R ( R ) 
                       );

  initial begin
    $monitor("Time=%0t A=%b (%0d) B=%b (%0d) Q=%b (%0d) R=%b (%0d)",
             $time, A, A, B, B, Q, Q, R, R);
  end

  initial begin

    run_test(4'd5 , 4'd4 , 4'd1 , 4'd1);   // 5 / 4 = 1 R1
    run_test(4'd5 , 4'd3 , 4'd1 , 4'd2);   // 5 / 3 = 1 R2
    run_test(4'd0 , 4'd1 , 4'd0 , 4'd0);   // 0 / 1 = 0 R0
    run_test(4'd15, 4'd3 , 4'd5 , 4'd0);   // 15 / 3 = 5 R0
    run_test(4'd3 , 4'd5 , 4'd0 , 4'd3);   // 3 / 5 = 0 R3
    run_test(4'd10, 4'd1 , 4'd10, 4'd0);   // 10 / 1 = 10 R0
    run_test(4'd12, 4'd13, 4'd0 , 4'd12);  // 12 / 13 = 0 R12
    run_test(4'd15, 4'd15, 4'd1 , 4'd0);   // 15 / 15 = 1 R0
    run_test(4'd15, 4'd15, 4'd1 , 4'd0);   // 15 / 15 =1 R0
    run_test(4'd10 , 4'd5 ,4'd2 , 4'd0);   // 10 / 5 =2 R0

    #Delay;
    if (error_count == 0) begin
      $display("All tests passed successfully!");
    end else begin
      $display("Test completed with %0d errors.", error_count);
    end

    $stop; 
  end

  task run_test(
    input [Width-1:0] a_in,
    input [Width-1:0] b_in,
    input [Output_Width-1:0] expected_out_Q,
    input [Output_Width-1:0] expected_out_R
  );
    begin
      A = a_in;
      B = b_in;
      #Delay; 
      if ((Q !== expected_out_Q) && (R !== expected_out_R) ) begin
        $display("ERROR at time %0t: A=%0d, B=%0d, Expected Q=%0d, Got Q=%0d, Expected R=%0d, Got R=%0d ",
                 $time, A, B, expected_out_Q, Q, expected_out_R, R );
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Out=%0d", A, B, Q, R);
      end
    end
  endtask

endmodule
// -----------------------------

module Divider_Top_Module (
    input [3:0] A , B ,
    input Sel ,
    output [3:0] Out 
);

wire [3:0] Quotient , Remainder ;

four_bit_divider Div_1 ( .A ( A ) ,
                         .B ( B ) ,
                         .Q (Quotient) ,
                         .R (Remainder) 
                       );

Mux_2_to_1_four_bits Mux_2 ( .A ( Quotient ) , 
                             .B ( Remainder ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

endmodule 

// ------------------------------------------------------------------------------------------------------------------------------------

// ------------------ parity checker Module ---------------------

module parity_checker (
    input [3:0] A , B ,
    output parity_A , parity_B  // 1 if odd parity, 0 if even
);
    assign parity_A = ^A ; 
    assign parity_B = ^B ;
endmodule


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



//    ---------------------------------- Arithmetical & Arithmetic Shift Unit --------------------------------





// ----------------------- Note -----------------------
// in Case of Signed Numbers: For Arithmetic Shift Right:
// Arithmetic right shift (>>>) replicates the sign bit
// (MSB = 1 for negative)
// (MSB = 0 for positive)

// reg signed [3:0] A = 4'b0101; 
// // A = 4 + 1 = +5
// result = A >>> 1;
// A = 0101  →  >>> 1  →  0010

// reg signed [3:0] A = 4'b1100; 
// // A = -8 + 4 = -4 
// result = A >>> 1;
// A       = 1100   // -4
// A >>> 1 = 1110   // -2

// // ------------- what if ( >>> 2 ) 

// reg signed [3:0] A = 4'b0101; 
// // A = 4 + 1 = +5
// result = A >>> 2;
// // Step 1 >>> 1 = 0010  (+2)
// // Step 2 >>> 2 = 0001  (+1)
// A >>> 2 = 4'b0001 // which is +1 in 4-bit signed

// reg signed [3:0] A = 4'b1100; 
// // A = -8 + 4 = -4 
// result = A >>> 2;
// // Step 1 >>> 1 = 1110  (−2)
// // Step 2 >>> 2 = 1111  (−1)
// A >>> 2 = 4'b1111 // which is -1 in 4-bit signed


// // ----------------------- Note -----------------------
// // in Case of Unsigned Numbers: For Arithmetic Shift Right:
// // Arithmetic right shift (>>>) works as Logical Shift Right 

// reg [3:0] A = 4'b1100;

// A       = 1100   // 12
// A >>> 1 = 0110   // 6

// A       = 1100   // 12
// A >>> 2 = 0011   // 3

// reg [3:0] A = 4'b0101;

// A       = 0101  // 5
// A >>> 1 = 0010  // 2

// A       = 0101  // 5
// A >>> 2 = 0001  // 1
 


// // ----------------------- Note -----------------------
// // in Case of Unsigned & Signed Numbers: For Arithmetic Shift Left: 
// // Arithmetic Left Shift (<<<) behaves the same as Logical Left Shift (<<).
// // This is true for both signed and unsigned types.

// reg [3:0] A = 4'b0101 ;

// A       = 0101  (5)
// A <<< 1 = 1010  (10)

// A       = 0101  (5)
// A <<< 2 = 0100  (4)


// reg signed [3:0] A = 4'b0101;

// A        = 0101  (+5) 
// A <<< 1  = 0101 <<< 1 = 1010 = (-6) in 4-bit signed

// A        = 0101  (+5) 
// A <<< 2  = 0101 <<< 2 = 0100 = (+4) in 4-bit signed


module Arithmetic_Shift_Unit (
    input  [3:0] A , B ,
    output [3:0] A_Arith_Right , B_Arith_Right , A_Arith_Left , B_Arith_Left
);

assign A_Arith_Right = A >>> 1 ;
assign A_Arith_Left  = A <<< 1 ;

assign B_Arith_Right = B >>> 1 ;
assign B_Arith_Left  = B <<< 1 ;

endmodule 



module Arithmetic_Shift_Top_Module (
    input [3:0] A , B ,
    input [1:0] Sel ,
    output [3:0] out 
);

wire  [3:0] A_Arith_Right , B_Arith_Right , A_Arith_Left , B_Arith_Left ;

Arithmetic_Shift_Unit A1 ( .A ( A ) ,
                           .B ( B ) ,
                           .A_Arith_Right ( A_Arith_Right ) ,
                           .B_Arith_Right ( B_Arith_Right ) ,
                           .A_Arith_Left  ( A_Arith_Left  ) ,
                           .B_Arith_Left  ( B_Arith_Left  )
                         );

Mux_4_to_1 M1 ( .A ( A_Arith_Right ) ,
                .B ( A_Arith_Left ) ,
                .C ( B_Arith_Right ) ,
                .D ( B_Arith_Left  ),
                .Sel ( Sel ) ,
                .out ( out ) 
             );

endmodule 

module Arithmetic_Shift_Top_Module_TB;

  parameter Width = 4;  
  parameter width_Sel = 2;         
  parameter Output_Width = 4;    
  parameter Delay = 10;    

  reg  [Width-1:0] A, B;      
  reg  [width_Sel-1:0] Sel ;
  wire [Output_Width-1:0] Out;  

  integer error_count = 0;     

Arithmetic_Shift_Top_Module A1 ( .A( A ) ,
                                 .B( B ) ,
                                 .Sel( Sel ) ,
                                 .out( Out ) 
                               );

  initial begin
    $monitor("Time=%0t A=%b (%0d) B=%b (%0d) Sel=%b (%0d) Out=%b (%0d)",
             $time, A, A, B, B, Sel, Sel, Out, Out);
  end

  initial begin

    // when Sel is 00 which indicates Arithmetic Shift Right (A)  
    run_test(4'b1100 , 4'b0000 , 2'b00 , 4'b0110);   
    run_test(4'b0101 , 4'b0000 , 2'b00 , 4'b0010);
    run_test(4'b1111 , 4'b0000 , 2'b00 , 4'b0111); 
    run_test(4'b0011 , 4'b0000 , 2'b00 , 4'b0001);  
    run_test(4'b1010 , 4'b0000 , 2'b00 , 4'b0101);  
    run_test(4'b1101 , 4'b0000 , 2'b00 , 4'b0110); 
    run_test(4'b0001 , 4'b0000 , 2'b00 , 4'b0000);   
    run_test(4'b0010 , 4'b0000 , 2'b00 , 4'b0001);      
    run_test(4'b1000 , 4'b0000 , 2'b00 , 4'b0100);

    // when Sel is 01 which indicates Arithmetic Shift Left (A)  
    run_test(4'b1100 , 4'b0000 , 2'b01 , 4'b1000);   
    run_test(4'b0101 , 4'b0000 , 2'b01 , 4'b1010);
    run_test(4'b1111 , 4'b0000 , 2'b01 , 4'b1110); 
    run_test(4'b0011 , 4'b0000 , 2'b01 , 4'b0110);  
    run_test(4'b1010 , 4'b0000 , 2'b01 , 4'b0100);  
    run_test(4'b1101 , 4'b0000 , 2'b01 , 4'b1010); 
    run_test(4'b0001 , 4'b0000 , 2'b01 , 4'b0010);   
    run_test(4'b0010 , 4'b0000 , 2'b01 , 4'b0100);      
    run_test(4'b1000 , 4'b0000 , 2'b01 , 4'b0000);

    // when Sel is 10 which indicates Arithmetic Shift Right (B)   
    run_test( 4'b0000 , 4'b1100 , 2'b10 , 4'b0110);   
    run_test( 4'b0000 , 4'b0101 , 2'b10 , 4'b0010);
    run_test( 4'b0000 , 4'b1111 , 2'b10 , 4'b0111); 
    run_test( 4'b0000 , 4'b0011 , 2'b10 , 4'b0001);  
    run_test( 4'b0000 , 4'b1010 , 2'b10 , 4'b0101);  
    run_test( 4'b0000 , 4'b1101 , 2'b10 , 4'b0110); 
    run_test( 4'b0000 , 4'b0001 , 2'b10 , 4'b0000);   
    run_test( 4'b0000 , 4'b0010 , 2'b10 , 4'b0001);      
    run_test( 4'b0000 , 4'b1000 , 2'b10 , 4'b0100);
    
    // when Sel is 11 which indicates Arithmetic Shift Left (B)   
    run_test( 4'b0000 , 4'b1100 , 2'b11 , 4'b1000);   
    run_test( 4'b0000 , 4'b0101 , 2'b11 , 4'b1010);
    run_test( 4'b0000 , 4'b1111 , 2'b11 , 4'b1110); 
    run_test( 4'b0000 , 4'b0011 , 2'b11 , 4'b0110);  
    run_test( 4'b0000 , 4'b1010 , 2'b11 , 4'b0100);  
    run_test( 4'b0000 , 4'b1101 , 2'b11 , 4'b1010); 
    run_test( 4'b0000 , 4'b0001 , 2'b11 , 4'b0010);   
    run_test( 4'b0000 , 4'b0010 , 2'b11 , 4'b0100);      
    run_test( 4'b0000 , 4'b1000 , 2'b11 , 4'b0000);
    
    #Delay;
    if (error_count == 0) begin
      $display("All tests passed successfully!");
    end else begin
      $display("Test completed with %0d errors.", error_count);
    end

    $stop; 
  end

  task run_test(
    input [Width-1:0] a_in,
    input [Width-1:0] b_in,
    input [width_Sel-1:0] sel_in,
    input [Output_Width-1:0] Expected_Out
  );
    begin
      A = a_in;
      B = b_in;
      Sel = sel_in;
      #Delay; 
      if (Out !== Expected_Out) begin
        $display("ERROR at time %0t: A=%0d, B=%0d, Sel=%b, Expected out=%0d, Got out=%0d",
                 $time, A, B, Sel, Expected_Out, Out );
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Out=%0d", A, B, Sel, Out);
      end
    end
  endtask

endmodule


module Reverser(
   input [3:0] A , B ,
   output [3:0] A_Rev , B_Rev  
); 

 assign A_Rev = {A[0] , A[1] , A[2] , A[3]} ;
 assign B_Rev = {B[0] , B[1] , B[2] , B[3]} ;

endmodule 

module Reverser_Top_Module (
   input [3:0] A , B , 
   input Sel ,
   output [3:0] Out  
);
 
wire [3:0] A_Rev , B_Rev ;  

Reverser R1 ( .A( A ) ,
              .B( B ) ,
              .A_Rev( A_Rev ) ,
              .B_Rev( B_Rev )  
            ); 
Mux_2_to_1_four_bits Mux_1 ( .A ( A_Rev ) , 
                             .B ( B_Rev ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

endmodule 

module Reverser_Top_Module_TB () ;

   reg [3:0] A , B ; 
   reg Sel ;
   wire [3:0] Out ;  
   integer error_count = 0 ;

   Reverser_Top_Module R1 ( .A ( A ) ,
                         .B ( B ) , 
                         .Sel ( Sel ) ,
                         .Out ( Out ) 
                       );
    initial begin  
    $monitor("Time = %0t  : A = %b (%0d) : B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                     $time , A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 

    initial begin 
     
    // when Sel is 0 which indicates the reverse of A :
    run_test (4'b0001, 4'b0000, 1'b0, 4'b1000); // Reverse of 0001 = 1000
    run_test (4'b0010, 4'b0000, 1'b0, 4'b0100); // Reverse of 0010 = 0100
    run_test (4'b0100, 4'b0000, 1'b0, 4'b0010); // Reverse of 0100 = 0010
    run_test (4'b1000, 4'b0000, 1'b0, 4'b0001); // Reverse of 1000 = 0001
    run_test (4'b1100, 4'b0000, 1'b0, 4'b0011); // Reverse of 1100 = 0011
    run_test (4'b1010, 4'b0000, 1'b0, 4'b0101); // Reverse of 1010 = 0101
    run_test (4'b1111, 4'b0000, 1'b0, 4'b1111); // Reverse of 1111 = 1111
    run_test (4'b0011, 4'b0000, 1'b0, 4'b1100); // Reverse of 0011 = 1100
    run_test (4'b0110, 4'b0000, 1'b0, 4'b0110); // Reverse of 0110 = 0110
    run_test (4'b1001, 4'b0000, 1'b0, 4'b1001); // Reverse of 1001 = 1001
    run_test (4'b0111, 4'b0000, 1'b0, 4'b1110); // Reverse of 0111 = 1110


    // when Sel is 1 which indicates the reverse of B :
    run_test (4'b0000, 4'b0001, 1'b1, 4'b1000); // Reverse of 0001 = 1000
    run_test (4'b0000, 4'b0010, 1'b1, 4'b0100); // Reverse of 0010 = 0100
    run_test (4'b0000, 4'b0100, 1'b1, 4'b0010); // Reverse of 0100 = 0010
    run_test (4'b0000, 4'b1000, 1'b1, 4'b0001); // Reverse of 1000 = 0001
    run_test (4'b0000, 4'b1100, 1'b1, 4'b0011); // Reverse of 1100 = 0011
    run_test (4'b0000, 4'b1010, 1'b1, 4'b0101); // Reverse of 1010 = 0101
    run_test (4'b0000, 4'b1111, 1'b1, 4'b1111); // Reverse of 1111 = 1111
    run_test (4'b0000, 4'b0011, 1'b1, 4'b1100); // Reverse of 0011 = 1100
    run_test (4'b0000, 4'b0110, 1'b1, 4'b0110); // Reverse of 0110 = 0110
    run_test (4'b0000, 4'b1001, 1'b1, 4'b1001); // Reverse of 1001 = 1001
    run_test (4'b0000, 4'b0111, 1'b1, 4'b1110); // Reverse of 0111 = 1110
    
    if ( error_count == 0 ) begin 
    $display("All Cases Passes") ;
    end 
    else begin 
    $display("Test Completed with %0d errors " , error_count ) ;
    end

    $stop ;

    end                    

   task run_test (
        input [3:0] A_in , B_in , 
        input Sel_in ,
        input [3:0] Expected_Out
   );   
     begin 
      
      A = A_in ;
      B = B_in ;
      Sel = Sel_in ;
      # 10 ;
      if ( Out !== Expected_Out ) begin 
      $display ("Error at time %0t : A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , expected_Out = %b (%0d) , gotten Out = %b (%0d) " ,
                $time , A , A , B , B , Sel , Sel, Expected_Out , Expected_Out , Out , Out ) ;
       error_count = error_count + 1 ;
      end 
      else begin  
      $display ("PASS : A = %b (%0d)  , B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) " ,
                       A , A , B , B , Sel , Sel , Out , Out) ;
      end    
     end  
   endtask                     
endmodule 


module Incrementer ( 
 input [3:0] A , B , 
 output [4:0] A_Inc , B_Inc  
);
four_bit_adder F1 ( .A ( A ) ,
                    .B ( 4'b0001 ) ,
                    .carry_in ( 1'b0 ) ,
                    .Sum ( A_Inc[3:0] ),
                    .carry_out ( A_Inc[4]) 
                 );

four_bit_adder F2 ( .A ( B ) ,
                    .B ( 4'b0001 ) ,
                    .carry_in ( 1'b0 ) ,
                    .Sum ( B_Inc[3:0] ),
                    .carry_out ( B_Inc[4] ) 
                 );


endmodule 



module Incrementer_Top_Module (
   input [3:0] A , B ,
   input Sel ,
   output [3:0] Out ,
   output Carry_Out_Inc  
);

wire [3:0] A_INC , B_INC ;
wire Carry_A_Inc , Carry_B_Inc ;

Incrementer Inc_1( .A ( A ) ,
                   .B ( B ) , 
                   .A_Inc ( { Carry_A_Inc , A_INC } ) ,
                   .B_Inc ( { Carry_B_Inc , B_INC } ) 
                 );
Mux_2_to_1_four_bits Mux_1 ( .A ( A_INC ) , 
                             .B ( B_INC ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

Mux_2_to_1_four_bits Mux_2 ( .A ( Carry_A_Inc ) , 
                             .B ( Carry_B_Inc ),
                             .Sel ( Sel ) , 
                             .Out ( Carry_Out_Inc )
                           );


endmodule

module Incrementer_Top_Module_TB () ;
  
  parameter Delay = 10 ;
  
   reg [3:0] A , B ;
   reg Sel ;
   wire [3:0] Out ;
   wire Carry_Out_Inc ;
   integer error_count = 0  ;

   Incrementer_Top_Module M_1 ( .A( A ) ,
                                .B( B ) ,
                                .Sel( Sel ) ,
                                .Out( Out ) ,
                                .Carry_Out_Inc( Carry_Out_Inc )  
                              );
   initial begin 
   $monitor("A : %b (%0d) , B : %b (%0d) , Sel : %b (%0d) , Out : %b (%0d) , Carry_Out_Inc : %b (%0d)" ,
             A , A , B , B , Sel , Sel , Out , Out , Carry_Out_Inc , Carry_Out_Inc ) ;
   end 
   
   initial begin 

   // Testing Incremneter for A when Sel = 0
  run_test (4'b0000, 4'b0000, 4'b0, 4'b0001, 4'b0);
  run_test (4'b0001, 4'b0000, 4'b0, 4'b0010, 4'b0);
  run_test (4'b0010, 4'b0000, 4'b0, 4'b0011, 4'b0);
  run_test (4'b0100, 4'b0000, 4'b0, 4'b0101, 4'b0);
  run_test (4'b0101, 4'b0000, 4'b0, 4'b0110, 4'b0);
  run_test (4'b0111, 4'b0000, 4'b0, 4'b1000, 4'b0);
  run_test (4'b0110, 4'b0000, 4'b0, 4'b0111, 4'b0);
  run_test (4'b1000, 4'b0000, 4'b0, 4'b1001, 4'b0);
  run_test (4'b1010, 4'b0000, 4'b0, 4'b1011, 4'b0);
  run_test (4'b1011, 4'b0000, 4'b0, 4'b1100, 4'b0);
  run_test (4'b1111, 4'b0000, 4'b0, 4'b0000, 4'b1);
  run_test (4'b1100, 4'b0000, 4'b0, 4'b1101, 4'b0);
  run_test (4'b1101, 4'b0000, 4'b0, 4'b1110, 4'b0);
  run_test (4'b0011, 4'b0000, 4'b0, 4'b0100, 4'b0);
  
  // Testing Incremneter for B when Sel = 1
  run_test (4'b0000, 4'b0000, 4'b1, 4'b0001, 4'b0);
  run_test (4'b0000, 4'b0001, 4'b1, 4'b0010, 4'b0);
  run_test (4'b0000, 4'b0010, 4'b1, 4'b0011, 4'b0);
  run_test (4'b0000, 4'b0100, 4'b1, 4'b0101, 4'b0);
  run_test (4'b0000, 4'b0101, 4'b1, 4'b0110, 4'b0);
  run_test (4'b0000, 4'b0111, 4'b1, 4'b1000, 4'b0);
  run_test (4'b0000, 4'b0110, 4'b1, 4'b0111, 4'b0);
  run_test (4'b0000, 4'b1000, 4'b1, 4'b1001, 4'b0);
  run_test (4'b0000, 4'b1010, 4'b1, 4'b1011, 4'b0);
  run_test (4'b0000, 4'b1011, 4'b1, 4'b1100, 4'b0);
  run_test (4'b0000, 4'b1111, 4'b1, 4'b0000, 4'b1);
  run_test (4'b0000, 4'b1100, 4'b1, 4'b1101, 4'b0);
  run_test (4'b0000, 4'b1101, 4'b1, 4'b1110, 4'b0);
  run_test (4'b0000, 4'b0011, 4'b1, 4'b0100, 4'b0);


   if (error_count == 0) begin 
   $display("All Cases Passes Successfully");
   end 
   else begin 
   $display("There are %0d errors" , error_count);
   end 

   $stop ;
   end  
   
   task run_test (
      input [3:0] A_in , B_in ,
      input Sel_in ,
      input [3:0] Expected_Out ,
      input Expected_Carry_Out  
   ); 
   begin

    A = A_in ;
    B = B_in ;
    Sel = Sel_in ;
    #Delay 
   
    if ((Out !== Expected_Out) && (Carry_Out_Inc !== Expected_Carry_Out))
    begin
    $display("Error at time : %0t , A : %b , B : %b (%0d) , Sel : %b (%0d) , Expected_Out : %b (%0d) , Gotten Out : %b (%0d)" ,
                A , A , B , B , Sel , Sel , Expected_Out , Expected_Out , Out , Out ) ;
            error_count = error_count + 1 ;    
    end 
    else begin
      $display("PASS : A = %b (%d) , B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d)" ,
                A , A , B , B , Sel , Sel , Out , Out ) ; 
    end 
   end
   endtask

endmodule 


module second_complement (
  input [3:0] A ,
  output [3:0] A_New
);

assign A_New[0] = A[0] ^ 1'b0 ;
assign A_New[1] = A[1] ^ A[0] ;
assign A_New[2] = (A[1] | A[2]) ^ A[3] ;
assign A_New[3] = (A[0] | A[1] | A[2]) ^ A[3] ;

endmodule 


module Decrementer (
   input [3:0] A , B ,
   output [3:0] A_Dec , B_Dec ,
   output Negative_Sign_Flag_A , Negative_Sign_Flag_B
);

wire [3:0] A_Dec_Sec_1 , B_Dec_Sec_1 ;
wire [3:0] A_Dec_Sec_2 , B_Dec_Sec_2 ;
wire Carry_Out_A , Carry_Out_B ;

four_bit_adder F1 ( .A ( A ) ,
                    .B ( 4'b1110 ) ,
                    .carry_in ( 1'b1 ) ,
                    .Sum ( A_Dec_Sec_1 ),
                    .carry_out ( Carry_Out_A ) 
                 );

four_bit_adder F2 ( .A ( B ) ,
                    .B ( 4'b1110 ) ,
                    .carry_in ( 1'b1 ) ,
                    .Sum ( B_Dec_Sec_1 ),
                    .carry_out ( Carry_Out_B ) 
                 );

second_complement SC1( .A ( A_Dec_Sec_1 ) ,
                       .A_New ( A_Dec_Sec_2 )
                     );

second_complement SC2( .A ( B_Dec_Sec_1 ) ,
                       .A_New ( B_Dec_Sec_2 )
                     );

assign Negative_Sign_Flag_A = ~ ( Carry_Out_A ) ;
assign Negative_Sign_Flag_B = ~ ( Carry_Out_B ) ;

Mux_2_to_1_four_bits Mux_1 ( .A ( A_Dec_Sec_2 ) , 
                             .B ( A_Dec_Sec_1 ),
                             .Sel ( Carry_Out_A ) , 
                             .Out ( A_Dec )
                           );

Mux_2_to_1_four_bits Mux_2 ( .A ( B_Dec_Sec_2 ) , 
                             .B ( B_Dec_Sec_1 ),
                             .Sel ( Carry_Out_B ) , 
                             .Out ( B_Dec )
                           );

endmodule 

module Mux_2_to_1_one_bit (
  input A , B , 
  input Sel ,
  output Out 
);

assign Out = ( Sel ==0 ) ? A : B ;

endmodule 

module Decrementer_Top_Module (
      input [3:0] A , B ,
      input Sel ,
      output [3:0] Out ,
      output Negative_Sign_Flag
);

wire [3:0] Total_Sum_A , Total_Sum_B ;
wire neg_Falg_A , neg_Flag_B ;

Decrementer D1( .A ( A ) ,
                .B ( B ) ,
                .A_Dec ( Total_Sum_A ) ,
                .B_Dec ( Total_Sum_B ) ,
                .Negative_Sign_Flag_A ( neg_Falg_A ) , 
                .Negative_Sign_Flag_B ( neg_Flag_B )
              );

Mux_2_to_1_four_bits Mux_1 ( .A ( Total_Sum_A ) , 
                             .B ( Total_Sum_B ),
                             .Sel ( Sel ) , 
                             .Out ( Out )
                           );

Mux_2_to_1_one_bit M_1 ( .A( neg_Falg_A ) , 
                         .B( neg_Flag_B ) , 
                         .Sel( Sel ) ,
                         .Out( Negative_Sign_Flag ) 
                       );

endmodule 

module Decrementer_Top_Module_TB () ;

parameter Delay = 10 ;

reg [3:0] A , B ;
reg Sel ;
wire [3:0] Out ;
wire Negative_Sign_Flag ;
integer error_count = 0 ;

Decrementer_Top_Module M1( .A ( A ) ,
                           .B ( B ) ,
                           .Sel ( Sel ) ,
                           .Out ( Out ) ,
                           .Negative_Sign_Flag ( Negative_Sign_Flag )
                         );

initial begin 
$monitor (" A : %b  (%0d)   ,  B : %b  (%0d)  , Sel : %b  (%0d)  , Out : %b  (%0d) , Sign : %b (%0d)",
            A  ,  A  , B  , B , Sel , Sel , Out , Out , Negative_Sign_Flag , Negative_Sign_Flag ) ;
end 

initial begin

// when Sel 0 for decrement of A 
run_test(4'b0000, 4'b0000, 1'b0, 4'b0001, 1'b1);
run_test(4'b0001, 4'b0000, 1'b0, 4'b0000, 1'b0);
run_test(4'b0010, 4'b0000, 1'b0, 4'b0001, 1'b0);
run_test(4'b0011, 4'b0000, 1'b0, 4'b0010, 1'b0);
run_test(4'b0100, 4'b0000, 1'b0, 4'b0011, 1'b0);
run_test(4'b0101, 4'b0000, 1'b0, 4'b0100, 1'b0);
run_test(4'b0110, 4'b0000, 1'b0, 4'b0101, 1'b0);
run_test(4'b0111, 4'b0000, 1'b0, 4'b0110, 1'b0);
run_test(4'b1000, 4'b0000, 1'b0, 4'b0111, 1'b0);
run_test(4'b1001, 4'b0000, 1'b0, 4'b1000, 1'b0);
run_test(4'b1010, 4'b0000, 1'b0, 4'b1001, 1'b0);
run_test(4'b1111, 4'b0000, 1'b0, 4'b1110, 1'b0);

// when Sel 1 for decrement of B 
run_test(4'b0000, 4'b0001, 1'b1, 4'b0000, 1'b0);
run_test(4'b0000, 4'b0000, 1'b1, 4'b0001, 1'b1);
run_test(4'b0000, 4'b0010, 1'b1, 4'b0001, 1'b0);
run_test(4'b0000, 4'b0011, 1'b1, 4'b0010, 1'b0);
run_test(4'b0000, 4'b0100, 1'b1, 4'b0011, 1'b0);
run_test(4'b0000, 4'b0101, 1'b1, 4'b0100, 1'b0);
run_test(4'b0000, 4'b0110, 1'b1, 4'b0101, 1'b0);
run_test(4'b0000, 4'b0111, 1'b1, 4'b0110, 1'b0);
run_test(4'b0000, 4'b1000, 1'b1, 4'b0111, 1'b0);
run_test(4'b0000, 4'b1001, 1'b1, 4'b1000, 1'b0);
run_test(4'b0000, 4'b1010, 1'b1, 4'b1001, 1'b0);
run_test(4'b0000, 4'b1111, 1'b1, 4'b1110, 1'b0);

if (error_count == 0) begin  
$display("All Cases Passes Successfully") ; 
end 
else begin
$display("there is %0d errors " , error_count); 
end 

$stop;

end 

task run_test (
   input [3:0] A_in , B_in ,
   input Sel_in ,
   input [3:0] Expected_Out ,
   input Expected_Sign 
);
  begin 
  
  A = A_in ;
  B = B_in ;
  Sel = Sel_in ;
  # Delay  
  if ((Out !== Expected_Out) && ( Negative_Sign_Flag !== Expected_Sign )) begin 
  $display("error at time %0t  when A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , Expected_Out = %b (%0d) , Gotten_Out = %b (%0d)   
               , Expected Sign = %b (%0d) , Negative_Sign_Flag = %b (%0d) ",
            $time , A , A , B , B , Sel , Sel , Expected_Out , Expected_Out , Out , Out , Expected_Sign , Expected_Sign , Negative_Sign_Flag , Negative_Sign_Flag ) ;
            error_count = error_count + 1 ;
  end 
  else 
  $display ("PASS : A = %b (%0d) , B = %b (%0d) , Sel = %b (%0d) , Out = %b (%0d) , Sign = %b (%0d)",
              A , A , B , B , Sel , Sel , Out , Out , Negative_Sign_Flag , Negative_Sign_Flag );
  end  
endtask 

endmodule 


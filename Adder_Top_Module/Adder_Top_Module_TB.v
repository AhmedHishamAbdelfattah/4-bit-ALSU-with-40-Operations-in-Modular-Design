module Adder_Top_Module_TB ;

  parameter Width = 4; 
  parameter Width_Sel = 5;          
  parameter Output_Width = 4;    
  parameter Delay = 10;    

  reg [Width-1:0] A , B ; 
  reg [Width_Sel-1:0] Sel ;
  wire [Output_Width-1:0] Out ;
  wire carry_out ;
  wire Negative_Sign_Adder_Flag ;
  integer error_count = 0;

Adder_TOP_Module DUT( .A ( A ) ,
                      .B ( B ) , 
                      .Sel ( Sel ) ,
                      .Sum ( Out ) ,
                      .carry_out ( carry_out ) ,
                      .Negative_Sign_Adder_Flag( Negative_Sign_Adder_Flag )
                    );
  initial begin 

  // when Sel is 00 which indicates A+B 
  run_test(4'b0101, 4'b0100, 2'b00, 4'b1001, 1'b0, 1'b0);
  run_test(4'b0101, 4'b0011, 2'b00, 4'b1000, 1'b0, 1'b0);
  run_test(4'b0000, 4'b0000, 2'b00, 4'b0000, 1'b0, 1'b0);
  run_test(4'b1111, 4'b0011, 2'b00, 4'b0010, 1'b1, 1'b0);
  run_test(4'b0011, 4'b0101, 2'b00, 4'b1000, 1'b0, 1'b0);
  run_test(4'b1010, 4'b0001, 2'b00, 4'b1011, 1'b0, 1'b0);
  run_test(4'b1100, 4'b1101, 2'b00, 4'b1001, 1'b1, 1'b0);

  // when Sel is 01 which indicates A-B
  run_test(4'b0101, 4'b0100, 2'b01, 4'b0001, 1'b0, 1'b0);
  run_test(4'b0101, 4'b0011, 2'b01, 4'b0010, 1'b0, 1'b0);
  run_test(4'b0000, 4'b0000, 2'b01, 4'b0000, 1'b0, 1'b0);
  run_test(4'b1111, 4'b0011, 2'b01, 4'b1100, 1'b0, 1'b0);
  run_test(4'b0011, 4'b0101, 2'b01, 4'b0010, 1'b0, 1'b1);
  run_test(4'b1010, 4'b0001, 2'b01, 4'b1001, 1'b0, 1'b0);
  run_test(4'b1100, 4'b1101, 2'b01, 4'b0001, 1'b0, 1'b1);

  // when Sel is 01 which indicates 2's comp.(B)
  run_test(4'b0101, 4'b1100, 2'b10, 4'b0100, 1'b0, 1'b0);
  run_test(4'b0101, 4'b0101, 2'b10, 4'b1011, 1'b0, 1'b0);
  run_test(4'b0101, 4'b1111, 2'b10, 4'b0001, 1'b0, 1'b0);
  run_test(4'b0101, 4'b0011, 2'b10, 4'b1101, 1'b0, 1'b0);
  run_test(4'b0101, 4'b1010, 2'b10, 4'b0110, 1'b0, 1'b0);
  run_test(4'b0101, 4'b1101, 2'b10, 4'b0011, 1'b0, 1'b0);
  run_test(4'b0101, 4'b0001, 2'b10, 4'b1111, 1'b0, 1'b0);
  run_test(4'b0101, 4'b0010, 2'b10, 4'b1110, 1'b0, 1'b0);
  run_test(4'b0101, 4'b1000, 2'b10, 4'b1000, 1'b0, 1'b0);

  // when Sel is 11 which indicates 2's comp.(A)
  run_test(4'b0101, 4'b1000, 2'b11, 4'b1011, 1'b0, 1'b0);
  run_test(4'b1100, 4'b1000, 2'b11, 4'b0100, 1'b0, 1'b0);
  run_test(4'b0001, 4'b1000, 2'b11, 4'b1111, 1'b0, 1'b0);
  run_test(4'b0011, 4'b1000, 2'b11, 4'b1101, 1'b0, 1'b0);
  run_test(4'b1010, 4'b1000, 2'b11, 4'b0110, 1'b0, 1'b0);
  run_test(4'b1101, 4'b1000, 2'b11, 4'b0011, 1'b0, 1'b0);
  run_test(4'b0001, 4'b1000, 2'b11, 4'b1111, 1'b0, 1'b0);
  run_test(4'b0010, 4'b1000, 2'b11, 4'b1110, 1'b0, 1'b0);
  run_test(4'b1000, 4'b1000, 2'b11, 4'b1000, 1'b0, 1'b0);
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
    input expected_carry_out,
    input Expected_Sign_Flag
  );
    begin
      A = a_in;
      B = b_in;
      Sel = Sel_in;
      #Delay; 
      if ( (Out !== expected_out) && (carry_out !== expected_carry_out ) && (Expected_Sign_Flag !== Negative_Sign_Adder_Flag)) begin
        $display("ERROR at time %0t: A=%b (%0d), B=%b (%0d), Sel=%b (%0d), Expected Out=%b (%0d), Got Out=%b (%0d), Expected Carry=%b (%0d), Got Carry Out=%b (%0d), Expected Sign Flag=%b (%0d)",  
                 $time, A, A, B, B, Sel, Sel, expected_out, expected_out, Out, Out, expected_carry_out, expected_carry_out , carry_out, carry_out , Expected_Sign_Flag , Expected_Sign_Flag , Negative_Sign_Adder_Flag , Negative_Sign_Adder_Flag);
        error_count = error_count + 1;
      end else begin
        $display("PASS: A=%0d, B=%0d, Sel=%b, Out=%0d", A, B, Sel, Out, carry_out);
      end
    end
  endtask

endmodule 

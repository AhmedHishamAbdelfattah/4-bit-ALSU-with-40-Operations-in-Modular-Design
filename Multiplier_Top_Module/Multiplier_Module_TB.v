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

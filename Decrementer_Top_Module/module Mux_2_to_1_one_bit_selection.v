module Mux_2_to_1_one_bit (
  input A , B , 
  input Sel ,
  output Out 
);

assign Out = ( Sel ==0 ) ? A : B ;

endmodule 

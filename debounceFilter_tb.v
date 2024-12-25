
`timescale 1ns / 1ps

module debounceFilter_tb( );
  
 
  parameter MAIN_CLK_DELAY = 10;  
  reg clock,reset;
  reg in;
  wire out;
  debFilter deInst (.clock(clock),.reset(reset),.in(in),.out(out));      
initial begin
  clock = 1'b0;
  forever #(MAIN_CLK_DELAY) clock = ~clock;  
end 

initial begin
    reset=0;in=0;#1000; reset=1;#1000;
    in=0;
    #100;
    in=1;
    #200;
    in=0;
    #10;
    in=1;
    #600;
    in=0;
    #40;
    in=1;
    #200;
    in=0;
    



 
   

end

endmodule

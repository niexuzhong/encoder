// DetectEdge.v
module DetectREdge(clock,reset,pluse,REdge);
input clock,reset,pluse;
output REdge;


reg firreg,secreg;
wire EdgeV;




 always @(posedge clock or negedge reset)
 begin
       if(reset==1'b0)
       begin
           firreg<=1'b1;
           secreg<=1'b1;
       end
       else
       begin
          firreg<=pluse;
          secreg<=firreg;
       end
 end
 assign EdgeV=firreg^secreg;
 assign REdge=~(EdgeV&firreg);
endmodule
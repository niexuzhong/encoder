module encoderCnt(clock,reset,phaseA,phaseB,direction,cntSetting);
input clock,reset,phaseA,phaseB;
input [2:0] cntSetting;
output reg direction;
localparam REGUALCNT=3'd0,DOUBLECNT=3'd1,QUADCNT=3'd2;
reg [1:0] Ar, Br;

wire A_posedge = (Ar==2'b01); // now we can detect A rising edges
wire A_negedge = (Ar==2'b10); // and falling edges
wire B_posedge = (Br==2'b01); // now we can detect B rising edges
wire B_negedge = (Br==2'b10); // and falling edges



always @(posedge clock or negedge reset)
begin
    if(reset==1'b0)
    begin
        direction<=1'b0;
    end
    else
    begin
        Ar <= {Ar[0], phaseA};
        Br <= {Br[0], phaseB};
        if (A_posedge)
        begin
           if (Br[1]==1'b0&&((cntSetting==REGUALCNT)||(cntSetting==DOUBLECNT)||(cntSetting==QUADCNT))) 
              direction<=1'b0;  // A leads B
           else if((Br[1]==1'b1)&&((cntSetting==QUADCNT)||(cntSetting==DOUBLECNT)))
              direction<=1'b1;
           else 
           begin
              direction<=1'b1;
           end
        end
        else if (A_negedge)
        begin  
           if ((Br[1]==1'b1)&&((cntSetting==QUADCNT)||(cntSetting==DOUBLECNT))) 
              direction<=1'b0;
           else if((Br[1]==1'b0)&&((cntSetting==REGUALCNT)||(cntSetting==DOUBLECNT)||(cntSetting==QUADCNT)))
              direction<=1'b1;
           else
           begin
              direction<=1'b1;
           end
        end
        else if (B_posedge)
        begin
           if ((Ar[1]==1'b1)&&((cntSetting==QUADCNT))) 
                direction<=1'b0;
           else if((Ar[1]==1'b0)&&(cntSetting==QUADCNT))
                direction<=1'b1;
           else
           begin
               direction<=1'b1;
           end
        end
        else if (B_negedge)
        begin        
        if ((Ar[1]==1'b0)&&(cntSetting==QUADCNT)) 
            direction<=0;
        else if((Ar[1]==1)&&((cntSetting==QUADCNT)))
            direction<=1'b1;
        else
        begin
            direction<=1'b1;
        end
       end
       else 
       begin
         direction<=1'b1;          
       end  
    end
end
endmodule

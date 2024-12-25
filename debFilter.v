module debFilter #(parameter SAMPLEWIDTH=4'd0) (clock,reset,in,out);
input clock;
input reset;
input in;
output out;
reg [2:0] samples;
reg rx_filtered;
reg [SAMPLEWIDTH-1:0] samplesCount;
reg sampleRx;
assign out=rx_filtered;


always @(posedge clock or negedge reset)
begin
    if(reset==1'b0)
        samplesCount<=12'd0;
    else
    begin
        samplesCount<=samplesCount+1;
    end
end

DetectREdge detectInst(.clock(clock),.reset(reset),.pluse(samplesCount[SAMPLEWIDTH-1]),.REdge(sampleClock)) ;
always@(posedge clock)
begin
      
         if(sampleClock==1'b0)
            sampleRx<=in;
         else
            sampleRx<=sampleRx;
     
end

always @(posedge clock or negedge reset)
begin : majority
  if (reset==1'b0)
  begin
    samples <= 3'b111;        
  end
  else
  begin
      if(sampleClock==1'b0)
      begin
          samples[1:0] <= samples[2:1];  
          samples[2] <= sampleRx;     
      end
    
  end
end

//  our voter
always @(samples)
begin
  case (samples)
    3'b000:
    begin
      rx_filtered <= 1'b0;      
    end
    3'b001:
    begin
      rx_filtered <= 1'b0;      
    end
    3'b010:
    begin
      rx_filtered <= 1'b0;      
    end
    3'b011:
    begin
      rx_filtered <= 1'b1;      
    end
    3'b100:
    begin
      rx_filtered <= 1'b0;      
    end
    3'b101:
    begin
      rx_filtered <= 1'b1;      
    end
    3'b110:
    begin
      rx_filtered <= 1'b1;      
    end
    default:
    begin
      rx_filtered <= 1'b1;      
    end
  endcase
end
endmodule
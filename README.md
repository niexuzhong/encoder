# encoder
encoder is verilog file for encoder(QEI),you can use it directly to read input of optical increment encoder. the port is listed as following:
clock,reset, clock and reset pin 
phaseA,phaseB, input for A and B for encoder.the phase is 90 degree (of course the phase difference is not fixed in fact)
direction,the direction output, 0 is clockwise, 1 is unclockwise
cntSetting  the count mode for encoder, it is regual double or quart.
debounce filter is vote method to remove the spike for digital wave,the SAMPLEWIDTH is the internal counter for sample clock, if you want to high speed file, you can decrease these value

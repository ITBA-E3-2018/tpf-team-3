module tstBench;
wire clock,hs,vs,d,pix;
 wire[7:0] tth;
 wire[7:0] ttm;
 wire[7:0] tts;
reg reset,start;
clock_gen mclk(clock);
//(pixelClock,h_sync_signal,v_sync_signal,draw);
//module mtimer(clk,reset,ss,th,tm,ts);
//mtimer timer(clock,reset,start,tth,ttm,tts);
mmsync vga_sync (clock,hs,vs,d);
//timeprinter(pixelclock,hsinc,vsinc,draw,th,tm,ts,pixel);
printvga printer (clock,hs,vs,d,1,1,1,pix);
  initial begin
    #150000
    $finish;

  end
reg dummy;
  reg[8*64:0] dumpfile_path = "output.vcd";
 initial begin
    dummy = $value$plusargs("VCD_PATH=%s", dumpfile_path);
    $dumpfile(dumpfile_path);
    $dumpvars(0,tstBench);
  end
endmodule

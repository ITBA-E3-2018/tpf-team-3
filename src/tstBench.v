module tstBench;
wire clock,hs,vs,d;
 wire[7:0] tth;
 wire[7:0] ttm;
 wire[7:0] tts;
reg reset,start;
clock_gen mclk(clock);
//(pixelClock,h_sync_signal,v_sync_signal,draw);
//module mtimer(clk,reset,ss,th,tm,ts);
mtimer timer(clock,reset,start,tth,ttm,tts);
//mmsync vga_sync (clock,hs,vs,d);

  initial begin
    reset=1;
    start=0;
    #2;
    reset=0;
    start=1;
    #2;
    start=0;
    #36000;
    reset=1;
    #2;
    reset=0;
    start=1;
    #2;
    start=0;
    #2;
     start=1;
    #2;
    start=0;
    #10;
     start=1;
    #2;
    start=0;
    #500;

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

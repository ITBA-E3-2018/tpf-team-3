module tstBench;
wire clock,hs,vs,d;
//(pixelClock,h_sync_signal,v_sync_signal,draw);
clock_gen mclk(clock);
msync vga_sync (clock,hs,vs,d);

  initial begin

    #1000000;
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

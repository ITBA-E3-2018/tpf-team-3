module msync(pixelClock,h_sync_signal,v_sync_signal,draw);
input wire pixelClock;
output wire h_sync_signal,v_sync_signal,draw;

parameter h_whith = 640; //ancho en pixeles de la panxalla
parameter h_front_porch=16;//tiempo en pixleclocks de el pulso se h sunc
parameter h_back_porch=96;
parameter h_sync_pulse=48;

parameter one_row= h_whith + h_front_porch + h_back_porch + h_sync_pulse;

parameter v_whith = 480;
parameter v_front_porch=10 * one_row;
parameter v_back_porch=33 * one_row;
parameter v_sync_pulse=2 *one_row;

endmodule

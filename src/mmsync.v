module mmsync(pixelClock,h_sync_signal,v_sync_signal,draw);
input wire pixelClock;
output wire h_sync_signal,v_sync_signal,draw;

//**********Caracterisitcas de la pantalla*********************
parameter h_whith = 640; //ancho en pixeles de la pantalla
parameter h_front_porch=16;//tiempo en pixleclocks de el pulso de h sync
parameter h_back_porch=48;
parameter h_sync_pulse=96;

parameter one_row=800;

parameter v_whith = 480;
parameter v_front_porch=10;
parameter v_back_porch=33;
parameter v_sync_pulse=2;
//******fin Caracterisitcas de la pantalla*********************

 reg[15:0] h_count=0;//contador de columnas y tambien utilizado para contar pulsos de clocks
 reg[15:0] v_count=0;//contador de filas
 
 assign h_sync_signal =((h_whith+h_front_porch)<=h_count)&&(h_count<(h_whith+h_front_porch+h_sync_pulse));
 assign v_sync_signal =((v_whith+v_front_porch)<=v_count)&&(v_count<(v_whith+v_front_porch+v_sync_pulse));
 assign draw=(h_count<(h_whith))&&(v_count<v_whith);
always @ (posedge pixelClock) begin
    
    if(h_count==(h_whith+h_front_porch+h_sync_pulse+ h_back_porch)-1) begin
        h_count<=0;
        v_count<=v_count+1;
    end else begin
        h_count<=h_count+1;
    end

    if(v_count==(v_whith+v_front_porch+v_sync_pulse+v_back_porch))begin
        v_count<=0;
    end
end


endmodule

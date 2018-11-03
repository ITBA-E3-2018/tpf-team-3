module msync(pixelClock,h_sync_signal,v_sync_signal,draw);
input wire pixelClock;
output reg h_sync_signal,v_sync_signal,draw;

//**********Caracterisitcas de la pantalla*********************
parameter h_whith = 640; //ancho en pixeles de la pantalla
parameter h_front_porch=16;//tiempo en pixleclocks de el pulso de h sync
parameter h_back_porch=96;
parameter h_sync_pulse=48;

parameter one_row= h_whith + h_front_porch + h_back_porch + h_sync_pulse;

parameter v_whith = 480;
parameter v_front_porch=10 * one_row;
parameter v_back_porch=33 * one_row;
parameter v_sync_pulse=2 *one_row;
//******fin Caracterisitcas de la pantalla*********************

//********Estados de la FSM*******************
parameter st_printing_line=0;

parameter st_h_fp=1;
parameter st_h_sync=2;
parameter st_h_bp=3;

parameter st_v_bp=4;
parameter st_v_fp=5;
parameter st_v_sync=6;

//*******fin Estados de la FSM***************



 reg[9:0] h_count=0;//contador de columnas 
 reg[8:0] v_count=0;//contador de filas
 reg[3:0] state=0;// estados de la fsm

 always @ (posedge pixelClock) begin
    case(state)
        st_printing_line: begin
            
            h_sync_signal=0;
            v_sync_signal=0;
            draw=1;
            if (h_count==(h_whith-1)) begin // si ya se mandaron todos los pixeles, paso a generar la señal de h syn para el monitor
                state=st_h_fp;
                h_count=0;

            end else begin
                h_count=h_count+1; // aumento el contador de pixeles
            end

        end

        st_h_fp: begin
            draw=0;
            h_sync_signal=0;
            if (h_count==(h_front_porch-1)) begin
                state=st_h_sync;
                h_count=0;
            end else begin
                h_count=h_count+1;
            end
        end

         st_h_sync: begin
            h_sync_signal=1;
            if (h_count==(h_sync_pulse-1)) begin
                state=st_h_bp;
                h_count=0;
            end else begin
                h_count=h_count+1;
            end
         end

        st_h_bp: begin
            draw=0;
            h_sync_signal=0;
            if (h_count==(h_front_porch-1)) begin//termine de enviar la señal de sincronismo
                if(v_count==(v_whith-1))begin//chequeo si ya imprimi todas las filas
                    v_count=0;
                    state=st_v_fp;
                    h_count=0;
                end else begin//como no se imprimieron todas las filas vuelvo al comienzo
                    v_count=v_count+1;
                    state=st_printing_line;
                end
               
            end else begin
                h_count=h_count+1;
            end
        end

        default: begin
        end

    endcase

 end







endmodule

module printvga(pixelclock,hsinc,vsinc,draw,th,tm,ts,pixel);
input pixelclock,hsinc,vsinc,draw,th,tm,ts;
reg [0:14] digit [0:10];
output reg pixel;
parameter boxSize=10;//cuantas veces se va a repetir cada pixel

parameter h_whith = 800;//ancho efectivo de la pantalla
parameter v_whith = 525;// alto efectivo de la pantalla
parameter vOffset=0;
parameter hOffset=5;
parameter digitAmount=8;//cantidad de digitos que se imprimen incluyendo los dos puntos
parameter digith=5;//alto del digito
parameter digitw=3;//ancho del digito
parameter d0= 15'b111101101101111;// numero 0
parameter d1= 15'b001001001001001;// numero 1
parameter d2= 15'b111001111100111;// numero 2
parameter d3=15'b111001111001111;// numero 3
parameter d4=15'b101101111001001;// numero 4
parameter d5=15'b111100111001111;// numero 5
parameter d6=15'b111100111101111;// numero 6
parameter d7=15'b111001111001001;// numero 7
parameter d8=15'b111101111101111;// numero 8
parameter d9=15'b111101111001001;// numero 9
parameter dpuntos=15'b000010000010000;// dos puntos verticales

reg [3:0] dataToPlot [7:0];
reg[15:0] h_count=0;//contador de columnas y tambien utilizado para contar pulsos de clocks
reg[15:0] v_count=0;//contador de fila
reg [2:0] printingPart=0;//contador de que parte de la line horizontal se esta imprimeinto
reg[7:0] hrepeat=0;
reg once=1;

always @ (posedge pixelclock) begin
    if(once==1)begin//cargo los numeros en un arreglo
        digit[0]=d0;
        digit[1]=d1;
        digit[2]=d2;
        digit[3]=d3;
        digit[4]=d4;
        digit[5]=d5;
        digit[6]=d6;
        digit[7]=d7;
        digit[8]=d8;
        digit[9]=d9;
        digit[10]=dpuntos;
        once=0;
        dataToPlot[0]=1;
        dataToPlot[1]=2;
        dataToPlot[2]=10;
        dataToPlot[3]=3;
        dataToPlot[4]=4;
        dataToPlot[5]=10;
        dataToPlot[6]=5;
        dataToPlot[7]=6;   
        
    end

    if((draw==1)&&(h_count>hOffset-1)&&(h_count<(hOffset+(digitAmount*boxSize*digitw)))&&(v_count>vOffset)&&(v_count<(vOffset+(boxSize*digith)))) begin
        if(hrepeat<(boxSize*digitw)-1)begin
        hrepeat=hrepeat+1;
        end else begin
        hrepeat=0;
        end
        pixel=digit[dataToPlot[(h_count-hOffset)/(digitw*boxSize)]][((v_count/boxSize)*digitw)+(hrepeat/boxSize)];
       //$write("%b",pixel);
       // $write("%d",((h_count)/30));
        
        
        
    end else begin
	 pixel=0;
	 end



  if(h_count<h_whith-1)begin
       h_count=h_count+1;
    end else begin
    h_count=0;
    hrepeat=0;
    end


    
    end

always @ (posedge hsinc) begin
    if(v_count<v_whith-1)begin
        v_count=v_count+1;//cada vez que hay un pulso de h sync se incremente al numero de fila
    end else begin
    v_count=0;
    end
    
    //$display (" ");

    end


endmodule
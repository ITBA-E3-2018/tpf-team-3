module timeprinter(pixelclock,hsinc,vsinc,draw,th,tm,ts,pixel);
input pixelclock,hsinc,vsinc,draw,th,tm,ts;
reg [0:14] digit [0:10];
output reg pixel;
parameter boxSize=10;//cuantas veces se va a repetir cada pixel
parameter levelNumber=5;
parameter withNumber=3;
parameter h_whith = 640;
parameter v_whith = 480;
parameter start2draw=35; //numero de filas que espero antes de escrivir el display
parameter d0= 15'b111101101101111;
parameter d1= 15'b001001001001001;
parameter d2= 15'b111001111100111;
parameter d3=15'b111001111001111;
parameter d4=15'b101101111001001;
parameter d5=15'b111100111001111;
parameter d6=15'b111100111101111;
parameter d7=15'b111001111001001;
parameter d8=15'b111101111101111;
parameter d9=15'b111101111001001;
parameter dpuntos=15'b000010000010000;
reg once=1;
reg endPrint=1;
reg endVertical=1;
reg [3:0] v_bitCount=0;//repetiziones verticales de cada bit
reg [3:0] h_bitCount=0;//cuenta las repeticiones horizontales
reg [3:0] printingPart=0;//contador de que parte de la line horizontal se esta imprimeinto
reg [3:0] levelPrinting=0;//nivel del numero que se imprime

reg cleanEnd=0;
reg cleanEnd2=0;

reg[15:0] h_count=0;//contador de columnas y tambien utilizado para contar pulsos de clocks
reg[15:0] v_count=0;//contador de filas

reg [3:0] thm=7;
reg [3:0] thl=0;

reg [3:0] tmm=3;
reg [3:0] tml=4;

reg [3:0] tsm=1;
reg [3:0] tsl=8;

always @ (posedge pixelclock) begin
    if(once==1)begin
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
    end
    if((v_count>(start2draw-1))&&(v_count<(start2draw+(boxSize*levelNumber)))&&(hsinc==1))begin
     if(v_bitCount<boxSize)begin
         endPrint=1;
     end
     end

    if((draw==1) && (v_count>(start2draw-1))&&(v_count<(start2draw+(boxSize*levelNumber)))&&(endPrint==1))begin
        //$display("bitcount %d ,draw %b ,endprint %b ",v_bitCount,draw,endPrint);
        if(h_bitCount<boxSize)begin//si todavia no conte el ancho del pixel mantengo el valor
            pixel=digit[thm][(levelPrinting*withNumber)+printingPart];
            $write("%b",pixel);
            h_bitCount=h_bitCount+1;
           //$write("%d",(levelPrinting*withNumber)+printingPart);
           //$write("%d",levelPrinting);
        end else begin
            if(printingPart<(withNumber-1))begin//TODO me parece que iria menos 1 en la condicion
                printingPart=printingPart+1;
            end else begin
                printingPart=0;
                endPrint=0;
            end
        
            h_bitCount=0;
        
        
        
        end
        
       // h_count=h_count+1;
    end else begin
        h_count=0;
        pixel=0;
    end
   h_count=h_count+1;  
end

always @ (posedge hsinc) begin
    v_count=v_count+1;//cada vez que hay un pulso de h sync se incremente al numero de fila
    $display (" ");
    
    if(v_count>499)begin
        v_count=0;
        levelPrinting=0;
        v_bitCount=0;
    end
    cleanEnd=0;
    if((v_count>(start2draw-1))&&(v_count<(start2draw+(boxSize*levelNumber))))begin
     if(v_bitCount<boxSize)begin
       v_bitCount=v_bitCount+1;
       //cleanEnd=1;
        //endPrint=1;
       //$display("%d",v_bitCount);
    end else begin
        v_bitCount=0;
        if(levelPrinting<levelNumber)begin
            levelPrinting=levelPrinting+1;
        end else
        levelPrinting=0; 
    end
end
end

always @ (posedge vsinc) begin
 //v_count=0;
// levelPrinting=0;
// v_bitCount=0;
end



endmodule


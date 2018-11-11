module mtimer(clk,reset,ss,th,tm,ts);
input clk,reset,ss;

parameter modulo = 60;
output reg[7:0] th=0;
output reg[7:0] tm=0;
output reg[7:0] ts=0;
reg status=0;

always @ (posedge clk) begin
    if(ss==1)begin
        status=!status;
    end
    if(status==1)begin
        ts=ts+1;
        
        if(ts==(modulo))begin
            ts=0;
            tm=tm+1;
        end
        if(tm==(modulo))begin
            tm=0;
            th=th+1;
        end
        if(th==(modulo))begin
            th=0;
        end

    end
    if(reset==1)begin
        status=0;
        ts=0;
        tm=0;
        th=0;
    end

end


endmodule
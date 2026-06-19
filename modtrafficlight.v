// instead of using ff for storing of both lights and states, why not
// store only states and display lights accordingly.
// So for that, a second always block is implemented, where blocking
//assignments are used so that ffs are not created and this is directly
//displayed.

module modtraffic (
clk, light
);
input clk;
input reg[2:0]light; //track 3 lights
parameter red =3'b100, yellow= 3'b010, green= 3'b001 ;
parameter s0 =2'b00, s1=2'b01, s2=2'b10 ;// if these are not used then
                                         // have to enter states mannually in cases
reg [0:1]state;  // 2 bits to define the 3 states
always@(posedge clk)
    case (state)
        s0: state<=s1;
        s1: state<= s2;
        s2: light<=red;
        default: 
            state<=s0;
    endcase
always@(posedge clk)
case (state)
    s0: light=yellow;
    s1: light=green;
    s2: light=red;

    default: light=red 
endcase
    
endmodule
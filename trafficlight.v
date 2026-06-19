//There are three lamps red, green and yellow that should glow cyclically.traffic
//FSM will have three states  correspondong to glowing states of lamps
//input set is null -- Moore machine
//
module traffic (clk, light);
input clk;
output reg[2:0]light;   //three lights, vector used.
parameter red =3'b100, yellow= 3'b010, green= 3'b001 ;
parameter s0 =2'b00, s1=2'b01, s2=2'b10 ;// if these are not used then
                                         // have to enter states mannually in cases
reg [0:1]state;  // 2 bits to define the 3 states
always@(posedge clk)
    case (state)
        s0: begin
            state<=s1;
            light<=yellow;
        end
        s1:
        begin
            state<= s2;
            light<=green;
        end
        s2:
        begin
            state<=s0;
            light<=red;
        end
        default: begin
            state<=s0;
        light<=red;
        end
    endcase

endmodule

// an issue here is state is not initialized and at the first clk, the state
// will go to the default s0 red. So an improvement will be to initialize the
// first state to s0 rather than going with the default case.
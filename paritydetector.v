//contonuous stream of bits is being fed and continuosly checked 
//if the input bit is odd or even.
//the continuos stream bit is fed in sync with the clk.
//even-->1   ; odd-->0


// MOORE MACHINE
// this is actually a moore machine as the output depends only on the state
// and not  the inputs


module paritydetector (x, clk,parity );
    input x;//wire as this gives something that's driven continuosly from outside
    input clk;
    output reg parity;  //reg used as assignment occurs inside always block
    reg even_odd;
    parameter even = 1, odd= 0;
    always @(posedge clk) 
    begin
        case (even_odd)
            even: even_odd<= x? odd:even;
            odd: even_odd<= x? even:odd;  
            default: even_odd<= even;
        endcase
    end
    always@(posedge clk)
    begin
        case (even_odd)//this approach is not creating a latch for the output
            even: parity= 1;// and here only the states are saved in latches
            odd: parity=0;
            default: parity=1;

            // even: parity<= x? 0:1;
            // odd:  parity<= x? 1:0;
            // this would have been the case if this was a mealy machine
            // output dependend on both input and state
        endcase
    end

endmodule

// here a better approach is initialising with reset, beacuse then the 
// parity is starting from 0. Here we have a default signal which will handle
// if there is any undefined state like x,z, but there is no strict
// initialisation. So it can be done: initialize, addition of reset signal
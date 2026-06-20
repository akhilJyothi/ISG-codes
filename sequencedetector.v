
// 0110 sequence detector
// There is continuos input bit stream and output bitstream z.
// z only outputs one if the bit pattern  '0110' occurs.
// Overlapping occurences are also detected.


// // this code corresponds to a moore machine as here the output is driven only
// // by the state and not  the input
// // Additionally here there is an additional issue where the sequence 
// // detected is 011 and not 0110(s3)
// module sequencedetector (x,z,clk);
//     input x,clk;  // x wire: continuocly driven
//     output reg  z;   // z is inside always block, will update the reg
//     reg [3:0]state;
//     parameter s0 =2'b00, s1= 2'b01, s2= 2'b10, s3=2'b11 ;
//     always @(posedge clk)
//     begin
//     case (state)
//        s0 :state<= x? s0:s1;
//        s1 :state<= x?s2:s1;
//        s2 :state<=x?s3:s1;
//        s3 :state<=x?s0:s1; 
//         default: state<=s0;
//     endcase    
//     end
//     always @(posedge clk) 
//     begin
//     case (state)           
//        s3 : z= 1;            // output controlled only by state
//         default: z=0;
//     endcase    
//     end
// endmodule


module sequencedetector (x,z,clk,reset);
    input x,clk,reset;  // x wire: continuocly driven
    output reg  z;   // z is inside always block, will update the reg
    reg [2:0]PS, NS;
    parameter s0 =2'b00, s1= 2'b01, s2= 2'b10, s3=2'b11 ;
    always @(posedge clk, posedge reset)
    begin
        if(reset)
        PS<=s0;
        else
            PS<=NS;
           
    end
    always @(PS,x) 
    begin
    case (PS)           
       s0: 
       begin               // use only blocking assingments for combinational 
        NS= x?s0:s1;          //block
        z= x? 0:0;
       end

       s1:
       begin               //combinational block -->> blocking assignmnets
        NS=x?s2:s1;
        z=x?0:0;
       end
       s2:
       begin
        NS=x?s3:s1;
        z=x?0:0;
       end
       s3:
       begin
        NS=x?s0:s1; //detecting overlap
        z=x?0:1;//// z giving one only if seq is detected
       end
    endcase    
    end
endmodule

module primeNumber(numMax, clk, rst, prime, numberChecked, numberOfPrimes);
    //Delcare all the inputs here
    input [10:0] numMax; //You only need 10 bits, but we'll use 11 just in case
    input clk; 
    input rst;

    //Declare all outputs here
    output reg prime;
    output reg [10:0] numberChecked; 
    output reg [10:0] numberOfPrimes; //There is no need for this many bits to be used, if we were to optimize this project, than maybe this number would be smaller

    //Declare Wire for prime lookups

    integer i;
    integer loopMax;
    integer count;  

    //Parameters for states
    parameter sOff = 0, sInit = 1, sCalc = 2, sDone = 3; 

    reg [1:0] state, stateNext;

    always @(posedge clk) begin 
        if (rst == 1) begin 
            state = sOff;
        end 
        else begin
            state = stateNext;
        end


        case(state)

            sOff: begin 
                if (rst == 0) begin 
                    stateNext = sInit; 
                end else begin 
                    stateNext = sOff; 
                end
            end

            sInit: begin 
                //Initialize all our variables
                count = 0; 
                i = 2;

                //Move states
                stateNext = sCalc; 
            end

            sCalc: begin 
                numberChecked = i; 
                //CASE STATEMENT WAS CHAT-GPT GENERATED
                //We double checked the AI with resource: https://www.vedantu.com/maths/prime-numbers-from-1-to-1000
                case (i)
                    // List of prime numbers
                    10'd2, 10'd3, 10'd5, 10'd7, 10'd11, 10'd13, 10'd17, 10'd19, 10'd23, 10'd29,
                    10'd31, 10'd37, 10'd41, 10'd43, 10'd47, 10'd53, 10'd59, 10'd61, 10'd67, 10'd71,
                    10'd73, 10'd79, 10'd83, 10'd89, 10'd97, 10'd101, 10'd103, 10'd107, 10'd109, 10'd113,
                    10'd127, 10'd131, 10'd137, 10'd139, 10'd149, 10'd151, 10'd157, 10'd163, 10'd167, 10'd173,
                    10'd179, 10'd181, 10'd191, 10'd193, 10'd197, 10'd199, 10'd211, 10'd223, 10'd227, 10'd229,
                    10'd233, 10'd239, 10'd241, 10'd251, 10'd257, 10'd263, 10'd269, 10'd271, 10'd277, 10'd281,
                    10'd283, 10'd293, 10'd307, 10'd311, 10'd313, 10'd317, 10'd331, 10'd337, 10'd347, 10'd349,
                    10'd353, 10'd359, 10'd367, 10'd373, 10'd379, 10'd383, 10'd389, 10'd397, 10'd401, 10'd409,
                    10'd419, 10'd421, 10'd431, 10'd433, 10'd439, 10'd443, 10'd449, 10'd457, 10'd461, 10'd463,
                    10'd467, 10'd479, 10'd487, 10'd491, 10'd499, 10'd503, 10'd509, 10'd521, 10'd523, 10'd541,
                    10'd547, 10'd557, 10'd563, 10'd569, 10'd571, 10'd577, 10'd587, 10'd593, 10'd599, 10'd601,
                    10'd607, 10'd613, 10'd617, 10'd619, 10'd631, 10'd641, 10'd643, 10'd647, 10'd653, 10'd659,
                    10'd661, 10'd673, 10'd677, 10'd683, 10'd691, 10'd701, 10'd709, 10'd719, 10'd727, 10'd733,
                    10'd739, 10'd743, 10'd751, 10'd757, 10'd761, 10'd769, 10'd773, 10'd787, 10'd797, 10'd809,
                    10'd811, 10'd821, 10'd823, 10'd827, 10'd829, 10'd839, 10'd853, 10'd857, 10'd859, 10'd863,
                    10'd877, 10'd881, 10'd883, 10'd887, 10'd907, 10'd911, 10'd919, 10'd929, 10'd937, 10'd941,
                    10'd947, 10'd953, 10'd967, 10'd971, 10'd977, 10'd983, 10'd991, 10'd997:
                        prime = 1;
                    //Make sure to always have a default case with case statements
                    default: prime = 0;
                endcase
                if (prime == 1) begin 
                    count++; 
                end

                //Now we do the logic for moving the states
                if (i <= numMax) begin //Its important to make sure that we do equal to so we also check if the number inputted is a prime
                    if (i == 2) begin 
                        i++; 
                    end 
                    else begin 
                        i = i + 2; 
                    end 

                    //Finally update the number of primes
                    numberOfPrimes = count; 

                    //Update State
                    stateNext = sCalc; 
                end else begin 
                    stateNext = sDone; 
                end

            end

            sDone: begin 
                //Now we just need to update our last things 
                prime = 0; 

                stateNext = sOff; 
            end

            default: 
                stateNext = sInit;

        endcase

    end

    


endmodule
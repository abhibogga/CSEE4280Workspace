module receiver_uart(baudRate, rst, bitStream, dataOut, readDone);
    //Define the inputs here
    //input clk; //clock input, this should be the 100MHz or maybe 9600
    input baudRate; //This is the baudrate input
    input rst; //Reset in case we need it
    input bitStream; //I don't know how we'll be reciving the bits, but for now lets go with this

    //Defind the outputs here
    output reg [7:0] dataOut;
    output reg readDone;


    //Define other variables here
    reg startCondition; 
    reg [4:0] counter; 
    reg [3:0] datCounter;
    reg [4:0] highCounter; 
    reg [4:0] lowCounter; 
    reg insertBit; 

    //Define the states
    parameter sIdle = 0, sStart = 1, sCount = 2, sCalc = 3, sWait = 4; 

    reg [2:0] state, stateNext; 

    //Define our tracker variables
    reg bit; 
    reg prevBit; 

    /*For this reader, we are reciving information at 9600 bits per second, 
        This means that we must be sampling our data at 16 times the rate, which well use the baudRateGen module for
        This will help us understand the information at a much higher rate
        So Lets Describe the states

        First should be an idle state, this state will be our no data infomation state
        - To break out of this state you must meet the start condition which is a falling edge on the data line
        - Once we are here we must move to some sort of calc state, this is where we are sampling data 
            - We need to be wary of when the data switches, so lets make a state for that
            - Once our counter, which would be 16 since we are sampling that fast, reaches 16 lets push to some sort of calc state
        - Once we are in that calc state lets decide how many ones and zeros we recieved in that 16 bit time frame, this will be our deciding factor on which bit to add 
           to the fifo. 
    */


    
    always @(posedge baudRate) begin
        state <= stateNext; 
    end

    always @(posedge baudRate) begin
        if (rst == 1 || startCondition == 0) begin
            stateNext = sIdle; 
        end

        //Track the bit
        bit = bitStream; 

        //Now lets make our cases
        case (state)
            sIdle: begin
                //This is our idle state, this is the wait state if rst is high
                if (rst == 1) begin
                    stateNext = sIdle;
                end else begin 
                    stateNext = sWait;
                end
            end

            sWait: begin
                //This is our state if we need to wait for information, this is where we are setting the start condition
                //If the start condition is true lets move to the sCount state

                //First check reset
                if (rst == 1) begin
                    stateNext = sIdle;
                end 

                //Next lets what would set our startCondition true: which is when the signal drops to a low
                if (bit == 0 && prevBit == 1) begin 
                    $display("starting");
                    //This means the signal has dropped, so lets move the state onto the count phase
                    stateNext = sCount;
                    startCondition = 0; //This means the start condition has not been fulfilled

                    //Initalize counters 
                    counter = 0;    
                    highCounter = 0; 
                    lowCounter = 0; 
                    datCounter = 0;

                    //Lets set our dataOut output
                    dataOut = 8'b0; 
                    readDone = 0; 
                end else begin
                    readDone = 0; 
                end
            end

            sCount: begin 
                //Here we need to just count for one baud (16) times
            
                //Lets implement the rst
                if (rst == 1) begin
                    stateNext = sIdle;
                end 

                //Now we need to check the data input for each baud increase
                if (counter < 7) begin
                    if (bit) begin  
                        //Increment some sort of ones counter
                        highCounter = highCounter + 1; 
                    end else begin
                        lowCounter = lowCounter + 1; 
                    end
                    //Lets move the next state here; 
                    stateNext = sCount; 
                    
                    //Increment Counter: 
                    counter = counter + 1; 
                end else begin
                    //This means that we have got all the data we need and lets move on to the next phase

                    //First lets calc the bit that we have decided in the calc phase
                    if (highCounter > lowCounter) begin 
                        $display("recived one here");
                        insertBit = 1; 
                    end else begin
                        $display("recivied zero here");
                        insertBit = 0; 
                    end

                    if (datCounter < 7) begin 
                        //First lets update the if we have fufilled the start condition 
                        if (startCondition == 0 && insertBit == 1) begin
                            //This means we have a problem for now lets display and error and exit program
                            $display("there has been an error, exiting now");
                            $finish;
                        end
                        
                        else if (startCondition == 0 && insertBit == 0) begin
                            //This means that everything is good
                            startCondition = 1; 
                            
                            //Now lets reset the nesseary counters
                            highCounter = 0; 
                            lowCounter = 0; 
                            counter = 0; 

    
                        end

                        else if (startCondition) begin 
                            //This means we are actually collecting data so lets make sure we do that
                            dataOut[datCounter] = insertBit; 
                            datCounter = datCounter + 1; 

                            //Lets reset nessary counters 
                            highCounter = 0; 
                            lowCounter = 0; 
                            counter = 0; 

                        end
                        stateNext = sCount;
                    end else begin 
                        //This means that the tranmission is done so we just need to count the stop bit 
                        //Right now according to programming logic we should have the stop bit encoded arleady when it reaches this loop so lets just check for that 
                        if (insertBit) begin
                            $display("recived correct stop singal");

                            stateNext = sWait; 
                            //Reset nessecary counters: 
                            datCounter = 0; 
                            readDone = 1; 
                        end else begin
                            //THis means an error has happened or im just retarted
                            $display("error has occured, fix the program"); 
                            $finish; 
                            datCounter = 0; 
                            readDone = 0; 
                        end
                    end 
                end
            end


            default: stateNext = sWait;
        endcase

        //Update prevbit
        prevBit = bit; 
    end




endmodule

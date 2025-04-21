

module fpgaMain_ssd_read(clk, dataInSignal, dataIn, writeOut, rst, ssd, anode_enable);
    //Insert INputs here
    input clk;
    input dataInSignal; //This should be fifo blip
    input [15:0] dataIn;
    input rst; 
    
    //Inputs for RAM
    reg [15:0] address; 
    reg writeEnable;

    //Outputs for RAM 
    output [15:0] writeOut; 

    //Outputs for SSD
    output reg [6:0] ssd;
    output reg [7:0] anode_enable;

    //States
    parameter sIdle = 0, sLoad = 1, sBegin = 2; ; 

    reg [1:0] state, stateNext; 
    reg prevBit, currBit; 

    //Initialize singleport ram module: 
    singlePortRam ram(
        .clk(clk), 
        .writeEnable(writeEnable), 
        .address(address), 
        .writeIn(dataIn), 
        .writeOut(writeOut) 
    ); 

    //Data for Seven Segment Display
    reg [3:0] digits_binary [0:5];  // Binary representation of each digit
    reg [6:0] digits_segs [0:7];    // Final 7-segment encoding per digit
    reg [2:0] current_digit; //Need to update these; 
    reg [11:0] update_timer; //Need to UPdate these

    // Convert 4-digit and 2-digit binary to decimal digits
    integer i;
    reg [15:0] rpmDisplay;
    reg [7:0]  tempDisplay;

    

     // Function to get 7-segment code
    function automatic [6:0] ssd_val;
        input [3:0] value;
        case(value)
            4'h0: ssd_val = 7'b0000001;
            4'h1: ssd_val = 7'b1001111;
            4'h2: ssd_val = 7'b0010010;
            4'h3: ssd_val = 7'b0000110;
            4'h4: ssd_val = 7'b1001100;
            4'h5: ssd_val = 7'b0100100;
            4'h6: ssd_val = 7'b0100000;
            4'h7: ssd_val = 7'b0001111;
            4'h8: ssd_val = 7'b0000000;
            4'h9: ssd_val = 7'b0000100;
            default: ssd_val = 7'b1111111;
        endcase
    endfunction


   

    always @(posedge clk) begin 
        //Update state
        state = stateNext; 

        currBit = dataInSignal;
        //Here we should just load in the data into the ram 
        case(state) 
            sBegin: begin 
                if (currBit == 0 && prevBit == 1) begin 
                    //Now we can go to the next state
                    stateNext = sIdle; 
                    writeEnable = 1;
                    address = 0;

                    current_digit = 0; //Need to update these; 
                    update_timer = 0;
                end
            end

            sIdle: begin 
                //here we need to set the write enable to 0
                writeEnable = 0; 

                //Now we need to detect a drop or negedge in dataInSignal
                if (currBit == 0 && prevBit == 1) begin 
                    //Now we can go to the next state
                    stateNext = sLoad; 
                    writeEnable = 1;
                end

            end

            sLoad: begin 
                //Here lets also load in the values for the ssd

                //Update address stuff
                address = address + 1; 
                stateNext = sIdle; 
            end 

            default: begin
                stateNext = sBegin; 
                
            end

        endcase

        // Convert 4-digit number to decimal digits
        rpmDisplay = dataIn;
        digits_binary[0] = rpmDisplay % 10; 
        rpmDisplay = rpmDisplay / 10;

        digits_binary[1] = rpmDisplay % 10; 
        rpmDisplay = rpmDisplay / 10;

        digits_binary[2] = rpmDisplay % 10; 
        rpmDisplay = rpmDisplay / 10;
        
        digits_binary[3] = rpmDisplay % 10;

        // Convert 2-digit number to decimal digits
        tempDisplay = dataIn[7:0];
        digits_binary[4] = tempDisplay % 10; tempDisplay = tempDisplay / 10;
        digits_binary[5] = tempDisplay % 10;

        // Map to segment digits
        digits_segs[7] = ssd_val(digits_binary[5]); // leftmost
        digits_segs[6] = ssd_val(digits_binary[4]);
        digits_segs[5] = 7'b1111111; // blank
        digits_segs[4] = 7'b1111111; // blank
        digits_segs[3] = ssd_val(digits_binary[3]);
        digits_segs[2] = ssd_val(digits_binary[2]);
        digits_segs[1] = ssd_val(digits_binary[1]);
        digits_segs[0] = ssd_val(digits_binary[0]);

        // Update display digit
        update_timer = update_timer + 1;
        if (update_timer == 0)
        current_digit = current_digit + 1;

        //Case statement for seven segment display
        case (current_digit)
            0: anode_enable = 8'b11111110;
            1: anode_enable = 8'b11111101;
            2: anode_enable = 8'b11111011;
            3: anode_enable = 8'b11110111;
            4: anode_enable = 8'b11101111;
            5: anode_enable = 8'b11011111;
            6: anode_enable = 8'b10111111;
            7: anode_enable = 8'b01111111;
        endcase

        ssd = digits_segs[current_digit];


        //update prevbit
        prevBit = currBit;
    end


endmodule
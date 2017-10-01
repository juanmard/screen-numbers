//////////////////////////////////////////////////////////////////////////////////
// Company: Ridotech
// Engineer: Juan Manuel Rico
// 
// Create Date: 09:33:32 01/10/2017 
// Module Name: dinamic
// Description: Dinamic debounce numbers behaviour like in a screen-saver.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dinamic (
                input wire        clk,         // System clock.
                input wire        clr,         // Asynchronous reset.
                input wire [9:0]  x_numbers,   // X position for actual numbers.
                input wire [9:0]  y_numbers,   // Y position for actual numbers.
                input wire        inc_vel,     // Increase velocity.
                input wire        dec_vel,     // Decrease velocity.
                output reg        mute,        // Silence actual sound.
                output wire [1:0] code_sound,  // Code of sound (silence, ping, pong, go).
                output reg  [2:0] number
               );


    // Sounds definition.
    parameter [1:0] ping = 2'b10;
    parameter [1:0] pong = 2'b01;
    parameter [1:0] go   = 2'b11;
    parameter [1:0] stop = 2'b00;
    
	// Numbers dimension.
    parameter width_numbers = 20;
    parameter height_numbers = 23;

    // Border definition.
    parameter border = 0;
    parameter [9:0] x_numbers_min = border;
    parameter [9:0] x_numbers_max = 640 - width_numbers - border;
    parameter [9:0] y_numbers_min = border;
    parameter [9:0] y_numbers_max = 480 - height_numbers - border;
    
    // Velocity increment in both direction.
    wire pixel;
    reg [9:0] incx = 1;              // Increment in a x direction.
    reg [9:0] incy = 2;              // Increment in a y direction.
    reg [5:0] delay = 16;            // Delay for animation. 
    reg [31:0] counter = 0;          // Counter for delay. 
   
    // Increment and decrement animation.
    always @(posedge counter[22])
    begin
        if (inc_vel) delay = delay + 1;
        if (dec_vel) delay = delay - 1;
    end
     
    // Actualice counter.
    always @(posedge clk)
    begin
        counter <= counter + 1;
    end
                
    // If counter is zero, new animation and new delay.
    always @ (posedge counter[delay])
    begin
        // Actualize x. Any border in x? Change velocity direction.
        // Note: For a correct working this was to be a blobking assingment (this =, not this <=).
        x_numbers = x_numbers + incx;
        if ((x_numbers > x_numbers_max) || (x_numbers <= x_numbers_min))
        begin
            incx <= -incx;
            //mute = 0;
            code_sound = pong;
            number <= number + 1;
        end
            
        // Actualize y. Any border in y? Change velocity direction.            
        y_numbers = y_numbers + incy;
        if ((y_numbers > y_numbers_max) || (y_numbers <= y_numbers_min))
        begin
            incy <= -incy;
            //mute = 0;
            number <= number - 1;
            code_sound = ping;
        end
    end
endmodule

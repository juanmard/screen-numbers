//////////////////////////////////////////////////////////////////////////////////
// Company: Ridotech
// Engineer: Juan Manuel Rico
// 
// Create Date: 09:11:32 01/10/2017 
// Module Name: numbers
// Description: Complete numbers behaviour (dinamic, graphics and sound).
//
// Dependencies: dinamic, graphics
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module numbers (
                input  wire        clk,         // System clock.
                input  wire        clr,         // Asynchronous reset.
                input  wire [9:0]  x_px,        // X position for actual pixel.
                input  wire [9:0]  y_px,        // Y position for actual pixel.
                output wire [2:0]  color_px,    // Color for actual pixel.
                input  wire        inc_vel,     // Increase velocity.
                input  wire        dec_vel,     // Decrease velocity.
                output wire        mute,        // Silence the sound.
                output wire [1:0]  code_sound   // Code of sound (ping, pong, go, stop). 
            );
    
    // Registers with numbers position. 
    reg [9:0] x_numbers;
    reg [9:0] y_numbers;
    wire [2:0] number;

    // Instance of dinamic part of numbers.
    dinamic
    dinamic01 (
            .clk (clk),
            .clr (clr),
            .x_numbers (x_numbers),
            .y_numbers (y_numbers),
            .inc_vel (inc_vel),
            .dec_vel (dec_vel),
            .mute(mute),
            .code_sound (code_sound),
            .number(number)
    );

    // Instance of graphics part of numbers.
    graphics
    graphics01 (
            .clk (clk),
//            .clr (clr),
            .x_px (x_px),
            .y_px (y_px),
            .x_numbers (x_numbers),
            .y_numbers (y_numbers),
            .color_px (color_px),
            .number(number)
    );

endmodule

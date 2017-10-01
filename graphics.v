//////////////////////////////////////////////////////////////////////////////////
// Company: Ridotech
// Engineer: Juan Manuel Rico
// 
// Create Date: 09:34:18 01/10/2017 
// Module Name: graphics
// Description: Graphics numbers behaviour.
//
// Dependencies: image
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module graphics (
                input wire        clk,        // System clock.
                input wire        clr,        // Asyncronous reset.
                input wire [9:0]  x_px,       // X position actual pixel.
                input wire [9:0]  y_px,       // Y position actual pixel.
                input wire [9:0]  x_numbers,  // X position actual number.
                input wire [9:0]  y_numbers,  // Y position actual number.
                input wire [2:0]  number,     // Actual number to display.
                output reg [2:0]  color_px    // Actual pixel color.
                );
    
    // Some colors.
    parameter [2:0] black  = 3'b000;
    parameter [2:0] blue   = 3'b001;
    parameter [2:0] green  = 3'b010;
    parameter [2:0] red    = 3'b100;
    parameter [2:0] yellow = 3'b110;
    parameter [2:0] white  = 3'b111;

    parameter background = black;
    parameter background_number = black;
    parameter ink = yellow;
    
	// Numbers dimension.
    parameter width_numbers = 21;
    parameter height_numbers = 23;

    // Position x and y from image.
    reg [7:0] x_img;
    reg [7:0] y_img;
    reg pixel;
   
    // Instance of image numbers.
    image
    image01 (
            .clk (clk),
            .x_img (x_img),
            .y_img (y_img),
            .pixel (pixel)
            );

    // Calculate relative position.
    assign x_img = x_px - x_numbers;
    assign y_img = (y_px - y_numbers) + number * height_numbers;

    // Draw or not the number.
    always @(posedge clk)
    begin
        // If we're inside the number, get pixel from image block and
        // if it's a pixel, draw in green.
        if ((x_px >= x_numbers) && (x_px < x_numbers + width_numbers) && (y_px >= y_numbers) && (y_px < y_numbers + height_numbers))   
        begin
            if (pixel)
                color_px = ink;
            else
                color_px = background_number;
        end
        else
           color_px = background;
    end
endmodule

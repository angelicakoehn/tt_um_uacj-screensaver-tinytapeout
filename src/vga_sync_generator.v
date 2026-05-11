`default_nettype none

module vga_sync_generator (
    input  wire clk,
    input  wire reset,
    output reg  hsync,
    output reg  vsync,
    output wire display_on,
    output reg [9:0] hpos,
    output reg [9:0] vpos
);

    // Horizontal timing
    localparam H_DISPLAY = 640;
    localparam H_FRONT   = 16;
    localparam H_SYNC    = 96;
    localparam H_BACK    = 48;
    localparam H_MAX     = H_DISPLAY + H_FRONT + H_SYNC + H_BACK - 1;

    // Vertical timing
    localparam V_DISPLAY = 480;
    localparam V_BOTTOM  = 10;
    localparam V_SYNC    = 2;
    localparam V_TOP     = 33;
    localparam V_MAX     = V_DISPLAY + V_BOTTOM + V_SYNC + V_TOP - 1;

    // Sync pulse ranges
    localparam H_SYNC_START = H_DISPLAY + H_FRONT;
    localparam H_SYNC_END   = H_DISPLAY + H_FRONT + H_SYNC - 1;

    localparam V_SYNC_START = V_DISPLAY + V_BOTTOM;
    localparam V_SYNC_END   = V_DISPLAY + V_BOTTOM + V_SYNC - 1;

    // Horizontal counter
    always @(posedge clk) begin
        if (reset)
            hpos <= 0;
        else if (hpos == H_MAX)
            hpos <= 0;
        else
            hpos <= hpos + 1;

        hsync <= (hpos >= H_SYNC_START && hpos <= H_SYNC_END);
    end

    // Vertical counter
    always @(posedge clk) begin
        if (reset)
            vpos <= 0;
        else if (hpos == H_MAX) begin
            if (vpos == V_MAX)
                vpos <= 0;
            else
                vpos <= vpos + 1;
        end

        vsync <= (vpos >= V_SYNC_START && vpos <= V_SYNC_END);
    end

    // Visible area
    assign display_on = (hpos < H_DISPLAY) && (vpos < V_DISPLAY);

endmodule
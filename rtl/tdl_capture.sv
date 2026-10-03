`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:Majed Abu Dante 
// Create Date: 09/7/2026 06:34:27 PM
// Design Name: First TDC
// Module Name: tdl_capture
// Project Name: Coincidence Counter TDC
// Target Devices: Basys 3
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tdl_capture (
    input logic clk,
    input logic hit
);

    // ---------------------------------------------------------
    // TDL size
    // ---------------------------------------------------------
    localparam int NUM_CARRY = 64;
    localparam int NUM_TAPS  = NUM_CARRY * 4;

    // Physical carry-chain outputs before sampling
    (* keep = "true", dont_touch = "true" *)
    wire [NUM_TAPS-1:0] carry_taps;

    // Sampled version of the carry chain
    // MARK_DEBUG keeps it available for the ILA later.
    (* keep = "true", dont_touch = "true", mark_debug = "true" *)
    logic [NUM_TAPS-1:0] raw_taps;


    // ---------------------------------------------------------
    // First CARRY4
    // The asynchronous hit starts the delay line here.
    // ---------------------------------------------------------
    CARRY4 carry_first (
        .CI     (1'b0),
        .CYINIT (hit),
        .DI     (4'b0000),
        .S      (4'b1111),
        .CO     (carry_taps[3:0]),
        .O      ()
    );


    // ---------------------------------------------------------
    // Remaining 63 CARRY4 blocks
    // ---------------------------------------------------------
    generate
        for (genvar i = 1; i < NUM_CARRY; i++) begin : GEN_CARRY

            CARRY4 carry_next (
                .CI     (carry_taps[(4*i)-1]),
                .CYINIT (1'b0),
                .DI     (4'b0000),
                .S      (4'b1111),
                .CO     (carry_taps[(4*i) +: 4]),
                .O      ()
            );

        end
    endgenerate


    // ---------------------------------------------------------
    // 256 sampling flip-flops
    // All taps are sampled on the same 100 MHz clock edge.
    // ---------------------------------------------------------
    always_ff @(posedge clk) begin
        raw_taps <= carry_taps;
    end

endmodule
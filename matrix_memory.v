module matrix_memory (
    input  wire clk,                 // System clock
    input  wire [3:0] addr,          // Memory address
    input  wire [31:0] write_data,   // Data to write
    input  wire write_enable,        // Write enable signal
    output reg [31:0] read_data      // Data output
);
    // Parameters
    parameter DEPTH = 16; // Adjust size based on matrix dimensions

    // Memory array
    reg [31:0] memory [0:DEPTH-1];

    // Read and write logic
    always @(posedge clk) begin
        if (write_enable) begin
            memory[addr] <= write_data;
        end
        read_data <= memory[addr];
    end
endmodule

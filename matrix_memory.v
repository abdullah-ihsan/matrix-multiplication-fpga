module matrix_memory (
    input  wire clk,                 // System clock
    input  wire [3:0] addr,          // Memory address (0 to 8 for 3x3 matrix)
    input  wire [7:0] write_data,    // Data to write
    input  wire write_enable,        // Write enable signal
    input  wire read_enable,         // Read enable signal
    output reg [71:0] a_data         // All data output
);

    // Parameters
    parameter DEPTH = 9; // 3x3 matrix for 8-bit elements

    // Memory array
    reg [7:0] memory [0:DEPTH-1];

    // Memory initialization using an initial block
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            memory[i] = 8'd0; // Initialize each element of the memory array to 0
        end
        a_data = 72'd0; // Initialize the output to 0
    end

    // Read and write logic
    always @(posedge clk) begin
        if (write_enable) begin
            memory[addr] <= write_data; // Write data to specified address
        end
        if (read_enable) begin
            a_data <= {memory[8], memory[7], memory[6], memory[5], memory[4], memory[3], memory[2], memory[1], memory[0]};
        end
    end
endmodule

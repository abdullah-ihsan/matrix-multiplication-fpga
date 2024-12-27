module matrix_memory (
    input  wire clk,                 // System clock
    input  wire [3:0] addr,          // Memory address
    input  wire [7:0] write_data,    // Data to write
    input  wire write_enable,        // Write enable signal
    input  wire read_enable,         // Read enable signal
    //output reg [7:0] read_data,      // Data output
    output reg [71:0] a_data         // All data output
);
    // Parameters
    parameter DEPTH = 9; // 3x3 matrix for 8-bit elements

    // Memory array
    reg [7:0] memory [0:DEPTH-1];

    // Read and write logic
    always @(posedge clk) begin
        if (write_enable) begin
            memory[addr] <= write_data;
        end
        //read_data <= memory[addr];
        
        if (read_enable) begin
            a_data <= {memory[8], memory[7], memory[6], memory[5], memory[4], memory[3], memory[2], memory[1], memory[0]};
        end
    end
endmodule
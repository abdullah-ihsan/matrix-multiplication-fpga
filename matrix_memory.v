module matrix_memory (
    input  wire clk,                  // System clock
    input  wire [6:0] addr,           // Memory address (0 to 99 for 10x10 matrix)
    input  wire [7:0] write_data,     // Data to write
    input  wire write_enable,         // Write enable signal
    input  wire read_enable,          // Read enable signal
    output reg [799:0] a_data         // All data output (10x10 matrix, each element is 8 bits)
);

    // Parameters
    parameter DEPTH = 100; // 10x10 matrix for 8-bit elements

    // Memory array
    reg [7:0] memory [0:DEPTH-1];

    // Memory initialization using an initial block
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            memory[i] = 8'd0; // Initialize each element of the memory array to 0
        end
        a_data = {DEPTH{1'b0}}; // Initialize the output to 0
    end

    // Read and write logic
    always @(posedge clk) begin
        if (write_enable) begin
            memory[addr] <= write_data; // Write data to specified address
        end
        if (read_enable) begin
            a_data <= {memory[99], memory[98], memory[97], memory[96], memory[95], memory[94], memory[93], memory[92], memory[91], memory[90],
                       memory[89], memory[88], memory[87], memory[86], memory[85], memory[84], memory[83], memory[82], memory[81], memory[80],
                       memory[79], memory[78], memory[77], memory[76], memory[75], memory[74], memory[73], memory[72], memory[71], memory[70],
                       memory[69], memory[68], memory[67], memory[66], memory[65], memory[64], memory[63], memory[62], memory[61], memory[60],
                       memory[59], memory[58], memory[57], memory[56], memory[55], memory[54], memory[53], memory[52], memory[51], memory[50],
                       memory[49], memory[48], memory[47], memory[46], memory[45], memory[44], memory[43], memory[42], memory[41], memory[40],
                       memory[39], memory[38], memory[37], memory[36], memory[35], memory[34], memory[33], memory[32], memory[31], memory[30],
                       memory[29], memory[28], memory[27], memory[26], memory[25], memory[24], memory[23], memory[22], memory[21], memory[20],
                       memory[19], memory[18], memory[17], memory[16], memory[15], memory[14], memory[13], memory[12], memory[11], memory[10],
                       memory[9],  memory[8],  memory[7],  memory[6],  memory[5],  memory[4],  memory[3],  memory[2],  memory[1],  memory[0]};
        end
    end
endmodule

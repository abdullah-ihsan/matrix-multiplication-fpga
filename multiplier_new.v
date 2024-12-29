module matrix_mult_parallel_flat #(
    parameter MAX_SIZE = 10,          // Maximum matrix size
    parameter DATA_WIDTH = 32         // Width of each matrix element
) (
    input clk,                        // Clock signal
    input enable,                     // Enable signal for multiplication
    input [31:0] matrix_size,         // Current size of the matrices (1 to MAX_SIZE)
    input [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] A, // Flattened input matrix A
    input [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] B, // Flattened input matrix B
    output reg [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] C, // Flattened output matrix C
    output reg done                   // Done signal indicating completion
);
    // Registered versions of inputs
    reg [31:0] matrix_size_reg;
    reg [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] A_reg, B_reg;
    
    // Wires for partial sums for each element of C
    wire [DATA_WIDTH-1:0] partial_sum [0:MAX_SIZE-1][0:MAX_SIZE-1][0:MAX_SIZE-1];
    wire [DATA_WIDTH-1:0] final_sum [0:MAX_SIZE-1][0:MAX_SIZE-1];
    
    genvar i, j, k;
    
    // Generate logic to compute partial products in parallel
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : row_loop
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : col_loop
                for (k = 0; k < MAX_SIZE; k = k + 1) begin : mult_loop
                    // Calculate partial products in parallel using generate
                    assign partial_sum[i][j][k] =
                        (i < matrix_size_reg && j < matrix_size_reg && k < matrix_size_reg)
                        ? A_reg[((i * MAX_SIZE + k) * DATA_WIDTH) +: DATA_WIDTH] *
                          B_reg[((k * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH]
                        : 0;
                end
            end
        end
    endgenerate

    // Parallel summation logic using reduction trees
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : sum_row_loop
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : sum_col_loop
                reg [DATA_WIDTH-1:0] sum;
                integer k_idx;
                always @(*) begin
                    sum = 0;
                    for (k_idx = 0; k_idx < MAX_SIZE; k_idx = k_idx + 1) begin
                        if (i < matrix_size_reg && j < matrix_size_reg && k_idx < matrix_size_reg) begin
                            sum = sum + partial_sum[i][j][k_idx];
                        end
                    end
                end
                assign final_sum[i][j] = sum;
            end
        end
    endgenerate

    // Sequential logic for enable and done signals
    always @(posedge clk) begin
        if (enable) begin
            // Register inputs
            matrix_size_reg <= matrix_size;
            A_reg <= A;
            B_reg <= B;
            
            // Assign results to output matrix
            for (integer i = 0; i < MAX_SIZE; i = i + 1) begin
                for (integer j = 0; j < MAX_SIZE; j = j + 1) begin
                    C[((i * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH] <=
                        (i < matrix_size && j < matrix_size) ? final_sum[i][j] : 0;
                end
            end
            
            // Set done signal
            done <= 1'b1;
        end
        else begin
            // Reset done signal when enable is low
            done <= 1'b0;
        end
    end
endmodule
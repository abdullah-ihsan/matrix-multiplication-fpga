module matrix_mult_parallel_flat #(
    parameter MAX_SIZE = 10,          // Maximum matrix size
    parameter DATA_WIDTH = 32         // Width of each matrix element
) (
    input [31:0] matrix_size,         // Current size of the matrices (1 to MAX_SIZE)
    input [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] A, // Flattened input matrix A
    input [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] B, // Flattened input matrix B
    output [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] C // Flattened output matrix C
);
    genvar i, j, k;

    // Wires for partial sums for each element of C
    wire [DATA_WIDTH-1:0] partial_sum [0:MAX_SIZE-1][0:MAX_SIZE-1][0:MAX_SIZE-1];
    wire [DATA_WIDTH-1:0] final_sum [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Generate logic to compute partial products in parallel
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : row_loop
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : col_loop
                for (k = 0; k < MAX_SIZE; k = k + 1) begin : mult_loop
                    // Calculate partial products in parallel using generate
                    assign partial_sum[i][j][k] =
                        (i < matrix_size && j < matrix_size && k < matrix_size)
                        ? A[((i * MAX_SIZE + k) * DATA_WIDTH) +: DATA_WIDTH] *
                          B[((k * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH]
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
                        if (i < matrix_size && j < matrix_size && k_idx < matrix_size) begin
                            sum = sum + partial_sum[i][j][k_idx];
                        end
                    end
                end
                assign final_sum[i][j] = sum;
            end
        end
    endgenerate

    // Assign the final sums to the flattened output C
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : assign_row
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : assign_col
                assign C[((i * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH] =
                    (i < matrix_size && j < matrix_size) ? final_sum[i][j] : 0;
            end
        end
    endgenerate
endmodule

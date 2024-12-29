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

    // Intermediate partial sums for each element of C
    wire [DATA_WIDTH-1:0] partial_sum [0:MAX_SIZE-1][0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Final sums for each element of C
    reg [DATA_WIDTH-1:0] final_sum [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Generate logic to compute all elements of C in parallel
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : row_loop
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : col_loop
                for (k = 0; k < MAX_SIZE; k = k + 1) begin : mult_loop
                    // Calculate partial products in parallel
                    assign partial_sum[i][j][k] =
                        (i < matrix_size && j < matrix_size && k < matrix_size)
                        ? A[((i * MAX_SIZE + k) * DATA_WIDTH) +: DATA_WIDTH] *
                          B[((k * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH]
                        : 0;
                end

                // Add partial sums for C[i][j] in a parallel always block
                always @(*) begin
                    final_sum[i][j] = 0;
                    for (k = 0; k < MAX_SIZE; k = k + 1) begin
                        final_sum[i][j] = final_sum[i][j] + partial_sum[i][j][k];
                    end
                end

                // Assign the final sum to the corresponding position in C
                assign C[((i * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH] =
                    (i < matrix_size && j < matrix_size) ? final_sum[i][j] : 0;
            end
        end
    endgenerate
endmodule

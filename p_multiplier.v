module matrix_mult_parallel #(
    parameter MAX_SIZE = 10  // Maximum matrix size
) (
    input [31:0] matrix_size, // Current size of the matrices (1 to MAX_SIZE)
    input [31:0] A [0:MAX_SIZE-1][0:MAX_SIZE-1], // Input matrix A
    input [31:0] B [0:MAX_SIZE-1][0:MAX_SIZE-1], // Input matrix B
    output [31:0] C [0:MAX_SIZE-1][0:MAX_SIZE-1] // Output matrix C
);
    genvar i, j, k;

    // Intermediate partial product wires
    wire [31:0] partial_products [0:MAX_SIZE-1][0:MAX_SIZE-1][0:MAX_SIZE-1];
    wire [31:0] partial_sums [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Generate partial products (A[i][k] * B[k][j])
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : row_loop
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : col_loop
                for (k = 0; k < MAX_SIZE; k = k + 1) begin : mult_loop
                    assign partial_products[i][j][k] = 
                        (i < matrix_size && j < matrix_size && k < matrix_size) 
                        ? A[i][k] * B[k][j] 
                        : 32'd0;
                end
            end
        end
    endgenerate

    // Generate summation logic for each C[i][j]
    generate
        for (i = 0; i < MAX_SIZE; i = i + 1) begin : sum_row_loop
            for (j = 0; j < MAX_SIZE; j = j + 1) begin : sum_col_loop
                reg [31:0] sum;
                integer idx;
                always @(*) begin
                    sum = 32'd0;
                    for (idx = 0; idx < matrix_size; idx = idx + 1) begin
                        sum = sum + partial_products[i][j][idx];
                    end
                    partial_sums[i][j] = sum;
                end
                assign C[i][j] = (i < matrix_size && j < matrix_size) ? partial_sums[i][j] : 32'd0;
            end
        end
    endgenerate
endmodule

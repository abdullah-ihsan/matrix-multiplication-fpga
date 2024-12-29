module matrix_mult_parallel_flat #(
    parameter MAX_SIZE = 10,          // Maximum matrix size
    parameter DATA_WIDTH = 32         // Width of each matrix element
) (
    input [31:0] matrix_size,         // Current size of the matrices (1 to MAX_SIZE)
    input [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] A, // Flattened input matrix A
    input [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] B, // Flattened input matrix B
    output reg [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] C // Flattened output matrix C
);
    integer i, j, k;
    reg [DATA_WIDTH-1:0] a_element;
    reg [DATA_WIDTH-1:0] b_element;
    reg [DATA_WIDTH-1:0] temp_sum;

    always @(*) begin
        // Initialize C to zero
        C = 0;
        
        // Perform matrix multiplication
        for (i = 0; i < MAX_SIZE; i = i + 1) begin
            for (j = 0; j < MAX_SIZE; j = j + 1) begin
                temp_sum = 0;
                for (k = 0; k < MAX_SIZE; k = k + 1) begin
                    if (i < matrix_size && j < matrix_size && k < matrix_size) begin
                        // Extract elements from the flattened arrays
                        a_element = A[((i * MAX_SIZE + k) * DATA_WIDTH) +: DATA_WIDTH];
                        b_element = B[((k * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH];
                        temp_sum = temp_sum + (a_element * b_element);
                    end
                end
                // Assign the result to the appropriate location in the flattened C
                C[((i * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH] = temp_sum;
            end
        end
    end
endmodule

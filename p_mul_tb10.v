`timescale 1ns / 1ps

module tb_matrix_mult_parallel;
    parameter MAX_SIZE = 10; // Maximum matrix size

    // Inputs
    reg [31:0] matrix_size;
    reg [31:0] A [0:MAX_SIZE-1][0:MAX_SIZE-1];
    reg [31:0] B [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Outputs
    wire [31:0] C [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Instantiate the module under test
    matrix_mult_parallel #(.MAX_SIZE(MAX_SIZE)) uut (
        .matrix_size(matrix_size),
        .A(A),
        .B(B),
        .C(C)
    );

    integer i, j;

    initial begin
        // Initialize the matrices
        matrix_size = 10;

        // Initialize matrix A (1 to 100 row-wise)
        for (i = 0; i < matrix_size; i = i + 1) begin
            for (j = 0; j < matrix_size; j = j + 1) begin
                A[i][j] = (i * matrix_size) + j + 1;
            end
        end

        // Initialize matrix B (100 to 1 column-wise)
        for (j = 0; j < matrix_size; j = j + 1) begin
            for (i = 0; i < matrix_size; i = i + 1) begin
                B[i][j] = (matrix_size * matrix_size) - (j * matrix_size) - i;
            end
        end

        // Wait for computation
        #10;

        // Display the result matrix
        $display("Resulting Matrix C:");
        for (i = 0; i < matrix_size; i = i + 1) begin
            for (j = 0; j < matrix_size; j = j + 1) begin
                $write("%d ", C[i][j]);
            end
            $display("");
        end

        // Verify the output (You can verify specific values programmatically or manually)
        // Add your expected value check here if desired.

        // End simulation
        $finish;
    end
endmodule

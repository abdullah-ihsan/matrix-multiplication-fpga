`timescale 1ns / 1ps

module tb_matrix_mult_parallel_flat;
    parameter MAX_SIZE = 10; // Maximum matrix size
    parameter DATA_WIDTH = 32;

    // Inputs
    reg [31:0] matrix_size;
    reg [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] A; // Flattened matrix A
    reg [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] B; // Flattened matrix B

    // Outputs
    wire [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] C; // Flattened matrix C

    // Instantiate the module under test
    matrix_mult_parallel_flat #(.MAX_SIZE(MAX_SIZE), .DATA_WIDTH(DATA_WIDTH)) uut (
        .matrix_size(matrix_size),
        .A(A),
        .B(B),
        .C(C)
    );

    integer i, j;

    // Task to initialize a flattened matrix with values
    task initialize_matrix(input integer size, output [(MAX_SIZE*MAX_SIZE*DATA_WIDTH)-1:0] matrix, input integer base_value, input integer row_major);
        integer row, col;
        begin
            matrix = 0;
            for (row = 0; row < size; row = row + 1) begin
                for (col = 0; col < size; col = col + 1) begin
                    if (row_major) begin
                        matrix[((row * MAX_SIZE + col) * DATA_WIDTH) +: DATA_WIDTH] = base_value + (row * size + col);
                    end else begin
                        matrix[((row * MAX_SIZE + col) * DATA_WIDTH) +: DATA_WIDTH] = base_value + (col * size + row);
                    end
                end
            end
        end
    endtask

    initial begin
        // Matrix size
        matrix_size = 10;

        // Initialize matrix A (row-major)
        initialize_matrix(matrix_size, A, 1, 1);

        // Initialize matrix B (column-major)
        initialize_matrix(matrix_size, B, 1, 0);

        // Wait for computation
        #10;

        // Display the result matrix
        $display("Resulting Matrix C:");
        for (i = 0; i < matrix_size; i = i + 1) begin
            for (j = 0; j < matrix_size; j = j + 1) begin
                $write("%d ", C[((i * MAX_SIZE + j) * DATA_WIDTH) +: DATA_WIDTH]);
            end
            $display("");
        end

        // End simulation
        $finish;
    end
endmodule

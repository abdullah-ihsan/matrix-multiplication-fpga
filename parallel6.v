module Calculator10(
    input clk,
    input enable_multiplication,  // Control for enabling multiplication
    input [799:0] A, // Single array for matrix A (10x10 elements, 8 bits each)
    input [799:0] B, // Single array for matrix B (10x10 elements, 8 bits each)
    output reg [1599:0] result, // Single array for result (10x10 elements, 16 bits each)
    output reg mult_done
);

    reg [7:0] A1 [0:9][0:9];
    reg [7:0] B1 [0:9][0:9];
    reg [15:0] Res1 [0:9][0:9];

    wire [15:0] partial_products [0:99];
	 
	 initial begin 
		result = 1600'd0; 
	 end

    // Assign input matrices to 2D arrays for processing
    integer i, j;
    always @(*) begin
        for (i = 0; i < 10; i = i + 1) begin
            for (j = 0; j < 10; j = j + 1) begin
                A1[i][j] = A[(i*10 + j)*8 +: 8];
                B1[i][j] = B[(i*10 + j)*8 +: 8];
            end
        end
    end

    // Parallel computation of matrix multiplication
    genvar m, n, k;
    generate
        for (m = 0; m < 10; m = m + 1) begin
            for (n = 0; n < 10; n = n + 1) begin
                assign partial_products[m*10 + n] = 
                    A1[m][0] * B1[0][n] + A1[m][1] * B1[1][n] +
                    A1[m][2] * B1[2][n] + A1[m][3] * B1[3][n] +
                    A1[m][4] * B1[4][n] + A1[m][5] * B1[5][n] +
                    A1[m][6] * B1[6][n] + A1[m][7] * B1[7][n] +
                    A1[m][8] * B1[8][n] + A1[m][9] * B1[9][n];
            end
        end
    endgenerate

    // Capture results on clock edge
    always @(posedge clk) begin
        if (enable_multiplication) begin
            for (i = 0; i < 10; i = i + 1) begin
                for (j = 0; j < 10; j = j + 1) begin
                    Res1[i][j] = partial_products[i*10 + j];
                end
            end

            // Assign result to single array
            for (i = 0; i < 10; i = i + 1) begin
                for (j = 0; j < 10; j = j + 1) begin
                    result[(i*10 + j)*16 +: 16] = Res1[i][j];
                end
            end

            mult_done <= 1'b1;
				end
    end
endmodule

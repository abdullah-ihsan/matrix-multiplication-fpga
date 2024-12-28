module Calculator(
    input clk,
    input enable_multiplication,  // Control for enabling multiplication
    input [7:0] A00, A01, A02, A10, A11, A12, A20, A21, A22,
    input [7:0] B00, B01, B02, B10, B11, B12, B20, B21, B22,
    output reg [15:0] R00, R01, R02, R10, R11, R12, R20, R21, R22 // Changed reg to wire
);
    
    reg [7:0] A1 [0:2][0:2];
    reg [7:0] B1 [0:2][0:2];
    reg [15:0] Res1 [0:2][0:2];
    
    integer i, j, k;
    
    always @ (posedge clk) begin
        if (enable_multiplication) begin
            // Convert inputs to 2D arrays for easier processing
            A1[0][0] = A00; A1[0][1] = A01; A1[0][2] = A02;
            A1[1][0] = A10; A1[1][1] = A11; A1[1][2] = A12;
            A1[2][0] = A20; A1[2][1] = A21; A1[2][2] = A22;
        
            B1[0][0] = B00; B1[0][1] = B01; B1[0][2] = B02;
            B1[1][0] = B10; B1[1][1] = B11; B1[1][2] = B12;
            B1[2][0] = B20; B1[2][1] = B21; B1[2][2] = B22;
        
            // Initialize result matrix to zero
            Res1[0][0] = 16'd0; Res1[0][1] = 16'd0; Res1[0][2] = 16'd0;
            Res1[1][0] = 16'd0; Res1[1][1] = 16'd0; Res1[1][2] = 16'd0;
            Res1[2][0] = 16'd0; Res1[2][1] = 16'd0; Res1[2][2] = 16'd0;
        
            // Matrix multiplication
            for (i = 0; i < 3; i = i + 1) begin
                for (j = 0; j < 3; j = j + 1) begin
                    for (k = 0; k < 3; k = k + 1) begin
                        Res1[i][j] = Res1[i][j] + (A1[i][k] * B1[k][j]);
                    end
                end
            end
            // Assign results to output ports (wires)
            assign R00 = Res1[0][0];
            assign R01 = Res1[0][1];
            assign R02 = Res1[0][2];
            assign R10 = Res1[1][0];
            assign R11 = Res1[1][1];
            assign R12 = Res1[1][2];
            assign R20 = Res1[2][0];
            assign R21 = Res1[2][1];
            assign R22 = Res1[2][2];
        end
    end


endmodule
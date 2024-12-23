module matrix_multiplier (
    input  wire clk,                   // System clock
    input  wire rst,                   // Reset signal
    input  wire [31:0] a_data,         // Matrix A element
    input  wire [31:0] b_data,         // Matrix B element
    input  wire start,                 // Start multiplication
    output reg [31:0] result,          // Result of multiplication
    output reg done                    // High when multiplication is complete
);
    // Internal signals
    reg [31:0] product = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            product <= 0;
            done <= 0;
        end else if (start) begin
            product <= a_data * b_data;
            done <= 1;
        end else begin
            done <= 0;
        end
        result <= product;
    end
endmodule

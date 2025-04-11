module SystolicArray #(
  parameter WIDTH = 8,
  parameter SIZE = 4
)(
  input  logic clk,
  input  logic rst,
  input  logic signed [WIDTH-1:0] A [0:SIZE-1][0:SIZE-1],
  input  logic signed [WIDTH-1:0] B [0:SIZE-1][0:SIZE-1],
  output logic signed [2*WIDTH-1:0] C [0:SIZE-1][0:SIZE-1]
);

  logic signed [WIDTH-1:0] a_wires [0:SIZE][0:SIZE];
  logic signed [WIDTH-1:0] b_wires [0:SIZE][0:SIZE];
  logic signed [2*WIDTH-1:0] sum_wires [0:SIZE][0:SIZE];

  genvar i, j;
  generate
    for (i = 0; i < SIZE; i++) begin
      for (j = 0; j < SIZE; j++) begin
        PE #(.WIDTH(WIDTH)) pe_inst (
          .clk(clk),
          .rst(rst),
          .a_in(a_wires[i][j]),
          .b_in(b_wires[i][j]),
          .sum_in(sum_wires[i][j]),
          .a_out(a_wires[i][j+1]),
          .b_out(b_wires[i+1][j]),
          .sum_out(sum_wires[i+1][j+1])
        );
      end
    end
  endgenerate

  // Initialize first row and column
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      for (int m = 0; m < SIZE; m++) begin
        for (int n = 0; n < SIZE; n++) begin
          a_wires[m][0] <= A[m][n]; // Feeding row-wise
          b_wires[0][n] <= B[m][n]; // Feeding column-wise
          sum_wires[m][n] <= 0;
        end
      end
    end
  end

  // Capture outputs
  always_ff @(posedge clk) begin
    for (int i = 0; i < SIZE; i++) begin
      for (int j = 0; j < SIZE; j++) begin
        C[i][j] <= sum_wires[i+1][j+1];
      end
    end
  end

endmodule

module PE #(
  parameter WIDTH = 8
)(
  input  logic clk,
  input  logic rst,
  input  logic signed [WIDTH-1:0] a_in,
  input  logic signed [WIDTH-1:0] b_in,
  input  logic signed [2*WIDTH-1:0] sum_in,
  output logic signed [WIDTH-1:0] a_out,
  output logic signed [WIDTH-1:0] b_out,
  output logic signed [2*WIDTH-1:0] sum_out
);

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      a_out   <= 0;
      b_out   <= 0;
      sum_out <= 0;
    end else begin
      a_out   <= a_in;
      b_out   <= b_in;
      sum_out <= sum_in + (a_in * b_in);
    end
  end

endmodule

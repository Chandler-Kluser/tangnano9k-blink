module top(
	input clk,
	input rst,
    output led
);

reg [23:0] counter = 24'd0;

always @(posedge clk) begin
	counter <= (counter + 1'd1);
	if (!rst) begin
		counter <= 24'd0;
	end
end

assign led = counter[23];

endmodule

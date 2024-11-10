module FIFO (
	input wire clk_i,
	input wire rstn_i,
	input wire signed [23:0] data_in_i,
	input wire valid_in_i,
	output wire signed [23:0] data_out_o,
	output wire valid_out_o
);

	reg signed [11:0] shift_reg [1:0];
	reg valid_out;
	reg [1:0] shift_counter;
	wire signed [11:0] max_value;

	assign valid_out_o = valid_out;
	assign data_out_o[0+:12] = (valid_out ? shift_reg[0] : 12'hxxx);
	assign data_out_o[12+:12] = (valid_out ? shift_reg[1] : 12'hxxx);

	always @(posedge clk_i)
		if (~rstn_i) begin
			shift_reg[1] <= 0;
			shift_reg[0] <= 0;
			shift_counter <= 0;
			valid_out <= 0;
		end

		else if (valid_in_i) begin
			shift_reg[1] <= shift_reg[0];
			shift_reg[0] <= max_value;
			if (shift_counter == 2'b01) begin
				valid_out <= 1;
				shift_counter <= 0;
			end
			else begin
				shift_counter <= shift_counter + 1;
				valid_out <= 0;
			end
		end

		else
			valid_out <= 0;
			
	comparator comparator_inst(
		.data_in_i(data_in_i),
		.data_out_o(max_value)
	);
endmodule

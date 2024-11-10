module global_controller (
	input wire clk_i,
	input wire rstn_i,
	input wire start_i,
	input wire iPE_valid_o,
	input wire fc_done_i,
	output reg oacc_wr_en,
	output reg [1:0] obuf_rd_mod,
	output reg oPE_rstn,
	output reg [1:0] weight_sel,
	output reg [1:0] bias_sel,
	output reg [1:0] o_PE_mux_sel,
	output reg oBuf1_we,
	output reg oBuf_adr_clr,
	output reg oBuf_valid_en,
	output reg oPE_clr,
	output reg oPE_valid_i,
	output reg oimage_rom_en,
	output reg [9:0] oimage_idx,
	output reg [5:0] ocycle,
	output reg acc_rd_en,
	output reg FIFO_valid,
	output reg shift_en,
	output reg conv_done,
	output reg ready
);
	
	reg [4:0] current_state;
	reg [4:0] next_state;
	reg idx_en;
	reg idx_clear;
	reg idx_clear_d1;
	reg oPE_clr_d1;
	reg buf_rd_mod_up;
	reg state12_cntEn;

	always @(posedge clk_i) begin
		idx_clear <= idx_clear_d1;
		oPE_clr <= oPE_clr_d1;
	end

	always @(posedge clk_i)
		if (!rstn_i)
			obuf_rd_mod <= 2'b00;
		else if (buf_rd_mod_up)
			obuf_rd_mod <= obuf_rd_mod + 2'b01;

	always @(posedge clk_i)
		if (!rstn_i)
			current_state <= 4'd0;
		else
			current_state <= next_state;

	always @(posedge clk_i)
		if (!rstn_i | idx_clear_d1)
			oimage_idx <= 10'd0;
		else if (idx_en)
			oimage_idx <= oimage_idx + 1;

	always @(posedge clk_i)
		if (!rstn_i)
			shift_en <= 1'b0;
		else if (state12_cntEn) begin
			if (oimage_idx > 10'd2)
				shift_en <= 1'b1;
			else
				shift_en <= 1'b0;
		end
		else
			shift_en <= 1'b0;

	always @(*) begin
    	// Default values for all signals
		// Initialize ocycle to avoid unintended resets
				oacc_wr_en = oacc_wr_en;
				buf_rd_mod_up = buf_rd_mod_up ;
				oPE_rstn = oPE_rstn;
				weight_sel = weight_sel;
				bias_sel = bias_sel;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = oBuf1_we;
				oBuf_valid_en = oBuf_valid_en;
				oBuf_adr_clr = oBuf_adr_clr;
				oPE_clr_d1 = oPE_clr_d1;
				oPE_valid_i = oPE_valid_i;
				oimage_rom_en = oimage_rom_en;
				idx_en = idx_en;
				idx_clear_d1 = idx_clear_d1;
				acc_rd_en = acc_rd_en;
				FIFO_valid = FIFO_valid;
				state12_cntEn = state12_cntEn;
				conv_done = conv_done;
				ready = ready;
				ocycle = ocycle;

		case (current_state)
			5'd0: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b1;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b1;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b1;
				oPE_clr_d1 = 1'b1;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b0;
				idx_clear_d1 = 1'b1;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b1;
				ocycle = 6'd0;

			end
			5'd1: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b1;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				//ocycle = ocycle;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b1;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd2: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b1;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				//ocycle = ocycle;
				oPE_valid_i = 1'b1;
				oimage_rom_en = 1'b1;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd3: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b1;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b1;
				oPE_valid_i = 1'b1;
				oimage_rom_en = 1'b1;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b1;
				ocycle = ocycle + 6'd1;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd4: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b1;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b0;
				idx_clear_d1 = 1'b0;
				//ocycle = 6'd0;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd5: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b1;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				//ocycle = 6'd0;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd6: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = 2'b00;
				bias_sel = 2'b00;
				o_PE_mux_sel = 2'b00;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b1;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b0;
				idx_clear_d1 = 1'b1;
				ocycle = 6'd0;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd7: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b1;
				weight_sel = weight_sel + 2'd1;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel + 2'd1;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				//ocycle = ocycle;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd8: begin
				oacc_wr_en = 1'b1;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = weight_sel;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b1;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b1;
				oimage_rom_en = 1'b0;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				//ocycle = ocycle;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd9: begin
				oacc_wr_en = 1'b1;
				buf_rd_mod_up = 1'b1;
				oPE_rstn = 1'b0;
				weight_sel = weight_sel;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b1;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b1;
				oPE_valid_i = 1'b1;
				oimage_rom_en = 1'b0;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b1;
				//ocycle = ocycle;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd10: begin
				oacc_wr_en = 1'b1;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = weight_sel;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b1;
				oimage_rom_en = 1'b0;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				//ocycle = ocycle;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd11: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b1;
				weight_sel = weight_sel;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b1;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b0;
				idx_clear_d1 = 1'b1;
				ocycle = ocycle + 6'b1;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd12: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = weight_sel;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b1;
				idx_clear_d1 = 1'b0;
				//ocycle = ocycle;
				acc_rd_en = 1'b1;
				FIFO_valid = 1'b1;
				state12_cntEn = 1'b1;
				conv_done = 1'b0;
				ready = 1'b0;
			end
			5'd13: begin
				oacc_wr_en = 1'b0;
				buf_rd_mod_up = 1'b0;
				oPE_rstn = 1'b0;
				weight_sel = weight_sel;
				bias_sel = 2'b01;
				o_PE_mux_sel = o_PE_mux_sel;
				oBuf1_we = 1'b0;
				oBuf_valid_en = 1'b0;
				oBuf_adr_clr = 1'b0;
				oPE_clr_d1 = 1'b0;
				oPE_valid_i = 1'b0;
				oimage_rom_en = 1'b0;
				idx_en = 1'b0;
				idx_clear_d1 = 1'b1;
				//ocycle = ocycle;
				acc_rd_en = 1'b0;
				FIFO_valid = 1'b0;
				state12_cntEn = 1'b0;
				conv_done = 1'b1;
				ready = 1'b0;
			end
		endcase
	end

	always @(*)begin
			next_state = 5'd0;
		case (current_state)
			5'd0:
				if (start_i)
					next_state = 5'd1;
				else
					next_state = 5'd0;
			5'd1: next_state = 5'd2;
			5'd2:
				if (oimage_idx == 10'd27)
					next_state = 5'd3;
				else
					next_state = 5'd2;
			5'd3:
				if (ocycle == 12)
					next_state = 5'd4;
				else
					next_state = 5'd2;
			5'd4: next_state = 5'd5;
			5'd5:
				if (oimage_idx == 10'd3)
					next_state = 5'd6;
				else
					next_state = 5'd5;
			5'd6: next_state = 5'd7;
			5'd7: next_state = 5'd8;
			5'd8:
				if (oimage_idx == 10'd11)
					next_state = 5'd9;
				else
					next_state = 5'd8;
			5'd9:
				if (obuf_rd_mod != 3)
					next_state = 5'd8;
				else
					next_state = 5'd10;
			5'd10:
				if (oimage_idx == 10'd1)
					next_state = 5'd11;
				else
					next_state = 5'd10;
			5'd11:
				if (ocycle != 3)
					next_state = 5'd7;
				else
					next_state = 5'd12;
			5'd12:
				if (oimage_idx == 10'd66)
					next_state = 5'd13;
				else
					next_state = 5'd12;
			5'd13: next_state = 5'd0;
			default:begin
					next_state = next_state;
			end
		endcase
	end
endmodule
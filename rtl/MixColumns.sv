//Description: This module multiplies state matrix with a constant matrix.
//Author: Pranav Prabhu
//Email:pp7437@rit.edu;prnv.prbh@gmail.com

module MixColumns(input logic [127:0]i_data,output logic [127:0]o_data);
	
	//Declaring intermediate logic
	logic [7:0] i_matrix[0:3][0:3];

	//To get result
	logic [7:0] o_result [0:3][0:3];

	//To hold products
	logic [7:0] product [0:3][0:3][0:3];
	
	//LUT of constant matrix
	logic [7:0]aes_matrix[3:0][3:0];
	
	always_comb begin
		aes_matrix[0][0] = 8'h02;aes_matrix[0][1] = 8'h03;aes_matrix[0][2] = 8'h01;aes_matrix[0][3] = 8'h01;
		aes_matrix[1][0] = 8'h01;aes_matrix[1][1] = 8'h02;aes_matrix[1][2] = 8'h03;aes_matrix[1][3] = 8'h01;
		aes_matrix[2][0] = 8'h01;aes_matrix[2][1] = 8'h01;aes_matrix[2][2] = 8'h02;aes_matrix[2][3] = 8'h03;
		aes_matrix[3][0] = 8'h03;aes_matrix[3][1] = 8'h01;aes_matrix[3][2] = 8'h01;aes_matrix[3][3] = 8'h02;
	end
	//Variable for replicating hardware units
	genvar row,col,k;
	//Unpack the input matrix
	always_comb begin
        for (int c = 0; c < 4; c = c + 1) begin
            for (int r = 0; r < 4; r = r + 1) begin
                i_matrix[r][c] = i_data[((c * 4) + r) * 8 +: 8];
            end
        end
    end

	//GF multiplication.
	generate
	for(row = 0; row < 4;row = row + 1)begin:gen_row
		for(col = 0; col < 4;col = col + 1)begin:gen_col
			for(k = 0;k < 4;k = k + 1)begin:gen_k
			  GFM gfm_inst0(.i_data_a(aes_matrix[row][k]),.i_data_b(i_matrix[k][col]),.o_data(product[row][col][k]));
		end
	end
	end
	endgenerate

	//Accumalation of products
	always_comb begin
		for(r = 0;r < 4;r = r + 1) begin
			for(c = 0;c < 4;c = c + 1) begin
                         o_result[r][c] = product[r][c][0]^product[r][c][1]^product[r][c][2]^product[r][c][3];
			end
		end
	end
	
	//Packing into matrix
	always_comb begin
        for (int c = 0; c < 4; c = c + 1) begin
            for (int r = 0; r < 4; r = r + 1) begin
                o_data[((c * 4) + r) * 8 +: 8] = o_result[r][c];
            end
        end
    end	

endmodule

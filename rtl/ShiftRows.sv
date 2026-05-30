//Description:This module takes a 4x4 matrix where each element is one byte
//and shifts row by one.
//Author:Pranav Prabhu
//Email:pp7437@rit.edu;prnv.prbh@gmail.com

`default_nettype none

module ShiftRows(input logic [127:0] i_data,output logic[127:0] o_data);

	logic [7:0] i_matrix[0:3][0:3];
	logic [7:0] o_shifted [0:3][0:3];
//variables to iterate through row and column
	int r;
	int c;
//Unpack the input matrix
	always_comb begin
        for (int c = 0; c < 4; c = c + 1) begin
            for (int r = 0; r < 4; r = r + 1) begin
                i_matrix[r][c] = i_data[((c * 4) + r) * 8 +: 8];
            end
        end
    end


//Assigning First Row for shift
	assign o_shifted[0][0] = i_matrix[0][0];
        assign o_shifted[0][1] = i_matrix[0][1];
	assign o_shifted[0][2] = i_matrix[0][2];
	assign o_shifted[0][3] = i_matrix[0][3];

//Assigning Second Row for shift
	assign o_shifted[1][0] = i_matrix[1][1];
	assign o_shifted[1][1] = i_matrix[1][2];
	assign o_shifted[1][2] = i_matrix[1][3];
	assign o_shifted[1][3] = i_matrix[1][0];

//Assigning Third Row for shift
	assign o_shifted[2][0] = i_matrix[2][1];
	assign o_shifted[2][1] = i_matrix[2][2];
	assign o_shifted[2][2] = i_matrix[2][3];
	assign o_shifted[2][3] = i_matrix[2][0];

//Assigning Fourth Row for shift
	assign o_shifted[3][0] = i_matrix[3][1];
	assign o_shifted[3][1] = i_matrix[3][2];
	assign o_shifted[3][2] = i_matrix[3][3];
	assign o_shifted[3][3] = i_matrix[3][0];
//Packing into output matrix
always_comb begin
        for (int c = 0; c < 4; c = c + 1) begin
            for (int r = 0; r < 4; r = r + 1) begin
                o_data[((c * 4) + r) * 8 +: 8] = o_shifted[r][c];
            end
        end
    end
endmodule

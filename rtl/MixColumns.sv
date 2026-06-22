//Description: This module multiplies state matrix with a constant matrix.
//Author: Pranav Prabhu
//Email:pp7437@rit.edu;prnv.prbh@gmail.com

module MixColumns(input logic [127:0]i_data,output logic [127:0]o_data);
	
	//Declaring intermediate logic
	logic [7:0] i_matrix[0:3][0:3];
	logic [7:0] o_result [0:3][0:3];
	
	//LUT of constant matrix
	reg [8:0]aes_matrix[3:0][3:0] = '{
		//Column:0	1	2	3
		'{8'h02,8'h03,8'h01,8'h01},	//Row 0
		'{8'h01,8'h02,8'h03,8'h01},	//Row 1
		'{8'h01,8'h01,8'h02,8'h03},	//Row 2
		'{8'h03,8'h01,8'h01,8'h02}	//Row 3
		};
		//variables to iterate through row and column
	int r;
	int c;
	//Unpack the input matrix
	always_comb begin
        for ( c = 0; c < 4; c = c + 1) begin
            for ( r = 0; r < 4; r = r + 1) begin
                i_matrix[r][c] = i_data[((c * 4) + r) * 8 +: 8];
            end
        end
    end

	//GF multiplication.
	always_comb begin
	for(r = 0; r < 4;r = r + 1)begin
		for(c = 0; c < 4;c = c + 1)begin
			  GFM(.i_data_a(aes_matrix[r][c]),.i_data_b(i_matrix[c][r]),.o_data(o_result[c][r]));
		end
		
	end
	end
	
	//Packing into matrix
	always_comb begin
        for ( c = 0; c < 4; c = c + 1) begin
            for ( r = 0; r < 4; r = r + 1) begin
                o_data[((c * 4) + r) * 8 +: 8] = o_result[r][c];
            end
        end
    end	

endmodule

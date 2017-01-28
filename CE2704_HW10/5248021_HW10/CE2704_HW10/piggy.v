`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    16:16:13 02/24/12
// Design Name:    
// Module Name:    piggy
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module piggy(clk, reset, b1_in, b5_in, b10_in, 
              segment1, segment0, full_led);

    input clk, reset;
    input b1_in, b5_in, b10_in;
    output [6:0]segment1;
    output [6:0]segment0;
    output full_led;
	 reg [6:0]segment1;
    reg [6:0]segment0;
    reg full_led;
	 reg tenths, ones, ntenths, nones, sum0, sum1;

// Add code here

//M
always @ (posedge clk)
	begin
		if (reset)
			begin
				ntenths <=#1 0;
				nones <=#1 0;
			end
		else
			begin
				ntenths <=#1 tenths;
				nones <=#1 ones;
			end
	end

//NSCL
always @ (b1_in or b5_in or b10_in or ntenths or nones)
	begin
		if (b1_in==1)
			if ((ntenths==9)&&(nones==9))
				begin
					tenths = ntenths;
					nones = nones;
				end
			else if ((nones==9)&&(ntenths!=9))
				begin
					tenths = ntenths+1;
					nones = 0;
				end
			else
				begin
					tenths = ntenths;
					nones = nones+1;
				end
		else if (b5_in==1)
			if ((ntenths==9)&&(nones==9))
				begin
					tenths = ntenths;
					nones = nones;
				end
			else if ((nones==5)&&(ntenths!=9))
				begin
					tenths = ntenths+1;
					nones = 0;
				end
			else if ((nones==6)&&(ntenths!=9))
				begin
					tenths = ntenths+1;
					nones = 1;
				end
			else if ((nones==7)&&(ntenths!=9))
				begin
					tenths = ntenths+1;
					nones = 2;
				end
			else if ((nones==8)&&(ntenths!=9))
				begin
					tenths = ntenths+1;
					nones = 3;
				end
			else if ((nones==9)&&(ntenths!=9))
				begin
					tenths = ntenths+1;
					nones = 4;
				end
			else
				begin
					tenths = ntenths;
					nones = nones+5;
				end
		else if (b10_in==1)
			if (ntenths==9)
				begin
					tenths = ntenths;
					nones = nones;
				end
			else
				begin
					tenths = ntenths+1;
					nones = nones;
				end
		else
			begin
					tenths = ntenths;
					nones = nones;
				end
	end

//OCL
always @ (b1_in or b5_in or b10_in or ntenths or nones)
	begin
		if (b1_in==1)
			if ((ntenths==9)&&(nones==9))
				begin
					sum1 = ntenths;
					sum0 = nones;
				end
			else if ((nones==9)&&(ntenths!=9))
				begin
					sum1 = ntenths+1;
					sum0 = 0;
				end
			else
				begin
					sum1 = ntenths;
					sum0 = nones+1;
				end
		else if (b5_in==1)
			if ((ntenths==9)&&(nones==9))
				begin
					sum1 = ntenths;
					sum0 = nones;
				end
			else if ((nones==5)&&(ntenths!=9))
				begin
					sum1 = ntenths+1;
					sum0 = 0;
				end
			else if ((nones==6)&&(ntenths!=9))
				begin
					sum1 = ntenths+1;
					sum0 = 1;
				end
			else if ((nones==7)&&(ntenths!=9))
				begin
					sum1 = ntenths+1;
					sum0 = 2;
				end
			else if ((nones==8)&&(ntenths!=9))
				begin
					sum1 = ntenths+1;
					sum0 = 3;
				end
			else if ((nones==9)&&(ntenths!=9))
				begin
					sum1 = ntenths+1;
					sum0 = 4;
				end
			else
				begin
					sum1 = ntenths;
					sum0 = nones+5;
				end
		else if (b10_in==1)
			if (ntenths==9)
				begin
					sum1 = ntenths;
					sum0 = nones;
				end
			else
				begin
					sum1 = ntenths+1;
					sum0 = nones;
				end
		else
			begin
					sum1 = ntenths;
					sum0 = nones;
				end
	end
	begin
		if ((sum1==9)&&(sum0==9))
			full_led=1;
		else
			full_led=0;
	end
	begin
		case (sum1)
		0: begin
				segment1[6]=0;
				segment1[5]=1;
				segment1[4]=1;
				segment1[3]=1;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=1;
			end 
		1: begin
				segment1[6]=0;
				segment1[5]=0;
				segment1[4]=0;
				segment1[3]=0;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=0;
			end
		2: begin
				segment1[6]=1;
				segment1[5]=0;
				segment1[4]=1;
				segment1[3]=1;
				segment1[2]=0;
				segment1[1]=1;
				segment1[0]=1;
			end
		3: begin
				segment1[6]=1;
				segment1[5]=0;
				segment1[4]=0;
				segment1[3]=1;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=1;
			end
		4: begin
				segment1[6]=1;
				segment1[5]=1;
				segment1[4]=0;
				segment1[3]=0;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=0;
			end
		5: begin		 
				segment1[6]=1;
				segment1[5]=1;
				segment1[4]=0;
				segment1[3]=1;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=1;
			end
		6: begin
				segment1[6]=1;
				segment1[5]=1;
				segment1[4]=1;
				segment1[3]=1;
				segment1[2]=1;
				segment1[1]=0;
				segment1[0]=0;
			end
		7: begin
				segment1[6]=0;
				segment1[5]=0;
				segment1[4]=0;
				segment1[3]=0;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=1;
			end
		8: begin
				segment1[6]=1;
				segment1[5]=1;
				segment1[4]=1;
				segment1[3]=1;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=1;
			end
		9: begin		 
				segment1[6]=1;
				segment1[5]=1;
				segment1[4]=0;
				segment1[3]=1;
				segment1[2]=1;
				segment1[1]=1;
				segment1[0]=1;
			end
		endcase
	end
	begin
		case (sum0)
		0: begin
				segment0[6]=0;
				segment0[5]=1;
				segment0[4]=1;
				segment0[3]=1;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=1;
			end 
		1: begin
				segment0[6]=0;
				segment0[5]=0;
				segment0[4]=0;
				segment0[3]=0;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=0;
			end
		2: begin
				segment0[6]=1;
				segment0[5]=0;
				segment0[4]=1;
				segment0[3]=1;
				segment0[2]=0;
				segment0[1]=1;
				segment0[0]=1;
			end
		3: begin		 
				segment0[6]=1;
				segment0[5]=0;
				segment0[4]=0;
				segment0[3]=1;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=1;
			end
		4: begin
				segment0[6]=1;
				segment0[5]=1;
				segment0[4]=0;
				segment0[3]=0;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=0;
			end
		5: begin
				segment0[6]=1;
				segment0[5]=1;
				segment0[4]=0;
				segment0[3]=1;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=1;
			end
		6: begin
				segment0[6]=1;
				segment0[5]=1;
				segment0[4]=1;
				segment0[3]=1;
				segment0[2]=1;
				segment0[1]=0;
				segment0[0]=0;
			end
		7: begin
				segment0[6]=0;
				segment0[5]=0;
				segment0[4]=0;
				segment0[3]=0;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=1;
			end
		8: begin
				segment0[6]=1;
				segment0[5]=1;
				segment0[4]=1;
				segment0[3]=1;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=1;
			end				 
		9: begin
				segment0[6]=1;
				segment0[5]=1;
				segment0[4]=0;
				segment0[3]=1;
				segment0[2]=1;
				segment0[1]=1;
				segment0[0]=1;
			end
		endcase
	end

endmodule
 


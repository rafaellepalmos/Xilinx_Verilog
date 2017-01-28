module signedmul(clk, a_in, b_in, c);
    parameter n = 8;
    input clk;
    input [n-1:0] a_in, b_in;
    output [2*n-1:0] c;

    // flop a_in and b_in and turn them into a and b
    reg [n-1:0] a, b;
    always @(posedge clk) begin
        a <= #100000 a_in;
        b <= #100000 b_in;
    end

	// ============ pipeline stage 1 =============================

    // check whether a,b are at minimum in 2's complement
    wire a_min, b_min;
    assign a_min = (a == {1'b1, {(n-1){1'b0}} } );
    assign b_min = (b == {1'b1, {(n-1){1'b0}} } );

	// generate -a and -b
	wire [n-1:0] minus_a, minus_b;
	assign minus_a = -a;
	assign minus_b = -b;

    // calculate sign and magnitude parts of a, b
	// sa=sign_a, sb=sign_b, ma=magnitude_a, mb=magnitude_b
    wire sa, sb;
	wire [n-2:0] ma, mb;
    assign sa = a[n-1];
	assign ma = sa ? minus_a[n-2:0] : a[n-2:0];
    assign sb = b[n-1];
	assign mb = sb ? minus_b[n-2:0] : b[n-2:0];

    // generate the sign of the multiplication
	// sc = sign_c
    wire sc;
    assign sc = ( (a == 0)||(b == 0) )? 1'b0 : a[n-1] ^ b[n-1];

	// ============ pipeline stage 2 ============================

    // generate the magnitude of a*b (magnitude_c)
    wire [2*(n-1)-1:0] mc;
    // verilog 95 only supports unsigned multiplication
	assign mc = ma * mb;

	// ============= pipeline stage 3 ============================

    // generate two's complement of {sc,1'b0,mc}
	wire [2*n-1:0] mul;
    wire [2*(n-1):0] minus_mc;
    assign minus_mc = -mc;
	assign mul = sc ? {sc, minus_mc} : {sc, 1'b0, mc};

    // generate final result from mux41
    reg [2*n-1:0] cc;
    always @(a_min or b_min or mul or minus_a or minus_b) begin
		case({a_min, b_min})
			2'b00: cc = mul;
			2'b10: cc = {minus_b[n-1], minus_b, {(n-1){1'b0}} };
			2'b01: cc = {minus_a[n-1], minus_a, {(n-1){1'b0}} };
			default: cc = {2'b01, {(2*n-2){1'b0}} };
		endcase
	end

    // output c is the flopped version of cc
    reg [2*n-1:0] c;
    always @(posedge clk) begin
        c <= #100000 cc;
    end

endmodule

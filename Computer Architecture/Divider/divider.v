module divider(
    output reg[8:0] q,
	 output reg[7:0] r,
	 input[7:0] a,b);

reg [7:0] aux1, aux2; //valorile in binar pt a si b 
integer i; //contor

always @(*) begin
		q = 0;
		r = 0;
		if (a[7] == 1) //daca a negativ, il transform in binar
			aux1 = ~a + 8'b1; 
		else
			aux1 = a;
		if (b[7] == 1) //analog pentru b
			aux2 = ~b + 8'b1;
		else
			aux2 = b;
		for (i=7; i >= 0; i=i-1) begin //algoritmul Long Division
			r = r << 1;
			r[0] = aux1[i];
			if (r >= aux2) begin
				r = r-aux2;
				q[i] = 1;
			end
		end
		if ((a[7] ^ b[7]) == 1) //stabilesc cand e catul negativ
			q = -q;
		if ( r!= 0 && a[7] == 1) //stabilesc cand e restul negativ
			r = -r;			
		
end

endmodule

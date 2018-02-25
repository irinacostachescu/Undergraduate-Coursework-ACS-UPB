`timescale 1ns / 1ps

module maze(
input 		    clk,
input[5:0] 	    starting_col, starting_row, 		// indicii punctului de start
input 		    maze_in, 							// oferă informații despre punctul de coordonate [row, col]
output reg[5:0] row, col, 							// selectează un rând si o coloană din labirint
output reg 		 maze_oe,							// output enable (activează citirea din labirint la rândul și coloana date) - semnal sincron	
output reg 		 maze_we, 							// write enable (activează scrierea în labirint la rândul și coloana  date) - semnal sincron
output reg 		 done);		 						// ieșirea din labirint a fost gasită; semnalul rămane activ 


reg[3:0] state = 0;		//starea initiala
reg[3:0] next_state; 
reg[5:0] current_row, current_col;

//Partea secventiala
always @(posedge clk) begin
	state <= next_state;			//modifica stare
	current_row <= row;			//updateaza rand
	current_col <= col;			//updateaza coloana
end

//Partea combinationala
always @(*) begin
	row = starting_row; //valorile initiale pentru row si col (pozitia de start)
	col = starting_col;
	maze_oe = 0;		//citire dezactivata, o voi activa doar cand am nevoie. Scriere activata, o dezactivez cand am nevoie		
	maze_we = 1;		

	case(state)
	
		//asteapta inceperea functionarii (wait for posedge)
		0: begin 
			next_state = 1;
		end
		
		
		//Algoritmul de parcurgere a labirintului
		
		1: begin						//Directia de deplasare DREAPTA
			maze_we = 0; 				
			col = current_col;
			row = current_row;
			if (col == 63)			//ma opresc daca sunt pe margine	
				done = 1;
			else begin
				maze_oe = 1;				//activez citirea
				row = current_row+1;		//ma mut pe peretele din dreapta si trec in starea 2
				next_state = 2;
			end
		end
	
		2: begin
			if (maze_in != 1) begin
				row = current_row;		
				col = current_col;
				next_state = 10;  //daca nu am perete in dreapta, schimb directia de deplasare - JOS	
			end
			else begin
				maze_oe = 1;				//activez citirea
				maze_we = 0;				//dezactivez scrierea, sunt pe cazul maze_in e 1
				col = current_col + 1; //daca am perete in dreapta, ma mut pe celula de deplasare inainte si trec in starea 3
				row = current_row - 1;
				next_state = 3;
			end
		end
	
		3: begin
			if (maze_in != 1) begin
				row = current_row;
				col = current_col;
				next_state = 1;		//daca nu am perete in fata, continui deplasarea in dreapta, ma intorc in starea 1
			end
			else begin
				maze_oe = 1;				//activez citirea
				maze_we = 0;				//dezactivez scrierea, sunt pe cazul maze_in e 1
				col = current_col - 1;
				row = current_row - 1;
				next_state = 6;		//daca am perete in fata, incerc sa ma deplasez in SUS asadar trec in starea 6
			end
		end
		
	
	
		4: begin					//Directia de deplasare SUS	
				maze_we = 0;
				row = current_row;
				col = current_col;
				if (row == 0)				//ma opresc daca sunt pe margine
					done = 1;
				else begin
					maze_oe = 1;				//activez citirea
					col = current_col+1;  //ma mut pe peretele din dreapta si trec in starea 5
					next_state = 5;
				end
		end
	
	
		5: begin
				if (maze_in != 1) begin
					row = current_row;
					col = current_col;
					next_state = 1;    //daca nu am perete in dreapta, schimb directia de deplasare - DREAPTA
				end
				else begin
					maze_we = 0;					//dezactivez scrierea, sunt pe cazul maze_in e 1
					maze_oe = 1;				//activez citirea
					col = current_col - 1;
					row = current_row - 1;
					next_state = 6;			//daca am perete in dreapta, ma mut pe celula de deplasare inainte si trec in starea 6
				end
		end
	
		6: begin
				if (maze_in != 1) begin
					row = current_row;
					col = current_col;
					next_state = 4;			//daca nu am perete in fata, continui sa ma deplasez in SUS, ma intorc in starea 4
				end
				else begin
					maze_oe = 1;					//activez citirea
					maze_we = 0;					//dezactivez scrierea, sunt pe cazul maze_in e 1
					col = current_col - 1;
					row = current_row + 1;
					next_state = 9;			//daca am perete in fata, incerc sa ma deplasez in STANGA, asadar trec in starea 9
				end
		end
	
		7: begin 						//Directia de deplasare STANGA
				maze_we = 0;
				col = current_col;
				row = current_row;
				if (col == 0)		//ma opresc daca sunt pe margine		
					done = 1;
				else begin
					maze_oe = 1;		//activez citirea
					row = current_row-1; //ma mut in peretele din dreapta si trec in starea 8
					next_state = 8;
				end
		end
	
		8: begin						
				if (maze_in != 1) begin
					row = current_row;
					col = current_col;
					next_state = 4;		//daca nu am perete in dreapta, schimb directia de deplasare - SUS
				end
				else begin
					maze_oe = 1;				//activez citirea
					maze_we = 0;				//dezactivez scrierea, sunt pe cazul maze_in e 1
					col = current_col - 1;
					row = current_row + 1;
					next_state = 9;          //daca am perete in dreapta, ma mut pe celula corespunzatoare deplasarii inainte si trec in starea 9
				end
		end
	
		9: begin
				if (maze_in != 1) begin
					row = current_row;
					col = current_col;
					next_state = 7;			//daca nu am perete in fata, continui sa ma deplasez spre STANGA, ma intorc in starea 7
				end
				else begin
					maze_oe = 1;					//activez citirea
					maze_we = 0;					//dezactivez scrierea, sunt pe cazul maze_in e 1
					col = current_col + 1;
					row = current_row + 1;
					next_state = 12;			//daca am perete in fata, schimb directia de deplasare - JOS
				end
		end
	
	
		10: begin						//Directia de deplasare JOS
				maze_oe = 1;
				maze_we = 0;
				row = current_row;
				col = current_col;
				if (row == 63) 	//ma opresc daca sunt pe margine
					done = 1;
				else begin
					col = current_col-1; //ma mut pe pozitia perete dreapta si trec in starea 11
					next_state = 11;
				end
		end
	
	
		11: begin
				if (maze_in != 1) begin
					col = current_col;
					row = current_row;
					next_state = 7;			//daca nu am perete in dreapta schimb directia de deplasare STANGA
				end
				else begin
					maze_oe = 1;					//activez citirea
					maze_we = 0;					//dezactivez scrierea, sunt pe cazul maze_in e 1
					col = current_col + 1;
					row = current_row + 1;
					next_state = 12;			//daca am perete in dreapta, ma mut pe celula corespunzatoare deplasarii inainte si trec in starea 12
				end	
			
				
		end
	
		12: begin
				if (maze_in != 1) begin
					col = current_col;
					row = current_row;
					next_state = 10;			//daca nu am perete in fata, continui sa ma deplasez in JOS, ma intorc in starea 10
				end
				else begin
					maze_oe = 1;					//activez citirea
					maze_we = 0;					//dezactivez scrierea, sunt pe cazul maze_in e 1
					row = current_row - 1;
					col = current_col + 1;
					next_state = 3;			//daca am perete in fata, schimb directia de deplasare - DREAPTA
				end
		end
		
	endcase
end

endmodule

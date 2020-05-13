import numpy as np

def Mesh(L1, L2, H, R, file_name):
	#note that we will label vertices as shown in the class notes
	#length variables are the same except for Lf->L1 and Lw->L2

	#this will be a list of our vertices, which will each be lists themselves
	V_list = [ #0-7
	          [0.5,0,0],
			  [0.5/sqrt(2), 0.5/sqrt(2), 0],
			  [0,0.5,0],
			  [-0.5/sqrt(2), 0.5/sqrt(2),0],
			  [-0.5,0,0],
			  [-0.5/sqrt(2), -0.5/sqrt(2), 0],
			  [0,-0.5,0],
			  [0.5/sqrt(2), -0.5/sqrt(2), 0],

			  #8-15
			  [0.5+R, 0,0],
			  [(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),0],
			  [0,0.5+R,0],
			  [-(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),0],
			  [-(0.5+R),0,0],
			  [-(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 0],
			  [0,-(0.5+R),0],
			  [(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 0],

			  #16-31
			  [L2,0,0],
			  [L2, (0.5+R)/sqrt(2),0],
			  [L2,H,0],
			  [(0.5+R)/sqrt(2), H,0],
			  [0,H,0],
			  [-(0.5+R)/sqrt(2),H,0],
			  [-L1,H,0],
			  [-L1,(0.5+R)/sqrt(2),0],
			  [-L1,0,0],
			  [-L1,-(0.5+R)/sqrt(2),0],
			  [-L1,-H,0],
			  [-(0.5+R)/sqrt(2),-H,0],
			  [0,-H,0]
			  [(0.5+R)/sqrt(2),-H,0],
			  [L1,-H,0]
			  [L1,-(0.5+R)/sqrt(2),0],

			  #32-39
	          [0.5,0,1],
			  [0.5/sqrt(2), 0.5/sqrt(2), 1],
			  [0,0.5,1],
			  [-0.5/sqrt(2), 0.5/sqrt(2),1],
			  [-0.5,0,1],
			  [-0.5/sqrt(2), -0.5/sqrt(2), 1],
			  [0,-0.5,1],
			  [0.5/sqrt(2), -0.5/sqrt(2), 1],

			  #40-47
			  [0.5+R, 0,1],
			  [(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),1],
			  [0,0.5+R,1],
			  [-(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),1],
			  [-(0.5+R),0,1],
			  [-(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 1],
			  [0,-(0.5+R),1],
			  [(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 1],

			  #48-63
			  [L2,0,1],
			  [L2, (0.5+R)/sqrt(2),1],
			  [L2,H,1],
			  [(0.5+R)/sqrt(2), H,1],
			  [0,H,1],
			  [-(0.5+R)/sqrt(2),H,1],
			  [-L1,H,1],
			  [-L1,(0.5+R)/sqrt(2),1],
			  [-L1,0,1],
			  [-L1,-(0.5+R)/sqrt(2),1],
			  [-L1,-H,1],
			  [-(0.5+R)/sqrt(2),-H,1],
			  [0,-H,1]
			  [(0.5+R)/sqrt(2),-H,1],
			  [L1,-H,1]
			  [L1,-(0.5+R)/sqrt(2),1]
			 ]; 

	#list of blocks, where each entry is a list consisting of the vertices which define the block
	#note that the order of the vertices matters
	B_list = []
	


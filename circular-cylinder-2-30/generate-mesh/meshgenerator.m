[V_list, Edges]= Mesh(3.5, 6.5, 3.5, 0.5);

%create blockMeshDict file
filename='blockMeshDict.txt';
blockMesh= fopen(filename, 'w');

%header- scan from txt file
header=fopen('header.txt');
tline=fgetl(header);
while ischar(tline)
    fprintf(blockMesh, '%s\n', tline);
    tline=fgetl(header);
end
fclose(header);

%vertices- generated using Mesh
fprintf(blockMesh, 'vertices\n(\n');
for i=1:length(V_list)
    x=V_list(i, 1);
    y=V_list(i, 2);
    z=V_list(i, 3);
    fprintf(blockMesh,'\t(%.4f %.4f %.4f)\n', x, y, z); 
end
fprintf(blockMesh, ');\n');

%blocks- scan from txt file
blocks=fopen('blocks.txt');
tline=fgetl(blocks);
while ischar(tline)
    fprintf(blockMesh, [tline '\n']);
    tline=fgetl(blocks);
end
fclose(blocks);

%edges- generated using Mesh
fprintf(blockMesh, 'edges\n(\n');
for i=1:length(Edges)
    v1=Edges(i, 1);
    v2=Edges(i,2);
    x=Edges(i, 3);
    y=Edges(i, 4);
    z=Edges(i, 5);
    fprintf(blockMesh,'\tarc %.0f %.0f (%.4f %.4f %.4f)\n', v1, v2, x, y, z); 
end
fprintf(blockMesh, ');\n');

%boundary (and mergePatchPairs)- scan from txt file
boundary=fopen('boundary.txt');
tline=fgetl(boundary);
while ischar(tline)
    fprintf(blockMesh, [tline '\n']);
    tline=fgetl(boundary);
end
fclose(header);

%closing
closing=fopen('closing.txt');
tline=fgetl(closing);
fprintf(blockMesh, '%s\n', tline);
fclose(closing);

function [V_list, Edges]=Mesh(L1, L2, H, R)
	%note that we will label vertices as shown in the class notes
	%length variables are the same except for Lf->L1 and Lw->L2
    %cylinder is centered at (0,0,0)
	%this will be a list of our vertices, which will each be lists themselves
	V_list = [ %0-7
	          [0.5,0,0];
			  [0.5/sqrt(2), 0.5/sqrt(2), 0];
			  [0,0.5,0];
			  [-0.5/sqrt(2), 0.5/sqrt(2),0];
			  [-0.5,0,0];
			  [-0.5/sqrt(2), -0.5/sqrt(2), 0];
			  [0,-0.5,0];
			  [0.5/sqrt(2), -0.5/sqrt(2), 0];

			  %8-15
			  [0.5+R, 0,0];
			  [(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),0];
			  [0,0.5+R,0];
			  [-(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),0];
			  [-(0.5+R),0,0];
			  [-(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 0];
			  [0,-(0.5+R),0];
			  [(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 0];

			  %16-31
			  [L2,0,0];
			  [L2, (0.5+R)/sqrt(2),0];
			  [L2,H,0];
			  [(0.5+R)/sqrt(2), H,0];
			  [0,H,0];
			  [-(0.5+R)/sqrt(2),H,0];
			  [-L1,H,0];
			  [-L1,(0.5+R)/sqrt(2),0];
			  [-L1,0,0];
			  [-L1,-(0.5+R)/sqrt(2),0];
			  [-L1,-H,0];
			  [-(0.5+R)/sqrt(2),-H,0];
			  [0,-H,0];
			  [(0.5+R)/sqrt(2),-H,0];
			  [L2,-H,0];
			  [L2,-(0.5+R)/sqrt(2),0];

			  %32-39
	          [0.5,0,1];
			  [0.5/sqrt(2), 0.5/sqrt(2), 1];
			  [0,0.5,1];
			  [-0.5/sqrt(2), 0.5/sqrt(2),1];
			  [-0.5,0,1];
			  [-0.5/sqrt(2), -0.5/sqrt(2), 1];
			  [0,-0.5,1];
			  [0.5/sqrt(2), -0.5/sqrt(2), 1];

			  %40-47
			  [0.5+R, 0,1];
			  [(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),1];
			  [0,0.5+R,1];
			  [-(0.5+R)/sqrt(2), (0.5+R)/sqrt(2),1];
			  [-(0.5+R),0,1];
			  [-(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 1];
			  [0,-(0.5+R),1];
			  [(0.5+R)/sqrt(2), -(0.5+R)/sqrt(2), 1];

			  %48-63
			  [L2,0,1];
			  [L2, (0.5+R)/sqrt(2),1];
			  [L2,H,1];
			  [(0.5+R)/sqrt(2), H,1];
			  [0,H,1];
			  [-(0.5+R)/sqrt(2),H,1];
			  [-L1,H,1];
			  [-L1,(0.5+R)/sqrt(2),1];
			  [-L1,0,1];
			  [-L1,-(0.5+R)/sqrt(2),1];
			  [-L1,-H,1];
			  [-(0.5+R)/sqrt(2),-H,1];
			  [0,-H,1];
			  [(0.5+R)/sqrt(2),-H,1];
			  [L2,-H,1];
			  [L2,-(0.5+R)/sqrt(2),1];
			 ]; 
    
    s=(0.5+R)/2;
    Edges=[
            [0, 1, sqrt(3)/4, 1/4, 0];
            [1, 2, 1/4, sqrt(3)/4, 0];
            [2, 3, -1/4, sqrt(3)/4, 0];
            [3, 4, -sqrt(3)/4, 1/4, 0];
            [4, 5, -sqrt(3)/4, -1/4, 0];
            [5, 6, -1/4, -sqrt(3)/4, 0];
            [6, 7, 1/4, -sqrt(3)/4, 0];
            [7, 0, sqrt(3)/4, -1/4, 0];
            
            [32, 33, sqrt(3)/4, 1/4, 1];
            [33, 34, 1/4, sqrt(3)/4, 1];
            [34, 35, -1/4, sqrt(3)/4, 1];
            [35, 36, -sqrt(3)/4, 1/4, 1];
            [36, 37, -sqrt(3)/4, -1/4, 1];
            [37, 38, -1/4, -sqrt(3)/4, 1];
            [38, 39, 1/4, -sqrt(3)/4, 1];
            [39, 32, sqrt(3)/4, -1/4, 1];
            
            [8, 9, s*sqrt(3), s, 0];
            [9, 10, s, s*sqrt(3), 0];
            [10, 11, -s, s*sqrt(3), 0];
            [11, 12, -s*sqrt(3), s, 0];
            [12, 13, -s*sqrt(3), -s, 0];
            [13, 14, -s, -s*sqrt(3), 0];
            [14, 15, s, -s*sqrt(3), 0];
            [15, 8, s*sqrt(3), -s, 0];
            
            [40, 41, s*sqrt(3), s, 1];
            [41, 42, s, s*sqrt(3), 1];
            [42, 43, -s, s*sqrt(3), 1];
            [43, 44, -s*sqrt(3), s, 1];
            [44, 45, -s*sqrt(3), -s, 1];
            [45, 46, -s, -s*sqrt(3), 1];
            [46, 47, s, -s*sqrt(3), 1];
            [47, 40, s*sqrt(3), -s, 1];
        ];
end



    
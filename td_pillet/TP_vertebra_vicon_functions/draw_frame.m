function H=draw_frame(M1,color,t)

% function drawing the frame R1 in the frame R0 from the matrix M1
% containing the following terms :
% M11 = i1.i0 ; M12 = j1.i0 ; M13 = k1.i0 ; M14 = O1.i0
% M21 = i1.j0 ; M22 = j1.j0 ; M23 = k1.j0 ; M24 = O1.j0
% M31 = i1.k0 ; M32 = j1.k0 ; M33 = k1.k0 ; M34 = O1.k0
% M41 = 0 ; M42 = 0 ; M43 = 0 ; M44 = 1
% where i1,j1,k1 are the unit vectors of  R1 and O1 the center of R1
%
% output : H structure contaning the handles of the three axes of the frame R1 
% Input
% M1 : matrix 4*4 defined above
% color is a table of strings containing the abbreviations of the colors of the axes
%(default are red, green, blue )
% t :norm of the vectors to be drawn (default 500)

if nargin==2
    t=500;
end;
if nargin == 1
    color=['r','g','b'];
    t=500;
end;

H.h1=line([M1(1,4) M1(1,4)+t*M1(1,1)],[M1(2,4) M1(2,4)+t*M1(2,1)],[M1(3,4) M1(3,4)+t*M1(3,1)],'Color',color(1));
hold on
H.h2=line([M1(1,4) M1(1,4)+t*M1(1,2)],[M1(2,4) M1(2,4)+t*M1(2,2)],[M1(3,4) M1(3,4)+t*M1(3,2)],'Color',color(2));
H.h3=line([M1(1,4) M1(1,4)+t*M1(1,3)],[M1(2,4) M1(2,4)+t*M1(2,3)],[M1(3,4) M1(3,4)+t*M1(3,3)],'Color',color(3));

champs=fieldnames(H);
for ii=1:length(champs)
    set(H.(champs{ii}),'LineWidth',3)
end

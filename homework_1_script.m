clc; clear;

% generate 3 random vectors
R = rand(1,3);
T = rand(1,3);
B = rand(1,3);

M = calculate_rv_frame(T,R,B);

i = M(1:3,1);
j = M(1:3,2);
k = M(1:3,3);

% plotv(M(1:3,1:3))
% 
% quiver3(0,0,0,i(1), i(2), i(3)); hold on
% quiver3(0,0,0,j(1), j(2), j(3)); hold on
% quiver3(0,0,0,k(1), k(2), k(3)); hold on


T = verify_base(i,j,k);



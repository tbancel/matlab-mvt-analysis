delete(findall(0, 'Type', 'figure'));
clear;
close;
clc;

% session 2 using CSV
file_path= '/Users/tbancel/Desktop/MS_BME/UE 3.11b Mouvement analysis - surgical navigation/TD Pillet/TP_vertebra_vicon_data'
file_name = file_path + "/position0.csv"

%chose position.

data=read_csv_data(file_name);

% question 8
T=nanmean(extract_coordinates(data,{'T'}),3);
R=nanmean(extract_coordinates(data,{'R'}),3);
B=nanmean(extract_coordinates(data,{'B'}),3);

% question 9
% The global reference frame is (x,y,z) where |x| = 1 mm
M_g = eye(4,4);

draw_frame(M_g)
% draw_frame_thomas(M_g);
pT = plot3(T(1), T(2), T(3), '*'); hold on
pT.DisplayName = "Top";
pR = plot3(R(1), R(2), R(3), '*'); hold on
pR.DisplayName = "Right";
pB = plot3(B(1), B(2), B(3), '*'); hold on
pB.DisplayName = "Bottom";
legend('show');

% question 10
center=(T+B+R)/3;
M_v = calculate_rv_frame(T,R,B);
M_v(1:3,4)=center

% question 11
draw_frame(M_v)

% question 12
angles=axemobile(M_v, 'xyz')

% question 13
% here we need to calculate the rotation matrix from R_0 until R_i
% (position i)
% we also have to define R_0 in such a way that x,y,z are aligned...
% need to take picture




function angles=main(file_name)
%% Reading of the data

% Reading of the csv file
data=read_csv_data(file_name);
% Extraction of the coordinates of the 3 markers
T=nanmean(extract_coordinates(data,{'T'}),3);
R=nanmean(extract_coordinates(data,{'R'}),3);
B=nanmean(extract_coordinates(data,{'B'}),3);

% Q8: nanmean(M, 3) calculate the mean of the matrix (along its third dimension), we obtain a 
% 1x3 matrix

center=mean(T+B+R)
% Q9:
MR0Rv = calculate_rv_frame(T,R,B)




%% Section here:
% Q1 : Draw the markers 

%% calculation of the angular position
% Q2 : Calculation of the transformation matrix MR0Rv : write the function calculate_Rv_frame
%MR0Rv = calculate_Rv_frame(T,R,B);

% Q3: draw the Rv frame on the same figure as the marker

% Q4 : calculation of the angles using the function axemobile


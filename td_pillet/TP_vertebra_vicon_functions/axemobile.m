function angles=axemobile(M,sequence)

% angles is a vector containing the 3 angles defining the angular position
% of the frame which transformation matrix (3*3) M is given as an input
% according to the sequence defined by a string of 3 caracters
% corresponding to the order of the 3 mobile axes

switch sequence
    case 'xyz'
        angles = axemobile_xyz(M);
    case 'xzy'
        angles = axemobile_xzy(M);
    case 'yxz'
        angles = axemobile_yxz(M);
    case 'yzx'
        angles = axemobile_yzx(M);
    case 'zxy'
        angles = axemobile_zxy(M);
    case 'zyx'
        angles = axemobile_zyx(M);
end
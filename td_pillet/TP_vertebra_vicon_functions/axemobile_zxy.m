%
% MobileAxis.cpp
% Implementation of functions to get angles from a rotation matrix
%
% Composed rotation matrices for all the composition orders:

%
%        [c(ay)*c(az)-s(ax)*s(ay)*s(az)  -c(ax)*s(az)  c(az)*s(ay)+c(ay)*s(ax)*s(az)]
% Rzxy = [c(ay)*s(az)+c(az)*s(ax)*s(ay)  c(ax)*c(az)   s(ay)*s(az)-c(ay)*c(az)*s(ax)]
%        [-c(ax)*s(ay)                   s(ax)         c(ax)*c(ay)                  ]

% In all of those, ax = alpha = rotation around mobile x axis
%                  ay = beta  = rotation around mobile y axis
%                  az = gamma = rotation around mobile z axis
%

%
% All the matrices have a similar form, in which:
%
%   * The rotation around the second axis can be accessed through its sine
%   * The other two can be accessed through their tangents
%
% So all we need is a list of where to find the necessary data in the composed
% matrix, and whether we need to swap the sign of each element before taking
% the inverse trigonometric function.
%
%
%
% Get back the angles around mobile axes for a rotation matrix
%
function [OutputVector] = axemobile_zxy(M)
% Table to find the values of interest in the composed rotation matrices


az = NaN; ay = NaN;
% Retrieve the second angle in the sequence by its sinus
ax = asin(M(3, 2));

 
% Retrieve the first angle in the sequence by its tangent
if ((M(1, 2) ~= 0) && (M(2, 2) ~= 0))
    % General case, tan(az) = FNumerator / FDenominator
    az = atan2(- M(1, 2), M(2, 2));
elseif ((M(1, 2) == 0) && (M(2, 2) == 0))
    % Case where cos(ax) = 0, and the other two angles are not defined
    az = NaN;
elseif ((M(1, 2) == 0) && (M(2, 2) ~= 0))
    % Case where sin(az) = 0 so az is 0� or 180�
    % Ratio of FNumerator to cos(ax) is cos(az)
    az = real(acos(M(2, 2) / cos(ax)));
elseif ((M(1, 2) ~= 0) && (M(2, 2) == 0))
    % Case where cos(az) = 0 so az is -90� or 90�
    % Ratio of FDenominator to cos(ax) is sin(az)
    az = real(asin(- M(1, 2) / cos(ax)));
end

% Retrieve the first angle in the sequence by its tangent
if ((M(3, 1) ~= 0) && (M(3, 3) ~= 0))
    % General case, tan(ay) = TNumerator / TDenominator
    ay = atan2(- M(3, 1), M(3, 3));
elseif ((M(3, 1) == 0) && (M(3, 3) == 0))
    % Case where cos(ax) = 0, and the other two angles are not defined
    ay = NaN;
elseif ((M(3, 1) == 0) && (M(3, 3) ~= 0))
    % Case where sin(ay) = 0 so ay is 0� or 180�
    % Ratio of TNumerator to cos(ax) is cos(ay)
    ay = real(acos(M(3, 3) / cos(ax)));
elseif ((M(3, 1) ~= 0) && (M(3, 3) == 0))
    % Case where cos(ay) = 0 so ay is -90� or 90�
    % Ratio of TDenominator to cos(ax) is sin(ay)
    ay = real(asin(- M(3, 1) / cos(ax)));
end
% Rearrange the results so we have them in the order Rx, Ry, Rz
OutputVector = [ax ay az] * 180 / pi;

%
% MobileAxis.cpp
% Implementation of functions to get angles from a rotation matrix
%
% Composed rotation matrices for all the composition orders:

%        [c(ay)*c(az)                    -s(az)                         c(az)*s(ay)]
% Rxzy = [s(ax)*s(ay)+c(ax)*c(ay)*s(az)  c(ax)*c(az)  c(ax)*s(ay)*s(az)-c(ay)*s(ax)]
%        [c(ay)*s(ax)*s(az)-c(ax)*s(ay)  c(az)*s(ax)  c(ax)*c(ay)+s(ax)*s(ay)*s(az)]
%
%
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
function [OutputVector] = axemobile_xzy(M)

ax = NaN;ay = NaN;
% Retrieve the second angle in the sequence by its sinus
az = asin(- M(1, 2));


% Retrieve the first angle in the sequence by its tangent
if ((M(3,2) ~= 0) && (M(2,2) ~= 0))
    % General case, tan(ax) = FNumerator / FDenominator
    ax = atan2(M(3,2), M(2,2));
elseif ((M(3,2) == 0) && (M(2,2) == 0))
    % Case where cos(ay) = 0, and the other two angles are not defined
    ax = NaN;
elseif ((M(3,2) == 0) && (M(2,2) ~= 0))
    % Case where sin(ax) = 0 so ax is 0� or 180�
    % Ratio of FNumerator to cos(ay) is cos(ax)
    ax = real(acos(M(2,2) / cos(az)));
elseif ((M(3,2) ~= 0) && (M(2,2) == 0))
    % Case where cos(ax) = 0 so ax is -90� or 90�
    % Ratio of FDenominator to cos(ay) is sin(ax)
    ax = real(asin(M(3,2) / cos(az)));
end


% Retrieve the first angle in the sequence by its tangent
if ((M(1, 3) ~= 0) && (M(1, 1) ~= 0))
    % General case, tan(ay) = TNumerator / TDenominator
    ay = atan2(M(1, 3), M(1, 1));
elseif ((M(1, 3) == 0) && (M(1, 1) == 0))
    % Case where cos(az) = 0, and the other two angles are not defined
    ay = NaN;
elseif ((M(1, 3) == 0) && (M(1, 1) ~= 0))
    % Case where sin(ay) = 0 so ay is 0� or 180�
    % Ratio of TNumerator to cos(az) is cos(ay)
    ay = real(acos(M(1, 1) / cos(az)));
elseif ((M(1, 3) ~= 0) && (M(1, 1) == 0))
    % Case where cos(ay) = 0 so ay is -90� or 90�
    % Ratio of TDenominator to cos(az) is sin(ay)
    ay = real(asin(M(1, 3) / cos(az)));
end
% Rearrange the results so we have them in the order Rx, Ry, Rz
OutputVector = [ax ay az] * 180 / pi;

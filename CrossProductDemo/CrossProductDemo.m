%% Understand cross product through visualisation

%
% author: Gary Zhang (gary.zhang@ucl.ac.uk)
%

%% Define two 3-D vectors

% magnetic field B, chosne as the z axis of our reference framework
vecB = [0 0 1]';

% magnetic moment mu
vecMu = [0.25 0.25 0.5]';

%% Visualise the vectors

figure;

% visualise the 1st vector with quiver3
% note: the 2nd to last argument is needed to disable automatic scaling of
% the vector length
quiver3(0, 0, 0, vecB(1), vecB(2), vecB(3), 0, 'r');

% label the vector, by placing the label along and slightly away from the
% tip of the vector
labelPosition = 1.05*vecB;
label = 'B';
text(labelPosition(1), labelPosition(2), labelPosition(3), label);

% label the figure axes
xlabel('x');
ylabel('y');
zlabel('z');

% Essential to ensure the physically correct aspect ratio is used
axis equal;

% set the figure up for the superposition mode 
hold on;

% visualise the 2nd vector
quiver3(0, 0, 0, vecMu(1), vecMu(2), vecMu(3), 0, 'b');

% label the vector
labelPosition = 1.05*vecMu;
label = texlabel('mu');
text(labelPosition(1), labelPosition(2), labelPosition(3), label);

%% Compute the cross product of these two vectors

% B cross mu
vecBxMu = cross(vecB, vecMu);

% visualise the cross product
quiver3(vecMu(1), vecMu(2), vecMu(3), vecBxMu(1), vecBxMu(2), vecBxMu(3), 0, 'm');

% label the vector
labelPosition = vecMu + 1.05*vecBxMu;
label = texlabel('B x mu');
text(labelPosition(1), labelPosition(2), labelPosition(3), label);

% ordering matters: mu cross B
vecMuxB = cross(vecMu, vecB);

% visualise the vector
quiver3(vecMu(1), vecMu(2), vecMu(3), vecMuxB(1), vecMuxB(2), vecMuxB(3), 0, 'k');

%label the vector
labelPosition = vecMu + 1.05*vecMuxB;
label = texlabel('mu x B');
text(labelPosition(1), labelPosition(2), labelPosition(3), label);

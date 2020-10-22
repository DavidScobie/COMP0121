%% Understand cross product through visualisation

%
% author: Gary Zhang (gary.zhang@ucl.ac.uk)
%

%% Define two 3-D vectors

% magnetic field B, chosne as the z axis of our reference framework
vecB = [0 0 1]';
vecMu=[0.25 0.25 0.5]';

%% Visualise the vectors

figure;

% visualise the 1st vector with quiver3
% note: the 2nd to last argument is needed to disable automatic scaling of
% the vector length
% quiver3(0, 0, 0, vecB(1), vecB(2), vecB(3), 0, 'r');

% label the vector, by placing the label along and slightly away from the
% tip of the vector
labelPosition = 1.05*vecB;
label = 'B';
% text(labelPosition(1), labelPosition(2), labelPosition(3), label);

% label the figure axes
xlabel('x');
ylabel('y');
zlabel('z');

% Essential to ensure the physically correct aspect ratio is used
axis equal;

% set the figure up for the superposition mode 
hold on;

% visualise the 2nd vector
% quiver3(0, 0, 0, vecMu(1), vecMu(2), vecMu(3), 0, 'b');

% label the vector
labelPosition = 1.05*vecMu;
label = texlabel('mu');
% text(labelPosition(1), labelPosition(2), labelPosition(3), label);

%% Compute the cross product of these two vectors

% B cross mu
vecBxMu = cross(vecB, vecMu);

% visualise the cross product
% quiver3(vecMu(1), vecMu(2), vecMu(3), vecBxMu(1), vecBxMu(2), vecBxMu(3), 0, 'm');

% label the vector
labelPosition = vecMu + 1.05*vecBxMu;
label = texlabel('B x mu');
% text(labelPosition(1), labelPosition(2), labelPosition(3), label);

% ordering matters: mu cross B
vecMuxB = cross(vecMu, vecB);

% visualise the vector
% quiver3(vecMu(1), vecMu(2), vecMu(3), vecMuxB(1), vecMuxB(2), vecMuxB(3), 0, 'k');

%label the vector
labelPosition = vecMu + 1.05*vecMuxB;
label = texlabel('mu x B');
% text(labelPosition(1), labelPosition(2), labelPosition(3), label);

%% Define a set of mu vectors

noOfVecMus=6;

vecMus=zeros(3,noOfVecMus);

vecMus(3,:)=vecMu(3);

magnitudeTransverse=norm(vecMu(1:2));

deltaTheta=2*pi/noOfVecMus;

phiTransverse=deltaTheta*(1:1:noOfVecMus);

vecMus(1,:)=magnitudeTransverse*cos(phiTransverse);

% for i=1:noOfVecMus
%     vecMus(1,i)=magnitudeTransverse*phiTransverse(i);
% end

vecMus(2,:)=magnitudeTransverse*(sin(phiTransverse));

%%
%Compute the corresponding cross products

vecMusXB=cross(vecMus,repmat(vecB,1,noOfVecMus));

%%
%Visualise the set of mu vectors

quiver3(0,0,0,vecB(1),vecB(2),vecB(3),0,'r');

labelPosition=1.05*vecB;
label='B';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);

xlabel('x');
ylabel('y');
zlabel('z');

axis equal;
hold on;

quiver3(zeros(1,noOfVecMus),zeros(1,noOfVecMus),zeros(1,noOfVecMus),...
    vecMus(1,:),vecMus(2,:),vecMus(3,:), 0 ,'b');

for i=1:noOfVecMus
    labelPosition=1.05*vecMus(:,i);
    label=texlabel(strcat('mu',num2str(i)));
    text(labelPosition(1),labelPosition(2),labelPosition(3),label);
end

quiver3(vecMus(1,:),vecMus(2,:),vecMus(3,:),...
    vecMusXB(1,:),vecMusXB(2,:),vecMusXB(3,:), 0 ,'m');

for i=1:noOfVecMus
    labelPosition=vecMus(:,i) + 1.05*vecMusXB(:,i);
    label=texlabel(strcat('mu',num2str(i),' x B'));
    text(labelPosition(1),labelPosition(2),labelPosition(3),label);
end

%%
%Transform the single magnetic moment through a set of steps

%no of steps
noOfSteps=6;

deltaTheta=2*pi/noOfSteps;

figure;
h=subplot(1,1,1);

quiver3(0,0,0,vecB(1),vecB(2),vecB(3),0,'r');
hold on

labelPosition=1.05*vecB;
label='B';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);

xlabel('x');
ylabel('y');
zlabel('z');

axis equal;

plotSpin3D(h,vecMu);
hold on

xlim([-0.5 0.5]);
ylim([-0.5 0.5]);

for i=1:noOfSteps
    rot=[cos(deltaTheta),sin(deltaTheta),0;-sin(deltaTheta),cos(deltaTheta),0;...
    0,0,1];
    vecMu=rot*vecMu;
    pause(0.5);
    plotSpin3D(h,vecMu);
    hold on
end

%%
%Repeating with complex numbers
figure;
h=subplot(1,1,1);

quiver3(0,0,0,vecB(1),vecB(2),vecB(3),0,'r');
hold on

labelPosition=1.05*vecB;
label='B';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);

xlabel('x');
ylabel('y');
zlabel('z');

axis equal;

plotSpin3D(h,vecMu);
hold on

xlim([-0.5 0.5]);
ylim([-0.5 0.5]);

transverseComponent=vecMu(1)+vecMu(2)*1i;

PhaseIncrement=cos(deltaTheta)+sin(-deltaTheta)*1i;

for i=1:noOfSteps
    transverseComponent=transverseComponent*PhaseIncrement;
    vecMu(1)=real(transverseComponent);
    vecMu(2)=imag(transverseComponent);
    pause(0.5);
    plotSpin3D(h,vecMu);
    hold on
end






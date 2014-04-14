% Generating Hexagonal Cell Site with random users 
%http://www.igoy.in/generating-hexagonal-cell-site-with-random-users-in-matlab/
%clc;
clear all;
close all;

%Generating a hexagon with centre (0,0)and radius 1.4

%Cells=[-1.866025404, -1.866025404, -1.866025404, -1.866025404, -1.866025404, -1.866025404, -1.866025404,
%    0,0,0,0, 0.866025404, 0.866025404, 0.866025404, 0.866025404, 0.866025404,
%    1.866025404, 866025404,866025404;
%    1,0,-1,1.5,-0.5,2,1,-1,-2,1.5,0.5,-0.5, 1, 0,-1];

celly=[1,0, -1, 1.5,0.5,-0.5,-1.5,2,1,-1,-2, 1.5,0.5,-0.5,-1.5, 1,0,-1];
Cells=ones(2,length(celly));
Cells(2,:)=celly;

%Generating a hexagon with centre (0,0) and radius 1.4
%if your cell radius needs to be 1 unit then replace
%1.40 by 1
%2.42 (1.4 x 1.732) by 1.732 (1 x 1.732)
%1.21 (1.4 x 0.866) by 0.866 (1 x 0.866)
%2.10 (1.4 x 1.500) by 1.500 (1 x 1.500)
% Also adjust xa, xb, ya & yb accordingly.

t=linspace(0,2*pi,7);
ahx=0+1.4*cos(t);
bhx=0+1.4*sin(t);
plot(ahx,bhx);
plot(0,0,'ro');
grid on
hold on

% To generate 6 adjacent hexagon

%Upper middle hex
a1=0+1.4*cos(t);    
b1=2.42+1.4*sin(t);     %2.42 = 1.4 * 1.732; 1.732 = sqrt(3)
plot(a1,b1);
plot(0,2.42,'ko');

a2=0+1.4*cos(t);        % Lower middle hex
b2=-2.42+1.4*sin(t);    % 2.42 = 1.4 * 1.732
plot(a2,b2);
plot(0,-2.42,'ko');

% Right lower hex
a3=2.1+1.4*cos(t);      % 2.1 = 1.4*1.500    
b3=-1.21+1.4*sin(t);    % 1.21=1.4*0.866
plot(a3,b3);
plot(2.1,-1.21,'ko');
	 
a4=2.1+1.4*cos(t);                      % Right upper hex
b4=1.21+1.4*sin(t);
plot(a4,b4);
plot(2.1,1.21,'ko');
	 
a5=-2.1+1.4*cos(t);                     % Left upper hex
b5=1.21+1.4*sin(t);
plot(a5,b5);
plot(-2.1,1.21,'ko');
	 
a6=-2.1+1.4*cos(t);                     % Left lower hex
b6=-1.21+1.4*sin(t);
plot(a6,b6);
plot(-2.1,-1.21,'ko');
 
% Generate 500 UEs randomly distributed in the central Cell
% a1=0+1.4*cos(t);    
% b1=2.42+1.4*sin(t);     %2.42 = 1.4 * 1.732; 1.732 = sqrt(3)
for i=1:250    
    xa=-0.75+1.5*rand(1,1);
    ya=-1.2+2.4*rand(1,1);
    xra(i)=xa;
    yra(i)=ya;
    xb=-1+2*rand(1,1);
    yb=-0.65+1.3*rand(1,1);
    xrb(i)=xb;
    yrb(i)=yb;

	figure(1)
    plot(xra(i),yra(i),'k.');
    hold on
    % plot(xrb(i),yrb(i),'k.');
end
%  Cell19_1km : 
%   this file generate the plot of 19 Celluers, 19 Node Bs
%   each 3-sector site located in the edge of each single cell 
%
%   simulate the rality as 
%     omni attena site lies at the middle of one  cell
%  
%   Parameters in this file: site distance = 1 km, cell radius = 0.577 =1/sqrt(3) km
%   Xu qing  20 Feb. 2012 
%
%  needed m-files: none
clear all;
close all;

% BSs's positons & MB's range
t=linspace(pi/2,5*pi/2,7);
plot(0,0,'ro');             text(0.01, -0.1,'BS1');
grid on;
hold on;

bsx1=cos(t);
bsy1=sin(t);

R = 1/sqrt(3);      % cellular radius
bsx2=sqrt(3)*cos(t-pi/6);
bsy2=sqrt(3)*sin(t-pi/6);

% BS's locations
plot(bsx1,bsy1,'ro');
plot(2*bsx1,2*bsy1,'mo');
plot(bsx2,bsy2,'ko');

BScoordinate_1km = [bsx1,bsx2,2*bsx1;bsy1,bsy2,2*bsy1];   % in meter

% Cell's coverage
% initial cell, central from the original point
cx0=R*cos(t+pi/2);     
cy0=R*sin(t+pi/2);      text(0.1, 0.1,'C1');

plot(cx0,cy0); 
plot(cx0,cy0+1); 
plot(cx0,cy0+2); 
plot(cx0,cy0-1); 
plot(cx0,cy0-2); 

cx1=cx0+0.866;    cy1=cy0+0.5;            
plot(cx1,cy1);
plot(cx1,cy1+1);
plot(cx1,cy1-1);
plot(cx1,cy1-2);

cx2=cx0-0.866;    cy2=cy0+0.5;   
plot(cx2,cy2);
plot(cx2,cy2+1);
plot(cx2,cy2-1);
plot(cx2,cy2-2);


cx3=cx0+1.732; cy3=cy0;
plot(cx3,cy3);
plot(cx3,cy3+1);
plot(cx3,cy3-1);


cx4=cx0-1.732; cy4=cy0;
plot(cx4,cy4);
plot(cx4,cy4+1);
plot(cx4,cy4-1);

Num = 1:1:10;
UserNotFarFromBS = zeros(2,length(Num));
UserFarFromBS = zeros(2,length(Num));
userCoverage_far = 0.95;         % random coverage 
userCoverage_half = 0.5;
UserRb = zeros(1,length(Num));

% Generate UEs randomly distributed in the central Cell
% x:[0,1], y : [0, 3^(-0.5)]
% x, y, round the original point with same coverage persent 
for i=1: length(Num)
    % generate the array of service bit rate for users
    % generate the array of user positions , with same coverage 
    th = 10*rand(1);
    UserNotFarFromBS(:,i)= 0.5*R*[cos(th+pi);sin(th+pi)]; 
    UserFarFromBS(:,i)=0.8*R*[cos(th);sin(th)];
    
    plot(UserNotFarFromBS(1,i),UserNotFarFromBS(2,i),'k.');
    plot(UserFarFromBS(1,i),UserFarFromBS(2,i),'r.');   
end

title({'19Cells, 19 omnidirectional antenna Node Bs'; 'site distance = 1000 m, cell radius = 1/sqrt(3) = 557 m'});
%UEs close to and far from BS1




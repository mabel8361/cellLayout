%  Cell19_1km : 
%   this file generate the plot of 19 Celluers, 19 Node Bs
%   each 3-sector site located in the edge of each single cell 
%
%   simulate the rality as 
%      figure r_one 3 sector cell site lies at the edge of severl cells
%
%   other reference: 
%  "Selection procedures for the choice of radio transmission technologies
%  of the UMTS"
%   3GPP UMTS Cellular layout of UMTS@ TR 101 112 V3.2.0 Figure 1.3.4.3.A
%       site distance = 6/1.5km; cell radius  = 2km /500m
%  
%   Parameters in this file: site distance = 3 km, cell radius = 1 km
%   Xu qing  20 Feb. 2012 
%
%  needed m-files: none
clear all;
close all;

% BSs's positons & MB's range
t=linspace(0,2*pi,7);
plot(0,0,'ro');             text(0.1,0.1,'O');
grid on;
hold on;

bsx1=3*cos(t);
bsy1=3*sin(t);

bsx2=sqrt(3)*3*cos(t-pi/6);
bsy2=sqrt(3)*3*sin(t-pi/6);

% BS's locations
plot(bsx1,bsy1,'ro');
plot(2*bsx1,2*bsy1,'mo');
plot(bsx2,bsy2,'ko');

% Cell's range
% initial cell, central from the original point
cx0=cos(t);     
cy0=sin(t);     

cx1=cx0+0.5;
cy1=cy0+sqrt(3)/2;
cx2=cx0+0.5;
cy2=cy0-sqrt(3)/2;

cx3=cx0-1;
cy3=cy0;

cx4=cx0-1;
cy4=cy0+sqrt(3);

plot(cx1,cy1);
plot(cx2,cy2);
plot(cx3,cy3);
plot(cx4,cy4);

text(0.5, sqrt(3)/2,'Cell 1');

% Results: BS's locations in m

cellRadius = 1;   
Num = 1:1:10;
UserNotFarFromBS = zeros(2,length(Num));
UserFarFromBS = zeros(2,length(Num));
userCoverage = 0.95;         % random coverage 
UserRb = zeros(1,length(Num));
% Generate UEs randomly distributed in the central Cell
% x:[0,1], y : [0, 3^(-0.5)]
for i=1: length(Num)
    % generate the array of service bit rate for users
    % generate the array of user positions , with same coverage 
    UserNotFarFromBS(:,i)= [rand(1); 1/sqrt(3)*rand(1)]; 
    UserFarFromBS(:,i)=[0.75 + 0.25*rand(1); 1.2 + (1.732-1.2)*rand(1)];
    
    plot(UserNotFarFromBS(1,i),UserNotFarFromBS(2,i),'k.');
    plot(UserFarFromBS(1,i),UserFarFromBS(2,i),'r.');   
 end






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
%   Parameters in this file: site distance = 1 km, cell radius = 1/3 km
%   Xu qing  20 Feb. 2012 
%
%  needed m-files: none
clear all;
close all;

% BSs's positons & MB's range
t=linspace(0,2*pi,7);
plot(0,0,'ro');             text(0.01, 0.05,'Node B');
grid on;
hold on;

bsx1=cos(t);
bsy1=sin(t);

bsx2=sqrt(3)*cos(t-pi/6);
bsy2=sqrt(3)*sin(t-pi/6);

% BS's locations
plot(bsx1,bsy1,'ro');
plot(1.5,0.866,'ro'); plot(-0.5,-0.866,'ro'); %plot(2*bsx1,2*bsy1,'mo');
plot(0,1.732,'ro');    %plot(bsx2,bsy2,'ko');


BScoordinate_1km = [bsx1,bsx2,2*bsx1;bsy1,bsy2,2*bsy1];   % in meter

% Cell's coverage
% initial cell, central from the original point
cx0=cos(t)/3;     
cy0=sin(t)/3;     

cx1=cx0+1/6;            text(1/6, sqrt(3)/6,'C1');
cy1=cy0+sqrt(3)/6;
cx2=cx0+1/6;            text(1/6, -sqrt(3)/6,'C2');
cy2=cy0-sqrt(3)/6;

cx3=cx0-1/3;               text(-1/3, 0,'C3');
cy3=cy0;
cx4=cx0-1/3;               text(-1/3, sqrt(3)/3,'C4');
cy4=cy0+1/sqrt(3);

plot(cx1,cy1); 
plot(cx2,cy2); 
plot(cx3,cy3); 
plot(cx4,cy4);

plot(cx0+1/6, cy0+ sqrt(3)/2);
plot(cx3,cy3-1/sqrt(3));    text(-1/3, -1/sqrt(3),'C10');

plot(cx1,cy1+1/sqrt(3));    text(1/6,sqrt(3)/2,'C5');
plot(cx1+1,cy1+1/sqrt(3));  text(7/6,sqrt(3)/2,'C17');
plot(cx1,cy1+2/sqrt(3));    text(1/6,2.5/sqrt(3),'C15');
plot(cx2,cy2-sqrt(3)/3);    text(1/6,-sqrt(3)/2,'C9');
plot(cx1+1,cy1);            text(7/6,sqrt(3)/6,'C18');
plot(cx2+1,cy2);            text(7/6,-sqrt(3)/6,'C19');
plot(cx4,cy4+1/sqrt(3));    text(-1/3,2*sqrt(3)/3,'C14');
plot(cx4+1,cy4+1/sqrt(3));  text(2/3,2*sqrt(3)/3,'C16');

plot(cx1-1,cy1);            text(-5/6,sqrt(3)/2,'C13');
plot(cx1-1,cy1+1/sqrt(3));  text(-5/6,sqrt(3)/6,'C12');
plot(cx2-1,cy2);            text(-5/6,-sqrt(3)/6,'C11');
plot(cx4+1,cy4);            text(2/3,sqrt(3)/3,'C6');
plot(cx3+1,cy3);            text(2/3,0,'C7');
plot(cx3+1,cy3-1/sqrt(3));  text(2/3,-1/sqrt(3),'C8');

cellRadius = 1;   
Num = 1:1:5;
UserNear = zeros(2,length(Num));
UserFar = zeros(2,2*length(Num));
UserMid = zeros(2,2*length(Num));
userCoverage = 0.95;         % random coverage 
UserRb = zeros(1,length(Num));

% Generate UEs randomly distributed in the central Cell
for i=1: length(Num)    
    UserNear(:,i)= [-0.1+0.1*rand(1); 0.2+0.1*rand(1)];  % x:[-0.1,0.1],y:[0.2,0.3]
    UserNear(:,2*i)= [0.1*rand(1); 0.1+0.1*rand(1)];  % x:[0,0.1],y:[0.1,0.2]    
    UserNear(:,3*i)= [0.1*rand(1); 0.1*rand(1)];  % x:[0.1,0.2],y:[0,0.1]    
    
    UserFar(:,i)=[0.75 + 0.25*rand(1); 1.2 + (1.732-1.2)*rand(1)]/3;
    UserFar(:,2*i)=[0.1*rand(1); 0.45+ 0.1*rand(1)];    %x[0, 0.1],y[0.45,0.55]
    UserFar(:,3*i)=[0.1+0.1*rand(1); 0.5+ 0.05*rand(1)];    %x[0.1, 0.2],y[0.5,0.55]
    
    UserMid(:,i)= [0.3*rand(1); 0.25+ 0.15*rand(1)];  % x:[0,0.3], y: [0.25,0.4]
    UserMid(:,2*i)= [0.1*rand(1); 0.4+ 0.*rand(1)]; % x:[0,0.1], y: [0.4,0.5]
    UserMid(:,3*i)= [0.25+0.1*rand(1); 0.15+ 0.1*rand(1)]; % x:[0.25,0.35], y: [0.15,0.25]
    
    %plot(UserNear(1,i),UserNear(2,i),'k.'); % 15 users 
    %plot(UserNear(1,2*i),UserNear(2,2*i),'k.');
    %plot(UserNear(1,3*i),UserNear(2,3*i),'k.');
    
    %plot(UserFar(1,i),UserFar(2,i),'r*');  
    %plot(UserFar(1,2*i),UserFar(2,2*i),'r*');  
    %plot(UserFar(1,3*i),UserFar(2,3*i),'r*');  
    
    %plot(UserMid(1,i),UserMid(2,i),'m+');             
    %plot(UserMid(1,2*i),UserMid(2,2*i),'m+');             
    %plot(UserMid(1,3*i),UserMid(2,3*i),'m+');     
end

%ylim([-1.4 1.9]) ;
xlim([-1.5,2]);
grid off;

set(gca,'ytick',[]);
set(gca,'xtick',[]);

%title({'User distributions in near/median/far scenarios'});
%title({'19 Hexagon Cells, 9 3-sector BSs'; ...,
%    'site distance = 1000 m, cell radius = 1/3 = 333.3 m'});
title({'19 Hexagon Cells, 9 3-sector base stations'; ...,
    'site distance = 3 km, cell radius = 1 km'});
%UEs close to and far from BS1




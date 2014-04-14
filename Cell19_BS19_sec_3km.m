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
plot(0,0,'ro');             text(0.1, -0.15,'Node B');
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

% coordinate for NPSW's implementation
BScoordinate = 1000*[bsx1,bsx2,2*bsx1;bsy1,bsy2,2*bsy1]';   % in meter

% Cell's coverage
% initial cell, central from the original point
cx0=cos(t);     
cy0=sin(t);     

cx1=cx0+0.5;            text(0.5, sqrt(3)/2,'C1');
cy1=cy0+sqrt(3)/2;
cx2=cx0+0.5;            text(0.5, -sqrt(3)/2,'C2');
cy2=cy0-sqrt(3)/2;

cx3=cx0-1;              text(-0.8, 0,'C3');
cy3=cy0;
cx4=cx0-1;               text(-0.8, sqrt(3),'C4');
cy4=cy0+sqrt(3);

cx5=cx0+2;          text(1.5,0,'C5');
cy5=cy0;
cx6=cx0+2;          text(1.5,sqrt(3),'C6')
cy6=cy0+sqrt(3);

plot(cx1,cy1);
plot(cx2,cy2);
plot(cx3,cy3);
plot(cx4,cy4);
plot(cx5,cy5);
plot(cx6,cy6);

cx2_1=cx2;
cy2_1=cy2-sqrt(3);
plot(cx2_1,cy2_1);
plot(cx2_1,cy2_1-sqrt(3));
plot(cx1,cy1+sqrt(3));

plot(cx1+3,cy1);   
plot(cx1+3,cy1-sqrt(3));
plot(cx1+3,cy1-2*sqrt(3));

plot(cx1-3,cy1);
plot(cx1-3,cy1-sqrt(3));
plot(cx1-3,cy1-2*sqrt(3));

plot(cx3,cy3-sqrt(3));
plot(cx3,cy3-2*sqrt(3));

plot(cx5,cy5-sqrt(3));
plot(cx5,cy5-2*sqrt(3));

cellRadius = 1;   
Num = 1:1:50;
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
    UserFarFromBS_lu(:,i)=[0.75 + 0.25*rand(1); 1.2 + (1.732-1.2)*rand(1)]; % up left 
    UserFarBS_ru(:,i)=[0.5*rand(1); 0.5*sqrt(3)+0.5*sqrt(3)*rand(1)];   %x[0,0.5], y[sqrt(3)/2,sqrt(3)] in the up right side from BS1
    
   % plot(UserNotFarFromBS(1,i),UserNotFarFromBS(2,i),'k.'); % near
   % plot(UserFarFromBS_lu(1,i),UserFarFromBS_lu(2,i),'r*'); % far  
   % plot(UserFarBS_ru(1,i),UserFarBS_ru(2,i),'c+');           %median
end

% coordinate for NPSW's implementation
MScoordinate=1000*[UserNotFarFromBS,UserFarFromBS_lu,UserFarBS_ru];


%set(gca,'ytick',[]);
%set(gca,'xtick',[]);


%%%%%%% restart, to generate the user distributions 

siteDistance = 3; % 1 or 3 km
userScenario = 'near'; % ['far','near','mid'];
UserNum =4;

Num = 1:1:3*UserNum;
% UserCoordinates = zeros(2,length(Num));
UserRb = zeros(1,length(Num));
Pdch_lin = zeros(1, length(Num));
Phs_lin = zeros(1, length(Num));
Pfach_lin = zeros(1, length(Num));
Ppc_lin = zeros(1, length(Num)); % record the results of 3GPP power counting 
Pdual = Ppc_lin;

% UserDistances = zeros(1, length(Num));

% the output will generate the coordinates of UE, number of 3*UserNum
UserNear = Layout(siteDistance, 'near',UserNum);
UserMid = Layout(siteDistance, 'mid',UserNum);
UserFar = Layout(siteDistance,'far',UserNum);
UserNear =  UserNear/1000; 
UserMid = UserMid/1000;
UserFar = UserFar/1000;

for i=1: length(Num)
    % generate the array of service bit rate for users
    % generate the array of user positions , with same coverage 
    %UserNotFarFromBS(:,i)= [rand(1); 1/sqrt(3)*rand(1)]; 
    %UserFarFromBS_lu(:,i)=[0.75 + 0.25*rand(1); 1.2 + (1.732-1.2)*rand(1)]; % up left 
    %UserFarBS_ru(:,i)=[0.5*rand(1); 0.5*sqrt(3)+0.5*sqrt(3)*rand(1)];   %x[0,0.5], y[sqrt(3)/2,sqrt(3)] in the up right side from BS1
    
    plot(UserNear(1,i),UserNear(2,i),'k.'); % near
    plot(UserMid(1,i),UserMid(2,i),'c+');           %median
    plot(UserFar(1,i),UserFar(2,i),'r*'); % far  
end

%legend('Near','Median','Far');
%title({'19 Cells, 19 3-sector BSs';'site distance = 3000 m, cell radius = 1000 m';'User distributions: near/median/far'});
title({'Node B distance = 3000 m, cell radius = 1000 m';'User distributions: near/median/far'});
ylim([-1, 2.5]) ;
xlim([-1, 2]);
grid off;

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

 plot (0:0,'r*');
% grid on;
 hold on;
 plot (0:0,'ko');
 plot(0:0,'+');
 LEG = legend ('s1: 128 kbps,(32,32,64 kbps);30ue', ...);
     's2: 128 kbsp,(64, 64 kbps); 40 ue',...
     's3: 64 kbsp,(64 kbps); 30 ue',...
     'Location', 'North');
 set(LEG,'FontSize',18);
  
% BSs's positons & MB's range
t=linspace(0,2*pi,7);
%plot(0,0,'ro');         
plot(0,0,'rs');           text(-0.15, 0.05,'Node-B 1', 'FontSize',18);
%hold on;
plot(-1.5, 2.598,'rs');   text(-1.45, 2.45, 'Node-B 2');
plot(1.5, 2.598,'rs');    %text(1.55, 2.45, 'Node-B 3');

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

cx1=cx0+0.5;            text(0.5, sqrt(3)/2,'Cell 1','FontSize',18);
cy1=cy0+sqrt(3)/2;  

text(0.5, 3*sqrt(3)/2,'Cell 5');
 
cx2=cx0+0.5;            text(0.5, -sqrt(3)/2,'Cell 2');
cy2=cy0-sqrt(3)/2;

cx3=cx0-1;              %text(-1, 0,'Cell 3');
cy3=cy0;
cx4=cx0-1;               %text(-1, sqrt(3),'Cell 4');
cy4=cy0+sqrt(3);

cx5=cx0+2;          %text(2,0,'Cell 7');
cy5=cy0;
cx6=cx0+2;         % text(2,sqrt(3),'Cell 6')
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


%Scenario from sec3-2s-far:   s1: 128 kbps, 10 UE (6-15); s2: 256 kbps, 10 UE (1-5; 16-20
UserS1ux_far =  [926.51  1023.7072  1001.4   927.3412  779.7494 , 937.8168  886.8039  953.5712  904.0112  979.2984]/1000;
UserS1uy_far = [1216.9    1368.7    1623    1601.5    1465.1    1335.7    1273.7    1329.6    1451.8    1352.1]/1000;

UserS2ux_far = [0.9537    0.8196    0.9893    0.9481    0.9197    0.7690    0.8922    0.8278    0.9223    0.7881]-0.15;
UserS2uy_far = [1.6819    1.4909    1.4582    1.7104    1.6031    1.2287    1.4497    1.4812    1.5980    1.6393]-2/sqrt(3);

Ux_far = [0.926   1.324        1.00       1.027      0.779 ,   0.938   0.886       0.053   0.9042  -0.179, -0.1 ];
Uy_far = [1.2169  0.8687    1.423    1.6015    1.4651    1.335    1.2737    1.5296    1.4518    1.3521, 1.4];
% distance: 1.5292    1.5835    1.7392    1.9025    1.6593    1.6316    1.5516    1.5305    1.7104    1.3639    1.4036

%Scenario from sec3-1s.txt:
UserUx_mix = [ 
    0.0564 ,    0.807, 0.204, -0.041,	-0.082, ..., % 1-5
    0.19542,  0.04842,   0.3486,   0.0492,    0.369, ..., % 6-10
    -0.0542 ,  0.555,  0.652,  0.7679,  0.5522, ...,  % 11-15
    0.8552 ,  0.0092,  0.04642,    0.26595,  0.0474, ...,       % 16-20    
    0.41433, 0.0535, 0.947, 	0.0544,     1.0355, ...,   % 21-25
    -0.07242, 0.27865, 0.4342,  0.554,    0.950 ...,         % 26-30 % new users start from her 
    0.7494,   0.99914,  0.836719, 0.92734, 0.2294 ...,  % 31-35
    -0.15,   0.15452,   0.34857, 0.87687,  0.9456 ..., % 36-40
    1.122, 1.345  ,     1.02,        0.421    0.4321  ...,  % 41-45
    0.35,    1.02,      -0.25         -0.346    -0.2  ...,    % 46 - 50 
    0.6,    0.85            0.25        1.1         0.85   ...,  % 51 - 55 
    0.1     0.9             0.4             0.7         0.85 ..., % 56 -60
    1.15     0.98    -0.05       0.55   0.57  ...,      % 61-65
    0.38    0.25        -0.07   0.56    0.15  ...,      % 66 - 70 
    0.2     0.55        0.575   1.157  0.302     ...,  % 71 - 75 
    0.24   -0.3         0.7        0.6  1.1   ...,             % 76 -80
    1.2     -0.05       -0.2    -0.05   0.556  ...,  % 81 - 85 
    1.32    0.95        0.7      0.68     0.7    ...,   % 86 -90
    0.35    -0.1        0.1     0.7     0.105 ...,      % 91 -100
    0.47   0.3          -0.2   0.7  0.15    ...,        % 101 - 105
   1.2      0.82        -0.35   0.57  0.49    ];  
 
UserUy_mix = [
    0.612    0.5    0.567    0.24    0.2164 , ...,% 1-5
    1.485    1.52    1.61    1.208    1.070 ...,   % 6-10
    1.206    1.13    0.81    1.5870    1.2600 ...,   % 11-15
     0.271    0.82    0.258    0.0086    0.1413 , ...,   % 16-20
    1.536    0.691    0.6384    0.4819    0.7261 ...,   % 21-25
    0.862    0.219    0.1640    0.1187  0.7328 ...,       % new users start from here
    1.192   0.691   0.652   1.602   1.6235 ...,   % 31-35
    0.744   0.1413  1.62    0.4783  0.461 ...,   % 36-40
    1.398   0.879    1.1      0.421   0.954 ...,    % 41 - 45 
    0.72     0.28   1.203    0.905      0.6 ...,        % 46 - 50 
    0.5        1.05     1.3     1              1.4...,          % 51 - 55 
    1       0.2     1.3        1.05      0.9  ...,          % 56 -60
    0.65    1.3     1.1     1.5         1.3 ...,
    0.6     0.41    0.5     0.3    0.9  ...,
    0.8     0.7     1.6    1.18   0.91     ...,
    1.15   0.8      0.4     0.2     0.4     ...,
    0.84    1.4     1       0.989   1.03 ...,
    1.108  1.5   0.6      0.16      0.25   ...,
    0.3     1.3     1.65    1.4         1.36   ...,
    0.8     1.4     0.4    0.9      1.68 ...,
    0.74    1.3     1.1    0.66     1.42     ];


%Scenario from sec3-1s-64k-far.txt:
ux_64k_far =  [0.9537    0.8196    0.9893    0.9481    0.9197    0.9265    0.9237    0.9414    0.9273    0.7797 ...,
    0.9378    0.8868    0.9536    0.9040    0.9793    0.7690    0.8922    0.8278    0.9223    0.7881 ...,
    0.7767    0.7711    0.7955    0.8875    0.8505    0.0381    0.2873    0.2401    0.1967    0.2229];

uy_64k_far =  [1.6819    1.4909    1.4582    1.7104    1.6031    1.2169    1.3687    1.6230    1.6015    1.4651 ...,
    1.3357    1.2737    1.3296    1.4518    1.3521    1.2287    1.4497    1.4812    1.5980    1.6393 ...,
    1.7117    1.4127    1.3403    1.2771    1.2404    1.6240    1.6395    1.3926    1.3607    1.4677]


% Generate UEs randomly distributed in the central Cell
% x:[0,1], y : [0, 3^(-0.5)]
% t 6 - t 10 too close 
    
    
%for i=1:length(UserUy_mix)/3
figure(1)
 %for i=1:length(UserUy_mix)
% for i  = 1:10
    % generate the array of service bit rate for users
    % generate the array of user positions , with same coverage 
    % plot(UserS1ux_far(i),UserS1uy_far(i),'ko');
    % plot(UserS2ux_far(i),UserS2uy_far(i),'kd');
    %plot (ux_64k_far(i), uy_64k_far(i), 'kd')
    %plot(Ux_far(i),Uy_far(i),'k.'); 
    % dis(i)= Distance([Ux_far(i);Uy_far(i)], [0;0]);    
  %  plot(UserUx_mix(i),UserUy_mix(i),'r.');
    % axis off;
   % ylim([-6 4]) ;
    % xlim([-4,5]);
    % for Cell1
   % ylim([-2 3.5]) ;
   % xlim([-2,3]);
    ylim([0 2.35]) ;
    xlim([-0.75,1.75]);
   % axis off;
    %ylim([0 1.8]) ;    
  % set(gca,'ytick', [0:0.1:1.8]);       
   %xlim([-0.5,1.5]);  
   % set(gca,'xtick', [-0.5:0.15:15]);       
 %end
 
   % plot(UserUx_mix(5:5),UserUy_mix(5:5),'.');
   % plot(UserUx_mix(1:20),UserUy_mix(1:20),'*');
 
 plot (0:0,'r*');
 %grid on;
 hold on;
 plot (0:0,'ko');
 plot(0:0,'+');
 
plot(UserUx_mix(31:40),UserUy_mix(31:40),'r*');
plot(UserUx_mix(61:80),UserUy_mix(61:80),'r*');
% plot(UserUx_mix(91:100),UserUy_mix(91:100),'*');

plot(UserUx_mix(21:30),UserUy_mix(21:30),'ko');
plot(UserUx_mix(41:60),UserUy_mix(41:60),'ko');
plot(UserUx_mix(81:90),UserUy_mix(81:90),'ko');

plot(UserUx_mix(11:20),UserUy_mix(11:20),'+');
plot(UserUx_mix(81:100),UserUy_mix(81:100),'+');
%legend('service 1: 128 kbps, 3 flows', 'service 2: 64 kbsp, 2 flows');
 
 %plot(UserUx_mix(21:40),UserUy_mix(21:40),'k.');
 %plot(UserUx_mix(41:60),UserUy_mix(41:60),'b.');
 % plot(UserUx_mix(61:80),UserUy_mix(61:80),'c.');
 % plot(UserUx_mix(81:length(UserUx_mix)),UserUy_mix(81:length(UserUy_mix)),'g.');
% coordinate for NPSW's implementation
%MScoordinate=1000*[UserNotFarFromBS,UserFarFromBS_lu,UserFarBS_ru];
% legend('Pt DCH','Pt HS-DSCH','Pt FACH');


title({'3-sector Node-Bs, site distance = 3000 m'}, 'FontSize',20); % , cell radius = 1000 m                     
% title({'3-sector Node-Bs, site distance = 3000 m'; % , cell radius = 1000 m
  %       '40 users(*) for service 1: 128 kbps, 3 sub flows: (32,32,64 kbps)';
    %    ' 40 users(.) for service 2: 128 kbsp, 2 sub flows: (64, 64 kbps)'});

    hold off;
%  subplot(2,2,1);
%plot(UserUx_mix(31:40),UserUy_mix(31:40),'r.');
%plot(UserUx_mix(41:60),UserUy_mix(41:60),'k.');
%legend('service 1: 128 kbps, 3 flows', 'service 2: 64 kbsp, 2 flows');
%xlim([-0.5,1.5]);  
    
% subplot(2,2,2);
%  plot(UserUx_mix(11:20),UserUy_mix(11:20),'r.');
%  ylim([0 1.8]) ;    
%  xlim([-0.5,1.5]);  
%  
% subplot(2,2,3);
%  plot(UserUx_mix(21:30),UserUy_mix(21:30),'r.');
%  ylim([0 1.8]) ;    
%  xlim([-0.5,1.5]);  
%  
% subplot(2,2,4);
% plot(UserUx_mix(31:40),UserUy_mix(31:40),'r.');
% ylim([0 1.8]) ;    
% xlim([-0.5,1.5]);  
%     
%gtext('title');


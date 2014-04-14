clear all;
close all;

%Pdch_lin = zeros(1, length(Num));
%UserCoordinates_3 = zeros(1, length(Num));

% global various: 
userScenario = 'far'; % ['far','near','random'];
UserNum = 8;
Num = 1:1:3*UserNum;
UserRb = zeros(1,length(Num));
Num =1:1:25;

% the output will generate the coordinates of UE, number of 3*UserNum
UserCoordinates_3t= Layout(3,userScenario, UserNum);
UserCoordinates_1t= Layout(1,userScenario, UserNum);

% user for s 1: 128 kbps far
UserS1ux_far =  [926.51  1023.7072  1001.4   927.3412  779.7494 , 937.8168  886.8039  953.5712  904.0112  979.2984];
UserS1uy_far = [1216.9    1368.7    1623    1601.5    1465.1    1335.7    1273.7    1329.6    1451.8    1352.1];

% user for s2: 256 kbps  near 
UserS2ux_far = [0.9537    0.8196    0.9893    0.9481    0.9197    0.7690    0.8922    0.8278    0.9223    0.7881]-0.15;
UserS2uy_far = [1.6819    1.4909    1.4582    1.7104    1.6031    1.2287    1.4497    1.4812    1.5980    1.6393]-2/sqrt(3);

UserCoordinates_1 = [UserS1ux_far; UserS1uy_far];
UserCoordinates_2 = 1000.*[UserS2ux_far; UserS2uy_far];
siteDistance =3;

%Scenario from sec3-1s.txt:
UserUx_mix = 1000*[ 
    0.0564 ,    0.807, 0.204, -0.041,	0.042, ..., % 1-5
    0.19542,  0.04842,   0.3486,   0.0492,    0.369, ..., % 6-10
    0.0542 ,  0.555,  0.652,  0.7679,  0.5522, ...,  % 11-15
    0.8552 ,  0.0092,  0.04642,    0.26595,  0.0474, ...,       % 16-20    
    0.41433, 0.0535, 0.947, 	0.0544,     1.0355, ...,   % 21-25
    -0.07242, 0.27865, 0.4342,  0.554,    0.950 ...,         % 26-30 % new users start from her 
    0.7494,   0.99914,  0.836719, 0.92734, 0.3294 ...,  % 31-35
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
 
UserUy_mix =1000* [
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

User_mix = [UserUx_mix; UserUy_mix];

for i=1: length(Num)
    UserRb_128(i) =128; % Service bitrate: Kbps              
    %UserRb_256(i) =256; % Service bitrate: Kbps              
    UserRb_64(i) =64; % Service bitrate: Kbps              
    
    %UserCoordinates_1 = UserCoordinates_1t(1:2,1:i);
    %UserCoordinates_3 = UserCoordinates_3t(1:2,1:i);
            
   % Pdch_1(i) = PtDCH(UserRb(1:i),UserCoordinates_1, 1);       
   % Pdch_3(i) = PtDCH(UserRb(1:i),UserCoordinates_3, 3);       
    %UserCoordinates_128 =  UserCoordinates_1(1:2,1:i);
    %UserCoordinates_256 =  UserCoordinates_2(1:2,1:i);

    UserCoordinates = User_mix(1:2,1:i);
    UserCoordinates_single = User_mix(1:2,i:i);
    
    Pdch_single_128(i) = PtDCH(128, UserCoordinates_single,siteDistance);
    Phs_single_128(i)= PtHS(128,UserCoordinates_single,siteDistance);
    
    Pdch_single_64(i) = PtDCH(64, UserCoordinates_single,siteDistance);
    Phs_single_64(i)= PtHS(64,UserCoordinates_single,siteDistance);
    
    Pdch_128(i) = PtDCH(UserRb_128, UserCoordinates,siteDistance);
    [Phs_128(i),numCode_128(i),allocBw_128(i)] = PtHS(UserRb_128,UserCoordinates,siteDistance );
    Pfach_128(i) = PtFACH(UserRb_128(i), UserCoordinates,siteDistance);
    %   numCode_128 =  numCode_256 = 1     2     3     3     3     3     4     4     5     5
    Xi(i)= xiCalc(User_mix(:,i), siteDistance);    
    Lp(i) = PathLoss(Distance(User_mix(:,i),[0;0]));
    Dis(i) = Distance(User_mix(:,i),[0;0]);
    
   Pdch_64(i) = PtDCH(UserRb_64, UserCoordinates,siteDistance);
   [Phs_64(i),numCode_64(i),allocBw_64(i)] = PtHS(UserRb_64,UserCoordinates,siteDistance);
   Pfach_64(i) = PtFACH(UserRb_64(i), UserCoordinates,siteDistance);
    
   %%%% UEs in secorized cell %%%%%%%%
   % x:[0,1], y : [0, 3^(-0.5)]  not far from BS1
   % MS_sec_near_1km(:,i)= 1000*[rand(1); 1/sqrt(3)*rand(1)]/3;
   % x:[0.75,1], y : [0.5, 3^(-0.5)] far from BS1
   % MS_sec_far_1km(:,i)= 1000*[0.75 + 0.25*rand(1); 1.2+(1.73-1.2)*rand(1)]/3;    
   % decide which distribution of UEs is used 
   % MS_sec_rand_1km(:,i) = 1000*[0.75 + 0.27*rand(1); 1.2+(1.78-1.2)*rand(1)]/3; 
   % UserCoordinates(:,i) = MS_sec_far_1km(:,i);   
   % UserDistances(i) = Distance(UserCoordinates(:,i),[0;0]);
   % Pdch_lin(i) = PtDCH(UserRb, UserCoordinates,siteDistance);
   % [Phs_lin(i),numCode(i),allocBw(i)] = PtHS(UserRb,UserCoordinates,siteDistance );
   % Pfach_lin(i) = PtFACH(UserRb(i), UserCoordinates,siteDistance);
end

x=1:length(Num);
figure(1);
% plot(x,Phs_lin,'k');
plot(x,Pdch_128,'r');
%plot(x,Pdch_256,'r');
hold on;
plot(x,Phs_128);
hold on;
%plot(x,Phs_256);
grid on;
% legend('Pt DCH for 1km site distance ','Pt DCH for 3km site distance');
% hold on;
plot(x,Pfach_128,'c');
%plot(x,Pfach_256,'c');

legend('Pt DCH','Pt HS-DSCH','Pt FACH');
xlabel('Number of Users');
ylabel('Tx Power in Watts');

 % UEs in secorized cell
    % x:[0,1], y : [0, 3^(-0.5)]  not far from BS1
%     MS_sec_near_3km(:,i)= 1000*[rand(1); 1/sqrt(3)*rand(1)];     
%     MS_sec_near_1km(:,i)= 1000*[rand(1); 1/sqrt(3)*rand(1)]/3;
%     % x:[0.75,1], y : [0.5, 3^(-0.5)] far from BS1
%     MS_sec_far_3km(:,i)= 1000*[0.75 + 0.25*rand(1); 1.2 + (1.73-1.2)*rand(1)];     
%     MS_sec_far_1km(:,i)= 1000*[0.75 + 0.25*rand(1); 1.2+(1.73-1.2)*rand(1)]/3;     

    % UEs in omonidirectional anttena's cell
%     th = 10*rand(1);
%     R=1/sqrt(3);    
%     MS_omni_half_1km(:,i) = 0.5*R*[cos(th+pi);sin(th+pi)];  % 50% coverage 
%     MS_omni_far_1km(:,i) = 0.85*R*[cos(th);sin(th)];        % 85% coverage

% decide which distribution of UEs is used 


%%%%% preparation for  MKP fomulation, %%%%%%%%%%%%%%%%%%%% 
% To observe if Pdch, Phs can be relexed to the accumulation of single Power 
% 因为在MKP中，所有item的weight都是固定的，并且constraint（背包体积限制）都为线性函数
% 图形基本可以说明是符合的，但是如何从公式上面推出呢？
Pdch_veri_128(1) = Pdch_single_128(1);
Phs_veri_128(1) = Phs_single_128(1);

Pdch_veri_64(1) = Pdch_single_64(1);
Phs_veri_64(1) = Phs_single_64(1);
    
for i=2:length(Num)
    Pdch_veri_128(i) = Pdch_veri_128(i-1)+Pdch_single_128(i);
    Phs_veri_128(i) = Phs_veri_128(i-1)+Phs_single_128(i);
    
    Pdch_veri_64(i) = Pdch_veri_64(i-1)+Pdch_single_64(i);
    Phs_veri_64(i) = Phs_veri_64(i-1)+Phs_single_64(i);
end 


figure(2);
plot(x,Pdch_128,'r');
grid on;
hold on;
plot(x,Pdch_veri_128,'.-r');
hold on;
plot(x,Phs_128,'g');
hold on;
plot(x,Phs_veri_128,'.-g');
legend('P_{DCH} in real implmentation','P_{DCH} as accumulation of single users',...,
    'P_{HS} in real implmentation','P_{HS} as accumulation of single users');
xlabel('Number of Users');
ylabel('Tx Power in Watts');
title ('128 kbps');


figure(3);
plot(x,Pdch_64,'r');
grid on;
hold on;
plot(x,Pdch_veri_64,'.-r');
hold on;
plot(x,Phs_64,'g');
hold on;
plot(x,Phs_veri_64,'.-g');
legend('P_{DCH} in real implmentation','P_{DCH} as accumulation of single users',...,
    'P_{HS} in real implmentation','P_{HS} as accumulation of single users');
xlabel('Number of Users');
ylabel('Tx Power in Watts');
title ('64 kbps');


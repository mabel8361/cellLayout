%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main file, 
% functionality: Power Calculation 
% Needed file: PtDCH.m, PtFACH.m, PtHS.m
% distance/coordinate unity: meter
% power unity: watt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

% global various: 
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
UserCoordinates_total= Layout(siteDistance,userScenario, UserNum);

% Generate UEs randomly distributed in the central Cell
for i=1: length(Num)    
    UserRb(i)= 256;  % Service bitrate: Kbps              
    UserCoordinates = UserCoordinates_total(1:2,1:i);
    
   
    Pdch_lin(i) = PtDCH(UserRb(1:i),UserCoordinates, siteDistance);       
    [Phs_lin(i),numCode(i),allocBw(i)] = PtHS(UserRb(1:i),UserCoordinates,siteDistance);    
    Pfach_lin(i) = PtFACH(UserRb(i), UserCoordinates, siteDistance);    
    % results of Dual Tx mode and Pure Power Counting 
    Ppc_lin(i) = min([Pfach_lin(i) ,Phs_lin(i),Pdch_lin(i)]);
    [Pdual(i), zone(i)]= PtDual(UserRb(i),UserCoordinates,siteDistance);
end

x=1:length(Num);

 figure(2);
 plot(x,Ppc_lin,'c');
 grid on;
 hold on;
 plot(x,Pdual,'r');
 ylim([0,30]);
 legend('3gpp Power Counting','Dual Tx Mode');
 xlabel('Number of Users');
 ylabel('Power in Watts')
 title({'3GPP power counting & Dual Tx Mode results';...,
        '256 kbps, User Distribution: Middle'});
    
% plot Ptx_dch in Watts vs number of users

figure(1);
plot(x,Pdch_lin,'r');
grid on;
hold on;
plot(x,Phs_lin);
hold on;
plot(x,Pfach_lin,'c');
xlabel('Number of Users');
ylabel('Power in Watts')
legend('DCH Tx Power','HS-DSCH Tx Power','FACH Tx Power');
title({'site distance = 3000 m, Macro cell enviroment with 19 hexagon cells'; ...,
        '256 Kbps, User distribution: Middle'});
    

    
% figure;
% plot(x,Phs_lin,'r');
% grid on;
% xlabel('Number of Users');
% ylabel('HS-DSCH Tx Power in Watts');
% title('figure 2');
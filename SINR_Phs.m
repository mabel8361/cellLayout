% ***************************************************************************
%
%   HSDPA calculate HS-DSCH SINR in function of the power and the distance 
%       Xu Qing     Feb. 2012
%              
%   Calculates the SINR(dB) vs Different Phs-dsch
%   UserDistance = vector of distance of users from Node B 
%   UserEbNoTarget = vector of Eb/No target for users
%   
%   Need files: SINRdB.m; SINRdB_s.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

Pwhs= 3:0.5:7;         % [3,4,5,6,7] watt , length = 14
cellRadius = 1000/3;    % 550 m
userCoverage = linspace(95,5,19);

GdB=[-5.2,-4,-3,-2,-1.5,-0.5,0.5,1,2,2.5 ...,
     3.5,4,5.5,6,8,9,11,12.5,14.5];

G_lin = 10.^(GdB/10);

color = ['b','g','r','c','m','w' ...,
    'b*','g*','r*','c*','m*','y*','k*','w*' ...,
    'b+','g+','r+','c+','m+','y+','k+','w+'];      

userDistance = 200:50:577;   
UserCoordinates = zeros(2,length(userDistance));

for t=1:length(userDistance)
    UserCoordinates(:,t) = userDistance(t)*cellRadius*[sin(pi/4),cos(pi/4)];
end

dBSINR = zeros(length(Pwhs),length(UserCoordinates));

for j= 1:length(Pwhs)
    for i=1:length(UserCoordinates)
       dBSINR(j,i)=SINRdB(Pwhs(j), UserCoordinates(:,i));
    end
end

for j= 1:length(Pwhs)
    for i=1:length(userCoverage)
       dBSINR_s(j,i)=SINRdB_s(Pwhs(j),G_lin(i));
    end
end

figure(1);
for i=1:length(Pwhs)
    % plot(UserCoordinates(1,:)/1000, dBSINR(i,:), color(i)); 
    plot(userDistance/1000, dBSINR(i,:), color(i));     
    grid on;
    hold on;
end
legend ('Phs= 3 watts','Phs= 3.5 watts','Phs= 4 watts','Phs= 4.5 watts','Phs= 5 watts');
title({'For different Transmission Power,' 'the SINR in function of distance' ...,
    'Use calculation of master thesis'});
xlabel('Distance from BS0[km]');
ylabel('SINR [dB]');

figure(2);
for i=1:length(Pwhs)
    % plot(UserCoordinates(1,:)/1000, dBSINR(i,:), color(i)); 
    plot(userCoverage, dBSINR_s(i,:), color(i));     
    grid on;
    hold on;
end
legend ('Phs= 3 watts','Phs= 3.5 watts','Phs= 4 watts','Phs= 4.5 watts','Phs= 5 watts');
title({'For different Transmission Power', 'the SINR in function of distance' ...,
    'Geometry use simple mapping with Coverage'});
xlabel('Coverage in one Cell [%]');
ylabel('SINR [dB]');
return;

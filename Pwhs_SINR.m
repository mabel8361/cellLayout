% ***************************************************************************
%
%  Calculate HS-DSCH Power in function of SINR and coverages 
%       Xu Qing     March. 2012
%              
%   Calculates the Phs-dsch vs SINR(dB)  for different Coverage 
%   UserDistance = vector of distance of users from Node B 
%   UserEbNoTarget = vector of Eb/No target for users
%   
%   Need files: none
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

Coverages = linspace(95,5,19);
GdBs=[-5.2,-4,-3,-2,-1.5,-0.5,0.5,1,2,2.5 ...,
     3.5,4,5.5,6,8,9,11,12.5,14.5];
Glins = 10.^(GdBs/10);

color = ['b','g','r','c','m','k' ...,
    'b*','g*','r*','c*','m*','y*','k*','w*' ...,
    'b+','g+','r+','c+','m+','y+','k+','w+'];  

color1 = ['-b'; 'g+'; 'r.'; 'c-'; 'm-'; 'y-'; ...,
    'b*';'g*';'r*';'c*';'m*';'y*';'k*']; 

SINRs_dB = -3:1:27;
SINRs_lin = 10.^(SINRs_dB/10);
Pown=20;                
othrfactor = 0.5;
atGain= 10^(11.5/10);
for i=1: length(SINRs_dB)
    for j = 1: length(Coverages)        
         Pwhs(i,j)=SINRs_lin(i)*Pown*(othrfactor + 1/Glins(j))/(16*atGain);
         %Pwhs(i,j)=SINRs_lin(i)*Pown*(othrfactor + 1/Glins(j))/(16*atGain);
    end
end

for j = 1: length(Coverages)    
    plot(SINRs_dB,Pwhs(:,j),color1(j));
    %plot(SINRs_dB,Pwhs(:,j));
    grid on;
    hold on;
end
axis([-5,30,0,20]);
xlabel('SINR (dB)');
ylabel('HS-DSCH Tx Power in Watts');
save Pwhs Pwhs

%-5.2,-4,-3,-2,-1.5,-0.5,0.5,1,2,2.5,3.5,4,5.5,6,8,9,11,12.5,14.5
legend('-5.2 ','-4','-3','-2','-1.5','-0.5','0.5','1','2','2.5','3.5','4','5.5','6','8','9','11','12.5','14.5');
title('Phs, each line for different coverages factor(dB)');
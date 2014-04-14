%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate the SINR [dB] in the function of CQI 
%
% with fixed BLER [1%,5%,10%]
% Reference: R. Litjens
%	"HSDPA flow level performance and the impact of terminal mobility" 
%    Proc. of the wireless communications and networking 2005
% in which: 
%  BLER = {10^(2*(SINR - 1.03*CQI+5.26)/(sqrt(3)-log10(CQI)))+1}^(-1/0.7)
%
% Conlusion:
%    Different from the results in master thesis; 
%    Neither the work in "A group based point-to-multipoint MBMS algorithm
%   over the HSDPA network" simulation of target SINR vs CQI by CML;
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;

%BLER=[0.01,0.05,0.1];
BLER = 0.01;
CQI= 1:1:30
color = ['b','g','r','c','m','w' ...,
    'b*','g*','r*','c*','m*','y*','k*','w*' ...,
    'b+','g+','r+','c+','m+','y+','k+','w+'];      

for j=1:length(BLER)
    for i=1:length(CQI)
    %ind = 2*(sinr-1.03*CQI(i)+5.26)/(sqrt(3)-log10(CQI(i)))
    %BLER = (10^ind+1)^(-1/0.7);
        %SINR(i,j)= 0.5*(sqrt(3)-log10(CQI(i)))*(log10(BLER(j)^0.7-1))+1.03* CQI(i)-5.26;
        SINR(i,j) = 0.5*(sqrt(3)-log10(CQI(i)))*(log10(BLER(j)^(-10/7)-1))+1.03* CQI(i)-5.26;
    end
end


for j=1:length(BLER)
   plot(CQI, SINR(:,j),color(j),'r+'); 
   grid on;
   hold on;
end

title({'For different BLER','the SINR in function of CQI'});
legend('BLER = 1%','BLER = 5%','BLER = 10%')
xlabel('CQI');
ylabel('SINR [dB]');

return;
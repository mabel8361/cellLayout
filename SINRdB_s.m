% calculate the SINR [dB]
% simplified version 
% use geometry factor in stead of Powen, Pnoise etc..
% input: geometry factor (dB), Phs 
function dBSINR = SINRdB(Pwhs,G_lin)
num = 0;
den = 0;

LpU = PathLoss(Distance(UserCoordinate, [0;0])); % the path loss from Cell0     % added 

atGain= 10^(11.5/10);
num= Pwhs*atGain;
%Pn = 10^(-100/10);  % thermal noise
Pown = 20;   %
%den = Pn + xi + p*Pown; 
den = Pown*(0.5+1/G_lin);
SINR=16*(num/den);
dBSINR = 10*log10(SINR);
return;
% calculate the SINR [dB]
% UserCoordinate is the position of one UE
function dBSINR = SINRdB(Pwhs,UserCoordinate)
num = 0;
den = 0;
LpU = PathLoss(Distance(UserCoordinate, [0;0])); % the path loss from Cell0

attenGain= 10^(11.5/10);
num= (Pwhs*attenGain)/LpU;

xi=xiCalc(UserCoordinate);

Pn = 10^(-100/10);  % thermal noise

p = 0.5;
Pown = 20;   %
den = Pn + xi + p*Pown/LpU; 
SINR=16*(num/den);
dBSINR = 10*log10(SINR);

return;
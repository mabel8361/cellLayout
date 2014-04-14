function L = PathLoss(userDistance_i);
% Calculate the pathloss from Okumura Hata's model,
% use BS height of 15m,
% frequency of 2GHz, 
% input: distance in meter, 
% while the distance in fomulation has to be in km

SF=10;
if userDistance_i >= 0
    LdB = SF +128.1 + 37.6*log10(userDistance_i/1000);
%     LdB = SF +128 + 37.6*log10(userDistance_i);
else LdB = SF;
end
L=10^(LdB/10);
return;
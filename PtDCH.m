%   ***************************************************************************
%
%   UMTS-DCH Power calcuation function
%       Xu Qing     Feb. 2012
%              
%   Calculates the BS Tx power to cover N users using DCH
%   input: UserRbs = array of service bit rate for users
%          Coordinations of UEs
%          site distance in km([1,3])
%          
%   output: User Coordinates in meters
%   Needed files: PathLoss.m,xiCalc.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Pdch_lin= PtDCH(UserRbs, UserCoordinates,siteDistance)

if (size(UserCoordinates,2)==0 || isempty(UserRbs)) 
    Pdch_lin =0;
    return
end

    
if siteDistance==1
%     cellRadius = 1000/sqrt(3);
     cellRadius = 333.3;
elseif siteDistance==3
    cellRadius =1000;
else 
    error('siteDistance is out of range: [1,3], PtDCH()');
end 
    
% Control
for k=1:length(UserCoordinates(1,:))
    if (Distance(UserCoordinates(:,k),[0;0]))>(2*cellRadius)
     error('user distance out of range (0, 667/2000m], dPtDCH()');
    end
end

if (length(UserRbs) ~= length(UserCoordinates(1,:)))
    error('Number of User Service Bitrate different to number of User Distance, PtDCH()');
end

% Parameters setting
% Pp = 1;       % Pp - power to common control channel 1W = 30 dBm
W=5e6;  % W - bandwidth 5MHz
p=0.5;       % p - orthogonality factor 0.5
Pn=-105;     % Pn - termal noise -105 dBm
%Pneigh=5;   % Pneigh - neighber cell Transmission power  5W = 37dBm
UserEbNoTarget=3;    % UserEbNoTarget - default set to 3dB
                                     % the higher Eb/No , the higher Pdch                  
% Iinter=-70       % inter-cell interference in dBm 
% distlossexp=3.52 % See Holma e.a. WCDMA for UMTS, section 8.2, p 160

Den =0;
Numerator=0;
Dch_bws = [32, 64, 128, 256];
EbNos = [2.5, 3, 3.5, 4];

for i = 1: length(UserRbs)      
    bw_ind = find(Dch_bws >= UserRbs(i));    
    if (~isempty(bw_ind))
        % dch_bw=Dch_bws(bw_ind(1));                  % find corresponding channel bandwidth  for service bitrate 
        UserEbNoTarget = EbNos(bw_ind(1));    % find target Eb/No 
    end                             
    N1 = 10^(-13.5) + xiCalc(UserCoordinates(:,i), siteDistance);    
    Lp = PathLoss(Distance(UserCoordinates(:,i),[0;0]));
    D1 = W/(10^(UserEbNoTarget/10)*1000*UserRbs(i)+p);     % User Rb is in Kbps    
    Numerator = Numerator + N1*Lp/D1;
    Den = Den + p/D1;
end 
Pdch_lin = Numerator/(1-Den);
if Pdch_lin <= 0
    Pdch_lin = 35;
end


return;

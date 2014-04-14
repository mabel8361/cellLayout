%   **********************************************************************
%   FACH Power calcuation 
%       Xu Qing     May. 2012
%              
%   Calculates the BS Tx power to cover users requesting one same flow 
%    UserRb is the bandwith of the requested bandwidth 
%    by using FACH 
%   
%   input: target bit rate ( e.g.: 64 or 128 Kbps)
%		   array of UEs' coordinates (e.g.[x1,x2;y1,y2] meters)     
%   output: Pfach in Watts
%   Needed files: Non
%
%   This new version is simulated by OPNET, 
% 	therefore Pfach only realted with service bandwidth and UE distance
% 	doesn't find Pfach through coverage 
%  ************************************************************

function [Pfach_lin]= PtFACH(userRb,UserCoordinates,siteDistance)
% cellRadius = 1000/sqrt(3);
if (size(UserCoordinates,2)==0) 
    Pfach_lin =0;
    return
end
    
Coverages = linspace(1,20,20);
UserDistances = zeros(1, length(UserCoordinates(1,:)));

% FACH power power in liner for different bandwidth: 
% and for different distance of UE from Node B:(0~2000]
% p[1] -> 0~100m, p[2] - 100~ 200 m, ... p[19] -> 1800~1900 m
% p[20] -> 1900~2000m

P_32 = [1.00, 1.02, 1.03, 1.04, 1.05,  1.06,   1.07 ...,   
	1.08, 1.1130,1.15, 1.238,1.34,1.45,   1.60, 1.788 ...,
	2.03, 2.29, 2.63, 3,3.47];

P_64 = [1.6, 1.65, 1.67, 1.69, 1.71, 1.74 ...,
    1.8, 1.87, 1.95, 2.22, 2.4540, 2.7800, 3.19, 3.72, 4.3870 ...,
    5.22, 6.12, 7.23, 8.58, 10.182];

P1_64 = [1.3, 1.42, 1.45, 1.6, 1.71, 1.7400 ...,
    1.8, 1.87, 1.95, 2.22, 2.4540, 2.7800, 3.19, 3.72, 4.3870 ...,
    5.22, 6.12, 7.23, 8.58, 10.182];    %Pfach  changed

P_128 = [1.64, 1.66, 1.68,1.71, 1.75, 1.8, 1.94, 2.11, 2.42,2.89, 3.311 ...,
	4.01, 4.9, 5.98, 7.39, 9.073, 11.092, 13.77, 16.683, 20.1];

P_256 = [1.65, 1.7100, 1.7300, 1.7700, 1.85, 2.17 ...,
	2.56, 3.0700, 3.9300, 5.0000, 7.23, 9.5232,12.4666,16.1736,20.5 ...,
	25,26,27,28,35.4];

for i=1:length(UserCoordinates(1,:))
    UserDistances(i) = Distance(UserCoordinates(:,i), [0;0]);
end
maxDis = max(UserDistances);
save fachmaxDis  maxDis

% control 
if siteDistance == 1
	if ((maxDis<0) || ( maxDis>667))
		error('the distance of UserCooridnates from Node B 0 is out of range (0,667]m, PtFACH():sitedistance = 1km');  
	end
elseif siteDistance ==3
	%if ((maxDis<0) || ( maxDis>2000))	
        if (maxDis>2000)
		%save err_maxDis maxDis
		error('the distance of UserCooridnates from Node B 0 is out of range (0,2000]m, PtFACH():sitedistance = 3km');  
	end
else
	error('input siteDistance is out of range: [1,3], PtFACH()');    
end
	
Fach_bws = [32, 64, 128, 256];
ind = find( Fach_bws >= userRb);
if (~isempty(ind))
    fachBw=Fach_bws(ind(1));         % for target bit rate, find corresponding minmum channel bandwidth  
end

switch fachBw
    case 32        
        Ps = P_32;
    case 64        
        Ps = P_64;
    case 128	   
        Ps = P_128;
    case 256      
        Ps = P_256;
    otherwise
        error('the input target FACH bandwith is out of range [0,256] Kbps, PtFACH()');        
end

%ind = floor(maxDis/100);
ind = ceil(maxDis/100);
Pfach_lin = Ps(ind);
return;

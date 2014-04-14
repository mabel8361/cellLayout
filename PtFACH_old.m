%   **********************************************************************
%   FACH Power calcuation 
%       Xu Qing     March. 2012
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
%  [1] chapter9-Radio Resource Management for E-MBMS Transmission towards
%  LTE, A.A. 2009, cell radius = 577 m, site distance = 1000m, Fig.9.6
%  [2] S-CCPCH performance, 3GPP, (4.3.1.5 Pedestrian B (3km/hr) Fig. 4.3.4
%  site distance = 2.8 km
%   %Tx=10^(Ec_Ior)/10); therefore, Ptfach_lin = 20*%Tx = 20* 10^(Ec_Ior/10)
%  [3] Multi-resolution MBMS.., fig 6 �C S-CCPCH average coverage vs Tx. Power for 1 RL
%    site distance = 1000 m 
%  ************************************************************

function [Pfach_lin]= PtFACH(userRb,UserCoordinates,siteDistance)

Coverages = linspace(5,100,20);
UserDistances = zeros(1, length(UserCoordinates(1,:)));

if siteDistance == 1
    cellRadius = 1000/3;%     cellRadius = 1000/sqrt(3);
    % simulation results through OPNET , actually for site distance =3km     
     P_32_lin = [0.61, 0.6325,0.6623,0.71,0.73,0.74,0.75,0.767 ...,
         0.789,0.843,0.879,0.9271,1.006,1.015,1.0238 ...,     
         1.06,1.12,1.13,1.14, 1.15];
    P_64_lin = [1.55,1.6,1.62,1.65 ,1.67 ,1.68, 1.69, 1.7, 1.73,  ...,
        1.74, 1.76, 1.80, 1.84, 1.87, 1.91, 1.95, 2.05, 2.22, 2];
    P_128_lin =[1.6, 1.64, 1.65, 1.66, 1.67, 1.68, 1.69, 1.71, 1.73, 1.75, 1.78,  ...,
                1.8, 1.88, 1.94, 2.06,2.11,2.34, 2.42, 2.65, 2.89];
    P_256_lin = [1.64,1.65 ,1.68 ,1.71, 1.72, 1.73 ,1.75 ,1.77 ...,
        1.83 ,1.85 ,2.03,2.17,2.33 ,2.56,2.77,3.07,3.46,3.93,4.52,5.02];
elseif siteDistance == 3
%     cellRadius =3000/sqrt(3);
    cellRadius =1000;    
    % FACH power (in Watts) for different bandwidth: 32,64, 128 Kbps [1]
    % and for different distance of UE from Node B:(0, 2000]
    P_32_lin = [ 0.95, 0.98, 1, 1.05, 1.1, 1.2, 1.4, 1.5, 1.7 ...,
        1.8,1.95,2.15, 2.4, 2.5, 2.6, 2.8, 3.15, 3.9, 4,5.3];
    P_64_lin = [1.4,1.5,1.6,1.8,1.85 ,1.95 ,2,2.3 ,2.5 ,2.8 ...,
        3,3.1 ,3.6,4.2,4.8 ,5.5,6.4 ,7.6 ,10.0,11];
    P_128_lin = [2.6,2.8,3,3.3,3.6,3.85,4.2,4.6,5 ...,
        5.6,6.2 ,7,7.8 ,9,9.8,11,13,16,17,19];
    P_256_lin = [6,6.4 ,6.6 ,7.2 ,8,8.8 ,9.6 ,10.6 ...,
        11.6 ,12.8 ,14,15.2 ,17.4 ,19,20,20,20,20,20,20];    
   

% find maxi coverage as target coverage 
for i=1:length(UserCoordinates(1,:))
    UserDistances(i) = Distance(UserCoordinates(:,i), [0;0]);
end

maxDis = max(UserDistances);
if siteDistance == 1
	if ((maxCov<0) || (maxCov >667))
		error('the distance of UserCooridnates from Node B 0 is out of range (0,667]m, PtFACH():sitedistance = 1km');  
	end
elseif siteDistance ==3
		if ((maxCov<0) || (maxCov >2000))	
		error('the distance of UserCooridnates from Node B 0 is out of range (0,2000]m, PtFACH():sitedistance = 3km');  
		end
else
	error('input siteDistance is out of range: [1,3], PtFACH()');    
end
	
maxCov = 100*maxDis/(2*cellRadius);   

if ((maxCov<0) || (maxCov >100))
    disp('the distance of UserCooridnates from Node B 0 is out of range, PtFACH()');
    save err_maxCov maxCov
    return;
end

Fach_bws = [32, 64, 128, 256];
ind = find( Fach_bws >= userRb);
if (~isempty(ind))
    fachBw=Fach_bws(ind(1));          % for target bit rate, find corresponding minmum channel bandwidth  
end

switch fachBw
    case 32
        Ps_lin = P_32_lin;
    case 64
        Ps_lin = P_64_lin;
    case 128
        Ps_lin = P_128_lin;
    case 256
        Ps_lin = P_256_lin;
    otherwise 
        disp('the input target FACH bandwith is out of range [0,256] Kbps, PtFACH()');        
end

ind = find( Coverages >= maxCov);
if (~isempty(ind))
    Pfach_lin = Ps_lin(ind(1));
else 
    Pfach_lin = 1;
end

return;

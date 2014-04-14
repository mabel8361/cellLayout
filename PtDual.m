%   ***************************************************************************
%  MBMS Dual Transmission Mode Power calcuation function
%       Xu Qing     April. 2012
%  
%   Calculate and determin the channel's power consumption based on Dual Tx mode
%   The 100% coverage of FACH reach the farest distance of one Cell, 
%    i.e.   2 x CellRadius   
%   Ref: <2011-Journal ComNet-Enhanced radio resource management algorithms
%          for efficient MBMS service provision in UTRAN_mix..C.C>
% 
%  Zone Idea:
%  one cell is divided into 10 zones,
%  zones = {0,1,2,....10},z0 has 0% coverage, z1 has 10% coverage , z2 has 20% etc...
%  Pi:  Zone_i by FACH + rest by DCHs (i = 0... 10)
%  P1: 10%  FACH, all rest by DCH
%  P10: All FACH, No DCH, 
%  P11: No FACH, All DCH
% 
%   input: UserRb = Flow bit rate
%          User coordinates - all termianls for one flow
%          site distance in km([1,3])
%          
%   output: Total Power in Watts, zone - the coverage of FACH (0,1]
%   Needed files: PtFACH.m, PtDCH.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Pdual, zone]= PtDual(userRb,UserCoordinates,siteDistance)

if siteDistance==1
     cellRadius = 333;    %     cellRadius = 1000/sqrt(3);
elseif siteDistance==3
    cellRadius =1000;
else 
    error('siteDistance is out of range: [1,3], PtDCH()');
end 

numUserTot = size(UserCoordinates,2);
%UserCoorDis = zeros(3, length(UserCoordinates(1,:)));
UserCoorDis = zeros(3, numUserTot);
% zrecord = zeros(10, size(UserCoordinates,2));    % to record the appearence of UE in one zone 
zrecord = zeros(10, numUserTot);    % to record the appearence of UE in one zone 

% for k=1:length(UserCoordinates(1,:))
% for k=1:size(UserCoordinates,2)    
for k=1:numUserTot    
    distemp = Distance(UserCoordinates(:,k),[0;0]);
    
    if (distemp)>2*cellRadius
     error('user distance out of range (0, 667/2000m], PtDual()');
    end
    
    UserCoorDis(:,k) = [distemp, UserCoordinates(1,k),UserCoordinates(2,k)];    
        
    % Classify the UE coordinates into 10 groups, 
    % z1,z2, z...z10, zi & zj (i!=j) don't have overlapping 
    indtemp= ceil(10*distemp/(2*cellRadius));
    zrecord(indtemp, k) = 1;    
end

% if zrecord is a vector, i.e. total UE number is 1;
% then znum_cum = zrecord';
if numUserTot==1
    znum_cum = zrecord';
else 
% znum(i) is the accumulation of number of users in zone(i)
    znum = sum(zrecord'); 
% znum_cum(i) is the total number of users from zone(1) to zone(i) 
    znum_cum = cumsum (znum); 
end

% sort UE's coordinates according to distance , in ascending orde
 TempAcc = sortrows(UserCoorDis');
 UserCoorDisAcc = TempAcc';  
 
pzones = zeros(1,11);
pdchs = pzones;
pfachs = pzones;

for i=1:9       
    num_dch = size(UserCoordinates,2)-znum_cum(i);
    userRbs= userRb*ones(1,num_dch);
    pdchs(i) =  PtDCH(userRbs, UserCoorDisAcc(2:3,(znum_cum(i)+1):end), siteDistance);
    pfachs(i) = PtFACH(userRb,UserCoorDisAcc(2:3, 1:znum_cum(i)),siteDistance);
    pzones(i) = pdchs(i) + pfachs(i);
end

pzones(10)=  PtFACH(userRb,UserCoordinates, siteDistance);  % all FACH
userRbs = userRb*ones(1,size(UserCoordinates,2));
pzones(11) = PtDCH(userRbs, UserCoordinates,siteDistance); % all DCH

Pdual =  min(pzones);
if Pdual == pzones(10) % pure FACH
    zone = 1;
    return
end

inds= find(pzones<=Pdual);
fach_users = zeros(1,length(inds));

if (length(inds) >1)
    % find the zone index that has most FACH users 
    for t=1:length(inds)
        if inds(t)==11
            zone = 0;  % since pure DCH is the min power case, therefore, noUser is using FACH 
            return
        else         
            fach_users(t) = znum_cum(inds(t));
        end        
    end
    zone = max(fach_users);    
end
zone=0.4;
return;
%   ***************************************************************************
%
%   HSDPA (HS-DSCH) Power calcuation function
%       Xu Qing     Feb. 2012
%              
%   Calculates the BS Tx power to cover users requesting total bandwidth of TargetBW
%   by using HS-DSCH 
%   
%   input: array of target bit rate ( e.g.:[64,128,] Kbps)
%		   array of UEs' coordinates (e.g.[x1,x2;y1,y2] meters)     
%          site to site distance (e.g. 3000 meters)
%   output: Phs-dsch in Watts
%           the number of HS-PDSCH SF16 codes 
%           allocated bandwidth (average throughput) for HS-DSCH 
%
%   Needed files: PathLoss.m,xiCalc.m
%
%
% Comment for BR_n: represent the achivealbe total bit rate (Kbps) for corresponding CQI value 
% [1] 3GPP 25.214-7h0 , CQI mapping tables in 6A.2.3
% [2] online:��agilent HSDPA PS Data Setup 
%   "MAC-hs and IP Bit Rates (kbps) versus CQI Value and UE Category" 
%   IP packet bit rate (kbps), when PDU size set to 336 bits
% [3] SINR-Based Transport Channel Selection for MBMS Applications,VTC 2009
%
% e.g. for UE category 7 & 8, IP packet bit rate (kbps) [3]��
% 
% BR_7=[480,480,480,480,480,480 ,960,960,960, 1440,1440,1440 ...,
%	1920, 1920, 2400, 4800,4800,4800,4800,4800,4800,4800 ...,
%	6720,7680,9600,11520,14400,14400,14400,14400];	
% 
% Comment for GdB and Gdb_lin,from [4], 
% similar results can also obtain from Fig 4.5.1[5]
% [4] 2004-IEEE Conf. 3G Mobile Communication Technologies-Covereage and
% Planning aspects of MBMS in UTRAN
% [5] 3GPP S-CCPCH Performance 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Phs_lin,numCode,allocBw]= PtHS(UserRbs,UserCoordinates,siteDistance)

if (length(UserRbs) ~= length(UserCoordinates(1,:)))
    error('Number of User Service Bitrate different to number of User Distance; PtHS()');
end

if siteDistance == 1
    cellRadius = 333.3;
elseif siteDistance == 3
    cellRadius =1000;
else 
    error('input siteDistance is out of range: [1,3], Phs()');    
end 
    
BR_7=[0,0,0,0,160,160,160, 320,320,480, 640, 800, 960 ...,
	1120,1440,1600,1920,2080,2400,2720 ...,
	3040,3360,4480,5280,6720,6720,6720,6720,6720,6720];             % for UE category 7 & 8 [2]

BR_10 = [0,0,0,0,160,    160,160,320,320,480,  640,800,960,1120,1440 ...,
        1600, 1920, 2080, 2400, 2720,   3040, 3360, 4480, 5280, 6720, ...,
        8160, 10240, 11040, 11520, 12160];              % for UE category 10, IP packet bit rate (kbps);[2]

BR_7_ref3=[480,480,480,480,480,480 ,960,960,960, 1440,1440,1440 ...,
	1920, 1920, 2400, 4800,4800,4800,4800,4800,4800,4800 ...,
	6720,7680,9600,11520,14400,14400,14400,14400];	

% choose the UE category 10  
BR = BR_10;     
%BR = BR_7_ref3;

% calculate requested total bandwidth 
targetBw = 0;
for i = 1:length(UserRbs)
    targetBw = targetBw + UserRbs(i);
end

tarCQI = 0;
if (targetBw> max(BR))  % BR(30)
    tarCQI=30;
elseif (targetBw<min(BR))
    tarCQI=5;
else tarCQI=0;          % to be fined in following procedure  
end

ind = find(BR>=targetBw);
if (length(ind)>0)
    tarCQI=ind(1);          % for target bit rate, find corresponding minmum CQI,
end
       
% find corresponding SINR(dB) from CQI, 
% tarSINR=tarCQI-3.5;         % method 1, simple estimation 
           
% method 2, estimation fomular from 
%	"HSDPA flow level performance and the impact of terminal mobility" 
%    Proc. of the wireless communications and networking 2005
%  BLER = {10^(2*(SINR - 1.03*CQI+5.26)/(sqrt(3)-log10(CQI)))+1}^(-1/0.7)
bler = 0.01;
%tarSINR= 0.5*(sqrt(3)-log10(tarCQI))*(log10(bler^0.7-1))+1.03* tarCQI-5.26;
tarSINR= 0.5*(sqrt(3)-log10(tarCQI))*(log10(bler^(-10/7)-1))+1.03* tarCQI-5.26;
% tarSINR = tarCQI+3.5;
% the number of codes corresponding CQI
NumCodes_7 = [1,1,1,1,1,1,2,2,2, 3,3,3 ...,
              4,4,5,5,5,5,5,5,5,5,7,8,10,10,10,10,10,10];        

NumCodes_10 = [1,1,1,1,1,  1,2,2,2,3,  3,3 ...,
              4,4,5,5,5,5,5,5,5,5,7,8,10,12,15,15,15,15];        

% choose the UE category 10 as example;
NumCodes = NumCodes_10;
numCode = NumCodes(tarCQI);        
allocBw = BR(tarCQI);

% simple version: only need to find coverage, then map to Geometry Factor
Coverages = linspace(100,5,20);
GdBs=[-10,-5.2,-4,-3,-2,-1.5,-0.5,0.5,1,2,2.5 ...,
     3.5,4,5.5,6,8,9,11,12.5,14.5];
Glins = 10.^(GdBs/10);

% find geometry factor corresponding User Coordinate 
for i=1:length(UserCoordinates(1,:))
    dis(i)=Distance(UserCoordinates(:,i), [0;0]);
end

maxDis = max(dis);
minDis = min(dis);              % the geometry is the largest disantance 

%if (maxDis > 2*cellRadius)
if (maxDis>2*cellRadius)  
    error ('maximum distance of users is out of Range > 2*Raius= 666.7 meters');    
end

% target_coverage = 100*minDis/(2*cellRadius);     % [0,100] %
target_coverage = 100*maxDis/(2*cellRadius);     % [0,100] %

ind = find(Coverages>=target_coverage);
if (length(ind)>0)
    % g_index=ind(1);          % for target bit rate, find corresponding minmum CQI,
    g_index=ind(end);          % for target bit rate, find corresponding minmum CQI,
end

% g_dB = GdBs(g_index)
g_lin = Glins(g_index);

save testGlin_Phs g_lin;

% calculate Phs (Watts) with found target SINR 
Pown = 20;                              % 20 Watts
othfactor=0.5;
tarSINR_lin = 10^(tarSINR/10);
atGain= 10^(11.5/10);

Phs_lin = tarSINR_lin*Pown*(othfactor+1/g_lin)/(16*atGain);

return;

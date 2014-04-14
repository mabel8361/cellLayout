%  Cell1NPSW : 
%   this file generate the plot of 19 Celluers, 19 Node Bs
%   each 3-sector site located in the edge of each single cell 
%
%   data from npsw original setting files:
%           "MSparam_2tier.txt"   and "BSparam_2tier.txt"
%
%   
%   Parameters in this file: site distance = 3000 m, cell radius = 1 km
%   Xu qing  20 Feb. 2012 
%
%  needed m-files: noneclear all;
clear all;
close all;


BScoordinate = [0,0,0,-3000,-3000,-3000,-1500,-1500,-1500,1500,1500,1500,3000,3000 ...,
    3000,1500,1500,1500,-1500,-1500,-1500;
    0,0,0,0,0,0,2598,2598,2598,2598,2598,2598,0,0,0,-2598,-2598,-2598,-2598,-2598,-2598];


% cell's coverage
t=linspace(0,2*pi,7);
cx0=1000*cos(t);
cy0=1000*sin(t);

cx1=cx0+500;
cy1=cy0+1000*sqrt(3)/2;

plot(cx1,cy1);
hold on;
grid on;

MScoordinate = [755.4125,953.278,882.513,806.928,883.92,766.74,945.93 ...,
    906.484,760.46,838.6,844,842.9,841.8,840.7,839.6,838.5,837.4,836.3,835.2,834.1;
    1684.4,1403.9,1346.3,1628,1246.3,1699.8,1484.2,1273.3,1256.9,1418.5 ...,
    1318.7,1295.8, 1273, 1250.2, 1227.4,1204.6,1181.8,1158.9,1136.1,1113.3];

for i=1:length(BScoordinate(1,:))
    plot(BScoordinate(1,i),BScoordinate(2,i),'ro');   
    
end

for k=1:length(MScoordinate)
    plot(MScoordinate(1,k),MScoordinate(2,k),'*');
    grid on;
    hold on;
end




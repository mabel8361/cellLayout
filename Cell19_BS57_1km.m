%  Cell19_1km : 
%   this file generate the plot of 19 Celluers, 19*3 Node Bs
%   each 3-sector site located in the centre/middle of cell coverage
%
%   simplified version as 
%       figure l_one 3 sector cell site the middle of one cell
%       coverage_simplified version
%
%  site to site distance: 1000 m 
%  Radius  577.35 m
%
%  Xu qing  20 Feb. 2012 
%
%  needed m-files: none

clear all;
close all;

% BSs's positons & MS's range
t=linspace(pi/6,11*pi/6,2*pi);
plot(0,0,'ro');             text(0.1,0.1,'O');
grid on;
hold on;

bsx1=cos(t);
bsy1=sin(t);

bsx2=sqrt(3)*cos(t-pi/6);
bsy2=sqrt(3)*sin(t-pi/6);

% BS's locations
plot(bsx1,bsy1,'ro');
plot(2*bsx1,2*bsy1,'mO');
plot(bsx2,bsy2,'ko');

% Cell's range
% initial cell, central from the original point
k=linspace(0,2*pi,7);
cx0=(sqrt(3)/3)*cos(k);     %[-0.5774, 0.5774]
cy0=(sqrt(3)/3)*sin(k);     %[]

% cell 1, middle
cx1=sqrt(3)/3+cx0;
cy1=cy0;
plot(cx1, cy1,'c');             text(sqrt(3)/3, 0, 'Cell 1');
plot(cx1, 1+cy1);               text(sqrt(3)/3, 1, 'Cell 7');
plot(cx1, -1+cy1);              text(sqrt(3)/3, -1, 'Cell 4');
plot(cx1, 2+cy1);               text(sqrt(3)/3, 2, 'Cell 19');
plot(cx1, -2+cy1);              text(sqrt(3)/3, -2, 'Cell 13');

plot(sqrt(3)+cx1, cy1);         text(4*sqrt(3)/3, 0, 'Cell 16');
plot(sqrt(3)+cx1, 1+cy1);       text(4*sqrt(3)/3, 1, 'Cell 17');
plot(sqrt(3)+cx1, -1+cy1);      text(4*sqrt(3)/3, -1, 'Cell 15');

plot(-sqrt(3)+cx1, cy1);        text(-2*sqrt(3)/3, 0, 'Cell 10');
plot(-sqrt(3)+cx1, 1+cy1);      text(-2*sqrt(3)/3, 1, 'Cell 9');
plot(-sqrt(3)+cx1, -1+cy1);     text(-2*sqrt(3)/3, -1, 'Cell 11');

% cell 2, left high 
cx2=-sqrt(3)/6+cx0;
cy2=0.5+cy0;
plot(cx2, cy2);                 text(-sqrt(3)/6, 0.5, 'Cell 2');
plot(cx2, 1+cy2);               text(-sqrt(3)/6, 1.5, 'Cell 8');
plot(sqrt(3)+cx2, cy2);         text(5*sqrt(3)/6, 0.5, 'Cell 6');
plot(sqrt(3)+cx2, 1+cy2);       text(5*sqrt(3)/6, 1.5, 'Cell 18');
%plot(-sqrt(3)+cx1, cy1);  

% cell 3, left low
cx3=-sqrt(3)/6+cx0; 
cy3=-0.5+cy0;
plot(cx3, cy3);                 text(-sqrt(3)/6, -0.5, 'Cell 3');
plot(cx3, -1+cy3);              text(-sqrt(3)/6, -1.5, 'Cell 12');
plot(sqrt(3)+cx3, cy3);         text(5*sqrt(3)/6, -0.5, 'Cell 5');
plot(sqrt(3)+cx3, -1+cy3);      text(5*sqrt(3)/6, -1.5, 'Cell 14');
%plot(-sqrt(3)+cx2, cy2);  

% Generate UEs randomly distributed in the central Cell
for i=1:70    
    xa= 1/3+0.53*rand(1,1);
    ya=-0.5+rand(1,1);
    msx1(i)=xa;
    msy1(i)=ya;
    xb=-1+2*rand(1,1);
    yb=-0.65+1.3*rand(1,1);    
	figure(1)
    plot(msx1(i),msy1(i),'k.');
    hold on
    % plot(xrb(i),yrb(i),'k.');
end


% Results: BS's locations in m
%bsx1 =		866.0254    0	 	-866.0254 	-866.0254   0		  866.0254
%bsy1 =		500.0    1000.0    	500.0   	  -500.0   -1000.0   -500.0

%bsx2 =     1732.051   866.025  	-866.025 	-1732.051  	-866.025   866.025
%bsy2 =      0  		1500.0  	1500.0    	0 			-1500.0 	-1500.0

%2*bsx1 =     1732.1    0   	  -1732.1   -1732.1   0    		1732.1
%2*bsy1 =     1000.0    2000.0    1000.0   -1000.0   -2000.0   -1000.0




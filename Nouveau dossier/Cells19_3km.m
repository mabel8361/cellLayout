% Generating Hexagonal Cell Site with random users 
% Test to illustrate the correct of cells and sectors
% the Cell sites(BS station) 
% should actually locate in the corner of cell's edge
% http://www.privateline.com/mt_cellbasics/iii_cell_sector_terminology/
% http://www.igoy.in/generating-hexagonal-cell-site-with-random-users-in-matlab/
% clc;

clear all;
close all;

% 19 Celluers and locations of Node B
% site to site distance = 2800 m , Radius = 1616,581  m 
clear all;
close all;

% BSs's positons & MB's range
t=linspace(pi/6,11*pi/6,2*pi);
plot(0,0,'ro');             text(0.1,0.1,'O');
grid on;
hold on;

bsx1=2.8*cos(t);
bsy1=2.8*sin(t);

bsx2=4.85*cos(t-pi/6);   % 3*1.617
bsy2=4.85*sin(t-pi/6);

% BS's locations
plot(bsx1,bsy1,'ro');
plot(2*bsx1,2*bsy1,'mo');
plot(bsx2,bsy2,'ko');

% Cell's range, centre (0,0) , radius 1.6 = 2.8/sqrt(3)
% initial cell, central from the original point
k=linspace(0,2*pi,7);
cx0=1.617*cos(k);     
cy0=1.617*sin(k);     

% cell 1, middle
cx1=2.8/sqrt(3)+cx0;
cy1=cy0;
plot(cx1, cy1,'c');             text(2.8/sqrt(3), 0, 'Cell 1');
plot(cx1, 2.8+cy1);             text(2.8/sqrt(3), 2.8,'Cell 7');
plot(cx1, -2.8+cy1);              text(2.8/sqrt(3), -2.8, 'Cell 4');
plot(cx1, 5.6+cy1);               text(2.8/sqrt(3), 5.6, 'Cell 19');
plot(cx1, -5.6+cy1);              text(2.8/sqrt(3), -5.6, 'Cell 13');

plot(4.851+cx1, cy1);         text(6.468, 0, 'Cell 16');
plot(4.851+cx1, 2.8+cy1);      text(6.468, 2.8, 'Cell 17');
plot(4.851+cx1, -2.8+cy1);     text(6.468, -2.8, 'Cell 15');

plot(-4.851+cx1, cy1);           text(-6.468, 0, 'Cell 10');
plot(-4.851+cx1, 2.8+cy1);      text(-6.468, 2.8, 'Cell 9');
plot(-4.851+cx1, -2.8+cy1);    text(-6.468, -2.8, 'Cell 11');

% cell 2, left high 
cx2=-0.8085+cx0;            
cy2=1.4+cy0;
plot(cx2, cy2);                text(-0.8085, 1.4, 'Cell 2');
plot(cx2, 2.8+cy2);            		text(-sqrt(3)/6, 4.2, 'Cell 8');
plot(4.851+cx2, cy2);         text(5*sqrt(3)/6, 4.2, 'Cell 6');
plot(4.851+cx2, 2.8+cy2);     text(1.617, 4.2, 'Cell 18');

% cell 3, left low
cx3=-0.8085+cx0; 
cy3=-1.4+cy0;
plot(cx3, cy3);                 text(-0.8085, -1.4, 'Cell 3');
plot(cx3, -2.8+cy3);              text(-0.8085, -4.2, 'Cell 12');
plot(4.851+cx3, cy3);         text(3,773, -1.4, 'Cell 5');
plot(4.851+cx3, -2.8+cy3);      text(3,773, -4.2, 'Cell 14');


    

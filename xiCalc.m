function xi=xiCalc(UserCoordinate,siteDistance)
% calcuate the intercell interference observed by ith user using the
% transmitted power by the neighbouring cells NeighCellPw and
% the path loss from this user to jth cell
% @ 18 neighboring cells model
% input unit @ meter

% CellsCoordinate_1km = [-1.866025404, -1.866025404, -1.866025404, ...,
%  -0.866025404, - 0.866025404, -0.866025404, -0.866025404,0, 0, 0, 0, ...,
%  0866025404, 0866025404, 0866025404, 0866025404, 1.866025404, 1.866025404, 1.866025404; 
%  1, 0, -1, 1.5, 0.5, -0.5, -1.5, 2, 1, -1, -2, 1.5, 0.5, -0.5, -1.5, 1, 0, -1];

xi=0;

% 21 BSs
bs_sector_3km = 1000*[3,1.5,-1.5,-3,-1.5,1.5,3,4.5,4.5,0,-4.5,-4.5,0, ...,
    4.5,6,3.0,-3.0,-6,-3.0,3.0,6;
    0, 2.60, 2.6,0, -2.5981 , -2.5981, 0, -2.6, 2.6, 5.2, 2.6, -2.6,-5.2, -2.6, 0,5.2,5.2,0,-5.2,-5.2,0];

bs_sector_1km = 1000*[1, 0.5,-0.5,-1,-0.5,0.5,1,1.5,1.5,0,-1.5, -1.5,0,1.5,2,1,-1,-2,-1,1,2;
    0,0.866,0.866,0,-0.866,-0.866,0,-0.866,0.866,1.7321,0.866, -0.866,-1.7321 ...,
    -0.866,0,1.7321,1.7321,0,-1.7321,-1.7321 ,0];  

bs9_sec1 = 1000*[1, 0.5,  -0.5,-1,-0.5,0.5,1,1.5,0 ;
    0,0.866,0.866,0,-0.866,-0.866,-0.866,0.866,1.7321];
    
% bs_omni_1km = [0,-0.866,-0.866,0,0.866, 0.866, 0, 0.866, -0.866, -1.7321, -0.866, 0.866, 1.732 ...,
%     0.866,0 , -1.732, -1.732, 0, 1.732, 1.732, 0;
%     1, 0.5, -0.5, -1,-0.5, 0.5,1, 1.5, 1.5, 0 -1.5,-1.5,0 ...,
%     1.5, 2,1, -1,-2, -1, 1,2];

if (siteDistance==1)
    cell_coordinate = bs_sector_1km;
elseif (siteDistance==3)
    cell_coordinate = bs_sector_3km;
else 
    disp('input siteDistance if out of range [1,3]');
    return;
end

Pneigh = 5;     % Power of neighber cell 5W
for i=1:length(cell_coordinate);
    xi = xi + Pneigh/PathLoss(Distance(UserCoordinate, cell_coordinate(:,i)));        
end

return;
    
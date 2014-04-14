%   **********************************************************************
%   FACH Power calcuation 
%       Xu Qing     March. 2012
%              
%   Calculates the BS Tx power to cover users requesting one same flow 
%    UserRb is the bandwith of the requested bandwidth 
%    by using FACH 
%   
%   input: site distance in km([1,3])
%          numer of total UEs
%          distribute scenario [near, far, mid]
%   output: User Coordinates in meters
%   Needed files: Non
%
%  ************************************************************

function UserCoordinates= Layout(siteDistance, UserDistribute,UserNum)

if (siteDistance ~= 1) &&(siteDistance ~= 3)
    error('input siteDistance is out of range: [1,3], Layout()');    
end 

switch UserDistribute
    case 'near'
        UserNear = zeros(2,3*UserNum);
        for i=1:UserNum            
            UserNear(:,i)= [-0.1+0.1*rand(1); 0.2+0.1*rand(1)];  % x:[-0.1,0.1],y:[0.2,0.3]
            UserNear(:,UserNum+i)= [0.1*rand(1); 0.1+0.1*rand(1)];  % x:[0,0.1],y:[0.1,0.2]    
            UserNear(:,2*UserNum+i)= [0.1*rand(1); 0.1*rand(1)];  % x:[0.1,0.2],y:[0,0.1]    
%             plot(UserNear(1,i),UserNear(2,i),'k.');
%             plot(UserNear(1,2*i),UserNear(2,2*i),'k.');
%             plot(UserNear(1,3*i),UserNear(2,3*i),'k.');
        end
        if siteDistance == 1
            UserCoordinates = 1000*UserNear;
        else UserCoordinates = 3000*UserNear;
        end 
        
    case 'far'
        UserFar = zeros(2,3*UserNum);
        for i=1:UserNum
            UserFar(:,i)=[0.75 + 0.25*rand(1); 1.2 + (1.732-1.2)*rand(1)]/3;
            UserFar(:,UserNum+i)=[0.1*rand(1); 0.45+ 0.1*rand(1)];    %x[0, 0.1],y[0.45,0.55]
            UserFar(:,2*UserNum+i)=[0.1+0.1*rand(1); 0.5+ 0.05*rand(1)];    %x[0.1, 0.2],y[0.5,0.55]
%             figure 
%             grid on;
%             plot(UserFar(1,i),UserFar(2,i),'r.');  
%             hold on;            
%             plot(UserFar(1,2*i),UserFar(2,2*i),'r.');  
%             hold on; 
%             plot(UserFar(1,3*i),UserFar(2,3*i),'r.');      
        end
            if siteDistance == 1 
                    UserCoordinates = 1000*UserFar;
            else 	UserCoordinates = 3000*UserFar;
            end 

        case 'mid' 
            UserMid = zeros(2,3*UserNum);
            for i=1:UserNum
                UserMid(:,i)= [0.3*rand(1); 0.25+ 0.15*rand(1)];  % x:[0,0.3], y: [0.25,0.4]
                UserMid(:,UserNum+i)= [0.1*rand(1); 0.4+ 0.*rand(1)]; % x:[0,0.1], y: [0.4,0.5]
                UserMid(:,2*UserNum+i)= [0.25+0.1*rand(1); 0.15+ 0.1*rand(1)]; % x:[0.25,0.35], y: [0.15,0.25]
%                 plot(UserMid(1,i),UserMid(2,i),'m.');             
%                 plot(UserMid(1,2*i),UserMid(2,2*i),'m.');             
%                 plot(UserMid(1,3*i),UserMid(2,3*i),'m.');  
            end  
            if siteDistance == 1 
                UserCoordinates = 1000*UserMid;
            else UserCoordinates = 3000*UserMid;
            end 
        
    otherwise 
        disp('input UserDistribute is out of range [near, far, mid]');
end

return;

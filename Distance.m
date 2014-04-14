function Dm=Distance(A,B)
% calcuate the distance between two points
% which have the coordination[x;y]
% in meter 
Dm=sqrt( (A(1,1)-B(1,1))^2 + (A(2,1)-B(2,1))^2);
return;
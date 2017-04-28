%This script will find the homography betweeb 4 points and their repsective
%projection by calling homography function and then we project the points
%to see if we get the projected points that we had at the first place:

clc;
xp0=100;
yp0=100;

x0=0;
y0=0;

xp1=200;
yp1=80;

x1=150;
y1=0;


xp2=220;
yp2=80;


x2=150;
y2=150;



xp3=100;
yp3=200; 


x3=0;
y3=150;




H=homography(x0,y0, x1,y1, x2,y2, x3,y3, xp0,yp0, xp1,yp1, xp2,yp2,xp3,yp3);


p0=[x0,y0; x1,y1 ; x2,y2 ; x3,y3];
p1=[xp0,yp0; xp1,yp1; xp2,yp2; xp3,yp3];
tform=maketform('projective',p0,p1);

projected_point=[x2 y2 1] * H;
projected_point(1,1)/projected_point(1,3)
projected_point(1,2)/projected_point(1,3)




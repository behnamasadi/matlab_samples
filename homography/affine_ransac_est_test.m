clc;
clear all;
x0=0;
y0=0; 
x1=1;
y1=0; 
x2=0;
y2=1;

p1=[x0,y0; x1,y1; x2,y2];

p1;

theta=24;
A11=cosd(theta);
A12=-sind(theta);
A21=sind(theta);
A22=cosd(theta);
Tx=1;
Ty=2;

tform = affine2d([A11 A12 0; A21 A22 0; Tx Ty 1]);
tform.T
[x,y]=transformPointsForward(tform,p1(:,1),p1(:,2));
% [x,y]


xp0=x(1,1);
yp0=y(1,1);
xp1=x(2,1);
yp1=y(2,1);
xp2=x(3,1);
yp2=y(3,1);

left_matches=[x0,y0;x1,y1;x2,y2];
right_matches=[xp0,yp0;xp1,yp1;xp2,yp2];


iter=2;
num=3;%minmum number of samples to make the model i.e for line is 2 and for affine is 3
threshDist=1; %1 pixel
[best_number_of_inliers,best_M]=affine_ransac_est(left_matches,right_matches,num,iter,threshDist);
best_number_of_inliers
best_M'
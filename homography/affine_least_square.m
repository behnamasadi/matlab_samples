function M= affine_least_square(x0,y0, x1,y1, x2,y2, xp0,yp0, xp1,yp1, xp2,yp2)
% This function finds the affine transform between three points

% an affine transformation with a 3x3 affine transformation matrix: 
% 
% [M11 M12 M13]
% [M21 M22 M23]
% [M31 M32 M33]

%Since third row is always [0 0 1] we can skip that.

% [x0 y0 1  0  0  0 ]     [M11]   [xp0]
% [0  0  0  x0 y0 1 ]     [M12]   [yp0] 
% [x1 y1 1  0  0  0 ]     [M13]   [xp1]
% [0  0  0  x1 y1 1 ]  *  [M21] = [yp1] 
% [x2 y2 1  0  0  0 ]     [M22]   [xp2] 
% [0  0  0  x2 y2 1 ]     [M23]   [yp2]
                          
%         A            *    X   =  B
%A -> 6x6
%X -> 6x1 in fact 
%X=A\B


A=[x0 y0 1  0  0  0 ; 0  0  0  x0 y0 1 ; x1 y1 1  0  0  0 ; 0  0  0  x1 y1 1 ; x2 y2 1  0  0  0;0  0  0  x2 y2 1];
B=[xp0; yp0; xp1;  yp1; xp2 ; yp2 ];


% X=A\B; 
% this is what we need but accroding to https://www.mathworks.com/matlabcentral/newsreader/view_thread/170201
%The following is better:
X=pinv(A)*B;

M11 =X(1,1);
M12 =X(2,1);  
M13 =X(3,1);
M21 =X(4,1);
M22 =X(5,1);
M23 =X(6,1);
M=[ M11 M12 M13; M21 M22 M23; 0 0 1];
end
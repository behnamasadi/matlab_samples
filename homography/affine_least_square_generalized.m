function M= affine_least_square_generalized(left_matches, right_matches)
% This function finds the affine transform between arbitrary set of points
% (more than 3 points)


% an affine transformation with a 3x3 affine transformation matrix: 
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
%A -> Nx6
%B -> Nx1
%X -> 6x1 in fact 
%X=A\B

n=2;%how many times we want to repeat each row
left_matches=kron(left_matches,ones(n,1))

[rows,cols]=size(left_matches);
append_matrix=zeros(rows,4);
append_matrix(:,1)=1;
left_matches=horzcat( left_matches ,append_matrix); 
for i=1:rows
    if mod(i,2)==0
         left_matches(i,:)=circshift(left_matches(i,:),3);

    end

    
end
tic

[rows,cols] = size(right_matches);
right_matches_Vec=reshape(right_matches', 1,rows*cols  );
right_matches_Vec=right_matches_Vec';

X=pinv(left_matches)*right_matches_Vec;

M11 =X(1,1);
M12 =X(2,1);  
M13 =X(3,1);
M21 =X(4,1);
M22 =X(5,1);
M23 =X(6,1);
M=[ M11 M12 M13; M21 M22 M23; 0 0 1];
end
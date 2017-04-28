function [u,v,binary_map] = myFlow(img1,img2, window_length,threshold)


G_X=(1/12)*[-1 8 0 -8 1];
G_Y=(1/12)*[-1 8 0 -8 1]';


Ix_m = conv2(img1,G_X, 'same');
Iy_m = conv2(img1,G_Y, 'same');


%figure('Name','Ix_m'), imshow(Ix_m,[]);
%figure('Name','Iy_m'), imshow(Iy_m,[]);


gaussian_dimension=3;%shouldn't that be 2*3*sigma+1?
sigma=1;
G = fspecial('gaussian',[gaussian_dimension gaussian_dimension],sigma);

img1_smoothed=imfilter(img1,G);
img2_smoothed=imfilter(img2,G);

figure('Name','img1_smoothed'), imshow(img1_smoothed,[]);
figure('Name','img2_smoothed'), imshow(img2_smoothed,[]);


It_m = img1_smoothed-img2_smoothed;

%figure('Name','It_m'), imshow(It_m,[]);


u = zeros(size(img1));
v = zeros(size(img2));

binary_map=zeros(size(img2));

tmp=zeros(2,2);
S='less than threshold';

for i = window_length+1:size(Ix_m,1)-window_length
    for j = window_length+1:size(Ix_m,2)-window_length
        Ix = Ix_m(i-window_length:i+window_length, j-window_length:j+window_length);
        Iy = Iy_m(i-window_length:i+window_length, j-window_length:j+window_length);
        It = It_m(i-window_length:i+window_length, j-window_length:j+window_length);

        Ix = Ix(:);
        Iy = Iy(:);
        b = -It(:); % get b here

        A = [Ix Iy]; % get A here
        nu = pinv(A)*b; % get velocity here

        u(i,j)=nu(1);
        v(i,j)=nu(2);


        tmp=transpose(A)*A;
        e=eig(tmp);
        if min(e(1),e(2)) > threshold
            binary_map(i,j)=1;
        
        else
            disp(S);
        end

   end;
end;

step_size_downsizing=10;

% downsize u and v
u_deci = u(1:step_size_downsizing:end, 1:step_size_downsizing:end);
v_deci = v(1:step_size_downsizing:end, 1:step_size_downsizing:end);
% get coordinate for u and v in the original frame
[m, n] = size(img1);
[X,Y] = meshgrid(1:n, 1:m);
X_deci = X(1:step_size_downsizing:end, 1:step_size_downsizing:end);
Y_deci = Y(1:step_size_downsizing:end, 1:step_size_downsizing:end);


figure();
imshow(img1);
hold on;
% draw the velocity vectors
quiver(X_deci, Y_deci, u_deci,v_deci, 'y')

end
function myWarp(img2,img1,u,v)

[x, y] = meshgrid(1:size(img2,2), 1:size(img2,1));
% method
% 'nearest' => Nearest neighbor interpolation
% 'linear' => Bilinear interpolation (default)
% 'spline' => Cubic spline interpolation
% 'cubic' => Bicubuc interpolation


method='nearest';
diff = interp2(img1, x-u, y-v,method);
figure('Name','diff method nearest'), imshow(diff-img1,[]);

method='linear';
diff = interp2(img1, x-u, y-v,method);
figure('Name','diff method linear'), imshow(diff-img1,[]);

method='spline';
diff = interp2(img1, x-u, y-v,method);
figure('Name','diff method spline'), imshow(diff-img1,[]);


method='cubic';
diff = interp2(img1, x-u, y-v,method);
figure('Name','diff method cubic'), imshow(diff-img1,[]);


end
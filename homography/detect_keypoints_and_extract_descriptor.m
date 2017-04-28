clc;
close all;
format long g



%1) you need to download vlfeat and uncomment the  run('<path_to_vlfeat>/toolbox/vl_setup')
%http://www.vlfeat.org/overview/sift.html 
% run('<path_to_vlfeat>/toolbox/vl_setup')
%vl_version verbose



%2)Detect keypoints and extract descriptors

image_left=imread('images/image-left.jpg');

scale=0.20;
image_left=imresize(image_left,scale);
image_left_colorfull=image_left;
image_left=single(rgb2gray(image_left)) ;
[f_image_left,d_image_left] = vl_sift(image_left) ;



image_right=imread('images/image-right.jpg');
[w,h]=size(image_left);
image_right=imresize(image_right,[w,h]);
image_right_colorfull=image_right;




% image_right=imresize(image_right,scale);

image_right=single(rgb2gray(image_right)) ;
[f_image_right,d_image_right] = vl_sift(image_right) ;

 
%visualize a random selection of 50 features:

figure(1) ; clf ;
imagesc(single(image_right)) ; colormap gray ; hold on ;

perm = randperm(size(f_image_right,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f_image_right(:,sel)) ;
h2 = vl_plotframe(f_image_right(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d_image_right(:,sel),f_image_right(:,sel)) ;
set(h3,'color','g') ;


%3)Match features
[dims, image_right_features]=size(d_image_right);
[dims, image_left_features]=size(d_image_left);

M=zeros(image_right_features,image_left_features);

for i=1:image_right_features
    for j=1:image_left_features
      
             
         diff = double(d_image_right(:,i))  - double(d_image_left(:,j)) ;
         distance = sqrt(diff' * diff);
        M(i,j)=distance ;
    end
end


%4)Prune features
%we get only top k matches
number_of_top_matches_to_select=90;
M_Vec=sort(M(:));


M=(M < M_Vec( number_of_top_matches_to_select )   );
n=sum(sum(M));

%5)Robust transformation estimation

[M_Rows,M_Cols]=size(M);
left_matches=[];
right_matches=[];

for i=1:M_Rows
    for j=1:M_Cols
       if M(i,j)>0
            x_right=round(f_image_right(1,i));
            y_right=round(f_image_right(2,i));
            x_left=round(f_image_left(1,j));
            y_left=round(f_image_left(2,j));
            left_matches=vertcat(left_matches, [x_left,y_left]);
            right_matches=vertcat(right_matches, [x_right,y_right]);
       end
    end
end



p=99/100;
e=50/100;
[s,dim]=size(left_matches);
s=3
N=  (log (1-p))/(log(1-(1-e)^s))

iter=N;%we choose this so with probability of 99% at least one random sample is free from ouliers
num=3;%minmum number of samples to make the model i.e for line is 2 and for affine is 3
threshDist=5; %5 pixel
[best_number_of_inliers,best_M,index_of_matches]=affine_ransac_est(left_matches,right_matches,num,iter,threshDist);
best_number_of_inliers;
best_M;
sum(index_of_matches);







best_left_matches= left_matches(find(index_of_matches),:) 
best_right_matches= right_matches(find(index_of_matches),:) 

figure; ax = axes;
%showMatchedFeatures(image_left,image_right,best_left_matches,best_right_matches,'montage','Parent',ax);
showMatchedFeatures(image_left_colorfull,image_right_colorfull,best_left_matches,best_right_matches,'montage','Parent',ax);
title(ax, 'Candidate point matches');
legend(ax, 'Matched points 1','Matched points 2');

 

best_M(1,3)=0;
best_M(2,3)=0;


%6)Compute optimal transformation


best_M=affine_least_square_generalized(best_left_matches, best_right_matches);


best_M(1,3)=0;
best_M(2,3)=0;

disp('final transformation is:')
best_M




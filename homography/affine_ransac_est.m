function [best_number_of_inliers,best_M,index_of_matches] = affine_ransac_est(left_matches,right_matches,num,iter,threshDist)
number = size(left_matches,1); % Total number of points

size(ones(number,1));

left_matches=  horzcat(left_matches,ones(number,1) );  

right_matches=  horzcat(right_matches,ones(number,1) );  

best_number_of_inliers=-1;

for i=1:iter
%% Randomly select 3 points    
    idx = randperm(number,num); 
    
    left_matches_sample =  left_matches(idx,:);
    right_matches_sample = right_matches(idx,:);
    
    x0=left_matches_sample(1,1);
    y0=left_matches_sample(1,2);
    
    x1=left_matches_sample(2,1);
    y1=left_matches_sample(2,2);
    
    x2=left_matches_sample(3,1);
    y2=left_matches_sample(3,2);
    
    
    xp0=right_matches_sample(1,1);
    yp0=right_matches_sample(1,2);
    
    xp1=right_matches_sample(2,1);
    yp1=right_matches_sample(2,2);

    xp2=right_matches_sample(3,1);
    yp2=right_matches_sample(3,2);
   
%% compute the affine matrix    
    M=affine_least_square(x0,y0, x1,y1, x2,y2, xp0,yp0, xp1,yp1, xp2,yp2);
    
%% Compute the distances between all points from the left_match to the  
%     left_matches_multiplied_by_affined=left_matches*M;

%     c = cond(M');
    if (cond(M') > 1e18 )
        disp('singular matrix');
        continue;
        
    end 

    tform = affine2d(M');
    [left_matches_multiplied_by_affined_x,left_matches_multiplied_by_affined_y]=transformPointsForward(tform,left_matches(:,1),left_matches(:,2));

    x_diff=(left_matches_multiplied_by_affined_x - right_matches(:,1));
    %x_distances=sqrt(x_diff'*x_diff);
    
    
    y_diff=(left_matches_multiplied_by_affined_y - right_matches(:,2));
    %y_distances=sqrt(y_diff'*y_diff);
    
    r= sqrt( (x_diff).^2 +(y_diff).^2  ) ;
    index_of_point_less_than_threshDist=  r<threshDist;
    number_of_inliers= sum(index_of_point_less_than_threshDist);
    if number_of_inliers>best_number_of_inliers;
        best_number_of_inliers=number_of_inliers;
        best_M=M;
        index_of_matches= index_of_point_less_than_threshDist;
        
    end
    

    
    
end


end

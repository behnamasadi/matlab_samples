warning('off','all')


%hybrid_image
clc;
clear all;
close all;


first_image_path='images/obama.jpg';
second_image_path='images/michelle_obama.jpg';

first_image=im2double( rgb2gray(  imread(first_image_path) ) );
second_image=im2double( rgb2gray(  imread(second_image_path) ) );

sigma=6;
gaussian_dimension=3*sigma*2+1;


first_image_high_pass_filtered=highPassFilter(first_image,gaussian_dimension);


figure('Name','first_image_high_pass_filtered'), imshow(first_image_high_pass_filtered,[]);



sigma=1;
gaussian_dimension=3*sigma*2+1;
second_image_low_pass_filtered=lowPassFilter(second_image,gaussian_dimension);

figure('Name','second_image_low_pass_filtered'), imshow(second_image_low_pass_filtered,[]);



final_image=second_image_low_pass_filtered+first_image_high_pass_filtered;
figure('Name','second_image_low_pass_filtered'), imshow(final_image, []);



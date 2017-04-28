clc;
clear all;
close all;

window_length=25;
threshold=0.01;

%% corridor example
corridor_bt_0_path='Sequences/corridor/bt_0.png';
corridor_bt_0=imread(corridor_bt_0_path);


corridor_bt_0_normalized = double(corridor_bt_0)./double(max(corridor_bt_0(:)));


corridor_bt_1_path='Sequences/corridor/bt_1.png';
corridor_bt_1=imread(corridor_bt_1_path);


corridor_bt_1_normalized = double(corridor_bt_1)./double(max(corridor_bt_1(:)));




[u,v,binary_map]=myFlow(corridor_bt_0_normalized,corridor_bt_1_normalized, window_length,threshold);




u=binary_map.*u;
v=binary_map.*v;

flow=zeros([size(corridor_bt_0_normalized),2]);
flow(:,:,1)=u ;
flow(:,:,2)=v;


figure('Name','flowToColor'), imshow(flowToColor(flow),[]);


myWarp(corridor_bt_1_normalized,corridor_bt_0_normalized,u,v);


%% sphere example

% pause;

sphere_0_path='Sequences/sphere/sphere_0.png';
sphere_0=rgb2gray(imread(sphere_0_path));


sphere_0_normalized = double(sphere_0)./double(max(sphere_0(:)));


sphere_1_path='Sequences/sphere/sphere_1.png';
sphere_1=rgb2gray(imread(sphere_1_path));


sphere_1_normalized = double(sphere_1)./double(max(sphere_1(:)));



[u,v,binary_map]=myFlow(sphere_0_normalized,sphere_1_normalized, window_length,threshold);

u=binary_map.*u;
v=binary_map.*v;

flow=zeros([size(sphere_0_normalized),2]);
flow(:,:,1)=u ;
flow(:,:,2)=v;


figure('Name','flowToColor'), imshow(flowToColor(flow),[]);

myWarp(sphere_1_normalized,sphere_0_normalized,u,v);



%% synth example

% pause;

synth_0_path='Sequences/synth/synth_0.png';
synth_0=imread(synth_0_path);


synth_0_normalized = double(synth_0)./double(max(synth_0(:)));


synth_1_path='Sequences/synth/synth_1.png';
synth_1=imread(synth_1_path);


synth_1_normalized = double(synth_1)./double(max(synth_1(:)));



[u,v,binary_map]=myFlow(synth_0_normalized,synth_1_normalized, window_length,threshold);
u=binary_map.*u;
v=binary_map.*v;

flow=zeros([size(synth_1),2]);
flow(:,:,1)=u ;
flow(:,:,2)=v;

figure('Name','flowToColor'), imshow(flowToColor(flow),[]);


myWarp(synth_1_normalized,synth_0_normalized,u,v);


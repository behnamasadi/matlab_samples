function filtered_image=lowPassFilter(image,filter_size)

image_FFT = fft2(image);
image_FFT_shifted=fftshift(image_FFT);

[M N]=size(image_FFT); % image size

X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Center_of_x=0.5*N;
Center_of_y=0.5*M;
G=exp(-((X-Center_of_x).^2+(Y-Center_of_y).^2)./(2*filter_size).^2);

image_FFT_filtered=image_FFT_shifted.*G;
image_FFT_filtered_shifted=ifftshift(image_FFT_filtered);
filtered_image=ifft2(image_FFT_filtered_shifted);


end
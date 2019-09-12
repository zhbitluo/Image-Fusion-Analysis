function max3 = CostCriteria(filename_image)
RGB = filename_image;
% convert image to greyscale if its not b&w already
if size(RGB,3) ~= 1
I = rgb2gray(RGB);
else
I=RGB;    
end
% convert image to double type. necesarry for sqrt function
I2 = im2double(I);
figure
imshow(I2)
% M=number of rows; N=number of columns in the image
M= size(I2,1); 
N= size(I2,2);
% calculate Raw Frequency RF 
SumRF=0;
for i=1:M 
    for j=2:N
      SumRF = SumRF + (I2(M,N)-I2(M,N-1)^2);  
    end
end
RF=sqrt(SumRF/(M*N)); 
    
% calculate Column Frequency CF 
SumCF=0;
for i=1:N 
    for j=2:M
      SumCF = SumCF + (I2(M,N)-I2(M-1,N)^2);  
end
end
CF=sqrt(SumCF/(M*N));  
% calculate Spatial Frequency SF output
SF=sqrt(RF^2+CF^2);
%% COMPUTING THE AVERAGE GRADIENT HERE
%Here X is the array for which Gradient is to be calculated
[Gmag,Gdir] = imgradient(I2,'sobel');
% Here since Gmag represent Magnitude of Gradient so no need to take absolute value
AG = sum(sum(Gmag))./(sqrt(2)*(size(I2,1)-1)*(size(I2,2)-1));
%% COMPUTING IMAGE ENTROPY HERE

EN=entropy(I2)
max3=SF+EN+AG;

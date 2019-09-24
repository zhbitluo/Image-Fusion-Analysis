%% importing the images
I=imread('a9.tif');
I = im2double(I);
I2=imread('b9.tif');
I2 = im2double(I2);
subplot(1,3,1), imshow(uint8(I))
subplot(1,3,2), imshow(uint8(I2))
%% initializing parameters
nTimes=5;
del=0.0705;
e=del/2;
%M= Number of rows; N= Number of coloumns
M= size(I, 1);
N= size(I, 2);
for n=1:nTimes
    for i=1:M
        for j=1:N
            %perform pcnn and calculate YA and YB
            YA=PCNN(I);
            YB=PCNN(I2);
        end
    end
end
for i=1:M
    for j=1:N
        if abs(YA-YB)< e
            F=abs(I+I2)/2;
            else if ((abs(YA-YB)) >= e) && (abs(YA > YB))
                F= I;
            else (abs(YA-YB)) >= e && (abs(YA > YB))
                F= I2;
                end
        end
    end
end

subplot(1,3,3), imshow(uint8(F))
        
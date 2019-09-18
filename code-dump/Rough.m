%% importing the images
I=imread('file_name');
I = im2double(I);
I2=imread('file_name');
I2 = im2double(I2);
%% initializing parameters
nTimes=50;
del=0.0705;
e=del/2;
%M= Number of rows; N= Number of coloumns
M= size(I, 1);
N= size(I, 2);
for n=1:nTimes
    for i=1:M
        for j=1:N
            %perform pcnn and calculate YA and YB
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

imshow(F);
        
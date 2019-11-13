%% importing the images
I=imread('a1.tif');
%if size(I,3) ~= 1
%    I = rgb2gray(I);
%end
I = double(I);
I2=imread('b1.tif');
%if size(I2,3) ~= 1
%    I2 = rgb2gray(I2);
%end
I2 = double(I2);

subplot(1,3,1), imshow(I,[])
subplot(1,3,2), imshow(I2,[])
%% initializing parameters
nTimes=1;
del=0.0705;
e=del/2;
%M= Number of rows; N= Number of coloumns
M= size(I, 1);
N= size(I, 2);

YA=PCNN_withParameters(I);
YB=PCNN_withParameters(I2);
%for n=1:nTimes
%    for i=1:M
%       for j=1:N
%            disp('PCNN is processing...')
%            %perform pcnn and calculate YA and YB
%            YA=PCNN_withParameters(I);
%            YB=PCNN_withParameters(I2);
%        end
%    end
%end
%temp=abs(YA-YB);
F=zeros(M,N);

for i=1:M
    for j=1:N
        if(abs(YA(i,j)-YB(i,j))<e)
            F(i,j)=(I(i,j)+I2(i,j))/2;
        else if(abs(YA(i,j)-YB(i,j))>=e)&(YA(i,j)>YB(i,j))
                F(i,j)=I(i,j);
            else(abs(YA(i,j)-YB(i,j))>=e)&(YA(i,j)<YB(i,j))
                F(i,j)=I2(i,j);
            end
        end
    end
end

[Gx, Gy]=gradient(F);
S=sqrt(Gx.*Gx+Gy.*Gy);
sharpness=sum(sum(S))./(numel(Gx))
          
subplot(1,3,3), imshow(F,[])
%subplot(1,4,4), imshow(temp)

%imwrite(F,'fused.tif');
%combImg = imfuse(I, I2, 'montage');
%imwrite(combImg,'combined.tif');        

%metrics=fusion_perform_fn(combImg,F)
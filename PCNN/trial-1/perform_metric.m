function Res= perform_metric(A,B,F)

%% Fusion Performance %%
% Written by Ritwik Raha
% Created on 17.11.19
%% Image Sharpness

% [Gx, Gy]=gradient(F);
% S=sqrt(Gx.*Gx+Gy.*Gy);
% sharpness=sum(sum(S))./(numel(Gx))
% 
% si_2=sharpness_index(F,0)

%% Avergae Pixel Intensity
API = mean(F(:));
Res(1)=API;

%% Standard Deviation
[p,q]=size(F);
F=double(F);
SD=sqrt(sum(sum((F-API).^2))/(p*q));
Res(2) = SD;

%% Spatial Frequency

% M=number of rows; N=number of columns in the image
M= size(F,1); 
N= size(F,2);
% calculate Raw Frequency RF 
SumRF=0;
for i=1:M 
    for j=2:N
      SumRF = SumRF + (F(M,N)-F(M,N-1)^2);  
    end
end
RF=sqrt(SumRF/(M*N)); 
    
% calculate Column Frequency CF 
SumCF=0;
for i=1:N 
    for j=2:M
      SumCF = SumCF + (F(M,N)-F(M-1,N)^2);  
end
end
CF=sqrt(SumCF/(M*N));  
% calculate Spatial Frequency SF output
SF=sqrt(RF^2+CF^2);
Res(3)= SF;
%% Mutual Information

MI_AF=mi(A,F,2);
Res(4)= MI_AF;
MI_BF=mi(B,F,2);
Res(5)= MI_BF;
MI_AB=MI_AF+MI_BF;
Res(6)= MI_AB;

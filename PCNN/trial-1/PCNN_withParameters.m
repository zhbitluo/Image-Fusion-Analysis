function R=PCNN_withParameters(matrix)
% Calulate the firing times of neurons in PCNN
% Please set the Para as follows:
% Parameters for PCNN
RGB = matrix;
% convert image to greyscale if its not b&w already
if size(RGB,3) ~= 1
I = rgb2gray(RGB);
else
I=RGB;    
end
I = double(I);
np=200;
link_arrange=3;
alpha_L=0.3;% 0.06931 Or 1
alpha_Theta=0.2;
beta=3;% 0.2 or 3
vL=0.2;
vTheta=20;

%=============================================================
% disp('PCNN is processing...')
[p,q]=size(I);
F_NA=abs(I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the parameters.
% You'd better change them according to your applications
% alpha_L=1;
% alpha_Theta=0.2;
%  beta=3;
% vL=1.00;
% vTheta=20;
% Generate the null matrix that could be used
L=zeros(p,q);
U=zeros(p,q);
Y=zeros(p,q);
Y0=zeros(p,q);
Theta=zeros(p,q);
% Compute the linking strength.
center_x=round(link_arrange/2);
center_y=round(link_arrange/2);
W=zeros(link_arrange,link_arrange);
for i=1:link_arrange
    for j=1:link_arrange
        if (i==center_x)&&(j==center_y)
            W(i,j)=0;
        else
            W(i,j)=1./sqrt((i-center_x).^2+(j-center_y).^2);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%beta, alpha_Theta, vTheta
F=F_NA;
for n=1:np
    K=conv2(Y,W,'same');
    L=K;
    U=double(F).*(1+beta*L); % default U
    Theta=exp(-alpha_Theta)*Theta+vTheta*Y;    
    Y=im2double(U>Theta);
    Y0=Y0+Y;
end
R=Y0;
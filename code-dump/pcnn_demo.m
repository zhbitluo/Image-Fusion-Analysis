% PCNN for image focus map generation
RGB = imread('a9.tif');
% convert image to greyscale if its not b&w already
if size(RGB,3) ~= 1
I = rgb2gray(RGB);
else
I=RGB;    
end
I = double(I);
S = I;

%S(:, 128:256) = S(:, 128:256)*0.5;
subplot(1,2,1), imshow(uint8(S))
%____________________________________
[r, c] = size(S);
Y = zeros(r,c); T = Y;
W = fspecial('gaussian',7,1);
F = S;
beta = 2;
alpha=0.001;
Th = 255*ones(r,c);
dT = exp(-alpha);
Vt = 400;
fire_num = 0;
n = 0;
while fire_num < r*c
    n = n + 1;
    L = imfilter(Y,W,'symmetric');
    Th = Th*exp(-alpha) + Vt*Y;
    fire = 1;
    while fire == 1
        Q = Y;
        U = F.*(1 + beta*L);
        Y = double(U > Th);
        if isequal(Q,Y);
            fire = 0;
        else
            L = imfilter(Y,W,'symmetric');
        end
    end
	T = T + n.*Y;
    fire_num = fire_num + sum(sum(Y));    
end
%____________________________________
%T = 256 - T;
subplot(1,2,2), imshow(uint8(T))

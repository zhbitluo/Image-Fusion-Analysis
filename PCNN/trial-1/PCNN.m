function Yimage = PCNN(filename_image)
RGB = filename_image;
% convert image to greyscale if its not b&w already
if size(RGB,3) ~= 1
I = rgb2gray(RGB);
else
I=RGB;    
end
I = double(I);
S = I;
% show the original image
%subplot(1,2,1), imshow(uint8(S))
%% initializing PCNN parameters
[r, c] = size(S);
Y = zeros(r,c); T = Y;
W = fspecial('gaussian',7,1);
F = S;
beta = 0.1;
alpha=0.2;
Th = 255*ones(r,c);
dT = exp(-alpha);
Vt = 20;
fire_num = 0;
n = 0;
%% running the PCNN main loop
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
%% showing the segmented focus map
%T = 256 - T;
%subplot(1,2,2), imshow(uint8(T))
Yimage=T;
end
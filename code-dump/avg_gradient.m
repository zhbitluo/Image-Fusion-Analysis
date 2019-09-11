%Here X is the array for which Gradient is to be calculated
[Gmag,Gdir] = imgradient(X,'sobel');
% Here since Gmag represent Magnitude of Gradient so no need to take absolute value
AG = sum(sum(Gmag))./(sqrt(2)*(size(X,1)-1)*(size(X,2)-1));
%------------------------- sharpness_index -------------------------

%    Compute the sharpness index (SI) of a numerical image
%
%               author: Lionel Moisan
%
%  This program is freely available on the web page
%
%     http://www.mi.parisdescartes.fr/~moisan/sharpness/
%
%  It implements the Sharpness Index (SI) described in the paper
%
%  G. Blanchet, L. Moisan, An explicit Sharpness Index related to
%  Global Phase Coherence, proceedings of the IEEE International Conference 
%  on Acoustics, Speech, and Signal Processing (ICASSP), pp. 1065-1068, 2012. 
%
%  If you use it for a publication, please mention this paper
%  If you modify this program, please indicate in the code that you 
%  did so and leave this message.
%  You can report bugs or suggestions to lionel.moisan [AT] parisdescartes.fr
%
% usage:    si = sharpness_index(u)   or   si = sharpness_index(u,pmode) 
%
% u is an image (a 2D array = a Matlab matrix)
%
% available preprocessing modes are:
%
% pmode = 0             raw sharpness index of u
% pmode = 1             sharpness index of the periodic component of u 
% pmode = 2             sharpness index of the 1/2,1/2-translated of u 
% pmode = 3 (default)   sharpness index of the 1/2,1/2-translated 
%                       of the periodic component of u
%
% Default mode (pmode = 3) should be used, unless you want to work on very
% specific images that are naturally periodic or not quantized (see paper)
%
% note: this function also works for 1D signals (line or column vectors)
%
% v1.0 (02/2014): initial version from sharpness_index.sci v1.4

% dependencies: dequant, perdecomp, logerfc

function si = sharpness_index(u,pmode)

if (nargin<2) pmode = 3; end
if (pmode==1) | (pmode==3) u = perdecomp(u); end
if (pmode==2) | (pmode==3) u = dequant(u); end
u = double(u);
[ny,nx] = size(u);
gx = u(:,[2:nx,1])-u; fgx = fft2(gx);
gy = u([2:ny,1],:)-u; fgy = fft2(gy);
tv = sum(sum(abs(gx)+abs(gy)));
Gxx = real(ifft2(fgx.*conj(fgx)));
Gyy = real(ifft2(fgy.*conj(fgy)));
Gxy = real(ifft2(fgx.*conj(fgy)));
oomega = @(t) real(t.*asin(t)+sqrt(1-t.^2)-1);
var = 0;
axx = Gxx(1,1);      if (axx>0) var = var+  axx*sum(sum(oomega(Gxx/axx))); end
ayy = Gyy(1,1);      if (ayy>0) var = var+  ayy*sum(sum(oomega(Gyy/ayy))); end
axy = sqrt(axx*ayy); if (axy>0) var = var+2*axy*sum(sum(oomega(Gxy/axy))); end
var = var*2/pi;
if var>0 
  % t = ( E(TV)-tv )/sqrt(var(TV))
  t = ( (sqrt(axx)+sqrt(ayy))*sqrt(2*nx*ny/pi) - tv )/sqrt(var);
  % si = -log10(P(N(0,1)>t))
  si = -logerfc(t/sqrt(2))/log(10)+log10(2); 
else 
  si = 0; 
end


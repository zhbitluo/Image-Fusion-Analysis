function Result = fusion_perform_fn(xrcw,x)

%%% fusion_perform_fn: Computes the Fusion Performance Parameters.
%%% 
%%% Author : B. K. SHREYAMSHA KUMAR 
%%% Created on 28-10-2011.
%%% Updated on 08-11-2011.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Fusion Performance Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Average Pixel Intensity (API) or Mean.
API=mean(xrcw(:));
Result(1) = API;

%%% Standard Deviation (SD).
[p,q]=size(xrcw);
xrcwd=double(xrcw);
SD=sqrt(sum(sum((xrcwd-API).^2))/(p*q));
Result(2) = SD;

%%% Average Gradient (AG).
tmp1=[xrcwd(2:p,:);xrcwd(1,:)];
tmp2=[xrcwd(:,2:q) xrcwd(:,1)];
tmp=sqrt((xrcwd-tmp1).^2+(xrcwd-tmp2).^2);
AG=sum(tmp(:))/(p*q);
Result(3) = AG;
clear tmp1 tmp2 tmp

%%% Entropy of the Fused Image (EN).
[p,q]=size(xrcw);
histF=imhist_fn(xrcw);
pdfF=histF/(p*q); %% p*q=sum(hist_out);
% entropyF=0;
% for ii=1:256
%    if(pdfF(ii)~=0)
%       entropyF=entropyF-pdfF(ii)*log2(pdfF(ii));
%    end
% end
xx = uint8(xrcw);
entropyF = entropy(xx);
Result(4) = entropyF;

%%% Mutual Information (Cross Entropy) of Fused Image (MI).
histA=imhist_fn(x{1}); pdfA=histA/(p*q);
histB=imhist_fn(x{2}); pdfB=histB/(p*q);
jpdfAF=joint_hist_fn(x{1},xrcw)/(p*q); %% Joint Entropy.
jpdfBF=joint_hist_fn(x{2},xrcw)/(p*q);
jpdfAB=joint_hist_fn(x{1},x{2})/(p*q);
MIAF=0; MIBF=0; MIAB=0;
[p,q]=size(jpdfAF);
for ii=1:p
   for jj=1:q
      if(jpdfAF(ii,jj)~=0)
         MIAF=MIAF+jpdfAF(ii,jj)*log2(jpdfAF(ii,jj)/(pdfA(ii)*pdfF(jj)));
      end
      if(jpdfBF(ii,jj)~=0)
         MIBF=MIBF+jpdfBF(ii,jj)*log2(jpdfBF(ii,jj)/(pdfB(ii)*pdfF(jj)));
      end
      if(jpdfAB(ii,jj)~=0)
         MIAB=MIAB+jpdfAB(ii,jj)*log2(jpdfAB(ii,jj)/(pdfA(ii)*pdfB(jj)));
      end         
   end
end
% MIAF,MIBF,MIAB;
MIF=MIAF+MIBF;
Result(5) = MIF;
clear histA histB histF
clear jpdfAF jpdfBF jpdfAB pdfA pdfB pdfF

%%% Fusion Symmetry (FS).
FS1=2-abs((MIAF/(MIAF+MIBF))-0.5);
FS2=2-abs((MIBF/(MIAF+MIBF))-0.5);
Result(6) = FS1;
% Result(7) = FS2;

%%% Average Normalized Correlation (ANC).
diffF=xrcw-mean(xrcw(:));
meanA=mean(x{1}(:)); diffA=x{1}-meanA;
meanB=mean(x{2}(:)); diffB=x{2}-meanB;
rAF=sum(sum((diffA.*diffF)))/(sqrt(sum(sum(diffA.^2))*sum(sum(diffF.^2))));
rBF=sum(sum((diffB.*diffF)))/(sqrt(sum(sum(diffB.^2))*sum(sum(diffF.^2))));
corr=(rAF+rBF)/2;
Result(7) = corr;
clear diffA diffB diffF

%%% Spatial Frequency (SF).
% [p,q]=size(xrcwd);
% rf=sqrt(sum(sum((xrcwd(:,2:q)-xrcwd(:,1:q-1)).^2))/(p*q));
% cf=sqrt(sum(sum((xrcwd(2:p,:)-xrcwd(1:p-1,:)).^2))/(p*q));
% SF=sqrt(rf^2+cf^2);
xx = uint8(xrcwd);
RF = diff(xx,1,1);
RF = sqrt(mean(mean(RF.^2)));
CF = diff(xx,1,2);
CF = sqrt(mean(mean(CF.^2)));
SF = sqrt(RF^2+CF^2);
Result(8) = SF;
clear tmp1 tmp2

[QABF,LABF,NABF,NABF1]=objective_fusion_perform_fn(xrcw,x);
Result(9) = QABF;
Result(10) = LABF;
Result(11) = NABF;
Result(12) = NABF1;

%%% Q0
x{1} = double(x{1});
x{2} = double(x{2});
xrcwd = double(xrcwd);
Result(13) = (img_qi(x{1}, xrcwd) + img_qi(x{2}, xrcwd))/2;

% fp=fopen('coded.txt','wb');
% fprintf(fp,'%6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f \t \t \t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f\t %6.4f',API,SD,AG,entropyF,MIF,FS1,corr,SF,QABF,LABF,NABF1,QABF+LABF+NABF1,NABF,QABF+LABF+NABF);
% fclose(fp);

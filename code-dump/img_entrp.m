%This is a function to compute the entropy of an image 
function D=img_entrp(A)
[M,N]=size(A);
temp=zeros(1,256);
%Statistic gray values of image on [0,255]
for m=1:M;
    for n=1:N;
    
        if A(m,n)==0;
           i=1;
        else
           i=A(m,n);
        end
        temp(i)=temp(i)+1;
    end
end
temp=temp./(M*N);
%comput the entropy by the defination
result=0;
for i=1:length(temp)
    if temp(i)==0;
       result=result;
    else
       result=result-temp(i)*log2(temp(i));
    end
end
D=result;

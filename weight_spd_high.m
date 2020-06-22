function [sMap,Cmax,i_mean2] = weight_spd_high(I,p,r)
R=2*r+1;

[h,w,N]=size(I);
N1 = boxfilter(ones(h, w), r);

% countWindowt = ones(R, R);
% countWindow=countWindowt./sum(countWindowt(:));

% N = size(I,3);

    
C = zeros(size(I,1),size(I,2),N);
% WB= zeros(size(I,1),size(I,2),N);
i_mean2= zeros(size(I,1),size(I,2),N);
for i = 1:N
    

    img = I(:,:,i);

%  img = mean(I(:,:,i),3);
  
    
%     i_mean2=filter2(countWindow,img,'same');
%     i_var2=filter2(countWindow,img.*img,'same')-i_mean2.*i_mean2;
    
      i_mean2(:,:,i)=boxfilter(img, r)./ N1;
     i_var2= boxfilter(img.*img, r) ./ N1- i_mean2(:,:,i).* i_mean2(:,:,i);
     

      
%       i_mean(:,:,i)=guidedfilter(img, img, r, 0.01);
      
    i_var2=sqrt(max(i_var2,0));
    
    C(:,:,i) = i_var2 * sqrt( R^2  )+ 1e-12; % signal strengh
%     WB(:,:,i)=2/pi*atan(20*i_mean2(:,:,i)).*imgradient(i_mean2(:,:,i));
end

% WB = WB + 1e-12; %avoids division by zero
% WB = WB./repmat(sum(WB,3),[1 1 N]);

Cmax=max(C,[],3);
% Cmax=repmat(Cmax,[1 1 3]);


sMap1 = C.^p; % signal structure weighting map
sMap2 = C.^(p-1);
sMap = sMap1 + 1e-12;
normalizer = sum(sMap,3);
sMap = sMap2 ./ repmat(normalizer,[1, 1, N]) ;
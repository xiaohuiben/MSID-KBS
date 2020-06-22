% Fast Infrared and Visible Image Fusion with Structural Decomposition, Knowledge-Based Systems,2020
% algorithm Version 1.0
% Copyright(c) 2020, Hui Li, Xianbiao Qi and Wuyuan Xie
% All Rights Reserved.
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is hereby
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
% Please refer to the following paper:
% H. Li et al., "Fast Infrared and Visible Image Fusion with Structural Decomposition, Knowledge-Based Systems,2020" In press
% Please kindly report any suggestions or corrections to xiaohui102788@126.com

function fI3= single_scale(imgSeqColor,r)

[h,w,n]=size(imgSeqColor);

N1 = boxfilter(ones(h, w), r);

p=4;


[WD,WB, Cmax,i_mean]= weight_spd(imgSeqColor,p,r);
WD=WD.*repmat(Cmax,[1 1 n]);


F_temp2_detail=zeros(h,w,n);
F_temp2_base=zeros(h,w,n);





for i = 1:n

    W_D1=boxfilter(i_mean(:,:,i).*WD(:,:,i), r)./ N1;
    W_D2=boxfilter(WD(:,:,i), r)./ N1;
    W_B2=boxfilter(i_mean(:,:,i).*WB(:,:,i), r)./ N1;

    
    
   F_temp2_detail(:,:,i)=W_D2.*(imgSeqColor(:,:,i))-W_D1;  
    F_temp2_base(:,:,i)= W_B2;
    
    

end

F_temp2=F_temp2_detail+F_temp2_base;
fI3=sum(F_temp2,3);


fI3(fI3 > 1) = 1;
fI3(fI3 < 0) = 0;



%% check

% figure(1),imshow(sum(F_temp2_detail,4))
% figure(2),imshow(sum(F_temp2_base,4))
end




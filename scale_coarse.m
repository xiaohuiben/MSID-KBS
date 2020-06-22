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

function fI3 = scale_fine(imgSeqColor,r)

[h,w,n]=size(imgSeqColor);
N = boxfilter(ones(h, w), r);


p=4;
[WD,WB, Cmax,i_mean2]= weight_spd(imgSeqColor,p,r);


WD=WD.*repmat(Cmax,[1 1 n]);

F_temp2_detail=zeros(h,w,n);
F_temp2_base=zeros(h,w,n);



%% approximate aggregation through averaging(mean filter) the weight map

F_temp2=zeros(h,w,2);
% tic
for i = 1:n

    
%     aa=i_mean2(:,:,i).*tem;
%     i_meant(:,:,i)=aa(1:2:h,1:2:w);

%     W_D1=boxfilter(aa.*WD(:,:,i), r)./ N1;
%     W_D2=boxfilter(WD(:,:,i).*tem, r)./ N1;
%     W_B2=boxfilter(aa.*WB(:,:,i), r)./ N1;

    W_D1=boxfilter(i_mean2(:,:,i).*WD(:,:,i), r)./ N;
    W_D2=boxfilter(WD(:,:,i), r)./ N;
    W_B2=boxfilter(i_mean2(:,:,i).*WB(:,:,i), r)./ N;
    
    F_temp2_detail(:,:,i)=W_D2.*(imgSeqColor(:,:,i))-W_D1;
    
    
    
    F_temp2_base(:,:,i)= W_B2;
    
    F_temp2(:,:,i)=F_temp2_detail(:,:,i)+F_temp2_base(:,:,i);
    
end



fI3=sum(F_temp2,3);
% toc

% figure, imshow(mat2gray(sum(F_temp2_detail,3)))
% figure, imshow(mat2gray(sum(F_temp2_base,3)))

end




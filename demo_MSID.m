
% ========================================================================
% This is the MSID demo in the following paper:
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




clear;
close all;

addpath(genpath(pwd));
folder1='typical_images/';
filepath=dir(folder1);
filepath1=filepath(4:end); % My system is MAC OS, filepath(1:3) are: '.','..','.DS_Store'.
% If you use Windows, probably filepath1=filepath(3:end)
for i = 1:2:length(filepath1)-1
    % for i = 1:2:13
    
    
    a=im2double(imread(fullfile(folder1,filepath1(i).name)));
    b=im2double(imread(fullfile(folder1,filepath1(i+1).name)));
    
    if size(a,3)==3
        a=rgb2gray(a);
    end
    if size(b,3)==3
        b=rgb2gray(b);
    end
    
    
    imgSeqColor=zeros(size(a,1),size(a,2),2);
    imgSeqColor(:,:,1)=a;
    imgSeqColor(:,:,2)=b;
    %         figure,imshow(a)
    %           figure,imshow(b)
    tic
    %         t1=toc;
    r1=2;
    
    %% multi-scale scale
    [ D1,i_mean1,aa1,N1] = scale_fine(imgSeqColor,r1);
    
    [r,c,~]=size(imgSeqColor);
    nlev = floor(log(min(r,c)) / log(2))-3;  %% plus 2 is total scale number
    
    D2 = cell(nlev,1);
    aa2= cell(nlev,1);
    N2= cell(nlev,1);
    
    r2=2;
    for ii=1:nlev
        [ D2{ii},i_mean2,aa2{ii},N2{ii}] = scale_interm(i_mean1,r2);
        i_mean1=i_mean2;
    end
    
    
    
    r3=1;
    fI3 = scale_coarse(i_mean2,r3);
    
    %% reconstruct
    
    for ii=nlev:-1:1
        temp=aa2{ii};
        fI=zeros(size(temp));
        fI(1:2:size(temp,1),1:2:size(temp,2))=fI3;
        B2=boxfilter(fI, r2)./ N2{ii}+D2{ii};
        
        fI3=B2;
    end
    
    fI=zeros(size(aa1));
    fI(1:2:size(aa1,1),1:2:size(aa1,2))=B2;
    B1=boxfilter(fI, r1)./ N1;
    C_out=B1+D1;
    
    toc
    %        t(1,(i+1)/2)=t2-t1;
    
    
    %         C_out=im2gray(C_out);
    figure,imshow(C_out)
    
    %% estimating images
    %         filename = ['/Users/huili/Desktop/kbs_compexp/MSID/res_test/',filepath1(i).name(1:end-4),'_our',filepath1(i).name(end-3:end)];
    %         imwrite(C_out,filename);
    %
    %         Result_test_multi{(i+1)/2} = Metric(uint8(a*255),uint8(b*255),uint8(C_out*255));
    
end
% end
%      t_mean=mean(t)
% save Result_test_multi
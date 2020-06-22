
% ========================================================================
% This is the SSID demo in the following paper:
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
    
    r=15;
    
    tic
    C_out = single_scale(imgSeqColor,r);
    toc
    
    % toc
    
    figure, imshow(C_out)
    
    
end


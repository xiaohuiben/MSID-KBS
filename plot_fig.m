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


clear all;
close all;

load Result_test_multi
temp=Result_test_multi;
num=length(temp); 

for i=1:num
EN(1,i)=temp{i}.EN;

MI(1,i)=temp{i}.MI;
Q_G(1,i)=temp{i}.Q_G;
SD(1,i)=temp{i}.SD;
SF(1,i)=temp{i}.SF;
end
EN=roundn(EN,-3);
Q_G=roundn(Q_G,-3);
SD=roundn(SD,-3);
MI=roundn(MI,-3);

% X=1:num;
% figure,plot(X,EN,'LineWidth',1.8)
% title('EN')
% 
% figure,plot(X,MI,'LineWidth',1.8)
% title('MI')
% 
% figure,plot(X,Q_G,'LineWidth',1.8)
% title('Q_G')
% 
% figure,plot(X,SD,'LineWidth',1.8)
% title('SD')
% figure,plot(X,SF,'LineWidth',1.8)
% title('SF')

Mean_EN=mean(EN);
Mean_EN=roundn(Mean_EN,-3)
Mean_MI=mean(MI);
Mean_MI=roundn(Mean_MI,-3)
Mean_Q_G=mean(Q_G);
Mean_Q_G=roundn(Mean_Q_G,-3)
Mean_SD=mean(SD);
Mean_SD=roundn(Mean_SD,-3)
Mean_SF=mean(SF);

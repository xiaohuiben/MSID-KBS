
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

function y=mean_fun(x,gamma)

% gamma=2;
% x=0:0.01:1;
% y1=x.^0.5;
% y2=x.^2;
% figure,plot(x,x,x,y1,x,y2)
y1=x.^gamma.*(x<=0.5)*(0.5/(0.5.^gamma));
y2=(0.5-(1-x).^gamma*(0.5/(0.5.^gamma))+0.5).*(x>0.5);
y=y1+y2;
% figure,plot(x,y,x,x)
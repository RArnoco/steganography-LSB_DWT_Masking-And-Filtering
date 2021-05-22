%save this matlab function as mse_psnr.m
%To calculate PSNR follow instruction
function [mse,psnr] = mse_psnr(im1,im2)
% find the size of image1
N = size(im1);
%convert image into double
x=im2double(im1);
y=im2double(im2);
%Now calculate MSE then PSNR for a original and encrypted image
acc = 0;
for k1=1:N(1)
for k2=1:N(2)
acc = acc+ ( x(k1,k2) - y(k1,k2) )^2;
end
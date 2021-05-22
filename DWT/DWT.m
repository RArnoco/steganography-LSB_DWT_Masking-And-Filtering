
clc;
close all;
%cover image 
cover_image=imread('dp.jpg');
figure(1);
subplot(2,2,1);
imshow(rgb2gray(cover_image));
title('1. Cover Image');
% apply dwt
[c_LL,c_LH,c_HL,c_HH]=dwt2(cover_image,'haar');
%select LL band
img=c_LL;
% generate R G B bands of Image
red1=img(:,:,1);
green1=img(:,:,2);
blue1=img(:,:,3);
% single value decomposition, generating "S" matrix having  values with U and V with zero elements.
[U_imgr1,S_imgr1,V_imgr1]= svd(red1);
[U_imgg1,S_imgg1,V_imgg1]= svd(green1);
[U_imgb1,S_imgb1,V_imgb1]= svd(blue1);

%secret image
secret_image=imread('kaneki.jpg');
subplot(2,2,2);
imshow(rgb2gray(secret_image));
title('2. Secret image');
% apply dwt
[w_LL,w_LH,w_HL,w_HH]=dwt2(secret_image,'haar');
%select LL band
img_wat=w_LL;
red2=img_wat(:,:,1);
green2=img_wat(:,:,2);
blue2=img_wat(:,:,3);
% single value decomposition, generating "S" matrix having  values with U and V with zero elements.
[U_imgr2,S_imgr2,V_imgr2]= svd(red2);
[U_imgg2,S_imgg2,V_imgg2]= svd(green2);
[U_imgb2,S_imgb2,V_imgb2]= svd(blue2);

% watermarking
S_wimgr=S_imgr1+(0.10*S_imgr2);
S_wimgg=S_imgg1+(0.10*S_imgg2);
S_wimgb=S_imgb1+(0.10*S_imgb2);
% merging
wimgr = U_imgr1*S_wimgr*V_imgr1';
wimgg = U_imgg1*S_wimgg*V_imgg1';
wimgb = U_imgb1*S_wimgb*V_imgb1';

wimg=cat(3,wimgr,wimgg,wimgb);
%newhost_LL=wimg;

%output
% apply idwt
rgb2=idwt2(wimg,c_LH,c_HL,c_HH,'haar');
imwrite(uint8(rgb2),'dp1.jpg');
subplot(2,2,3);imshow(rgb2gray(uint8(rgb2)));title(' 3. Steganographed Image');


%read the stego image
rgbimage=imread('dp1.jpg');
%apply dwt
[wm_LL,wm_LH,wm_HL,wm_HH]=dwt2(rgbimage,'haar');
%select ll band
img_w=wm_LL;
red3=img_w(:,:,1);
green3=img_w(:,:,2);
blue3=img_w(:,:,3);
[U_imgr3,S_imgr3,V_imgr3]= svd(red3);
[U_imgg3,S_imgg3,V_imgg3]= svd(green3);
[U_imgb3,S_imgb3,V_imgb3]= svd(blue3);



S_ewatr=(S_imgr3-S_imgr1)/0.10;
S_ewatg=(S_imgg3-S_imgg1)/0.10;
S_ewatb=(S_imgb3-S_imgb1)/0.10;

ewatr = U_imgr2*S_ewatr*V_imgr2';
ewatg = U_imgg2*S_ewatg*V_imgg2';
ewatb = U_imgb2*S_ewatb*V_imgb2';

ewat=cat(3,ewatr,ewatg,ewatb);



%output
subplot(2,2,4);
rgb2=idwt2(ewat,w_LH,w_HL,w_HH,'haar');
imshow(rgb2gray(uint8(rgb2)));
imwrite(uint8(rgb2),'kaneki1.jpg');title('4. Extracted Secret Image');


pic1=double(cover_image);
pic2=double(uint8(rgb2));


[M N] = size(pic1);


error = pic1 - pic2;
MSE = sum(sum(error .* error)) / (M * N);
if(MSE > 0)
    PSNR = 10*log10(M*N./MSE);
else
    PSNR = 99;
end
disp('PSNR of message image to extracted image is')
disp(abs(PSNR))
disp('MSE is')
disp(abs(MSE))

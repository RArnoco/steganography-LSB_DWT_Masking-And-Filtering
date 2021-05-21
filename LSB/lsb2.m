
clear all;
close all;



x = imread('image.jpg');         % cover message
y = imread('image1.jpg');    % message image
%n = input('Enter the no of LSB bits to be subsituted- '); 
n=3;
S = uint8(bitor(bitand(x,bitcmp(2^n-1,8)),bitshift(y,n-8))); %Stego
E = uint8(bitand(255,bitshift(S,8-n))); %Extracted
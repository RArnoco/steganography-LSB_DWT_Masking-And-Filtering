function A = psnr('extracted2.jpg','message2.jpg')
    
%     convert to doubles
    image=(image);
    image_prime=(image_prime);
 
    % avoid divide by zero nastiness
    
    if  sum(sum(image-(image_prime))) == 0   
        Error('Input vectors must not be identical')
    else 
        MSE=mean(mean((image-image_prime).^2));
        disp(MSE);

        %A=sum(sum((image-image_prime).^2));
        A=10*log10(255^2/MSE);      % calculate PSNR
    end 

end


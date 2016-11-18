function result=Fcompression_psnr(im1,im2);
MSE=mean(mean((im1-im2).^2));
result=10*log10((255^2)/MSE);

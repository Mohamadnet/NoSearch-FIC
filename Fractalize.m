function Fractalize()

for uu=1:8
tic ;
Pic_name=['256-256\Fig(' num2str(uu) ').jpg'];
Original_pic=imread(Pic_name);
coe_alpha=15;
[a r_block X_size]=Fractal_coding(Pic_name,4,coe_alpha);
fractime  = toc ;
save('lena-128_result','a');
X=zeros(X_size);
X(:)=128;
for ii=1:25
    temp_X=Fractal_decoding(a,X,r_block);
    X=temp_X;
    disp(['End of run ',num2str(ii),' th.']) ;
end
disp(mat2str(fractime))   ;
imshow(uint8(X));
Original_pic=imread(Pic_name);
%Psnr=Fcompression_psnr(Original_pic,X);
imwrite(uint8(X),['256-256\Fig(' num2str(uu) ')-256-256-wavelet-nosearch.jpg']);
%dlmwrite(['256-256\psnr(' num2str(uu) ').txt'],Psnr);
dlmwrite(['256-256\time(' num2str(uu) ').txt'],fractime);
end
disp('Finished');
save('X','X');
end
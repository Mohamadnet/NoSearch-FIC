function result = Fractal_decoding(image_code,X,r_block)

X_size=size(X);
Z=zeros(X_size);
d_block=2*r_block;
r=X_size/r_block;
d=r/2;
3

for ii=1:r(1)
    for jj=1:r(1)    
        k=image_code(ii,jj).domain_index(1);
        l=image_code(ii,jj).domain_index(2);
        d=X(k:(k-1)+d_block,l:(l-1)+d_block);
        temp_d=imresize(d,0.5);
                        if image_code(ii,jj).rotation==1
                            result_temp_d=temp_d;
                        elseif image_code(ii,jj).rotation==2
                            result_temp_d=imrotate(temp_d,90,'bilinear');
                        elseif image_code(ii,jj).rotation==3
                            result_temp_d=imrotate(temp_d,180,'bilinear');
                        elseif image_code(ii,jj).rotation==4
                            result_temp_d=imrotate(temp_d,270,'bilinear');
                        elseif image_code(ii,jj).rotation==5
                            tform=maketform('affine',[-1 0 0; 0 1 0; 0 0 1]);
                            result_temp_d=imtransform(temp_d,tform);
                        elseif image_code(ii,jj).rotation==6
                            tform=maketform('affine',[1 0 0; 0 -1 0; 0 0 1]);
                            result_temp_d=imtransform(temp_d,tform);
                        elseif image_code(ii,jj).rotation==7
                            tform=maketform('affine',[0 1 0; 1 0 0; 0 0 1]);
                            result_temp_d=imtransform(temp_d,tform);
                        elseif image_code(ii,jj).rotation==8
                            tform=maketform('affine',[-1 0 0; 0 -1 0; 0 0 1]);
                            result_temp_d=imtransform(temp_d,tform);
                        end
                        Z((ii-1)*r_block+1:ii*r_block,(jj-1)*r_block+1:jj*r_block)=image_code(ii,jj).S .* result_temp_d + image_code(ii,jj).O;
                        
    end
end
result=Z;
4
end
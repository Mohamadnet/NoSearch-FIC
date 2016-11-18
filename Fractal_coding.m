function [result r_block X_size]= Fractal_coding(image_name,r_block,coe_alpha)

X=double(imread(image_name));
X_size=size(X);
d_block=2*r_block;
r=X_size/r_block;
d=r/2;
% for k=1:X_size(1)-d_block+1
%     for l=1:X_size(1)-d_block+1
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Y(k,l,1).d=X(k:(k-1)+d_block,l:(l-1)+d_block);
%         temp_d=imresize(Y(k,l).d,0.5);
%         Y(k,l,1).sum_d=sum(sum(temp_d));
%         Y(k,l,1).sum_d_2=sum(sum((temp_d).^2));
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Y(k,l,1).mode=temp_d;
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Y(k,l,2).mode=imrotate(temp_d,90,'bilinear');
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Y(k,l,3).mode=imrotate(temp_d,180,'bilinear');
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Y(k,l,4).mode=imrotate(temp_d,270,'bilinear');
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         tform=maketform('affine',[-1 0 0; 0 1 0; 0 0 1]);
%         Y(k,l,5).mode=imtransform(temp_d,tform);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         tform=maketform('affine',[1 0 0; 0 -1 0; 0 0 1]);
%         Y(k,l,6).mode=imtransform(temp_d,tform);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         tform=maketform('affine',[0 1 0; 1 0 0; 0 0 1]);
%         Y(k,l,7).mode=imtransform(temp_d,tform);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         tform=maketform('affine',[-1 0 0; 0 -1 0; 0 0 1]);
%         Y(k,l,8).mode=imtransform(temp_d,tform);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     end
% end
% save('lena-512_domain_and_range pool_range block4','Y');
% load('lena-512_domain_and_range pool_range block4');

[c,s] = wavedec2(X,1,'sym4');
help=fuzzy_final_decompose_show(s,c);
                f1=help.f1;
                f2=abs(help.f2);
                f3=abs(help.f3);
                f4=abs(help.f4);
                Min=min(min(f1));
                Max=max(max(f1));
                f1=255*(f1-Min)/(Max-Min);
                f1=imresize(f1,(X_size(1)/2)/size(f1,1));
                Min=min(min(abs(f2)));
                Max=max(max(f2));
                f2=255*(f2-Min)/(Max);
                f2=imresize(f2,(X_size(1)/2)/size(f2,1));
                Min=min(min(abs(f3)));
                Max=max(max(f3));
                f3=255*(f3-Min)/(Max);
                f3=imresize(f3,(X_size(1)/2)/size(f3,1));
                Min=min(min(abs(f4)));
                Max=max(max(f4));
                f4=255*(f4-Min)/(Max);
                f4=imresize(f4,(X_size(1)/2)/size(f4,1));
                f4_size=size(f4);
%                 imwrite(uint8(f2),['new\f2.jpg']);
%                 imwrite(uint8(f3),['new\f3.jpg']);
%                 imwrite(uint8(f4),['new\f4.jpg']);
                for ii=1:f4_size(1)-r_block+1
                 for jj=1:f4_size(1)-r_block+1
                      W(ii,jj).f2_image=f2(ii:(ii-1)+r_block,jj:(jj-1)+r_block);
                      W(ii,jj).f2_mean=mean(mean(W(ii,jj).f2_image));
                      W(ii,jj).f3_image=f3(ii:(ii-1)+r_block,jj:(jj-1)+r_block);
                      W(ii,jj).f3_mean=mean(mean(W(ii,jj).f3_image));
                      W(ii,jj).f4_image=f4(ii:(ii-1)+r_block,jj:(jj-1)+r_block);
                      W(ii,jj).f4_mean=mean(mean(W(ii,jj).f4_image));
                 end
                end
for ii=1:r(1)
    for jj=1:r(1)
        RB=X((ii-1)*r_block+1:ii*r_block,(jj-1)*r_block+1:jj*r_block);
        k=((ii-1)*r_block)+1-(r_block/2);
        l=((jj-1)*r_block)+1-(r_block/2);
        if ((ii-1)*r_block)+1-(r_block/2)<1
                k=((ii-1)*r_block)+1;
        end
        if ((ii-1)*r_block)+1-(r_block/2)>X_size(1)-d_block+1
            k=((ii-1)*r_block)+1-(r_block);
        end
        if ((jj-1)*r_block)+1-(r_block/2)<1
            l=((jj-1)*r_block)+1;
        end
        if ((jj-1)*r_block)+1-(r_block/2)>X_size(1)-d_block+1
            l=((jj-1)*r_block)+1-(r_block);
        end
        f2_image=f2((ii-1)*(r_block/2)+1:ii*(r_block/2),(jj-1)*(r_block/2)+1:jj*(r_block/2));
        f3_image=f3((ii-1)*(r_block/2)+1:ii*(r_block/2),(jj-1)*(r_block/2)+1:jj*(r_block/2));
        f4_image=f4((ii-1)*(r_block/2)+1:ii*(r_block/2),(jj-1)*(r_block/2)+1:jj*(r_block/2));
        mean_f2=mean(mean(f2_image));
        mean_f3=mean(mean(f3_image));
        mean_f4=mean(mean(f4_image));
        [wavelet_RB Index_max]=max([mean_f2,mean_f3,mean_f4]);
        SR=sum(sum(RB));
        n=r_block^2;
        if wavelet_RB<coe_alpha
%             	d=X(k:(k-1)+d_block,l:(l-1)+d_block);
%                 temp_d=imresize(d,0.5);
%                 sum_d=sum(sum(temp_d));
%                 sum_d_2=sum(sum((temp_d).^2));
		d=X(k:(k-1)+d_block,l:(l-1)+d_block);
        temp_d=imresize(d,0.5);
        sum_d=sum(sum(temp_d));
        sum_d_2=sum(sum((temp_d).^2));
                sent2=SR*sum_d;
                sent4=sum_d^2;
                Min=inf;
                for h=1:8
                    D_rotated=rotate_block(temp_d,h);
                    sent1=n*sum(sum(RB.*D_rotated));
                    S=(sent1-sent2)/(n * sum_d_2-sent4);
                    O=(SR-S*sum_d)/n;
                    help1=sum(sum((D_rotated*S - RB +O).^2));
                    help2=sum(sum((D_rotated -  RB).^2));
                    if help1 > help2
                        S=1;
                        O=0;
                        RMS=help2;
                    else
                        RMS=help1;
                    end
                    if RMS<Min
                    Min=RMS;
                    S_co=S;
                    O_co=O;
                    rotation=h;    
                    end
                end
        temp_result(ii,jj).RMS=Min;
        temp_result(ii,jj).rotation=rotation;
        temp_result(ii,jj).domain_index=[k l];
        temp_result(ii,jj).O=O_co;
        temp_result(ii,jj).S=S_co;
        else
                [domain_index rotation S_co O_co Min]= Fractal_domain_search(X,W,coe_alpha,SR,RB,n,Index_max,X_size(1),d_block);
                temp_result(ii,jj).RMS=Min;
                temp_result(ii,jj).rotation=rotation;
                temp_result(ii,jj).domain_index=domain_index;
                temp_result(ii,jj).O=O_co;
                temp_result(ii,jj).S=S_co;
        end
    end
end
result=temp_result;


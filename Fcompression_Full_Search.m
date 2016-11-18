clc;
clear;
image_name(1).name='lena';
image_name(2).name='Einstein';
image_name(3).name='Cameraman';
image_size(1)=128;
image_size(2)=256;
image_size(3)=512;
range_block_size(1)=16;
range_block_size(2)=8;
range_block_size(3)=4;
for im_size=1:3
    for RB_size=1:3
        for im_name=1:3
            X=double(imread(['D:\Fractal\' image_name(im_name).name num2str(image_size(im_size)) '.jpg']));
            iteration=25;
            domain_block_size=range_block_size(RB_size)*2;
            [height width]=size(X);
            range_horizontal=width/range_block_size(RB_size);
            range_vertical=height/range_block_size(RB_size);
            domain_horizontal=width-domain_block_size+1;
            domain_vertical=height-domain_block_size+1;
            filename=['D:\Fractal\Results_' image_name(im_name).name 'I_size' num2str(image_size(im_size)) 'R_size' num2str(range_block_size(RB_size)) '_Full_Search.mat'];
            if exist(filename)~=2
                filename=['D:\Fractal\Domain_Pool_' image_name(im_name).name 'I_size' num2str(im_size) 'R_size' num2str(RB_size) '.mat'];
                if exist(filename)==2
                    load(filename);
                else
                    for ii=1:domain_horizontal
                        for jj=1:domain_vertical
                            for T=1:8
                                Domain_pool(jj,ii,T).block=Fcompression_rotate(imresize(X(jj:jj+domain_block_size-1,ii:ii+domain_block_size-1),0.5),T);
                            end
                            SD(jj,ii)=sum(sum(Domain_pool(jj,ii,1).block));
                            sent3(jj,ii)=range_block_size(RB_size)*range_block_size(RB_size)*sum(sum(Domain_pool(jj,ii,1).block.^2));
                        end
                        clc;
                        'Finding SD, Sent3 Domain'
                        round(100*ii/(height-range_block_size(RB_size)+1))
                    end
                    save(filename,'Domain_pool','SD','sent3');
                end
                filename=['D:\Fractal\Results_' image_name(im_name).name 'I_size' num2str(image_size(im_size)) 'R_size' num2str(range_block_size(RB_size)) '_Full_Search.mat'];
                for ii=1:range_horizontal
                    for jj=1:range_vertical
                        RB=X((jj-1)*range_block_size(RB_size)+1:jj*range_block_size(RB_size),(ii-1)*range_block_size(RB_size)+1:ii*range_block_size(RB_size));
                        SR=sum(sum(RB));
                        n=range_block_size(RB_size)^2;
                        Min=inf;
                        for y=1:domain_vertical
                            for x=1:domain_horizontal
                                sent2=SR*SD(y,x);
                                sent4=SD(y,x)^2;
                                for T=1:8
                                    D_rotated=Domain_pool(y,x,T).block;
            %                                 SD=sum(sum(D_rotated));
                                    sent1=n*sum(sum(RB.*D_rotated));
            %                                 sent3=n*sum(sum(D_rotated.^2));
                                    S=(sent1-sent2)/(sent3(y,x)-sent4);
                                    O=(SR-S*SD(y,x))/n;
                                    help1=Fcompression_rms(D_rotated*S+O,RB);
                                    help2=Fcompression_rms(D_rotated,RB);
                                    RMS=min(help1,help2);
                                    if RMS<Min
                                        Min=RMS;
                                        encoded.x(jj,ii)=x;
                                        encoded.y(jj,ii)=y;
                                        encoded.T(jj,ii)=T;
                                        encoded.S(jj,ii)=S;
                                        encoded.O(jj,ii)=O;
                                        encoded.RS=range_block_size(RB_size);
                                    end
                                end
                            end
                        end
                    end                        
                    clc;
                    disp('Finding Full Search ');
                    disp(['I_size: ' num2str(im_size)]);
                    disp(['R_size: ' num2str(RB_size)]);
                    disp(['Percent: ' num2str(round(100*ii/(range_horizontal)))]);
                end
                decoded=Fcompression_decode(encoded,25,false,true);
                psnr_Full_Search=Fcompression_psnr(decoded,X);
                imwrite(uint8(decoded),['D:\Fractal\Results\' image_name(im_name).name num2str(range_block_size(RB_size)) '_Full_Search_' num2str(image_size(im_size)) '.jpg']);
                save(filename,'encoded','psnr_Full_Search');
                clear encoded;
            end
        end
    end
end
clear;
clc;




image_name(1).name='lena';
image_name(2).name='Einstein';
image_name(3).name='Cameraman';
image_size(1)=128;
image_size(2)=256;
image_size(3)=512;
pop_no(1)=15;
pop_no(2)=20;
pop_no(3)=25;
pop_no(4)=30;
range_block_size(1)=64;
range_block_size(2)=32;
range_block_size(3)=16;
range_block_size(4)=8;
range_block_size(5)=4;
it=100;
counter=0;
for im_size=1:3
    for RB_size=2:4
        for im_name=1:3
            for pop_size=1:1
                X=double(imread(['E:\Process\other\fractal\' image_name(im_name).name num2str(image_size(im_size)) '.jpg']));
%                 iteration=25;
%                 domain_block_size=range_block_size(RB_size)*2;
%                 [height width]=size(X);
%                 range_horizontal=width/range_block_size(RB_size);
%                 range_vertical=height/range_block_size(RB_size);
%                 domain_horizontal=width-domain_block_size+1;
%                 domain_vertical=height-domain_block_size+1;
% 
% 
% 
%                 help1=zeros(1,domain_horizontal*domain_vertical);
%                 help2d=zeros(domain_horizontal,domain_vertical);
%                 help2d1=zeros(domain_horizontal,domain_vertical);
%                 help2d2=zeros(domain_horizontal,domain_vertical);
%                 indexxWH=zeros(1,(height-range_block_size(RB_size)+1)*(width-range_block_size(RB_size)+1));
%                 indexyWH=zeros(1,(height-range_block_size(RB_size)+1)*(width-range_block_size(RB_size)+1));
%                 indexxWV=zeros(1,(height-range_block_size(RB_size)+1)*(width-range_block_size(RB_size)+1));
%                 indexyWV=zeros(1,(height-range_block_size(RB_size)+1)*(width-range_block_size(RB_size)+1));



                original=X;
                [height width]=size(X);
%                 WH=zeros(height-domain_block_size+1,width-domain_block_size+1);
%                 WV=zeros(height-domain_block_size+1,width-domain_block_size+1);
%                 WHR=zeros(round(height/range_block_size(RB_size)),round(width/range_block_size(RB_size)));
%                 WVR=zeros(round(height/range_block_size(RB_size)),round(width/range_block_size(RB_size)));

                [c,s] = wavedec2(X,1,'sym4');

                help=fuzzy_final_decompose_show(s,c);
                f1=help.f1;
                f2=abs(help.f2);
                f3=abs(help.f3);
                f4=abs(help.f4);
                Min=min(min(f1));
                Max=max(max(f1));
                f1=255*(f1-Min)/(Max-Min);
                f1=imresize(f1,(height/2)/size(f1,1));
                Min=min(min(abs(f2)));
                Max=max(max(f2));
                f2=255*(f2-Min)/(Max);
                f2=imresize(f2,(height/2)/size(f2,1));
                Min=min(min(abs(f3)));
                Max=max(max(f3));
                f3=255*(f3-Min)/(Max);
                f3=imresize(f3,(height/2)/size(f3,1));
                Min=min(min(abs(f4)));
                Max=max(max(f4));
                f4=255*(f4-Min)/(Max);
                f4=imresize(f4,(height/2)/size(f4,1));
                image1=([f1 f2;f3 f4]);
                imwrite(uint8(double(image1)),['E:\Process\other\fractal\Results\image' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
                imwrite(uint8(double(f1)),['E:\Process\other\fractal\Results\f1' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
                imwrite(uint8(double(f2)),['E:\Process\other\fractal\Results\f2' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
                imwrite(uint8(double(f3)),['E:\Process\other\fractal\Results\f3' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
                imwrite(uint8(double(f4)),['E:\Process\other\fractal\Results\f4' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
            end
        end
    end
end


% 
% 
% 
%                 filename=['E:\Process\other\fractal\Results\WHWVR' num2str(range_block_size(RB_size)) image_name(im_name).name num2str(image_size(im_size)) '.mat'];
%                 if exist(filename)==0
%                     for ii=1:height/range_block_size(RB_size)
%                         for jj=1:width/range_block_size(RB_size)
%                             y=round((ii-1)*range_block_size(RB_size)*s(1,1)/(height))+1;
%                             x=round((jj-1)*range_block_size(RB_size)*s(1,1)/(width))+1;
%                             WHR(ii,jj)=mean(mean(f2(y:min(y+range_block_size(RB_size)-1,s(1,1)),x:min(x+range_block_size(RB_size)-1,s(1,1)))));
%                             WVR(ii,jj)=mean(mean(f3(y:min(y+range_block_size(RB_size)-1,s(1,1)),x:min(x+range_block_size(RB_size)-1,s(1,1)))));
%                         end
%                         clc;
%                         'Finding Coeffs Range'
%                         round(100*ii/(height/range_block_size(RB_size)))
%                     end
%                     save(filename,'WHR','WVR');
%                 else
%                     load(filename);
%                 end
%                 
%                 filename=['E:\Process\other\fractal\Results\WHWV' num2str(range_block_size(RB_size)) image_name(im_name).name num2str(image_size(im_size)) '.mat'];
%                 if exist(filename)==0
%                     for ii=1:height-domain_block_size+1
%                         for jj=1:width-domain_block_size+1
%                             y=round(ii*s(1,1)/height);
%                             x=round(jj*s(1,1)/width);
%                             WH(ii,jj)=mean(mean(f2(y:min(y+range_block_size(RB_size)-1,s(1,1)),x:min(x+range_block_size(RB_size)-1,s(1,1)))));
%                             WV(ii,jj)=mean(mean(f3(y:min(y+range_block_size(RB_size)-1,s(1,1)),x:min(x+range_block_size(RB_size)-1,s(1,1)))));
%                         end
%                         clc;
%                         'Finding Coeffs Domain'
%                         round(100*ii/(height-range_block_size(RB_size)+1))
%                     end
%                     save(filename,'WH','WV');
%                 else
%                     load(filename);
%                 end
%                 
%                 
% 
% 
% 
% 
% %                 filename=['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'WaveletQEA2_result_code' image_name(im_name).name num2str(image_size(im_size)) '.mat'];
% %                 if exist(filename)==0
% %                     encoded=Fcompression_WaveletQEA2(it,pop_no(pop_size),X,range_block_size(RB_size),WHR,WVR,WH,WV);
% %                     decoded=Fcompression_decode(encoded,iteration,false,true);
% %                     psnr_WaveletQEA2=Fcompression_psnr(decoded,X);
% %                     imwrite(uint8(decoded),['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'WaveletQEA2_result' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
% %                     save(filename,'encoded','psnr_WaveletQEA2');
% %                 else
% %                     load(filename);
% %                 end
%                 filename=['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'WaveletQEA1' image_name(im_name).name num2str(image_size(im_size)) '.mat'];
%                 if exist(filename)==0
%                     encoded=Fcompression_WaveletQEA1(it,pop_no(pop_size),X,range_block_size(RB_size),WHR,WVR,WH,WV);
%                     decoded=Fcompression_decode(encoded,iteration,false,true);
%                     psnr_WaveletQEA1=Fcompression_psnr(decoded,X);
%                     imwrite(uint8(decoded),['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'WaveletQEA1' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
%                     save(filename,'encoded','psnr_WaveletQEA1');
%                 else
%                     load(filename);
%                 end
%                 filename=['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'QEA' image_name(im_name).name num2str(image_size(im_size)) '.mat'];
%                 if exist(filename)==0
%                     encoded=Fcompression_QEA(it,pop_no(pop_size),X,range_block_size(RB_size));
%                     decoded=Fcompression_decode(encoded,iteration,false,true);
%                     psnr_QEA=Fcompression_psnr(decoded,X);
%                     imwrite(uint8(decoded),['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'QEA' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
%                     save(filename,'encoded','psnr_QEA');
%                 else
%                     load(filename);
%                 end
% %                 filename=['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'Genetic_result_code' image_name(im_name).name num2str(image_size(im_size)) '.mat'];
% %                 if exist(filename)==0
% %                     encoded=Fcompression_genetic(it,pop_no(pop_size),X,range_block_size(RB_size),0.05);
% %                     decoded=Fcompression_decode(encoded,iteration,false,true);
% %                     psnr_GA=Fcompression_psnr(decoded,X);
% %                     imwrite(uint8(decoded),['E:\Process\other\fractal\Results\' num2str(range_block_size(RB_size)) 'Genetic_result' image_name(im_name).name num2str(image_size(im_size)) '.jpg']);
% %                     save(filename,'encoded','psnr_GA');
% %                 else
% %                     load(filename);
% %                 end
%                 counter=counter+1;
%                 Table(counter,1)=psnr_WaveletQEA1;
%                 Table(counter,2)=psnr_QEA;
%                 Table(counter,3)=range_block_size(RB_size);
%                 Table(counter,4)=image_size(im_size);
%                 Table(counter,5)=im_name;
%                 filename=['E:\Process\other\fractal\Results\Table.mat'];
%                 save(filename,'Table');
%             end
%         end
%     end
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % domain1=X(43:43+domain_block_size-1,46:46+domain_block_size-1);
% % counter=1;
% % for x=1:domain_horizontal
% %     for y=1:domain_vertical
% %         domain=X(indexy(counter):indexy(counter)+domain_block_size-1,indexx(counter):indexx(counter)+domain_block_size-1);
% %         help2d(y,x)=Fcompression_find_best_fit(domain,domain1);
% %         help2d2(y,x)=Fcompression_find_best_fit(X(y:y+domain_block_size-1,x:x+domain_block_size-1),domain1);
% %         counter=counter+1;
% %     end
% %     clc;
% %     round(100*x/(domain_horizontal))
% % end
% % 
% % for ii=1:2500
% %     help2d2(ii)=mean(help2d((ii-1)*100+1:ii*100));
% %     help2d3(ii)=mean(help2d1((ii-1)*100+1:ii*100));
% % end
% % 
% % 
% % 
% % 
% % 
% % for x=1:domain_horizontal
% %     for y=1:domain_vertical
% %         domain=f(y:y+domain_block_size-1,x:x+domain_block_size-1);
% %         M=mean(mean(domain));
% %         help(y,x)=(sum(sum((domain-M).^2))/(domain_block_size^2))^0.5;
% % 
% %     end
% % end
% del=0;
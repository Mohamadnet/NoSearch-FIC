function [domain_index rotation S_co O_co Min]= Fractal_domain_search(X,W,coe_alpha,SR,RB,n,f_type,X_size,d_block)
if f_type==1
Min=inf;
                for k=1:X_size-d_block+1   
                 for l=1:X_size-d_block+1
                     if W(floor(k/2)+1,floor(l/2)+1).f2_mean>=coe_alpha
						d=X(k:(k-1)+d_block,l:(l-1)+d_block);
						temp_d=imresize(d,0.5);
						sum_d=sum(sum(temp_d));
						sum_d_2=sum(sum((temp_d).^2));
						sent2=SR*sum_d;
						sent4=sum_d^2;
                        for h=1:2:3
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
                             domain_index=[k l];
                             rotation=h;
                             S_co=S;
                             O_co=O;
                         end
                        end
%                      elseif W(floor(k/2)+1,floor(l/2)+1).f3_mean>=coe_alpha
% 						d=X(k:(k-1)+d_block,l:(l-1)+d_block);
% 						temp_d=imresize(d,0.5);
% 						sum_d=sum(sum(temp_d));
% 						sum_d_2=sum(sum((temp_d).^2));
% 						sent2=SR*sum_d;
% 						sent4=sum_d^2;
%                         for h=2:2:4
% 					      D_rotated=rotate_block(temp_d,h);
%                           sent1=n*sum(sum(RB.*D_rotated));
%                           S=(sent1-sent2)/(n * sum_d_2-sent4);
%                           O=(SR-S*sum_d)/n;
%                            help1=sum(sum((D_rotated*S - RB +O).^2));
%                           help2=sum(sum((D_rotated -  RB).^2));
%                          if help1 > help2
%                                 S=1;
%                                O=0;
%                              RMS=help2;
%                          else
%                             RMS=help1;
%                          end
%                          if RMS<Min
%                              Min=RMS;
%                              domain_index=[k l];
%                              rotation=h;
%                              S_co=S;
%                              O_co=O;
%                          end
%                         end
                     end
                 end
                end
elseif f_type==2
    55
    Min=inf;
                for k=1:X_size-d_block+1   
                 for l=1:X_size-d_block+1
                     if W(floor(k/2)+1,floor(l/2)+1).f3_mean>=coe_alpha
						d=X(k:(k-1)+d_block,l:(l-1)+d_block);
						temp_d=imresize(d,0.5);
						sum_d=sum(sum(temp_d));
						sum_d_2=sum(sum((temp_d).^2));
						sent2=SR*sum_d;
						sent4=sum_d^2;
                     for h=1:2:3
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
                               domain_index=[k l];
                               rotation=h;
                               S_co=S;
                               O_co=O;
                           end                     
					 end
%                      elseif W(floor(k/2)+1,floor(l/2)+1).f2_mean>=coe_alpha
% 						d=X(k:(k-1)+d_block,l:(l-1)+d_block);
% 						temp_d=imresize(d,0.5);
% 						sum_d=sum(sum(temp_d));
% 						sum_d_2=sum(sum((temp_d).^2));
% 						sent2=SR*sum_d;
% 						sent4=sum_d^2;
%                         for h=2:2:4
%                           D_rotated=rotate_block(temp_d,h);
%                           sent1=n*sum(sum(RB.*D_rotated));
%                           S=(sent1-sent2)/(n * sum_d_2-sent4);
%                           O=(SR-S*sum_d)/n;
%                            help1=sum(sum((D_rotated*S - RB +O).^2));
%                           help2=sum(sum((D_rotated -  RB).^2));
%                          if help1 > help2
%                                 S=1;
%                                O=0;
%                              RMS=help2;
%                          else
%                             RMS=help1;
%                          end
%                          if RMS<Min
%                              Min=RMS;
%                              domain_index=[k l];
%                              rotation=h;
%                              S_co=S;
%                              O_co=O;
%                          end  
%                         end
                     end
                 end
                end
elseif f_type==3
    55
    Min=inf;
                for k=1:X_size-d_block+1   
                 for l=1:X_size-d_block+1
						d=X(k:(k-1)+d_block,l:(l-1)+d_block);
						temp_d=imresize(d,0.5);
						sum_d=sum(sum(temp_d));
						sum_d_2=sum(sum((temp_d).^2));
						sent2=SR*sum_d;
						sent4=sum_d^2;
                     if W(floor(k/2)+1,floor(l/2)+1).f4_mean>=coe_alpha
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
                             domain_index=[k l];
                             rotation=h;
                             S_co=S;
                             O_co=O;
                         end   
                        end
                     end
                 end
                end
end

end
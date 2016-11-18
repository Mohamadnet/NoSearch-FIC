function result=fuzzy_final_decompose_show(s,c);
start1=1;
end1=s(1,1)*s(1,1);
start2=end1;
end2=start2+s(1,1)*s(1,1);
start3=end2;
end3=start3+s(1,1)*s(1,1);
start4=end3;
end4=start4+s(1,1)*s(1,1);

for ii=1:s(1,1)
    for jj=1:s(1,1)
        f1(jj,ii)=c(jj+(ii-1)*s(1,1));
    end
end

for ii=1:s(1,1)
    for jj=1:s(1,1)
        f2(jj,ii)=c(start2+jj+(ii-1)*s(2,1));
    end
end

for ii=1:s(1,1)
    for jj=1:s(1,1)
        f3(jj,ii)=c(start3+jj+(ii-1)*s(1,1));
    end
end

for ii=1:s(1,1)
    for jj=1:s(1,1)
        f4(jj,ii)=c(start4+jj+(ii-1)*s(1,1));
    end
end


result.f1=f1;
result.f2=f2;
result.f3=f3;
result.f4=f4;
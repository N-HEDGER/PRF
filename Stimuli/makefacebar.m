function [bar] = makefacebar(stim,barwidth,barlength,vd,xres,dispx,horzbar);

[len]=round(visang2pix(barlength,barlength,vd,xres,dispx));
[width]=round(visang2pix(barwidth,barwidth,vd,xres,dispx));



width=width(1);
len=len(1);


% horzbar=0;
bar2=cell(1,1);
numsquaresW=1;

unit_size=width/numsquaresW;

numsquaresL=round(len/unit_size);




if horzbar==1;
k=cell(numsquaresW,numsquaresL);
for i=1:numsquaresW
    for j=1:numsquaresL
k{i,j}=makefacegrid(stim,width,width,randi([1,2]),1);
    end    
end


bar=cell2mat(k);

bar2=imresize(bar,[width,NaN]);
elseif horzbar==0;

    k2=cell(numsquaresL,numsquaresW);
    
    
    
    for i=1:numsquaresW
        for j=1:numsquaresL
            k2{j,i}=makefacegrid(stim,width,width,randi([1,2]),1);
        end
    end
    
bar=cell2mat(k2);

bar2=imresize(bar,[NaN,width]);
end


end


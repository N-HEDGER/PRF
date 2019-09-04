function [bar] = facebarbar(elementsize,barwidth,barlength,vd,xres,dispx,isplot)


[elsize]=visang2pix(elementsize,elementsize,vd,xres,dispx);

[len]=visang2pix(barlength,barlength,vd,xres,dispx);
[width]=visang2pix(barwidth,barwidth,vd,xres,dispx);

numsquaresL=round(len/elsize);
numsquaresW=round(width/elsize);

k=cell(numsquaresW,numsquaresL);
for i=1:numsquaresW
    for j=1:numsquaresL
k{i,j}=colnoise(elementsize,1,randsample(0:0.1:4,1),vd,xres,dispx,0);
    end
end

bar=cell2mat(k);
if isplot
    imshow(bar)
else
end
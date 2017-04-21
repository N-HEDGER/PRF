function [im] = colnoise(imsize,rms,factor,vd,xres,dispx,isplot)
[pix]=visang2pix(1,1,vd,xres,dispx);
imsize=round(imsize*pix(1));

k=noiseonf2(imsize,rms,factor);
l=gray2rgb(k);
l(:,:,1)=noiseonf2(imsize,rms,factor);
l(:,:,2)=noiseonf2(imsize,rms,factor);
l(:,:,3)=noiseonf2(imsize,rms,factor);

im=l;
if isplot
    imshow(im)
else
end
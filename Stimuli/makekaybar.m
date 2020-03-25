function [bar] = makekaybar(stim,barwidth,barlength,vd,xres,dispx,grid_sizeX,grid_sizeY,horzbar);

[len]=round(visang2pix(barlength,barlength,vd,xres,dispx));
[width]=round(visang2pix(barwidth,barwidth,vd,xres,dispx));




scaled_pattern=imresize(stim(:,:,:,randi(100)),[grid_sizeX,grid_sizeY]);

size_scaled=size(scaled_pattern);


stripstart=linspace(1,size_scaled(1)-width(1),10);
start=round(stripstart(randi(10)));


    

if horzbar
    bar=scaled_pattern(start:(start+width(1)),:,:);
    
else
    
     bar=scaled_pattern(:,start:(start+width(1)),:);
     
end












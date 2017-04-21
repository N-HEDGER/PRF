function [pix,dpi] = degperim(viewingdistance,width,imagesize)
% works out the degrees per image and pixels per image.
% width and image size must be in the same units.

% screens = Screen('Screens');
%     whichscreen = max(screens);
%     rect=Screen('rect',whichscreen);
    
pix=visang2pix(1,1,viewingdistance,1280,width);

dpi=imagesize/pix(1);
return



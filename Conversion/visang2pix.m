function [pix] = visang2pix(sizex,sizey,viewingdistance,screenres,screenwidth)


visang_screen= 2 * atan(screenwidth/2/viewingdistance);
visang_deg_screen = visang_screen * (180/pi);
visang_perpix = visang_deg_screen / screenres;
pixx=sizex/visang_perpix;
pixy=sizey/visang_perpix;
pix=[pixx,pixy];
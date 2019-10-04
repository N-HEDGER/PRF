scr.main = max(Screen('Screens'));
[scr.scr_sizeX, scr.scr_sizeY]=Screen('WindowSize', scr.main);
% Get useful screen coords.
scr.x_mid = (scr.scr_sizeX/2.0);
scr.y_mid = (scr.scr_sizeY/2.0);
scr.mid = [scr.x_mid,scr.y_mid];

% Vertical size of screen.
scr.dispsize=46;

% Viewing distance
scr.vd=80;

scr.rect=Screen(scr.main,'Rect');



visang_screen= 2 * atan(scr.dispsize/2/scr.vd);

scr.visang_deg_screen = visang_screen * (180/pi);




gridsizepix=visang2pix(const.const.displaysize,const.const.displaysize,scr.scr_sizeX,scr.dispsize);

gridsizepix=round(gridsizepix(1));
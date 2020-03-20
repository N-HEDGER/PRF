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


gridsizepix=visang2pix(const.displaysize,const.displaysize,scr.vd,scr.scr_sizeX,scr.dispsize);

gridsizepix=round(gridsizepix(1));


grid_sizeX=gridsizepix;
grid_sizeY=gridsizepix;


scr.padl=[0,0,scr.x_mid-(grid_sizeX/2),scr.scr_sizeY];
% scr.padl=[0,0,scr.x_mid-(grid_sizeX/2),scr.scr_sizeY];


rgb=repmat(0.5,1080,1920,4);

top    = (scr.y_mid - (grid_sizeY/2));
bottom = (scr.y_mid + (grid_sizeY/2));
left   = (scr.x_mid - (grid_sizeX/2));
right  = (scr.x_mid + (grid_sizeX/2));



alpha=repmat(1,1080,1920,1);

alpha(top:bottom,left:right) = 0; 





 [scr.window, scr.rect] = Screen('OpenWindow', scr.main, [const.opacity*255 const.opacity*255 const.opacity*255],[]);
 Screen('BlendFunction', scr.window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
 Screen('FillOval', scr.window, [0,0,0], [left, top, right, bottom]);
 Screen('Flip',scr.window);
 myaperture=Screen('GetImage', scr.window);
 
 
 
 [unit]=round(visang2pix(1,1,scr.vd,scr.scr_sizeX,scr.dispsize));
 unit=unit(1);
 
 
 Screen('DrawLine',scr.window,[255 0 0],scr.mid(1),scr.mid(2),scr.mid(1),scr.mid(2)+unit);
 Screen('DrawLine',scr.window,[255 0 0],scr.mid(1),scr.mid(2),scr.mid(1),scr.mid(2)-unit);
  Screen('DrawLine',scr.window,[255 0 0],scr.mid(1),scr.mid(2),scr.mid(1)+unit,scr.mid(2));
 Screen('DrawLine',scr.window,[255 0 0],scr.mid(1),scr.mid(2),scr.mid(1)-unit,scr.mid(2));
 Screen('Flip',scr.window);
 
 myaperture2=im2double(myaperture(:,:,1));
 
 rgb(:,:,4)=myaperture2;
 
KbWait
Screen('CloseAll')
 
 
% 
%  xstim=Screen('MakeTexture',scr.window,im2uint8(rgb));
% 
% 
% Screen('DrawTexture', scr.window,xstim, [],[]);
% Screen('Flip',scr.window)
% 









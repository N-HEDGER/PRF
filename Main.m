
%% Add paths

addpath('Config','Data','Stimuli','Conditions','Conversion');

%% Constants

Const_config

%% Key
Key_config

%% Set up screen 

Scr_config

%% Make stimuli

Make_bars

%% Pass config

Pass_config


prompt='subject filename?';
filename = input(prompt,'s');

% Spit some initial information into a text file.
log_text=sprintf('Data/%s_log.txt',filename);
log_text_fid=fopen(log_text,'a+');




[scr.window, scr.rect] = Screen('OpenWindow', scr.main, [128 128 128]);
priorityLevel=MaxPriority(scr.window);
Priority(priorityLevel);
slack = Screen('GetFlipInterval', scr.window);

for i=1:const.Nbars
    STIMULI{i}=Screen('MakeTexture',scr.window,im2uint8(bars{i}));
end




Screen('DrawText', scr.window, 'texturesloaded',scr.x_mid, scr.y_mid);
Textpres=Screen('Flip', scr.window,[],[]);
KbWait(keyboard);

stimpres=0;
tic
startclock=clock;
log_txt=sprintf('Trial start at %s',num2str(startclock));
 
 fprintf(log_text_fid,'%s\n',log_txt);
 i=0;
 while i<(const.totaldrawsv)
     i=i+1;
      [keyIsDown, ~,keyCode] = KbCheck(responsebox,scanlist);
       if keyIsDown
           if keyCode(Responsekey)
               % write in log/edf
              log_txt = sprintf('Button press at %s',num2str(etime(clock,startclock)));
               fprintf(log_text_fid,'%s\n',log_txt);
          end
       end
%  

 
 
    
 Screen('DrawTexture', scr.window,STIMULI{randi(const.Nbars)}, [], scr.stimrectv+[const.locationsv(i) 0 const.locationsv(i) 0],[]);
 Screen('DrawDots',scr.window,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);   
%  WaitSecs((TR/DRAWSPERTR)-slack);
 
 stimpres=Screen('Flip', scr.window,[stimpres+(const.TR/const.drawsperTR)-slack]);
 log_txt=sprintf('Flip at Position %f at %s',const.locationsv(i),num2str(etime(clock,startclock)));
 fprintf(log_text_fid,'%s\n',log_txt);

end

log_txt=sprintf('Trial end at %s',num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);

Screen('CloseAll');
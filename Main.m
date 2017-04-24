
%% Add paths

addpath('Config','Data','Stimuli','Conditions','Conversion');

%% Constants

Const_config

%% Design

Design_config
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

STIMULI=cell(2,const.Nbars);
for i=1:const.Nbars
    STIMULI{1,i}=Screen('MakeTexture',scr.window,im2uint8(bars{i}));
    STIMULI{2,i}=Screen('MakeTexture',scr.window,imrotate(im2uint8(bars{i}),90));
end




Screen('DrawText', scr.window, 'texturesloaded',scr.x_mid, scr.y_mid);
Textpres=Screen('Flip', scr.window,[],[]);
KbWait(keyboard);


for t=1:length(const.conditions)
    
% Vertical bar, left to right.
if const.conditions (t,2)==1 && const.conditions (t,3)==1
trial.locations=(const.locationsv);
trial.totaldraws=const.totaldrawsv;
trial.stimrect=scr.stimrectv;
% Vertical bar, right to left.
elseif const.conditions (t,2)==1 && const.conditions (t,3)==2
trial.locations=fliplr(const.locationsv);
trial.totaldraws=const.totaldrawsv;
trial.stimrect=scr.stimrectv
% Horizontal bar, bottom to top
elseif const.conditions (t,2)==2 && const.conditions (t,3)==1
trial.locations=(const.locationsh);
trial.totaldraws=const.totaldrawsh;
trial.stimrect=scr.stimrecth;
% Horizontal bar, top to bottom
elseif const.conditions (t,2)==2 && const.conditions (t,3)==2
trial.locations=fliplr(const.locationsh);
trial.totaldraws=const.totaldrawsh;
trial.stimrect=scr.stimrecth;
end


stimpres=0;
tic
startclock=clock;
log_txt=sprintf('Trial %i start at %s',t,num2str(startclock));
fprintf(log_text_fid,'%s\n',log_txt);
 
 i=0;
 while i<(trial.totaldraws)
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

if const.conditions (t,2)==1
Screen('DrawTexture', scr.window,STIMULI{1,randi(const.Nbars)}, [], trial.stimrect+[trial.locations(i) 0 trial.locations(i) 0],[]);
else
Screen('DrawTexture', scr.window,STIMULI{2,randi(const.Nbars)}, [], trial.stimrect+[0 trial.locations(i) 0 trial.locations(i)],[]);
end

Screen('DrawDots',scr.window,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);

 
stimpres=Screen('Flip', scr.window,[stimpres+(const.TR/const.drawsperTR)-slack]);
log_txt=sprintf('Flip at Position %f at %s',trial.locations(i),num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);

end

log_txt=sprintf('Trial end at %s',num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);

end

Screen('CloseAll');
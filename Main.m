Screen('Preference', 'SkipSyncTests', 1);
%% Mode for returning stimuli.
istest=0;
getstimuli=0;
mapper=1;
%% Add paths

addpath('Config','Data','Stimuli','Conditions','Conversion','Hardware');

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

%% Syncbox config

if istest
   
else
     Syncbox_config
     fopen(s2);
end



prompt='subject filename?';
filename = input(prompt,'s');

% Spit some initial information into a text file.

mkdir(strcat('Data/',filename))
log_text=sprintf('Data/%s/log.txt',filename);
log_text_fid=fopen(log_text,'a+');



if getstimuli
[scr.window, scr.rect] = Screen('OpenWindow', scr.main, [0 0 0]);
else
[scr.window, scr.rect] = Screen('OpenWindow', scr.main, [128 128 128]);
end

priorityLevel=MaxPriority(scr.window);
Priority(priorityLevel);
slack = Screen('GetFlipInterval', scr.window);

STIMULI=cell(2,const.Nbars);
for i=1:const.Nbars
    STIMULI{1,i}=Screen('MakeTexture',scr.window,im2uint8(bars{i}));
    STIMULI{2,i}=Screen('MakeTexture',scr.window,imrotate(im2uint8(bars{i}),90));
end



%% If pRF
if mapper==0

Screen('DrawText', scr.window, 'Press button to recieve pulses',scr.x_mid, scr.y_mid);
Textpres=Screen('Flip', scr.window,[],[]);
KbWait(keyboard);



 for t=1:length(const.conditions)

if istest || getstimuli
else
GETPULSE
end     
     
% Vertical bar, left to right.
if const.conditions (t,3)==1 && const.conditions (t,4)==1 && const.conditions (t,2)==1
trial.locations=(const.locationsv);
trial.totaldraws=const.totaldrawsv;
trial.stimrect=scr.stimrectv;
% Vertical bar, right to left.
elseif const.conditions (t,3)==1 && const.conditions (t,4)==2 && const.conditions (t,2)==1
trial.locations=fliplr(const.locationsv);
trial.totaldraws=const.totaldrawsv;
trial.stimrect=scr.stimrectv
% Horizontal bar, bottom to top
elseif const.conditions (t,3)==2 && const.conditions (t,4)==1 && const.conditions (t,2)==1
trial.locations=(const.locationsh);
trial.totaldraws=const.totaldrawsh;
trial.stimrect=scr.stimrecth;
% Horizontal bar, top to bottom
elseif const.conditions (t,3)==2 && const.conditions (t,4)==2 && const.conditions (t,2)==1
trial.locations=fliplr(const.locationsh);
trial.totaldraws=const.totaldrawsh;
trial.stimrect=scr.stimrecth;

elseif const.conditions (t,2)==0
trial.locations=fliplr(const.locationsh);
trial.totaldraws=const.totaldrawsh;
trial.stimrect=scr.stimrecth;


end

%% If real trial


if const.conditions (t,2)==1
    

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

if const.conditions (t,3)==1
Screen('DrawTexture', scr.window,STIMULI{1,randi(const.Nbars)}, [], trial.stimrect+[trial.locations(i) 0 trial.locations(i) 0],[]);
else
Screen('DrawTexture', scr.window,STIMULI{2,randi(const.Nbars)}, [], trial.stimrect+[0 trial.locations(i) 0 trial.locations(i)],[]);
end

Screen('DrawDots',scr.window,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);


if getstimuli
stimpres=Screen('Flip', scr.window,[]);
else
stimpres=Screen('Flip', scr.window,[stimpres+(const.TR/const.drawsperTR)-slack]);
end


if getstimuli
BARIMAGES{i,t}=Screen('GetImage', scr.window);
else
end
log_txt=sprintf('Flip at Position %f at %s',trial.locations(i),num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);

if istest || getstimuli
else
    if mod(i,const.drawsperTR)==0 && i~=1 && i~=trial.totaldraws
        GETPULSE
        stimpres=0;
    else
    end
end
    

 end

 
      
log_txt=sprintf('Trial end at %s',num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);

%% Null trials



else
    
stimpres=0;
tic
startclock=clock;
log_txt=sprintf('Null Trial %i start at %s',t,num2str(startclock));
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

% if const.conditions (t,3)==1
% Screen('DrawTexture', scr.window,STIMULI{1,randi(const.Nbars)}, [], trial.stimrect+[trial.locations(i) 0 trial.locations(i) 0],[]);
% else
% Screen('DrawTexture', scr.window,STIMULI{2,randi(const.Nbars)}, [], trial.stimrect+[0 trial.locations(i) 0 trial.locations(i)],[]);
% end

Screen('DrawDots',scr.window,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
Screen('DrawDots',scr.window,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);


if getstimuli
stimpres=Screen('Flip', scr.window,[]);
else
stimpres=Screen('Flip', scr.window,[stimpres+(const.TR/const.drawsperTR)-slack]);
end


if getstimuli
BARIMAGES{i,t}=Screen('GetImage', scr.window);
else
end
log_txt=sprintf('Flip at Position %f at %s',trial.locations(i),num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);

if istest || getstimuli
else
    if mod(i,const.drawsperTR)==0 && i~=1 && i~=trial.totaldraws
        GETPULSE
        stimpres=0;
    else
    end
end


 end


 
log_txt=sprintf('Trial end at %s',num2str(etime(clock,startclock)));
fprintf(log_text_fid,'%s\n',log_txt);




end
 end

Screen('CloseAll');

if getstimuli
    MAKEBINSTIMFRAMES
else
end

%% If it is the mapper

elseif mapper==1
    Screen('DrawText', scr.window, 'Press button to recieve pulses',scr.x_mid, scr.y_mid);
    Textpres=Screen('Flip', scr.window,[],[]);
    KbWait(keyboard);
    
    
    for t=1:length(const.conditions)
        %     Wait for pulse
        if istest
        else
            GETPULSE
            
        end
        
        %Null or real trial
        if const.conditions (t,2)==1
            stimpres=0;
            tic
            startclock=clock;
            log_txt=sprintf('Trial %i start at %s',t,num2str(startclock));
            fprintf(log_text_fid,'%s\n',log_txt);
            i=0;
            while i<(const.drawsperTR)
                i=i+1;
                [keyIsDown, ~,keyCode] = KbCheck(responsebox,scanlist);
                if keyIsDown
                    if keyCode(Responsekey)
                        % write in log/edf
                        log_txt = sprintf('Button press at %s',num2str(etime(clock,startclock)));
                        fprintf(log_text_fid,'%s\n',log_txt);
                    end
                end
                
                
                Screen('DrawTexture', scr.window,STIMULI{1,randi(const.Nbars)}, [], scr.rect,[]);
                
                Screen('DrawDots',scr.window,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
                Screen('DrawDots',scr.window,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
                Screen('DrawDots',scr.window,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);
                stimpres=Screen('Flip', scr.window,[stimpres+(const.TR/const.drawsperTR)-slack]);
                
                log_txt=sprintf('Flip at at %s',num2str(etime(clock,startclock)));
                fprintf(log_text_fid,'%s\n',log_txt);
     
                    
                
            end
        else
            stimpres=0;
            tic
            startclock=clock;
            log_txt=sprintf('Null Trial %i start at %s',t,num2str(startclock));
            fprintf(log_text_fid,'%s\n',log_txt);
            i=0;
            while i<(const.drawsperTR)
                i=i+1;
                [keyIsDown, ~,keyCode] = KbCheck(responsebox,scanlist);
                if keyIsDown
                    if keyCode(Responsekey)
                        % write in log/edf
                        log_txt = sprintf('Button press at %s',num2str(etime(clock,startclock)));
                        fprintf(log_text_fid,'%s\n',log_txt);
                    end
                end
                
                Screen('DrawDots',scr.window,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
                Screen('DrawDots',scr.window,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
                Screen('DrawDots',scr.window,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);
                stimpres=Screen('Flip', scr.window,[stimpres+(const.TR/const.drawsperTR)-slack]);
                
                log_txt=sprintf('Flip at at %s',num2str(etime(clock,startclock)));
                fprintf(log_text_fid,'%s\n',log_txt);
   
                
            end
            
        end
        
        log_txt=sprintf('Trial end at %s',num2str(etime(clock,startclock)));
        fprintf(log_text_fid,'%s\n',log_txt);

    end
    Screen('CloseAll');
    
    
    
end
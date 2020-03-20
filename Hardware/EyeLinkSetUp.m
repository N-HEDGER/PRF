dummymode=0;

% Pixels size:
scr.clr_depth = Screen('PixelSize', scr.scr_num);

if ~IsOctave
    commandwindow;
else
    more off;
end
stopkey=KbName('space');
firstRun = 1;
infix=0;


try
    
    %%%%%%%%%%
    % STEP 1 %
    %%%%%%%%%%
    
    % Added a dialog box to set your own  file name before opening
    % experiment graphics. Make sure the entered EDF file name is 1 to 8
    % characters in length and only numbers or letters are allowed.


   edfFile = char(strcat(const.sbj.subname)); 
    %%%%%%%%%%
    % STEP 2 %
    %%%%%%%%%%
    
    Screen(scr.main,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [winWidth, winHeight] = WindowSize(scr.main);
    wRect = scr.rect;
    % create fixation dot and fixation window rectangles
 
    fixationDot = [-const.dotSize -const.dotSize const.dotSize const.dotSize];
    fixationDot = CenterRect(fixationDot, scr.rect);    
    fixationWindow = [-const.fixWinSize -const.fixWinSize const.fixWinSize const.fixWinSize];
    fixationWindow = CenterRect(fixationWindow,scr.rect);
    
    
    %%%%%%%%%%
    % STEP 3 %
    %%%%%%%%%%
    
    % Provide Eyelink with details about the graphics environment
    % and perform some initializations. The information is returned
    % in a structure that also contains useful defaults
    % and control codes (e.g. tracker state bit and Eyelink key values).
    
    el=EyelinkInitDefaults(scr.main);
    
    % We are changing calibration to a black background with white targets,
    % no sound and smaller targets
    el.backgroundcolour = const.background_color;
    el.calibrationtargetcolour = [0 0 0];
    el.imgtitlecolour = WhiteIndex(el.window);
    el.targetbeep = 0;
    el.feedbackbeep=0;
   
    el.calibrationtargetcolour = WhiteIndex(el.window);
    
    % for lower resolutions you might have to play around with these values
    % a little. If you would like to draw larger targets on lower res
    % settings please edit PsychEyelinkDispatchCallback.m and see comments
    % in the EyelinkDrawCalibrationTarget function
    el.calibrationtargetsize= 1.5;
    el.calibrationtargetwidth=0.75;
    % call this function for changes to the calibration structure to take
    % affect
    EyelinkUpdateDefaults(el)
    
    %%%%%%%%%%
    % STEP 4 %
    %%%%%%%%%%
    
    % Initialization of the connection with the Eyelink Gazetracker.
    % exit program if this fails.
    
    if ~EyelinkInit(dummymode)
        fprintf('Eyelink Init aborted.\n');
        cleanup;  % cleanup function
        return;
    end
      
    % open file to record data to
    b = Eyelink('Openfile', edfFile);
    if b~=0
        fprintf('Cannot create EDF file ''%s'' ', edffilename);
        cleanup;
        return;
    end
    
    % make sure we're still connected.
    if Eyelink('IsConnected')~=1 && ~dummymode
        cleanup;
        return;
    end;
        
    %%%%%%%%%%
    % STEP 5 %
    %%%%%%%%%%
    
    % SET UP TRACKER CONFIGURATION
    % Setting the proper recording resolution, proper calibration type,
    % as well as the data file content;
    Eyelink('command', 'add_file_preamble_text ''Recording for Krishna Experiment''');
   
    % This command is crucial to map the gaze positions from the tracker to
    % screen pixel positions to determine fixation
    Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, winWidth-1, winHeight-1);
    
    Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, winWidth-1, winHeight-1);
    % set calibration type.
        
      if const.Calfive == 1
            % Try 5-point calibration, with scaled values
            Eyelink('command', 'calibration_type = HV5');
            Eyelink('command', 'generate_default_targets = YES');
            
            % you must send this command with value NO for custom calibration
            % you must also reset it to YES for subsequent experiments
     

            width = winWidth;%scr.frame_rect1(3) - scr.frame_rect1(1);
            height = winHeight;%scr.frame_rect1(4) - scr.frame_rect1(2);
      elseif const.Calfive==2
            % Try smaller range of HV values with 9-point calibration
            Eyelink('command', 'calibration_type = HV9');
            % you must send this command with value NO for custom calibration
            % you must also reset it to YES for subsequent experiments
            % Default to 9-point EyeLink Cal
            Eyelink('command', 'calibration_type = HV9');   
            Eyelink('command', 'generate_default_targets = YES');
      end
% 
%     
    %Eyelink('command', 'generate_default_targets = YES');
    % set parser (conservative saccade thresholds)
    Eyelink('command', 'saccade_velocity_threshold = 35');
    Eyelink('command', 'saccade_acceleration_threshold = 9500');
    % set EDF file contents
        % 5.1 retrieve tracker version and tracker software version
    [v,vs] = Eyelink('GetTrackerVersion');
    fprintf('Running experiment on a ''%s'' tracker.\n', vs );
    vsn = regexp(vs,'\d','match');
    
    if v ==3 && str2double(vsn{1}) == 4 % if EL 1000 and tracker version 4.xx
        
        % remote mode possible add HTARGET ( head target)
        Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT,HTARGET');
        % set link data (used for gaze cursor)
        Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,FIXUPDATE,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT,HTARGET');
    else
        Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT');
        % set link data (used for gaze cursor)
        Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,FIXUPDATE,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT');
    end
    
    % calibration/drift correction target
    Eyelink('command', 'button_function 5 "accept_target_fixation"');
    
    %%%%%%%%%%
    % STEP 6 %
    %%%%%%%%%%
    
    if ~dummymode
        % Hide the mouse cursor and setup the eye calibration window
        %Screen('HideCursorHelper', window);
    end
    
%     % enter Eyetracker camera setup mode, calibration and validation
     EyelinkDoTrackerSetup(el);
     
    
catch
    %cleanup;
    fprintf('%s: some error occured\n', mfilename);
    psychrethrow(lasterror); %#ok<*LERR>
    
end









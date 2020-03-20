  %%%%%%%%%
    % STEP 7%
    %%%%%%%%%
    
    % Now starts running individual trials
    % You can keep the rest of the code except for the implementation
    % of graphics and event monitoring
    % Each trial should have a pair of "StartRecording" and "StopRecording"
    % calls as well integration messages to the data file (message to mark
    % the time of critical events and the image/interest area/condition
    % information for the trial)

    index = i;

        % wait a second between trials
        WaitSecs(1);
        % STEP 7.1
        % Sending a 'TRIALID' message to mark the start of a trial in Data
        % Viewer.  This is different than the start of recording message
        % START that is logged when the trial recording begins. The viewer
        % will not parse any messages, events, or samples, that exist in
        % the data file prior to this message.       
        Eyelink('Message', 'TRIALID %d', index);
        % This supplies the title at the bottom of the eyetracker display
        Eyelink('command', 'record_status_message "TRIAL %d"', index);
        Eyelink('Command', 'set_idle_mode');
        % clear tracker display and draw box at center
        %Eyelink('Command', 'clear_screen %d', 0);
        % draw fixation and fixation window shapes on host PC
        %Eyelink('command', 'draw_cross %d %d 15', winWidth/2,winHeight/2);
        %Eyelink('command', 'draw_box %d %d %d %d 15', fixationWindow(1), fixationWindow(2), fixationWindow(3), fixationWindow(4));
            
        % STEP 7.2
        % Do a drift correction at the beginning of each trial
        % Performing drift correction (checking) is optional for
        % EyeLink 1000 eye trackers. Drift correcting at different
        % locations x and y depending on where the ball will start
        % we change the location of the drift correction to match that of
        % the target start position
        Eyelink('command', 'drift_correction_rpt_error = 0.5');
        EyelinkDoDriftCorrection(el);
        showtrialims
        % STEP 7.3
        % start recording eye position (preceded by a short pause so that
        % the tracker can finish the mode transition)
        % The paramerters for the 'StartRecording' call controls the
        % file_samples, file_events, link_samples, link_events availability
       
        %Eyelink('Command', 'set_idle_mode');
        WaitSecs(0.05);
        Eyelink('StartRecording');
        eye_used = Eyelink('EyeAvailable'); % get eye that's tracked  
        % returns 0 (LEFT_EYE), 1 (RIGHT_EYE) or 2 (BINOCULAR) depending on what data is
        if eye_used == 2
            eye_used = 1; % use the right_eye data
        end
        % record a few samples before we actually start displaying
        % otherwise you may lose a few msec of data
        WaitSecs(0.1);
        

       
        


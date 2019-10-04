% Const config

%% Bar properties


const.displaysize=15;


% Size of elements within the bar
const.elementsize=1;

% Width of bar
const.barwidth=3;

% Length of Bar
const.barlength=36;

% How many bars shall we draw?
const.Nbars=100;
if getstimuli
    const.Nbars=1
elseif mapper
    % const.Nbars=10;
else
end

%% Fixation properties

fixchangeval=25;

if getstimuli
    
const.bigfixcol=[0 0 0];
const.smallfixcol=[0 0 0];
const.smallerfixcol=[0 0 0];
else
const.bigfixcol=[0 0 0];
const.smallfixcol=[255 255 255];
const.smallerfixcol{1}=[128-fixchangeval 128-fixchangeval 128-fixchangeval];
const.smallerfixcol{2}=[128+fixchangeval 128+fixchangeval 128+fixchangeval];

end

const.bigfixsize=30;
const.smallfixsize=20;
const.smallerfixsize=10;

%% Bar pass properties

% The duration of a horizontal bar pass
const.h_period=36;

% The duration of a vertical bar pass
const.v_period=48;

% The TR (also the duration that the bar is in one place, since these are synchronised). 
const.TR=2;

% The number of updates per TR.
const.drawsperTR=4;


% If we are just retriving the binary stimulus frames, then we only want 1
% per TR.

if getstimuli
    const.drawsperTR=1;
else
end

% The mean of the exponential distribution that we draw the intervals between events (bar shifts, fixation
% changes) from.
const.expM=3;
% The maximum and minimum interval between stimulus events (bar shifts, fixation
% changes).
const.expl=2;
const.exph=8;


%% Properties for drawing stimframes

% Scale for downsizing binary stimulus frames
const.downsize=0.2;


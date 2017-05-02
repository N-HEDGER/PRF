

%% Bar properties

const.elementsize=0.5;
const.barwidth=2;
const.barlength=36;
const.Nbars=20;
if getstimuli
    const.Nbars=1
else
end

%% Fixation properties

if getstimuli
    
const.bigfixcol=[0 0 0];
const.smallfixcol=[0 0 0];
const.smallerfixcol=[0 0 0];
else
const.bigfixcol=[0 0 0];
const.smallfixcol=[255 255 255];
const.smallerfixcol=[128 128 128];
end



const.bigfixsize=30;
const.smallfixsize=20;
const.smallerfixsize=10;

%% Bar pass properties

const.h_period=30;
const.v_period=42;

const.TR=2;


const.smallfixsize=20;
const.smallerfixsize=10;

const.drawsperTR=5;
if getstimuli
    const.drawsperTR=1
else
end

%% Properties for drawing stimframes

% Scale for downsizing binary stimulus frames
const.downsize=0.2;

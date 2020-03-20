% Pass config

%% Vertical pass

% Get centre for vertical bar pass.
[scr.stimrectv,dh,dv] = CenterRect([0 0 const.barsize(2) const.barsize(1)], scr.rect);

% Define start point. This is 1/2 the screen +1/2 the bar width from the
% centre.
scr.stimrectv=scr.stimrectv-[(grid_sizeX/2)+(const.barsize(2)/2) 0 (grid_sizeX/2)+(const.barsize(2)/2) 0];

% The number of positions is the total time of the pass divided by the TR
const.positionsv=const.v_period/const.TR;

% The total draws is the number of positions * the number of draws per TR
const.totaldrawsv=const.positionsv*const.drawsperTR;

% Make a linearly spaced vector that extends from the start postion to the same postion off
% the other side of the screen.
const.positionvecv=linspace(0,grid_sizeX+const.barsize(2),const.positionsv);

% Ensure that the bar is stationary at each postion for the correct number
% of draws. Use Kronnecker tensor product function.
const.locationsv=kron(const.positionvecv,ones(const.drawsperTR,1));

% Reshape into vector.
const.locationsv=reshape(const.locationsv,1,const.totaldrawsv);



%% Horizontal bar


[scr.stimrecth,dh,dv] = CenterRect([0 0 const.barsize(1) const.barsize(2)], scr.rect);

% The start point is 1/2 the screen +1/2 the bar width
scr.stimrecth=scr.stimrecth-[0 (grid_sizeY/2)+(const.barsize(2)/2) 0 (grid_sizeY/2)+(const.barsize(2)/2)];

% The number of positions is the total time of the pass divided by the TR
const.positionsh=const.h_period/const.TR;

% The total draws is the number of positions * the number of draws per TR
const.totaldrawsh=const.positionsh*const.drawsperTR;

% Make a linearly spaced vector that extends from the start postion to the same postion off
% the other side of the screen.
const.positionvech=linspace(0,grid_sizeY+const.barsize(2),const.positionsh);

% Ensure that the bar is stationary at each postion for the correct number
% of draws. Use Kronnecker tensor product function.
const.locationsh=kron(const.positionvech,ones(const.drawsperTR,1));

% Reshape into vector.
const.locationsh=reshape(const.locationsh,1,const.totaldrawsh);

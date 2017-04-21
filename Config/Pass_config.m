% Pass config

% Also define for h pass;
[scr.stimrectv,dh,dv] = CenterRect([0 0 const.barsize(2) const.barsize(1)], scr.rect);
scr.stimrectv=scr.stimrectv-[(scr.scr_sizeX/2)+(const.barsize(2)/2) 0 (scr.scr_sizeX/2)+(const.barsize(2)/2) 0];



const.positionsv=const.v_period/const.TR;
const.totaldrawsv=const.positionsv*const.drawsperTR;


const.positionvecv=linspace(0,scr.scr_sizeX+const.barsize(2),const.positionsv);
const.locationsv=kron(const.positionvecv,ones(const.drawsperTR,1));
const.locationsv=reshape(const.locationsv,1,const.totaldrawsv);


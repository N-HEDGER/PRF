    

bars=cell(1,const.Nbars);
    for i=1:const.Nbars
        bars{i}=colnoisebar(const.elementsize,const.barlength,const.barwidth,scr.vd,scr.scr_sizeX,scr.dispsize,0);
    end
    
    
    const.barsize=size(bars{1});
    
    

bars=cell(1,const.Nbars);
h=waitbar(0,'Creating Stimuli...');
    for bar=1:const.Nbars
        perc=(bar/const.Nbars)*100;
        waitbar(perc/100,h,sprintf('Drawing Stimuli... %d%%completed',perc));
        bars{bar}=colnoisebar(const.elementsize,const.barlength,const.barwidth,scr.vd,scr.scr_sizeX,scr.dispsize,0);
    end
    close(h)
    
    
    const.barsize=size(bars{1});
    
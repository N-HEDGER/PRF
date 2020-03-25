% load('allfaceims')
load('stimuli.mat');


if mapper==0
    
    
bars=cell(2,const.Nbars);
h=waitbar(0,'Creating Stimuli...');
    for bar=1:const.Nbars
        perc=floor((bar/const.Nbars)*100);
        waitbar(perc/100,h,sprintf('Drawing Stimuli... %d%%completed',perc));
%         bars{bar}=colnoisebar(const.elementsize,scr.visang_deg_screen,const.barwidth,scr.vd,scr.scr_sizeX,scr.dispsize,0);
        
        
%         bars{1,bar}=makefacebar(Tapered2,const.barwidth,const.barlength,scr.vd,scr.scr_sizeX,scr.dispsize,0);
%         bars{2,bar}=makefacebar(Tapered2,const.barwidth,const.barlength,scr.vd,scr.scr_sizeX,scr.dispsize,1);
         bars{1,bar}=makekaybar(patterns,const.barwidth,const.barlength,scr.vd,scr.scr_sizeX,scr.dispsize,grid_sizeX,grid_sizeY,0);
         bars{2,bar}=makekaybar(patterns,const.barwidth,const.barlength,scr.vd,scr.scr_sizeX,scr.dispsize,grid_sizeX,grid_sizeY,1);

        
        
        if getstimuli
            bars{bar}(:,:,:)=1;
        else
        end
           
    end
    close(h)
    const.barsize=size(bars{1});
    
    
    
else
    
    bars=cell(2,const.Nbars);
h=waitbar(0,'Creating Stimuli...');
    for bar=1:const.Nbars
        perc=floor((bar/const.Nbars)*100);
        waitbar(perc/100,h,sprintf('Drawing Stimuli... %d%%completed',perc));
        
        
        bars{1,bar}=makefacebar(Tapered2,scr.visang_deg_screen,scr.visang_deg_screen,scr.vd,scr.scr_sizeX,scr.dispsize,0);
        bars{2,bar}=makefacebar(Tapered2,scr.visang_deg_screen,scr.visang_deg_screen,scr.vd,scr.scr_sizeX,scr.dispsize,0);

%         bars{bar}=colnoisebar(const.elementsize,scr.visang_deg_screen*(scr.scr_sizeY/scr.scr_sizeX),scr.visang_deg_screen,scr.vd,scr.scr_sizeX,scr.dispsize,0);
        if getstimuli
            bars{bar}(:,:,:)=1;
        else
        end
           
    end
    close(h)
    
    const.barsize=size(bars{1});
    
    
end
    
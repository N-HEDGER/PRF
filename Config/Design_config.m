
if mapper==0
    
    if istest
        const.nreps=1;
    else
        const.nreps=2;
    end
    
    const.istrial=[0,1,0,1,1,0,1];
    const.orientation=[2,1,2,1,2,2,2];
    const.dir=[1,1,1,2,1,2,2];
    const.conditions=horzcat(const.istrial',const.orientation',const.dir');
    const.conditions=GenerateEventTable(const.conditions,const.nreps,1);
    
    
    if istest
        const.conditions=const.conditions(const.conditions(:,2)==1,:);
    else
    end
    
elseif mapper==1
    const.nreps=120;
    const.istrial=[0,1];
    const.conditions=GenerateEventTable(const.istrial',const.nreps,0);
    
    if istest
        const.conditions=const.conditions(1:30,:);
    else
    end
    
end

    



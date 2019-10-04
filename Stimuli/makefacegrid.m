function [bar2] = makefacebar(facecell,desired_length, desired_width, numsquaresW,horzbar)



unit_size=desired_width/numsquaresW;

numsquaresL=round(desired_length/unit_size);

k=cell(numsquaresW,numsquaresL);
for i=1:numsquaresW
    for j=1:numsquaresL
k{i,j}=facecell{randsample(length(facecell),1)};
    end    
end


bar=cell2mat(k);

bar2=imresize(bar,[desired_width,NaN]);



end

Tapered2 = [Tapered,Taperedbl,bn.Tapered];

for i=1:length(Tapered2)
Tapered2{i} = edgetaper(Tapered2{i},PSF);
end


desired_length=1400;
numsquaresW=1;

desired_width=300;

horzbar=0;
bar2=cell(1,1);
for b=1:10

unit_size=desired_width/numsquaresW;

numsquaresL=round(desired_length/unit_size);


if horzbar==1;
k=cell(numsquaresW,numsquaresL);
for i=1:numsquaresW
    for j=1:numsquaresL
k{i,j}=makefacebar(Tapered2,desired_width,desired_width,randi([1,2]),1);
    end    
end


bar=cell2mat(k);

bar2{b}=imresize(bar,[desired_width,NaN]);
elseif horzbar==0;

    k2=cell(numsquaresL,numsquaresW);
    for i=1:numsquaresW
        for j=1:numsquaresL
            k2{j,i}=makefacebar(Tapered2,desired_width,desired_width,randi([1,2]),1);
        end
    end
    
bar=cell2mat(k2);

bar2{b}=imresize(bar,[NaN,desired_width]);
end


end
close all

BARIMAGES2=reshape(BARIMAGES,numel(BARIMAGES),1);
BARIMAGES3=BARIMAGES2(~cellfun('isempty',BARIMAGES2)); 

BINSTIMFRAMES=cell(1,length(BARIMAGES3));

figure
for i=1:length(BARIMAGES3)
    BINSTIMFRAMES{i}=imresize(im2double(rgb2gray(BARIMAGES3{i})),const.downsize);
    imshow(BINSTIMFRAMES{i})
    drawnow
    hold on
   
end

save(strcat('Data/',filename,'/BINARY_STIMULUS_FRAMES.mat'),'BINSTIMFRAMES');



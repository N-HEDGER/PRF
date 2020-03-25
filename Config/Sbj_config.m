
prompt='subject filename?';
filename = input(prompt,'s');

% Spit some initial information into a text file.

mkdir(strcat('Data/',filename))
log_text=sprintf('Data/%s/log.txt',filename);
log_text_fid=fopen(log_text,'a+');
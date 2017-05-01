% If it is a test then print the condition labels for debugging.
if istest==1

else
    
    [x,count]=fread(s2,1);
    
end

% Print to the log file when pulse is recieved.
log_txt=sprintf('Pulse recieved at %s',num2str(clock));
fprintf(log_text_fid,'%s\n',log_txt);
% Sequence config
% Here we define the sequence of events that take place during a trial.



% Draw random values from a exponential distribution
vec=zeros(1,1000);
for i=1:1000
    vec(i)=exprnd(const.expM);
end


% Truncate the distribution.
mask = vec>const.expl & vec<const.exph;
intervals=vec(mask);


binary_fix_sequence=cell(1,length(const.conditions));
for t=1:length(const.conditions)

    if const.conditions(t,3)==1
        period=const.v_period;
        totaldraws=const.totaldrawsv;
    else
        period=const.h_period;
        totaldraws=const.totaldrawsh;
    end
fix_sequence=[];
% Here we begin a sequence.
 fix_sequence(1)=0;
 i=1;
 endtime=0;
while endtime<period;
    i=i+1;
   fix_sequence(i)=(fix_sequence(i-1)+randsample(intervals,1));
   endtime=fix_sequence(end);
end

% Make this the same length as the number of draws.


time_sequence=linspace(0,period,totaldraws);

binary_fix_sequence{t}=zeros(1,totaldraws);

s=2;
while s<length(fix_sequence)

 if mod(s,2)==1
     val=0;
 else
     val=1;
 end
binary_fix_sequence{t}(time_sequence>fix_sequence(s) & time_sequence<fix_sequence(s+1))=val;
s=s+1;  
  
end

end


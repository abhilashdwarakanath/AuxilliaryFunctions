function locs = correctForMinEventDur(locs,minpeakdist)

while 1
    
    del=diff(locs)<minpeakdist;
    
    if ~any(del), break; end % There must be a more efficient way of doing this instead of using break?
    
    pks=samples(locs);
    
    [~,mins]=min([pks(del) ; pks([false del])]);
    
    deln=find(del);
    
    deln=[deln(mins==1) deln(mins==2)+1];
    
    locs(deln)=[];
    
end

end
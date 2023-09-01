function [chanLoc,PWdistances] = getElecInfoTable(params,map,chan2elec)

%% Get params

nChannels = params.elecs;
unitDist = 0.4; % mm

%% Input row and channel information

chanLoc = zeros(nChannels,3);

for iElec = 1:size(chan2elec,1)
    
    [r, c] = find(map == chan2elec(iElec,2));
    
    chanLoc(iElec,1) = chan2elec(iElec,2);
    chanLoc(iElec,2) = r;
    chanLoc(iElec,3) = c;
    
end

% for iElec = 1:size(chan2elec,1)
%     
%     [r, c] = find(map == iElec);
%     
%     chanLoc(iElec,1) = iElec;
%     chanLoc(iElec,2) = r;
%     chanLoc(iElec,3) = c;
%     
% end

[~,idx] = sort(chanLoc(:,1),'ascend');

chanLoc = chanLoc(idx,:);

%% Compute the distances

PWdistances = zeros(nChannels, nChannels);

for currChan = 1 : nChannels
    for nextChan = currChan+1 : nChannels
       % Only the Upper matrix is computed as the upper and lower halves are mirrored. So to extract distances, use Column and Row instead of Row and Column.
        PWdistances(currChan, nextChan) = norm([chanLoc(currChan, 2) chanLoc(currChan, 3)]*unitDist - [chanLoc(nextChan, 2) chanLoc(nextChan, 3)]*unitDist);
        
    end
end

end
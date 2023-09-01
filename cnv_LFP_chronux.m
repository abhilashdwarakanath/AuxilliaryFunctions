function tetrode = cnv_LFP_chronux(dataField) 

% author: Natalie Zhavoronkov
%  start: 2013/03/15

% IN:
%   dataField : e.g. data.lfp.v
% OUT:
%   tetrode: structure -> tetrode(x).condition{x}  

tetrode = struct();

for iTet = 1:size(dataField,1)
    for iCond = 1:size(dataField,3)
        tmp = dataField(iTet,:,iCond);
        tetrode(iTet).condition{iCond} = horzcat(tmp{:});
    end
end
  
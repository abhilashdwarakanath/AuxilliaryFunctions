function fieldData_chronuxFormat = convert_LFP_chronux(fieldData) 
% fieldData_chronuxFormat = convert_LFP_chronux(fieldData) 
% author: Natalie Zhavoronkov
%  start: 2013/03/15
% 
% IN:
%   fieldData : e.g. data.lfp.v
% 
% OUT:
%   fieldData_chronuxFormat
%   e.g.:
%   tetrode: structure -> tetrode(x).condition{x}  

nChannels  = size(fieldData, 2); 
% this is specific for my (shervin) data structre

fieldData_chronuxFormat = struct();

for iCh = 1 : nChannels
%     for iCond = 1 : size(fieldData,3)
%         tmp = squeeze(fieldData(:, iCh, :));
        fieldData_chronuxFormat(iCh).v = squeeze(fieldData(:, iCh, :));
%     end
end
  
function signalDespiked = despike(params,signal,spikeTimes)

spkSamps = ceil(spikeTimes*params.fs);

removeBeforeSpike = ceil(params.fs*(params.beforeSpike)./1e3);
removeAfterSpike = ceil(params.fs*(params.afterSpike)./1e3);

% fill in all signal points around spikes with NaN

signalNaN = signal;

for iSpike = 1:length(spikeTimes)

    nanRange = spkSamps(iSpike) - removeBeforeSpike:spkSamps(iSpike) + removeAfterSpike - 1;

    if nanRange(1) > 0 && nanRange(end) < numel(signalNaN)
        signalNaN(nanRange) = NaN;
    end
end

% interpolate NaN signal using linear method

target = 1:numel(signalNaN);
interpAxis = target;
target = target(~isnan(signalNaN));
signalNaN = signalNaN(~isnan(signalNaN));
signalDespiked = interp1(target,signalNaN,interpAxis,'linear');
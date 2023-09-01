function h = violinplot(data, pos, varargin)
% VIOLINPLOT Create a violin plot
%
%   VIOLINPLOT(DATA, POS) creates a violin plot for the input data at the
%   specified position.
%
%   VIOLINPLOT(..., 'ShowData', true/false) specifies whether to show the
%   individual data points.
%
%   VIOLINPLOT(..., 'ViolinColor', COLOR) specifies the color of the violin
%   plot.
%
%   VIOLINPLOT(..., 'DataColor', COLOR) specifies the color of the data
%   points.
%
%   VIOLINPLOT(..., 'Bandwidth', BW) specifies the bandwidth of the kernel
%   density estimation used to compute the violin plot.
%
%   VIOLINPLOT(..., 'Normalization', NORM) specifies the normalization
%   method used to scale the kernel density estimation. Valid values for
%   NORM are 'pdf' (probability density function) and 'count' (number of
%   observations).
%
%   VIOLINPLOT(..., 'FaceAlpha', ALPHA) specifies the transparency of the
%   violin plot face.

% Parse inputs
p = inputParser;
addRequired(p, 'data');
addRequired(p, 'pos');
addParameter(p, 'ShowData', false, @islogical);
addParameter(p, 'ViolinColor', [0.5 0.5 0.5], @isnumeric);
addParameter(p, 'DataColor', 'k', @ischar);
addParameter(p, 'Bandwidth', [], @isnumeric);
addParameter(p, 'Normalization', 'pdf', @(x) any(validatestring(x, {'pdf', 'count'})));
addParameter(p, 'FaceAlpha', 1, @isnumeric);
parse(p, data, pos, varargin{:});

% Compute the kernel density estimates
if isempty(p.Results.Bandwidth)
    bandwidth = 1.06 * std(data(:)) * length(data(:))^(-1/5);
else
    bandwidth = p.Results.Bandwidth;
end
x = linspace(min(data(:)), max(data(:)), 200);
pdf = ksdensity(data(:), x, 'Bandwidth', bandwidth, 'Kernel', 'epanechnikov');
pdf = pdf / max(pdf);

% Compute the violin plot shape
if strcmpi(p.Results.Normalization, 'pdf')
    y = pdf;
else
    y = ksdensity(data(:), x, 'Bandwidth', bandwidth, 'Kernel', 'epanechnikov', 'Function', 'count');
    y = y / max(y);
end
y = [y' fliplr(y')];

% Create the violin plot
h = patch(pos + y', x, p.Results.ViolinColor, 'EdgeColor', 'none');
set(h, 'FaceAlpha', p.Results.FaceAlpha);

% Add the data points if requested
if p.Results.ShowData
    hold on;
    scatter(data, repmat(pos, size(data)), 8, p.Results.DataColor, 'filled');
    hold off;
end

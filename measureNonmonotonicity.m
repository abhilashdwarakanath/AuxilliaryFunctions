function nonmonotonicity = measureNonmonotonicity(x, y, sem)
    % Fit a linear regression model
    model = fitlm(x, y, 'Weights', 1 ./ sem.^2);

    % Calculate the residuals
    residuals = model.Residuals.Raw;

    % Calculate the non-monotonicity measure
    nonmonotonicity = sum((residuals)) / sum((y - mean(y)));
end
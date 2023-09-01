function y = normaliseMatrix(x)

y = (x - min2(x))/(max2(x) - min2(x));
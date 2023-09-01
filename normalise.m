function out = normalise(in)

out = (in - min(in)) / ( max(in) - min(in) );
end
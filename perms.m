function p = perms(m)
% PERMS Returns all possible permutations of length M.
%
%   P = PERMS(M) returns an array P containing all possible permutations of
%   the integers 1:M.
%
%   Example:
%       >> p = perms(3)
%       p =
%            1     2     3
%            1     3     2
%            2     1     3
%            2     3     1
%            3     1     2
%            3     2     1

n = prod(m);
p = zeros(n, length(m));

indices = ones(size(m));
cycles = length(m):-1:1;

for i = 1:n
    p(i,:) = indices;
    
    for j = cycles
        if indices(j) < m - cycles(j) + 1
            indices(j) = indices(j) + 1;
            break
        else
            indices(j) = j;
        end
    end
end
end
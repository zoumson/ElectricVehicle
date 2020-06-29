function output = A_constraint(l)
% Use to build SOC max and min constaints 
a1 = ones(l);
a2 = tril(a1);
output = cat(1, a2, -a2);
end
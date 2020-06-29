function output = b_constraint(l, ub, lb)
% Use to build SOC max and min constaints
a1 = ub*ones(l, 1);
b1 = -lb*ones(l, 1);
output = cat(1, b1, a1);
end
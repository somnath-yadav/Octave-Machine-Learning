function J = testCost(X,y,theta)

% X is the design matrix containing training example
% y is actual output
% theta is parameter

m = size(X,1); % number of training example
J = 0;

predictions = X*theta; % predictions for all hypothesis on all m examples

sqrtError = (predictions - y).^2;

J = 1/(2*m) * sum(sqrtError);

end

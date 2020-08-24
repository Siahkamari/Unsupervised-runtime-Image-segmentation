%% distance definition
function out = metric(X)
out  = sum(X.*X,2);
end
function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;


stepsize = (max(pval) - min(pval)) / 1000;

for epsilon = (min(pval)+stepsize):stepsize:max(pval)

    %epsilon = min(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    % truePovitive when it is an anomaly and algorithm predicts same
    trueP = sum((yval==1) & (pval<epsilon));
    %fprintf('trueP found using cross-validation: %e\n', trueP);
    
    % falsePovitive when it is not an anomaly and algorithm predicts anomaly
    falseP = sum((yval==0) & (pval<epsilon));
    %fprintf('falseP found using cross-validation: %e\n', falseP);
    
    % falseNevative when it is an anomaly and algorithm predicts not an anomaly
    falseN = sum((yval==1) & (pval>=epsilon));
    %fprintf('falseN found using cross-validation: %e\n', falseN);
    
    % precision and recall
    prec = trueP/(trueP+falseP);
    %fprintf('prec found using cross-validation: %e\n', prec);
    rec = trueP/(trueP+falseN);
    %fprintf('rec found using cross-validation: %e\n', rec);
    
    % F1 value
    F1 = 2*((prec*rec)/(prec+rec));

    % =============================================================
    %fprintf('F1 before loop found using cross-validation: %e\n', F1);
    %fprintf('bestF1 before loop found using cross-validation: %e\n', bestF1);
    
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
       %fprintf('F1 after loop using cross-validation: %e\n', F1);
       %fprintf('bestF1 after loop found using cross-validation: %e\n', bestF1);
       %fprintf('bestEpsilon after loop found using cross-validation: %e\n', bestEpsilon);
       
    end
    
end

end

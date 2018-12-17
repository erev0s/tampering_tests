function [F,tp,fn,fp] = f_measure(map_gt,map_est)

% Computing the F-measures between two binary arrays with the same size.
% The first input is the ground truth map, where 1 indicates forged pixels
% and 0 indicates non-forged pixels. The second input is the estimated
% tampering map.

if ~isequal(size(map_gt),size(map_est))
    error('The compared maps must have the same size');
end

% Vectorize maps
map_gt=map_gt(:); map_est=map_est(:);

% Number of pixels
N=numel(map_gt);
% Number of forged pixels in the ground truth
n_pos = numel(find(map_gt==1));
% Indices of forged pixels in the ground truth
i_pos = (map_gt==1); 

% True Positive Rate: fraction of forged pixels correctly identified as forged
tp=sum(map_gt(i_pos)==map_est(i_pos)); tpr = tp / n_pos;
% False Negative Rate: fraction of forged pixels wrongly identified as non-forged
fn= n_pos-tp; fnr = fn / n_pos;
% False Positive Rate: fraction of non-forged pixels wrongly identified as forged
fp = sum(map_gt(~i_pos)~=map_est(~i_pos)); fpr = fp /(N-n_pos);

F = 2*tp / (2*tp + fn + fp);

end


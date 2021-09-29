function [P_intensityfiltered_tmp, P_downsampled_tmp, P_vectorfiltered_tmp,...
    P_clustered_tmp, P_non_1_tmp, P_non_2_tmp, P_non_3_tmp] ...
    = division(P_mat, I_th, mp, sigma, epsilon, minpts)
    
[P_intensityfiltered_tmp, P_non_1_tmp] = intensityfilter(P_mat, I_th); %先用强度阈值筛去一些点
if ~isempty(P_intensityfiltered_tmp)
    P_downsampled_tmp = matdownsample(P_intensityfiltered_tmp, mp); %降采样
else
    P_downsampled_tmp = [];
end
if ~isempty(P_downsampled_tmp)
    [P_vectorfiltered_tmp, P_non_2_tmp] = vectorfilter(P_downsampled_tmp, sigma);
else
    P_vectorfiltered_tmp = [];
    P_non_2_tmp = [];
end
if ~isempty(P_vectorfiltered_tmp)
    [P_clustered_tmp, P_non_3_tmp] = DBSCAN(P_vectorfiltered_tmp, epsilon, minpts);
else
    P_clustered_tmp = [];
    P_non_3_tmp = [];
end
end


function [P_intensityfiltered, P_downsampled, P_vectorfiltered, P_clustered, P_non_1, P_non_2, P_non_3] ...
    = road_division(P_t, I_th, mp, sigma, epsilon, minpts, debug)
%ROAD_DIVISION
P_intensityfiltered = [];
P_downsampled = [];
P_vectorfiltered = [];
P_clustered = [];
P_non_1 = [];
P_non_2 = [];
P_non_3 = [];
if debug == true
    for i = ceil(0.65*length(P_t)):ceil(0.7*length(P_t))
        [P_intensityfiltered_tmp, P_downsampled_tmp, P_vectorfiltered_tmp,...
    P_clustered_tmp, P_non_1_tmp, P_non_2_tmp, P_non_3_tmp] ...
    = division(P_t{i,1}, I_th, mp, sigma, epsilon, minpts);
        
        P_intensityfiltered = [P_intensityfiltered; P_intensityfiltered_tmp];
        P_downsampled = [P_downsampled; P_downsampled_tmp];
        P_vectorfiltered = [P_vectorfiltered; P_vectorfiltered_tmp];
        P_clustered = [P_clustered; P_clustered_tmp];
        P_non_1 = [P_non_1; P_non_1_tmp];
        P_non_2 = [P_non_2; P_non_2_tmp];
        P_non_3 = [P_non_3; P_non_3_tmp];
    end
else
    for i = 1:length(P_t)
        [P_intensityfiltered_tmp, P_downsampled_tmp, P_vectorfiltered_tmp,...
    P_clustered_tmp, P_non_1_tmp, P_non_2_tmp, P_non_3_tmp] ...
    = division(P_t{i,1}, I_th, mp, sigma, epsilon, minpts);
        
        P_intensityfiltered = [P_intensityfiltered; P_intensityfiltered_tmp];
        P_downsampled = [P_downsampled; P_downsampled_tmp];
        P_vectorfiltered = [P_vectorfiltered; P_vectorfiltered_tmp];
        P_clustered = [P_clustered; P_clustered_tmp];
        P_non_1 = [P_non_1; P_non_1_tmp];
        P_non_2 = [P_non_2; P_non_2_tmp];
        P_non_3 = [P_non_3; P_non_3_tmp];
    end
end
end


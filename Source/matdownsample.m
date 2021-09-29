function [P_downsampled] = matdownsample(P_mat, mp)
%降采样
PC = pointCloud(P_mat(:,1:3),'Intensity',P_mat(:,4));
PC = pcdownsample(PC,'gridAverage',mp);%降取样
P_downsampled = [PC.Location double(PC.Intensity)];%原始点集合
end


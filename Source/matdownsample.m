function [P_downsampled] = matdownsample(P_mat, mp)
%������
PC = pointCloud(P_mat(:,1:3),'Intensity',P_mat(:,4));
PC = pcdownsample(PC,'gridAverage',mp);%��ȡ��
P_downsampled = [PC.Location double(PC.Intensity)];%ԭʼ�㼯��
end


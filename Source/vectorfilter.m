function [P_vectorfiltered, P_non] = vectorfilter(pc_mat, sigma)
%VECTORFILTER �˴���ʾ�йش˺�����ժҪ
pc = pointCloud(pc_mat(:,1:3),'Intensity',pc_mat(:,4));
normals = pcnormals(pc,20);
u = normals(:,1);
v = normals(:,2);
w = normals(:,3);
th = cos(sigma*pi/180);
index = w >= th;
P_vectorfiltered = pc_mat(index,:);
P_non = pc_mat(~index,:);
end


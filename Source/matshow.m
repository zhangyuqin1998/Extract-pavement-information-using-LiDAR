function [] = matshow(pointcloud_mat)
%����������飬��������
pc=pointCloud(pointcloud_mat(:,1:3),'Intensity',pointcloud_mat(:,4));
pcshow(pc);view(2);
end


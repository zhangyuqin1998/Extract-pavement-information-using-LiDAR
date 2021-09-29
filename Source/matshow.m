function [] = matshow(pointcloud_mat)
%传入点云数组，画出点云
pc=pointCloud(pointcloud_mat(:,1:3),'Intensity',pointcloud_mat(:,4));
pcshow(pc);view(2);
end


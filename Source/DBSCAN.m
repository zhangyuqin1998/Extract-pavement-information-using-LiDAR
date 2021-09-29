function [P_clustered, P_non_3] = DBSCAN(P_mat, epsilon, minpts)
%无监督聚类
X = P_mat;
% kD = pdist2(X(:,1:3),X(:,1:3),'euc','Smallest',minpts);
% plot(sort(kD(end,:)))
% grid
labels = dbscan(X(:,1:3), epsilon, minpts);
index = labels == mode(labels); %找到出现次数最多的类别，即为路面点
P_clustered = X(index, :);
P_non_3 = X(~index, :);
end


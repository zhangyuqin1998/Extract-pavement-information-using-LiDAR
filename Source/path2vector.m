function [V, N, T] = path2vector(Path_0)
%PATH2VECTOR
Path_1=Path_0(2:end,:);
V=Path_1-Path_0(1:end-1,1:3);%轨迹向量 %想办法更精准
V(:,3)=0;
N=[V(:,2) -V(:,1) V(:,3)];%法向量
T=(Path_1+Path_0(1:end-1,1:3))/2;
end


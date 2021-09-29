function [Path_,V_,N_,T_] = simplified_trajectory(Path,V,N,T,d)
%用于简化轨迹，输入轨迹点与简化的间隔
Path_all=[Path V N T];
Path_tmp=zeros(size(Path_all,1),12);
cnt=1;
Path_tmp(1,:)=[Path_all(1,:)];%初始点
for i=1:size(Path_all,1)
    if pdist([Path_tmp(cnt,:);Path_all(i,:)],'euclidean')>=d %简化轨迹数据，每隔x米保留一个截面
        cnt=cnt+1;
        Path_tmp(cnt,:)=Path_all(i,:);
    end
end
Path_tmp(cnt+1:end,:)=[];
Path_=Path_tmp(:,1:3);%简化后的轨迹点
V_=Path_tmp(:,4:6);%简化后的轨迹向量
N_=Path_tmp(:,7:9);%简化后的法向量
T_=Path_tmp(:,10:12);%简化后的T
end


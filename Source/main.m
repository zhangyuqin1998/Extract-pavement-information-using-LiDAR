function [P_intensityfiltered, P_downsampled, P_vectorfiltered, P_clustered, P_non_1, P_non_2, P_non_3, Geometric_Information, Radius] ...
    = main(PC,Path, I_th, mp, sigma, epsilon, minpts, dd, dth, xBound, yBound, R, h_th, debug)
%MAIN
P_0 = [PC.x,PC.y,PC.z,double(PC.intensity), double(PC.gps_time)];%将原始点云转换成矩阵形式
P_t = subsection_by_time(P_0, 3); %按时间戳分段以并行计算
[P_intensityfiltered, P_downsampled, P_vectorfiltered, P_clustered, P_non_1, P_non_2, P_non_3] ...
    = road_division(P_t, I_th, mp, sigma, epsilon, minpts, debug);%路面提取
% [x_move, y_move, P_centered] = move2center(P_clustered); %移动坐标原点至左下角
[P_rebuilded, P_road_rebuild, P_non_all] = false_deletion_point_recovery(P_clustered, P_non_2, P_non_3, R, h_th);

figure(1);matshow(P_intensityfiltered)
figure(2);matshow(P_downsampled)
figure(3);matshow(P_vectorfiltered)
figure(4);matshow(P_clustered)
figure(5);matshow(P_rebuilded)
figure(6);matshow(P_road_rebuild)
figure(7);matshow(P_non_all)

%%几何信息提取的部分
Path_=sortrows(Path,2);
[V_, N_, T_] = path2vector(Path_);%计算轨迹向量以及法向量
[~, V, N, T] = simplified_trajectory(Path_(2:end,:),V_,N_,T_,dd);%简化轨迹数据
% gscatter(Path_(:,1),Path_(:,2)) %画出轨迹

if debug == false
    [Geometric_Information,Radius] = calculate_geometric_information(P_rebuilded, Path_, V, N, T, xBound, yBound, dth, dd);%计算几何信息
    figure(8);%左超高
    scatter(Geometric_Information(:,1),Geometric_Information(:,2),'.');
    xlabel('里程数(m)');ylabel('左侧超高值');axis([-inf inf -0.1 0.1]);
    figure(9);%右超高
    scatter(Geometric_Information(:,1),Geometric_Information(:,3),'.');
    xlabel('里程数(m)');ylabel('右侧超高值');axis([-inf inf -0.1 0.1]);
    figure(10);%纵坡
    scatter(Geometric_Information(:,1),Geometric_Information(:,4),'.');
    xlabel('里程数(m)');ylabel('纵坡坡度');axis([-inf inf -0.1 0.1]);
    figure(11);%曲率半径
    scatter(Radius(:,1),Radius(:,2),'.');
    xlabel('里程数(m)');ylabel('曲率半径(m)');axis([-inf inf 1500 2500]);
    figure(12);%道宽
    scatter(Geometric_Information(:,1),Geometric_Information(:,5),'.');
    xlabel('里程数(m)');ylabel('道路宽度(m)');
else
    Geometric_Information = [];
    Radius = [];
end
end


function [P_road, P_road_rebuild, P_non_all] = false_deletion_point_recovery(P_road, P_non_2, P_non_3, R, h_th)
%FALSE_DELETION_POINT_RECOVERY
P_non_all = [P_non_2; P_non_3];
P_road_rebuild=zeros(length(P_non_all(:,1)),4);
[idx,~]=rangesearch(P_non_all(:,1:2),P_road(:,1:2),R);
P_road_rebuild_scoring=0;
for i=1:length(P_road(:,1))
    for j=1:size(idx{i,1},2)
        delta_h=abs(P_non_all(idx{i,1}(1,j),3)-P_road(i,3));
        if delta_h<h_th
          P_road_rebuild_scoring=P_road_rebuild_scoring+1;
          P_road_rebuild(P_road_rebuild_scoring,:)=P_non_all(idx{i,1}(1,j),:);
          P_non_all(idx{i,1}(1,j),:)=P_non_all(idx{i,1}(1,j),:)*0;
       end
    end
end
P_road_rebuild(all(P_road_rebuild==0,2),:)=[];
P_non_all(all(P_non_all==0,2),:)=[];
P_road = [P_road;P_road_rebuild];
end


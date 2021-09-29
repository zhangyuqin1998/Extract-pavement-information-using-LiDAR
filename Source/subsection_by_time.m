function [P_t] = subsection_by_time(P_0,interval)
%SUBSECTION_BY_TIME 
mean_time = mean(P_0(:, 5));
std_time = std(P_0(:, 5));
ind = P_0(:, 5) > mean_time + 3*std_time | P_0(:, 5) < mean_time - 3*std_time;%找到离群点
P_0(ind, :) = [];%删除离群点
%histogram(P_0(:,5));
u = max(P_0(:, 5));
d = min(P_0(:, 5));
edges = [d:interval:u];
P_t = cell(length(edges), 1);
for i = 1:length(edges)
    T_d = edges(i);
    T_u = edges(i) + interval;
    index = P_0(:,5) >= T_d & P_0(:,5) <= T_u;
    P_t{i ,1} = P_0(index, :);
end

end


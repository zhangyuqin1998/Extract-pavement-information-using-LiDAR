function [x_move, y_move, pc_mat] = move2center(pc_mat)
%将坐标轴移动至坐标原点
x_move = min(pc_mat(:,1));
y_move = min(pc_mat(:,2));
pc_mat = [pc_mat(:,1) - x_move, pc_mat(:,2) - y_move, pc_mat(:,3), pc_mat(:,4)];%初步筛选点后将坐标轴移动至坐标原点
end


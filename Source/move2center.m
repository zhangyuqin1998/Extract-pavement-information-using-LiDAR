function [x_move, y_move, pc_mat] = move2center(pc_mat)
%���������ƶ�������ԭ��
x_move = min(pc_mat(:,1));
y_move = min(pc_mat(:,2));
pc_mat = [pc_mat(:,1) - x_move, pc_mat(:,2) - y_move, pc_mat(:,3), pc_mat(:,4)];%����ɸѡ����������ƶ�������ԭ��
end


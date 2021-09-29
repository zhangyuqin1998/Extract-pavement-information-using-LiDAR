function [pc_mat, p_non] = intensityfilter(pc_mat, I_th)
%Ç¿¶ÈÂË²¨
index = pc_mat(:,4) > I_th;
p_non = pc_mat(~index,:);
pc_mat = pc_mat(index,:);
end


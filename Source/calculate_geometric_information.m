function [Geometric_Information,Radius] = calculate_geometric_information(P_clustered, Path_, V, N, T, xBound, yBound, dth, dd)
A=N(:,2);
B=-N(:,1);
C=N(:,1).*T(:,2)-N(:,2).*T(:,1);
P_CS=cell(size(V,1),3);
Geometric_Information=[];
P_cen=[];
jiaodu=[];
for i=1:size(V,1)-1
    index=find(P_clustered(:,1)<=T(i,1)+xBound & P_clustered(:,1)>=T(i,1)-xBound & P_clustered(:,2)<=T(i,2)+yBound & P_clustered(:,2)>=T(i,2)-yBound);
    P_road_current=P_clustered(index,:);
    x1=P_road_current(:,1);
    y1=P_road_current(:,2);
    z1=P_road_current(:,3);
    d=abs(A(i)*x1+B(i)*y1+C(i))/sqrt(A(i)^2+B(i)^2);%水平距离
    h=abs(z1-T(i,3));%垂直距离 
    index_1=find(d <= dth & h <= 5);
    P_CS_current = P_road_current(index_1,:);
    if isempty(P_CS_current)
        continue;
    end
    X_mean = mean(P_CS_current(:,1));
    Y_mean = mean(P_CS_current(:,2));
    Z_mean = mean(P_CS_current(:,3));
    P_cen = [P_cen;X_mean Y_mean Z_mean];%利用平均坐标求道路中心线
    
    a=[0 1 0];
    b=[V(i,1) V(i,2) 0];
    Theta=pi-atan(cross(b,a)/sum(a.*b));
    Theta=Theta(1,3);
    Theta_jiaodu=Theta/pi*180;
    jiaodu=[jiaodu;Theta_jiaodu];
    R = [cos(Theta) -sin(Theta) 0;sin(Theta) cos(Theta) 0;0 0 1];%旋转矩阵
    P_CS_current = [P_CS_current(:,1:3)*R P_CS_current(:,4)];
%     z_mean = mean(P_CS_current(:,3));
%     x_mean = mean(P_CS_current(:,1));
%     z_std = std(P_CS_current(:,3));
%     x_std = std(P_CS_current(:,1));
    P_CS_current = sortrows(P_CS_current,1,'descend');
    P_CS{i,1} = P_CS_current;
    
    W=P_CS_current(1,1)-P_CS_current(end,1); %路宽
    mm=find(P_CS{i,1}(:,1)<=mean(P_CS{i,1}(:,1)));%中点横坐标
    M=size(mm,1);%半边点数
    superelevation_L=polyfit(P_CS{i,1}(1:M,1),P_CS{i,1}(1:M,3),1);
    superelevation_R=polyfit(P_CS{i,1}(M:end,1),P_CS{i,1}(M:end,3),1);
    Z_L=polyval(superelevation_L,P_CS{i,1}(M,1));
    Z_R=polyval(superelevation_R,P_CS{i,1}(M,1));
    %录入道路信息：中点横坐标/半边点数/左超高/左超高/右超高/右超高/中点高程/路宽
    P_CS{i,2}=[mean(P_CS{i,1}(:,1)) M superelevation_L superelevation_R (Z_L+Z_R)/2 W Theta_jiaodu];%近似拐点的横坐标,半边点数，以及左右超高，中线高程,旋转角
    if i>1
        l=sqrt((P_CS{i,1}(P_CS{i,2}(1,2),1)-P_CS{i-1,1}(P_CS{i-1,2}(1,2),1))^2+(P_CS{i,1}(P_CS{i,2}(1,2),1)-P_CS{i-1,1}(P_CS{i-1,2}(1,2),1))^2);
        SS=(P_cen(i,3)-P_cen(i-1,3))/dd;
        P_CS{i,3}=[(i-1)*dd P_CS{i,2}(1,3) P_CS{i,2}(1,5) SS W];%储存里程数，左超高，右超高和纵坡坡度、路宽
    else
        SS=0;
        P_CS{i,3}=[(i-1)*dd P_CS{i,2}(1,3) P_CS{i,2}(1,5) SS W];%储存里程数，左超高，右超高和纵坡坡度、路宽
    end
    %一般公路超高值会小于0.04，故除去离谱的超高点
    if i>1 && abs(P_CS{i,3}(1,2))>0.04
        P_CS{i,3}(1,2)=P_CS{i-1,3}(1,2);
    end
    if i>1 && abs(P_CS{i,3}(1,3))>0.04
        P_CS{i,3}(1,3)=P_CS{i-1,3}(1,3);
    end
    if i==1 && abs(P_CS{i,3}(1,2))>0.04
        P_CS{i,3}(1,2)=0;
    end
    if i==1 && abs(P_CS{i,3}(1,3))>0.04
        P_CS{i,3}(1,3)=0;
    end
    
    Geometric_Information=[Geometric_Information;P_CS{i,3}];%汇总信息
end
neighbors=rangesearch(Path_(:,1:2),Path_(:,1:2),300*dd); %测试后发现用轨迹路线更为准确
sss=0;
C_line=[];
Radius=[];
for i=1:size(Path_,1)
    neighbors_current=neighbors{i,:};
    x=Path_(neighbors_current,1);
    y=Path_(neighbors_current,2);
    AA=[x y ones(length(x),1)];
    BB=-(x.^2+y.^2);
    abc=AA\BB;
    aa=abc(1);
    bb=abc(2);
    cc=abc(3);
    %%根据abc求圆心坐标和半径
    x0=-0.5*aa;
    y0=-0.5*bb;
    r=sqrt(x0^2+y0^2-cc);
    cc=1/r;
    if i>1
        ddd=sqrt((Path_(i,1)-Path_(i-1,1))^2+(Path_(i,2)-Path_(i-1,2))^2);%水平距离
    else
        ddd=0;
    end
    sss=sss+ddd;
%     C_line=[C_line;sss cc];
    Radius=[Radius;sss r];
end
end


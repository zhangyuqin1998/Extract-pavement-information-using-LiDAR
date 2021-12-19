# 基于车载激光点云的道路几何信息提取

**原始数据：

郊区公路与复杂街区：

![image](https://user-images.githubusercontent.com/75946871/146675646-c9898f7c-d002-4330-bfc5-620268bf922c.png)

**分割效果**：

![image](https://user-images.githubusercontent.com/75946871/146675676-7b543eb3-5c1d-4525-8fea-169103c23338.png)

![image](https://user-images.githubusercontent.com/75946871/146675678-78c8ba19-16c5-4b17-94a7-082de972503a.png)


**算法分为三个阶段**：  

stage-1 用于预处理，使用降采样、柱状单元重构等方法

stage-2 用于路面点云分割，主要包括：法向量滤波；DBSCAN聚类  

stage-3 用于沿道路前进方向切取横切面，计算道路几何信息  
![image](https://user-images.githubusercontent.com/75946871/146675636-44d4d84c-6257-45d5-b9e3-7568567329ce.png)

栅格间距与运行时间关系图：

![image](https://user-images.githubusercontent.com/75946871/146675682-fd2fc2ee-f155-49d9-a1d9-0378b64233a7.png)



交流可联系zhangyuqin@seu.edu.cn

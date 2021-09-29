clc;clear;close all;
addpath('.\Source');%添加环境路径
PC = lasdata('.\Data\highway_1.las','loadall');load('.\Data\Path_hy1_refine.mat')

debug = false;

%%设置一些参数
I_th = 1000; %重要参数：强度阈值
mp = 0.4; %降取样步长
sigma = 3; %法向量与Z轴夹角阈值
epsilon = 1.8;%DBSCAN的参数
minpts = 50;%DBSCAN最少核心的点数
dd=2;%切片间距
dth=1.5;%切片厚度
xBound = 10; %取样范围
yBound = 10; %取样范围
R=0.5;%搜索半径
h_th=0.06; %高度差阈值

[P_intensityfiltered, P_downsampled, P_vectorfiltered, P_clustered, P_non_1, P_non_2, P_non_3, Geometric_Information, Radius] ...
    = main(PC,Path, I_th, mp, sigma, epsilon, minpts, dd, dth, xBound, yBound, R, h_th, debug);
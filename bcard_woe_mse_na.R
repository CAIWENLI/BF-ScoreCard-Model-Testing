#清空变量+控制面板
rm(list=ls())
#Ctrl+l

#读取数据
w=read.csv("C:/Users/hp/Desktop/R_DATA/bcard_28.csv");
#填充成0（空值为0/-1/NA）通过考察空值数量及相应定义合理的填充空值
w[is.na(w$MAX_CPD),]$MAX_CPD<-0
w[is.na(w$NOCALL_DAY),]$NOCALL_DAY<--1
w[is.na(w$PTP_CONTACT),]$PTP_CONTACT<--1
w[is.na(w$SALESCOMMISSION),]$SALESCOMMISSION<--1
w[is.na(w$CERTF_INTERVAL_YEARS),]$CERTF_INTERVAL_YEARS<--1
w[is.na(w$WK_3Y_EXP_NUM),]$WK_3Y_EXP_NUM<--1
w[is.na(w$CUS_CHILDRENTOTAL),]$CUS_CHILDRENTOTAL<-0
w[is.na(w$FAMILY_INCOME),]$FAMILY_INCOME<--1
w[is.na(w$IS_INSURE),]$IS_INSURE<-"NA"
w[is.na(w$IS_SSI),]$IS_SSI<-"NA"

#哑变量转因子型
w$IS_INSURE = as.factor(w$IS_INSURE)
w$IS_SSI = as.factor(w$IS_SSI)
w$CUS_SEX = as.factor(w$CUS_SEX)
w$CERT_4_INITAL = as.factor(w$CERT_4_INITAL)

#随机抽样
w=w[,c(3,5:28)]
#rows <- nrow (w)   
#indexes <- sample (rows,10000,replace =TRUE)   
#w<- w[indexes, ] 
data_class = sapply(w,class)
factor_class = as.data.frame(which(sapply(w,class) == "factor"))
rownames(factor_class)

#计算WOE值
cal<- function(data,y,var)
{
  i_y = which(names(data)==y)
  i_var = which(names(data)==var)
  
  tot_0 = table(data[,i_y])[1]
  tot_1 = table(data[,i_y])[2]
  
  x0 = as.data.frame(matrix(NA,nrow = length(levels(data[,i_var])),ncol = 3))
  colnames(x0) = c("Var_Name","Group_Type","WOE")
  
  x0[,1] = c(rep(var,length(levels((data[,i_var])))))
  x0[,2] = levels(data[,i_var])
  p_0 = table(data[,i_y],data[,i_var])[1,]/tot_0
  p_1 = table(data[,i_y],data[,i_var])[2,]/tot_1
  woe = log(p_1/p_0)
  x0[,3] = woe
  return(x0)
}

#因子、文本变量求WOE
x0 = cal(w,"TARGET","CUS_EDUCATION")
x = x0
x = rbind(x,cal(w,"TARGET","CUS_SEX"))
x = rbind(x,cal(w,"TARGET","IS_INSURE"))
x = rbind(x,cal(w,"TARGET","OTHER_PERSON_TYPE"))
x = rbind(x,cal(w,"TARGET","CUS_FAMILY_STATE"))
x = rbind(x,cal(w,"TARGET","WK_INDUSTRY"))
x = rbind(x,cal(w,"TARGET","IS_SSI"))
x = rbind(x,cal(w,"TARGET","WK_EXP_CUR"))
x = rbind(x,cal(w,"TARGET","CERT_4_INITAL"))

#导入包-SQL语句使用
library(gsubfn)
library(proto)
library(RSQLite)
library(DBI)
library(sqldf)
library(tcltk)

#填充WOE值--求得的WOE值包含很多Inf NA 
x$WOE[which(x$WOE == Inf)]= 3
x$WOE[which(x$WOE == -Inf)] = -3
na.omit(x$WOE)

#进行WOE替换,得到新的训练集
w_woe = sqldf("select t.TARGET,t.MAX_CPD,T.NOCALL_DAY,T.PTP_CONTACT
                  ,FINISH_PERIODS_RATIO,SALESCOMMISSION,CUSTOMERSERVICERATES,CERTF_INTERVAL_YEARS,WK_3Y_EXP_NUM       
                  ,CUS_CHILDRENTOTAL,LOWPRINCIPAL,ASSUME_CPD,EXTRA_INIT_RATE
                  ,PAY_CONSULT_MON,FAMILY_INCOME
                  ,(select woe from x where x.Var_Name = 'CUS_SEX' and x.Group_Type = t.CUS_SEX) as WOE_CUS_SEX
                  ,(select woe from x where x.Var_Name = 'CUS_EDUCATION' and x.Group_Type = t.CUS_EDUCATION) as WOE_CUS_EDUCATION
                  ,(select woe from x where x.Var_Name = 'IS_INSURE' and x.Group_Type = IS_INSURE) as WOE_IS_INSURE
                  ,(select woe from x where x.Var_Name = 'OTHER_PERSON_TYPE' and x.Group_Type = OTHER_PERSON_TYPE) as WOE_OTHER_PERSON_TYPE
                  ,(select woe from x where x.Var_Name = 'CUS_FAMILY_STATE' and x.Group_Type = CUS_FAMILY_STATE) as WOE_CUS_FAMILY_STATE
                  ,(select woe from x where x.Var_Name = 'WK_INDUSTRY' and x.Group_Type = WK_INDUSTRY) as WOE_WK_INDUSTRY
                  ,(select woe from x where x.Var_Name = 'IS_SSI' and x.Group_Type = IS_SSI) as WOE_IS_SSI
                  ,(select woe from x where x.Var_Name = 'WK_EXP_CUR' and x.Group_Type = WK_EXP_CUR) as WOE_WK_EXP_CUR
                  ,(select woe from x where x.Var_Name = 'CERT_4_INITAL' and x.Group_Type = CERT_4_INITAL) as WOE_CERT_4_INITAL
                  from w as t")
#再次查看训练集的全部变量类型
sapply(w_woe,class)

#再次查看训练集的空值占比
sapply(w_woe,function(x) sum(is.na(x))/length(x))

#回归交叉验证的数据---数据特点（全为数值型）
w=w_woe
n=nrow(w)

#若有空缺值--进行空缺值填补
library(missForest);
w=missForest(w)$ximp

#函数---目的：进行十折交叉验证
CV=function(n,Z=10,seed=888){
z=rep(1:Z,ceiling(n/Z))[1:n]
set.seed(seed);z=sample(z,n)
mm=list();for (i in 1:Z) mm[[i]]=(1:n)[z==i]
return(mm)}#输出Z个下标集;mm[[i]]为第i个下标集i=1到Z

#导入所需要的程序包
library(rpart.plot);
library(ipred);
detach(package:adabag);
library(mboost);
library(randomForest);
library(kernlab);
library(e1071);
library(nnet);
library(neuralnet)

#基本定义
(n=nrow(w))
D=15;Z=10;mm=CV(nrow(w),Z) #D是因变量位置, Z是折数
gg=paste(names(w)[D],"~",".")#gg=(TARGET~.)
gg=as.formula(gg)

#mboost1
zy=(1:ncol(w))[-D]
gg1=paste(names(w)[D],"~btree(",names(w)[zy[1]],")",sep="")
for(i in (1:ncol(w))[-D][-1])gg1=paste(gg1,"+btree(",names(w)[i],")",sep="")
gg1=as.formula(gg1)

#mboost2
gg2=paste(names(w)[D],"~btree(",names(w)[zy[1]],sep="")
for(i in (1:ncol(w))[-D][-1])gg2=paste(gg2,",",names(w)[i],sep="")
gg2=as.formula(paste(gg2,")"))

#建立MSE矩阵
MSE=matrix(1,Z,9);

#决策树回归
J=1
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=rpart(gg,w[-m,]) 
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
  }

#mboost_1
J=J+1;
set.seed(1010);
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=mboost(gg1,data =w[-m,])#注意这里用gg1
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
  }

#mboost_2
J=J+1;
set.seed(1010);
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=mboost(gg2,data =w[-m,])#注意这里用gg2
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
  }

#blackboost
J=J+1;
set.seed(1010);
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=blackboost(gg,data =w[-m,],control = boost_control(mstop = 50))
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
  }

#bagging
J=J+1;
set.seed(1010);
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=bagging(gg,data =w[-m,])
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
  } 

#随机森林
J=J+1;
set.seed(1010);
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=randomForest(gg,data=w[-m,])
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M 
  }

#支持向量机
J=J+1;
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=svm(gg,w[-m,])
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M 
  }

#支持向量机_kernel
J=J+1;
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=ksvm(gg,w[-m,],model="svm")
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M 
  }

#Logistic回归
J=1;
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=glm(gg,w[-m,],family=gaussian)
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
  }

#标准化处理
#w=scale(w,center = TRUE,scale = TRUE);

#神经网络---过度拟合
J=1;
set.seed(1010);
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=nnet(w[-m,D]/max(w[,D]) ~ ., data=w[-m,], size=6, decay=0.1) 
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,])*max(w[,D]))^2)/M
  }

#形成MSE数据集
MSE=data.frame(MSE)
names(MSE)=c("tree","boost1","boost2","bboost","bagging","RF","svm","ksvm","glm")
#画图--excel
write.csv(MSE,file="C:/Users/hp/Desktop/MSE_woe(10).csv")

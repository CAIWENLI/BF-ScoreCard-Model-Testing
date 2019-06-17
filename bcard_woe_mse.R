#清空变量+控制面板
rm(list=ls())
#Ctrl+l

#读取数据
w=read.csv("C:/Users/hp/Desktop/R_DATA/bcard_woe.csv");
#随机抽样
w=w[,c(3,4:29)]
rows <- nrow (w)   
indexes <- sample (rows,50000,replace =TRUE)   
w<- w[indexes, ] 
#查看空值占比
sapply(w,function(x) sum(is.na(x))/length(x))
#导入包-SQL语句使用
library(gsubfn)
library(proto)
library(RSQLite)
library(DBI)
library(sqldf)
library(tcltk)

#搜出好客户的特征，进行建模
w=sqldf("select WOE_CERT_4_INITAL
                ,WOE_CUS_EDUCATION
                ,WOE_WK_EXP_CUR
                ,WOE_WK_INDUSTRY
                ,WOE_CUS_FAMILY_STATE	
                ,WOE_IS_CERTID_PROVINCE
                ,WOE_APP_COUNT
                ,WOE_CERTF_INTERVAL_YEARS	
                ,WOE_CUSTOMERSERVICERATES	
                ,WOE_CUS_CHILDRENTOTAL	
                ,WOE_CUS_SEX
                ,WOE_FAMILY_INCOME
                ,WOE_FINISH_PERIODS_RATIO
                ,WOE_HIS_CONTACT_M
                ,WOE_HIS_PTPSUM	
                ,WOE_IS_INSURE
                ,WOE_IS_SSI
                ,WOE_MAX_CPD
                ,WOE_NOCALL_DAY
                ,WOE_N_CUR_BALANCE	
                ,WOE_ONTIME_PAY
                ,WOE_OTHER_PERSON_TYPE
                ,WOE_PAY_CONSULT_MON	
                ,WOE_PTP_RATE
                ,WOE_SALESCOMMISSION
                ,WOE_WK_3Y_EXP_NUM
         from   w 
        where   TARGET=0")
#填空值
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
MSE=matrix(1,Z,11);

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

#逻辑回归
J=J+1;
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=glm(gg,family=gaussian,w[-m,])
  MSE[i,J]=mean((w[m,D]-predict(a,w[m,]))^2)/M
}

#线性回归
J=J+1;
for(i in 1:Z){
  m=mm[[i]];
  M=mean((w[m,D]-mean(w[m,D]))^2)
  a=lm(gg,w[-m,])
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

#神经网络
J=J+1;
set.seed(1010);
for(i in 1:Z){
 m=mm[[i]];
 M=mean((w[m,D]-mean(w[m,D]))^2)
 a=nnet(w[-m,D]/max(w[,D]) ~ ., data=w[-m,], size=6, decay=0.1) 
 MSE[i,J]=mean((w[m,D]-predict(a,w[m,])*max(w[,D]))^2)/M
}

#形成MSE数据集
MSE=data.frame(MSE)
names(MSE)=c("tree","boost1","boost2","bboost","bagging","RF","lm","glm","svm","ksvm","net")
(ME=apply(MSE,2,mean));MSE
MSE[11,]=ME
#画图--excel
write.csv(MSE,file="C:/Users/hp/Desktop/MSE_WOE_FINCOME.csv")

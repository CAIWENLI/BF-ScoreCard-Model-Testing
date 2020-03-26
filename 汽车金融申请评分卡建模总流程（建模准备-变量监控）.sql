；
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------  车贷评分卡（张双版）   ---------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
/**********************************************************************************
    * 功能：汽车金融评分卡建模总流程（变量分析部分）
    * 创建人：张双
    * 创建时间：2016/09/07
    * 更新时间：2016/09/07
    * 版本：V1.0
**********************************************************************************/
sco.zs_car_train_testname_v1 ---训练集配置表
sco.zs_car_train_clus_v1 ---最终分组表
sco.zs_car_var_clus_v1---变量分组1
sco.zs_car_train_woe_v1---最终WOE表
sco.zs_car_var_woe_v1--分组WOE表


/*************************车贷评分卡建模准备 V1*********************/
---------------------------- Section 1.1 testname
create table sco.zs_car_train_testname_v1 
as
(
select 
      t.contract_no
     ,t.target
     ,t.inputdate
     ,case when t.CHILDREN_TOTAL=0 then '0' 
           when t.CHILDREN_TOTAL=1 then '1'
           else '(1,+∞]$other'  end  CHILDREN_TOTAL
     ,case when (t.GPS_SUM<=1068 or t.GPS_SUM is null) then '(-∞,1068]$null' 
           when t.GPS_SUM> 1068 then '(1068,+∞]'  end  GPS_SUM
     ,case when SERVICE_FEE<=130 then '(-∞,130]' 
           when SERVICE_FEE<=200 then '(130,200]'
           when SERVICE_FEE<=300 then '(200,300]'
           when SERVICE_FEE>300  then '(300,+∞]'                      
           else 'other' end  SERVICE_FEE
     ,case when VEHICLE_PRICE<=84300  then '(-∞,84300]' 
           when VEHICLE_PRICE<=240000 then '(84300,240000]'
           when VEHICLE_PRICE>240000 then '(240000,+∞]'                        
           else 'other' end VEHICLE_PRICE
     ,case when PAYMENT_SUM<=19800  then '(-∞,19800]' 
           when PAYMENT_SUM<=43800 then '(19800,43800]'  
           when PAYMENT_SUM>43800  then '(43800,+∞]'                                          
           else 'other' end PAYMENT_SUM
     ,case when BUSINESSSUM<=52500  then '(-∞,52500]' 
           when BUSINESSSUM<=77100 then '(52500,77100]'  
           when BUSINESSSUM>77100 then '(77100,+∞]'                                          
           else 'other' end   BUSINESSSUM
     ,case when CAR_GUIDEPRICE<=87000  then '(-∞,87100]' 
           when CAR_GUIDEPRICE<=167000 then '(87100,137300]'  
           when CAR_GUIDEPRICE>167000 then '(137300,+∞]'                                          
           else 'other' end   CAR_GUIDEPRICE
     ,case when CAR_TOTAL<=80000  then '(-∞,80000]' 
           when CAR_TOTAL<=128000 then '(80000,128000]'  
           when CAR_TOTAL>128000 then '(128000,+∞]'                                          
           else 'other' end  CAR_TOTAL
     ,case when (MONTH_TOTAL<=6300 or MONTH_TOTAL is null) then '(-∞,6300]$other' ---空值归到最好的分组
           when MONTH_TOTAL<=22500 then '(6300,22500]'  
           when MONTH_TOTAL>22500 then '(22500,+∞]' end MONTH_TOTAL
     ,case when MFEE_SUM<=0  then '(-∞,0]' 
           when MFEE_SUM<=30 then '(0,30]'  
           when MFEE_SUM>30 then '(30,+∞]'                                          
           else 'other' end  MFEE_SUM
     ,case when t.belong_area in ('华东','华南') then '1'
           when t.belong_area in ('东北','华北') then '2'
           when t.belong_area in ('西区') then '3' 
           else 'other' end belong_area
     ,case when t.car_brand in 
        ('上汽汽车','吉奥','东风裕隆','福迪汽车','华泰','三菱','华晨中华','奔驰','现代'
        ,'猎豹','福特','通用','路虎','起亚','北京汽车','宝马','奥迪','大众','马自达') then '1'
          when t.car_brand in 
        ('广汽乘用车','一汽奔腾','雪铁龙','丰田','日产','标致','别克','本田','江淮汽车'
         ,'雪佛兰','野马汽车','铃木','江铃','力帆') then '2'
          when t.car_brand in 
        ('猎豹汽车','海马','众泰','东风乘用车','吉利','奇瑞','上海大众斯柯达','长安汽车'
         ,'福田汽车','东风小康','北汽威旺','陆风汽车','东南汽车','长城汽车','五菱','中兴') then '3'
          when t.car_brand in 
        ('比亚迪','东风风行','Jeep','金杯','北汽银翔','北汽幻速','潍柴汽车') then '4'
          else 'other' end car_brand
     ,case when t.EDU_EXPERIENCE in ('研究生','大学本科','大学专科') then '2'
          else '1' end EDU_EXPERIENCE
     ,case when t.headship in ('高层管理人员/总监以上/局级以上干部','中层管理人员/经理以上/科级以上干部') then '1'
           when t.headship in ('基层管理人员/主管组长/科员','司机','销售/中介/业务代表/促销') then '2'
           when t.headship in ('个体','农民','其它','商业/服务业人员','一般员工') then '3'
           else '4' end headship
     ,case when t.PRODUCT_TYPE in ('二手快捷融') then '1'
           when t.PRODUCT_TYPE in ('二手轻松购','轻卡融','舒心融') then '2'
           when t.PRODUCT_TYPE in ('二手融e购','聚宝融','快捷融') then '3'
           else  'other' end PRODUCT_TYPE
     ,case when t.PROVINCE in ('福建省','陕西省','重庆市','湖北省') then '1'
           when t.PROVINCE in ('江西省','吉林省','江苏省','广西省','辽宁省','山东省','河北省','湖南省') then '2'
           when t.PROVINCE in ('黑龙江省','安徽省','河南省','内蒙古自治区','山西省') then '3'
           when t.PROVINCE in ('贵州省','广东省','云南省','北京市','海南省','四川省','新疆','宁夏回族自治区','天津市') then '4'
           else  'other' end PROVINCE
     ,case when t.CUSTOMER_GENDER='女' then '2' 
           else  '1' end CUSTOMER_GENDER
     ,case when t.HOUSE_HAVE='有' then '1'  
           else '2'end HOUSE_HAVE
     ,case when t.MARRIAGE_STAUTS='离异' then '1' 
           when t.MARRIAGE_STAUTS='未婚' then '2' 
            else  '3' end MARRIAGE_STAUTS
     ,case when t.carstatus1='二手车' then '1' 
           when t.carstatus1='新车' then '2' 
           else  'other' end carstatus1
 from sco.zs_car_train t)
;
---------------------------- Section 1.2 WOE
--WOE值的计算，
create table  sco.zs_car_var_woe_v1 
as(

select var_name
,group_name
,WOE
,case when group_name is null then sum(IV)over(partition by var_name) else null end IV
from
(
select 
     t.var_name
     ,t.group_name
     ,ln( (t.n1/sum(t.n1) over (partition by var_name ))/
     ((t.n-t.n1)/sum(t.n-t.n1)over(partition by var_name ))) WOE    
     ,((t.n1/sum(t.n1) over (partition by var_name ))-((t.n-t.n1)/sum(t.n-t.n1)over(partition by var_name )))
     *ln((t.n1/sum(t.n1) over (partition by var_name ))/
     ((t.n-t.n1)/sum(t.n-t.n1)over(partition by var_name ))) IV
from ZS_CAR_VAR_PRE_V2 t
))

---------------------------- Section 1.3 分组+填充WOE
------------分组+填充WOE------------------
/*create table  sco.zs_CAR_var_clus_v1
(
 CREATE_TIME date 
,UPDATE_TIME date
,GROUP_TYPE Varchar2(30)
,TESTNAME  Varchar2(30)
,clus number
,N  number
,N1 number
,BADRATE number
,IS_NUM number 
,IS_MONOTONE number
,DEFAULT_GROUP number
,WOE  number
)*/
--1、CHILDREN_TOTAL
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('CHILDREN_TOTAL') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='CHILDREN_TOTAL '
     and t2.var_name='CHILDREN_TOTAL '
     and t2.group_name=t1.group_name;

commit;
--select * from dual;
--2、GPS_SUM
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('GPS_SUM ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,2 DEFAULT_GROUP---表示默认分组在2分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='GPS_SUM '
     and t2.var_name='GPS_SUM '
     and t2.group_name=t1.group_name;
commit;

--3、SERVICE_FEE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('SERVICE_FEE  ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='SERVICE_FEE '
     and t2.var_name='SERVICE_FEE '
     and t2.group_name=t1.group_name;
commit;
----4、VEHICLE_PRICE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('VEHICLE_PRICE  ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='VEHICLE_PRICE '
     and t2.var_name='VEHICLE_PRICE '
     and t2.group_name=t1.group_name;
commit;

--5、BUSINESSSUM
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('BUSINESSSUM  ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='BUSINESSSUM '
     and t2.var_name='BUSINESSSUM '
     and t2.group_name=t1.group_name;
commit;

--6、PAYMENT_SUM
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('PAYMENT_SUM  ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在2分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='PAYMENT_SUM '
     and t2.var_name='PAYMENT_SUM '
     and t2.group_name=t1.group_name;
commit;
--7、CAR_GUIDEPRICE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('CAR_GUIDEPRICE  ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='CAR_GUIDEPRICE '
     and t2.var_name='CAR_GUIDEPRICE '
     and t2.group_name=t1.group_name;
commit;
---8、CAR_TOTAL
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)

select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('CAR_TOTAL  ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='CAR_TOTAL '
     and t2.var_name='CAR_TOTAL '
     and t2.group_name=t1.group_name;
commit;
---9、MONTH_TOTAL
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)

select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('MONTH_TOTAL ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,3 DEFAULT_GROUP---表示默认分组在3分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='MONTH_TOTAL '
     and t2.var_name='MONTH_TOTAL '
     and t2.group_name=t1.group_name;
commit;  

---10、MFEE_SUM
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)

select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('MFEE_SUM ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='MFEE_SUM '
     and t2.var_name='MFEE_SUM '
     and t2.group_name=t1.group_name;
commit;     
---11、BELONG_AREA
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)

select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('BELONG_AREA ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='BELONG_AREA'
     and t2.var_name='BELONG_AREA'
     and t2.group_name=t1.group_name;
commit; 
---12、CAR_BRAND
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('CAR_BRAND ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,3 DEFAULT_GROUP---表示默认分组在3分组，车品牌的贷款个数少于50的全部在3分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='CAR_BRAND '
     and t2.var_name='CAR_BRAND '
     and t2.group_name=t1.group_name;
commit; 
---13、EDU_EXPERIENCE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('EDU_EXPERIENCE ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,2 DEFAULT_GROUP---表示默认分组在3分组，车品牌的贷款个数少于50的全部在3分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='EDU_EXPERIENCE '
     and t2.var_name='EDU_EXPERIENCE '
     and t2.group_name=t1.group_name;
commit; 
---14、HEADSHIP
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('HEADSHIP ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,4 DEFAULT_GROUP---表示默认分组在4分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='HEADSHIP '
     and t2.var_name='HEADSHIP '
     and t2.group_name=t1.group_name;
commit; 
---15、PRODUCT_TYPE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('PRODUCT_TYPE ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,2 DEFAULT_GROUP---表示默认分组在2分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='PRODUCT_TYPE '
     and t2.var_name='PRODUCT_TYPE '
     and t2.group_name=t1.group_name;
commit; 


---16、PROVINCE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('PROVINCE ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='PROVINCE '
     and t2.var_name='PROVINCE '
     and t2.group_name=t1.group_name;
commit; 

---17、CUSTOMER_GENDER
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('CUSTOMER_GENDER ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在4分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='CUSTOMER_GENDER '
     and t2.var_name='CUSTOMER_GENDER '
     and t2.group_name=t1.group_name;
commit;

---18、HOUSE_HAVE
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('CUSTOMER_GENDER ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,2 DEFAULT_GROUP---表示默认分组在2分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='HOUSE_HAVE '
     and t2.var_name='HOUSE_HAVE '
     and t2.group_name=t1.group_name;
commit;
---19、MARRIAGE_STAUTS
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('MARRIAGE_STAUTS ') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,2 DEFAULT_GROUP---表示默认分组在2分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='MARRIAGE_STAUTS '
     and t2.var_name='MARRIAGE_STAUTS '
     and t2.group_name=t1.group_name;
commit;
--20、carstatus1
insert into  sco.zs_CAR_var_clus_v1(CREATE_TIME,UPDATE_TIME,group_type,TESTNAME,clus,N,N1,BADRATE,IS_NUM,IS_MONOTONE,DEFAULT_GROUP,WOE)
 select sysdate CREATE_TIME 
       ,sysdate UPDATE_TIME       
       ,upper('carstatus1') group_type
       ,t2.group_name testname
       ,row_number()over(order by badrate DESC ) clus
       , N1
       , N
       , badrate
       ,1 is_num
       ,1 IS_MONOTONE
       ,1 DEFAULT_GROUP---表示默认分组在1分组
       ,t2.woe
     from 
     (select t.*,n1/n badrate
      from sco.Zs_Car_Var_Pre_V2 t
      )t1,sco.zs_car_var_woe_v1 t2
     where t1.var_name='CARSTATUS1 '
     and t2.var_name='CARSTATUS1 '
     and t2.group_name=t1.group_name;
commit;


---------------------------- Section 1.4 CLUS填充------------------------------------------


---匹配训练集里面每个变量对应的分组
create table sco.zs_car_train_clus_v1
as
(
select t1.contract_no
,t1.target
,t1.inputdate
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CHILDREN_TOTAL' and a.testname=t1.children_total ) children_total
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='VEHICLE_PRICE  ' and a.testname=t1.VEHICLE_PRICE ) VEHICLE_PRICE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='SERVICE_FEE  ' and a.testname=t1.SERVICE_FEE ) SERVICE_FEE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PROVINCE ' and a.testname=t1.PROVINCE ) PROVINCE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PRODUCT_TYPE '  and a.testname=t1.PRODUCT_TYPE ) PRODUCT_TYPE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PAYMENT_SUM  ' and a.testname=t1.PAYMENT_SUM ) PAYMENT_SUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MONTH_TOTAL ' and a.testname=t1.MONTH_TOTAL ) MONTH_TOTAL
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MFEE_SUM ' and a.testname=t1.MFEE_SUM ) MFEE_SUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MARRIAGE_STAUTS ' and a.testname=t1.MARRIAGE_STAUTS ) MARRIAGE_STAUTS
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='HOUSE_HAVE ' and a.testname=t1.HOUSE_HAVE ) HOUSE_HAVE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='HEADSHIP ' and a.testname=t1.HEADSHIP ) HEADSHIP
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='GPS_SUM ' and a.testname=t1.GPS_SUM ) GPS_SUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='EDU_EXPERIENCE ' and a.testname=t1.EDU_EXPERIENCE ) EDU_EXPERIENCE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CUSTOMER_GENDER ' and a.testname=t1.CUSTOMER_GENDER ) CUSTOMER_GENDER
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_TOTAL  ' and a.testname=t1.CAR_TOTAL ) CAR_TOTAL
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_GUIDEPRICE  ' and a.testname=t1.CAR_GUIDEPRICE ) CAR_GUIDEPRICE
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_BRAND ' and a.testname=t1.CAR_BRAND ) CAR_BRAND
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CARSTATUS1' and a.testname=t1.CARSTATUS1 ) CARSTATUS1
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='BUSINESSSUM  ' and a.testname=t1.BUSINESSSUM ) BUSINESSSUM
,(select a.clus from ZS_CAR_VAR_CLUS_V1 a where a.group_type='BELONG_AREA ' and a.testname=t1.BELONG_AREA ) BELONG_AREA

from sco.zs_car_train_testname_v1 t1
);


-
--------------------------- Section 1.5 WOE填充--------------------------------

----匹配训练集里面的每个变量对应的WOE值 然后进行相关性分析
create table sco.zs_car_train_WOE_v1
as
(
select t1.contract_no
,t1.target
,t1.inputdate
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CHILDREN_TOTAL' and a.testname=t1.children_total ) children_total
---注意a表里面的group type是不是有空格
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='VEHICLE_PRICE  ' and a.testname=t1.VEHICLE_PRICE ) VEHICLE_PRICE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='SERVICE_FEE  ' and a.testname=t1.SERVICE_FEE ) SERVICE_FEE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PROVINCE ' and a.testname=t1.PROVINCE ) PROVINCE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PRODUCT_TYPE '  and a.testname=t1.PRODUCT_TYPE ) PRODUCT_TYPE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='PAYMENT_SUM  ' and a.testname=t1.PAYMENT_SUM ) PAYMENT_SUM
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MONTH_TOTAL ' and a.testname=t1.MONTH_TOTAL ) MONTH_TOTAL
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MFEE_SUM ' and a.testname=t1.MFEE_SUM ) MFEE_SUM
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='MARRIAGE_STAUTS ' and a.testname=t1.MARRIAGE_STAUTS ) MARRIAGE_STAUTS
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='HOUSE_HAVE ' and a.testname=t1.HOUSE_HAVE ) HOUSE_HAVE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='HEADSHIP ' and a.testname=t1.HEADSHIP ) HEADSHIP
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='GPS_SUM ' and a.testname=t1.GPS_SUM ) GPS_SUM
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='EDU_EXPERIENCE ' and a.testname=t1.EDU_EXPERIENCE ) EDU_EXPERIENCE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CUSTOMER_GENDER ' and a.testname=t1.CUSTOMER_GENDER ) CUSTOMER_GENDER
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_TOTAL  ' and a.testname=t1.CAR_TOTAL ) CAR_TOTAL
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_GUIDEPRICE  ' and a.testname=t1.CAR_GUIDEPRICE ) CAR_GUIDEPRICE
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CAR_BRAND ' and a.testname=t1.CAR_BRAND ) CAR_BRAND
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='CARSTATUS1' and a.testname=t1.CARSTATUS1 ) CARSTATUS1
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='BUSINESSSUM  ' and a.testname=t1.BUSINESSSUM ) BUSINESSSUM
,(select a.woe from ZS_CAR_VAR_CLUS_V1 a where a.group_type='BELONG_AREA ' and a.testname=t1.BELONG_AREA ) BELONG_AREA

from sco.zs_car_train_testname_v1 t1
);
---------------------------- Section 1.5 分组+填充WOE

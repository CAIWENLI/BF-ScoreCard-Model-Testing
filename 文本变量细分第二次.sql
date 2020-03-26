------------------文本变量细分组-------------------
---1.belong_area-----------------------
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time) 
select '宽表变量分析20160517' state_name,
       upper('belong_area') var_name,
       decode(group_name,null,'belong_area '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select (case when t.belong_area in ('华东','华南') then '1'
            when t.belong_area in ('东北','华北') then '2'
            when t.belong_area in ('西区') then '3' 
            else 'other' end)  group_name     
       ,count(*) N
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.belong_area in ('华东','华南') then '1'
            when t.belong_area in ('东北','华北') then '2'
            when t.belong_area in ('西区') then '3' 
            else 'other' end)
);
--commit;
/*
----2.car_brand(变量太细，分组不均匀)
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('car_brand ') var_name,
       decode(group_name,null,'car_brand '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select 
case when t.car_brand in 
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
 else 'other' end  group_name     
       ,count(*) N
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.car_brand in 
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
 else 'other' end)
)
--commit;*/


-----3.EDU_EXPERIENCE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('EDU_EXPERIENCE ') var_name,
       decode(group_name,null,'EDU_EXPERIENCE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.EDU_EXPERIENCE in ('研究生','大学本科'，'大学专科') then '1'
            when t.EDU_EXPERIENCE in ('高中','中专/中等技校','技术学校','初中') then '2'
            else '3' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.EDU_EXPERIENCE in ('研究生','大学本科'，'大学专科') then '1'
            when t.EDU_EXPERIENCE in ('高中','中专/中等技校','技术学校','初中') then '2'
            else '3' end)
);
--commit;


-----4.headship
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('headship ') var_name,
       decode(group_name,null,'headship '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.headship in ('高层管理人员/总监以上/局级以上干部','中层管理人员/经理以上/科级以上干部') then '1'
            when t.headship in ('基层管理人员/主管组长/科员','司机','销售/中介/业务代表/促销') then '2'
            when t.headship in ('个体','农民','其它','商业/服务业人员','一般员工') then '3'
            else '4' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.headship in ('高层管理人员/总监以上/局级以上干部','中层管理人员/经理以上/科级以上干部') then '1'
            when t.headship in ('基层管理人员/主管组长/科员','司机','销售/中介/业务代表/促销') then '2'
            when t.headship in ('个体','农民','其它','商业/服务业人员','一般员工') then '3'
            else '4' end )
)
;
--commit;

----5.occupation 
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('headship ') var_name,
       decode(group_name,null,'headship '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.headship in ('国家机关、党群组织、企业、事业单位负责人','不便分类的其他从业人员') then '1'
            when t.headship in ('生产、运输设备操作人员及有关人员','办事人员和有关人员','商业、服务业人员') then '2'
            when t.headship in ('农、林、牧、渔、水利业生产人员','专业技术人员','未知') then '3'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.headship in ('国家机关、党群组织、企业、事业单位负责人','不便分类的其他从业人员') then '1'
            when t.headship in ('生产、运输设备操作人员及有关人员','办事人员和有关人员','商业、服务业人员') then '2'
            when t.headship in ('农、林、牧、渔、水利业生产人员','专业技术人员','未知') then '3'
             else  'other' end)
)
;
--commit;

----6.PRODUCT_TYPE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('PRODUCT_TYPE ') var_name,
       decode(group_name,null,'PRODUCT_TYPE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.PRODUCT_TYPE in ('二手快捷融') then '1'
            when t.PRODUCT_TYPE in ('二手轻松购','轻卡融','舒心融') then '2'
            when t.PRODUCT_TYPE in ('二手融e购','聚宝融','快捷融') then '3'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.PRODUCT_TYPE in ('二手快捷融') then '1'
            when t.PRODUCT_TYPE in ('二手轻松购','轻卡融','舒心融') then '2'
            when t.PRODUCT_TYPE in ('二手融e购','聚宝融','快捷融') then '3'
             else  'other' end)
)
;
--commit;

-----7.PROVINCE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('PROVINCE ') var_name,
       decode(group_name,null,'PROVINCE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.PROVINCE in ('福建省','陕西省','重庆市','湖北省') then '1'
            when t.PROVINCE in ('江西省','吉林省','江苏省','广西省','辽宁省','山东省','河北省','湖南省') then '2'
            when t.PROVINCE in ('黑龙江省','安徽省','河南省','内蒙古自治区','山西省') then '3'
            when t.PROVINCE in ('贵州省','广东省','云南省','北京市','海南省','四川省','新疆','宁夏回族自治区','天津市') then '4'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.PROVINCE in ('福建省','陕西省','重庆市','湖北省') then '1'
            when t.PROVINCE in ('江西省','吉林省','江苏省','广西省','辽宁省','山东省','河北省','湖南省') then '2'
            when t.PROVINCE in ('黑龙江省','安徽省','河南省','内蒙古自治区','山西省') then '3'
            when t.PROVINCE in ('贵州省','广东省','云南省','北京市','海南省','四川省','新疆','宁夏回族自治区','天津市') then '4'
             else  'other' end)
)
;
--commit;



-----9.CUSTOMER_GENDER
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('CUSTOMER_GENDER ') var_name,
       decode(group_name,null,'CUSTOMER_GENDER '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.CUSTOMER_GENDER='女' then '2' 
             else  '1' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.CUSTOMER_GENDER='女' then '2' 
             else  '1' end)
)
;
--commit;
-------10.HOUSE_HAVE
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('HOUSE_HAVE ') var_name,
       decode(group_name,null,'HOUSE_HAVE '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
 select case when t.HOUSE_HAVE='有' then '1' end  
         else '2'end group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.HOUSE_HAVE='有' then '1' end  
         else '2'end)
)
;
--commit;


------11.MARRIAGE_STAUTS
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('MARRIAGE_STAUTS ') var_name,
       decode(group_name,null,'MARRIAGE_STAUTS '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.MARRIAGE_STAUTS='离异' then '1' 
            when t.MARRIAGE_STAUTS='未婚' then '2' 
             else  '3' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.MARRIAGE_STAUTS='离异' then '1' 
                   when t.MARRIAGE_STAUTS='未婚' then '2' 
                   when t.MARRIAGE_STAUTS='已婚' then '3'  
                    else  'other' end )
)
;
--commit;

------12.carstatus1
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('carstatus1 ') var_name,
       decode(group_name,null,'carstatus1 '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.carstatus1='二手车' then '1' 
            when t.carstatus1='新车' then '2' 
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.carstatus1='二手车' then '1' 
            when t.carstatus1='新车' then '2' 
             else  'other' end)
)
;
--commit;

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
--
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
 ('恒天汽车'
,'镇江飞驰'
,'海格汽车') then '1'
 when t.car_brand in 
 ('长安沃尔沃','菲亚特（进口）','沃尔沃亚太','莲花','日本三菱','东风悦达','凯迪拉克进口'
,'上海英伦','MINI','莲花汽车','一汽丰田长春丰越','别克','上汽','日本铃木','日本日产','标致雪铁龙','日本马自达') then '2'
when t.car_brand in ( '奔驰(进口)','华泰汽车','成功汽车','宝马（进口）','宝马(进口)','英菲尼迪(进口)','标致雪铁龙 (进口)','Jeep(进口)'
,'雪佛兰','梅赛德斯-奔驰','长丰汽车','上汽荣威汽车','苏州金龙','名爵汽车','奔驰','广汽吉奥','绵阳金杯','凯马汽车'
,'戴姆勒-克莱斯勒','大众(进口)','丰田','美国通用','一汽海马','上汽通用雪佛兰','雪佛兰(进口)','马自达（进口）')then '3' 
when t.car_brand in 
 ('东南三菱'  ,'韩国现代（进口）','东风裕隆','斯巴鲁'	,'东风悦达起亚' ,'福特汽车','梅赛德斯-奔驰 (进口)','南京依维柯'
 ,'福特(进口)','上汽商用车','通用别克','唐骏汽车','沃尔沃(进口)','上海大众','广汽丰田','广汽三菱','一汽-大众奥迪'
,'马自达'	,'上海大众斯柯达','一汽奥迪','广州本田','福迪汽车','神龙','纳智捷','雷克萨斯','奥迪(进口)','上海通用别克'	
,'猎豹','一汽奔腾'
,'上汽集团','曙光汽车','广汽乘用车','北京汽车制造厂','永源汽车','丰田汽车','双龙汽车','广汽传祺','北京现代'
,'厦门金龙','东风汽车','通用','路虎(进口)','北京汽车','开瑞汽车','五菱','广汽菲亚特',,'菲亚特','海马郑州','长城哈弗汽车','东风本田'
,'一汽-大众','华晨宝马','广汽本田','东风雪铁龙','东风标致','大众汽车','江淮汽车','一汽马自达','东风日产','华晨中华'
,'上海通用雪佛兰','道奇(进口)'
,'长城哈弗','北京奔驰','一汽大众','三菱(进口)','一汽丰田','重庆力帆','中国重汽集团','长安福特','宝马','路虎') then '4'
when t.car_brand in (
,'华晨鑫源','丰田（进口）','长安轻型车','梅赛德斯- AMG','北汽幻速','长安商用','观致','凯迪拉克（进口）','四川现代'
,'吉奥','保时捷(进口）','北汽福田汽车','长安马自达','日本丰田','奥迪（进口）','成都大运汽车','东风','宾利','广汽菲克','克莱斯勒(进口)'
,'保时捷','长安铃木','丰田(进口)','奔驰AMG','荣成华泰','起亚（进口）','海格新五十铃皮卡','讴歌','新凯汽车','庆铃汽车'
,'大众（进口）','奔驰(进口','通用凯迪拉克','比亚迪','江苏九龙汽车','江铃','厦门金龙联合','奥驰汽车','黑豹'
,'昌河铃木','厦门金旅','东风英菲尼迪','奔驰（进口）','江铃集团轻汽','广汽','江铃汽车','沃尔沃（进口）'
,'克莱斯勒（进口）','一汽轿车','东南汽车','四川明君汽车','马自达(进口)','双龙','双环汽车','广汽吉奥汽车','金龙金威','长安标致雪铁龙'
,'福建奔驰','凯迪拉克(进口)','长安轿车','力帆汽车','东风风度','昌河汽车','北汽制造','smart','时代汽车'
,'大众','起亚','东风风行','上汽通用五菱','陆风汽车','郑州海马','林肯','一汽吉林','东风乘用车','潍柴汽车','郑州日产','通用雪佛兰'
,'东风风神','东风小康','北汽威旺','众泰','中兴汽车','众泰汽车','江西五十铃','天津一汽','雷诺'
,'英菲尼迪','现代(进口)','猎豹汽车','大运汽车','铃木(进口)','沈阳金杯','长城','中兴威虎','奇瑞汽车'
,'福汽新龙马','福特（进口）','华晨汽车','卡威汽车','长城汽车','绵阳新华金杯','中国重汽','力帆'
,'海马汽车','北汽银翔','Jeep','奇瑞捷豹路虎'
,'长安跨越','金龙汽车','金杯','一汽通用','新凯奔驰','比亚迪汽车','别克（进口）','沃尔沃'
,'卡威','凯翼汽车','通用五菱','吉利汽车','华晨金杯','捷豹','福田汽车','吉利','北京奔驰-戴克','观致汽车','上汽通用别克','长安汽车'
,'日产(进口)','黄海汽车','上汽荣威','迷你','起亚(进口)','依维柯'
,'上汽通用凯迪拉克','一汽-大众CC','玛莎拉蒂','一汽欧朗','野马汽车','奔驰 ML级','欧宝') 


     
     end  group_name     
       ,count(*) N
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube()
)
--commit;


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
            when t.EDU_EXPERIENCE in ('小学','文盲或半文盲','未知') then '3'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.EDU_EXPERIENCE in ('研究生','大学本科'，'大学专科') then '1'
            when t.EDU_EXPERIENCE in ('高中','中专/中等技校','技术学校','初中') then '2'
            when t.EDU_EXPERIENCE in ('小学','文盲或半文盲','未知') then '3'
             else  'other' end)
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
            when t.headship in ('工人（包括 生产、加工、建筑和设备操作人员及有关人员）','专业(技术)人员') then '4'                
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.headship in ('高层管理人员/总监以上/局级以上干部','中层管理人员/经理以上/科级以上干部') then '1'
            when t.headship in ('基层管理人员/主管组长/科员','司机','销售/中介/业务代表/促销') then '2'
            when t.headship in ('个体','农民','其它','商业/服务业人员','一般员工') then '3'
            when t.headship in ('工人（包括 生产、加工、建筑和设备操作人员及有关人员）','专业(技术)人员') then '4'                
             else  'other' end)
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

------8.relace_bank
--insert into sco.zs_CAR_var_pre_v1(state_name,var_name,group_type,group_name,N,N1,state_Interva_sdate,state_Interva_edate,create_time)

select '宽表变量分析20160517' state_name,
       upper('REPLACE_BANK ') var_name,
       decode(group_name,null,'REPLACE_BANK '||'分析',null) group_type,
       group_name,
       decode(group_name,null,null,N) N,
       decode(group_name,null,null,N1) N1,
       to_date('20140827','yyyymmdd') state_Interva_sdate,
       to_date('20151015','yyyymmdd') state_Interva_edate,
       sysdate create_time
from
(
select case when t.REPLACE_BANK in ('中国银行股份有限公司','招商银行股份有限公司','中国建设银行股份有限公司') then '1'
            when t.REPLACE_BANK in ('中国农业银行股份有限公司','中国工商银行股份有限公司') then '2'
            when t.REPLACE_BANK in ('中国邮政储蓄银行') then '3'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.REPLACE_BANK in ('中国银行股份有限公司','招商银行股份有限公司','中国建设银行股份有限公司') then '1'
            when t.REPLACE_BANK in ('中国农业银行股份有限公司','中国工商银行股份有限公司') then '2'
            when t.REPLACE_BANK in ('中国邮政储蓄银行') then '3'
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
select case when t.HOUSE_HAVE='无' then '2' 
            when t.HOUSE_HAVE='有' then '1'
             else  'other' end  group_name     
       ,count(*) N 
       ,sum(t.target) N1
from sco.zs_car_basetrain t 
group by cube(case when t.HOUSE_HAVE='无' then '2' 
            when t.HOUSE_HAVE='有' then '1'
             else  'other' end )
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
            when t.MARRIAGE_STAUTS='已婚' then '3'  
             else  'other' end  group_name     
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

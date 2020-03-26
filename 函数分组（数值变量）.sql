---------------------函数区分文本变量-----------------
---2.GPS_SUM 
/*cu.f_sco_number_compress_dj（‘表名’，‘列名’，‘条件’，响应变量，组数，组间最小间隔，每组最小单，是否有序，每组要求最小样本数）*/
---insert into sco.SHENJI_AREA_VAR_woe_step1(create_time,update_time,group_type,testname,clus,n,n1,badrate,is_num,is_monotone,default_group ,woe )
create table sco
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'GPS_SUM' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(
 select * from table(cu.f_sco_number_compress_dj('sco.zs_car_basetrain','GPS_SUM','','target',2,50,50,1,20)) 
)t2
where t2.type_name is not null
order by t2.woe desc
;
----GPS_SUM需要分两个组才能够分出来，3组就分不出来了
----COMMIT;

--/*cu.f_sco_number_compress_dj（‘表名’，‘列名’，‘条件’，响应变量，组数，组间最小间隔，每组最小单，是否有序，每组要求最小样本数）*/
--insert into sco.SHENJI_AREA_VAR_woe_step1(create_time,update_time,group_type,testname,clus,n,n1,badrate,is_num,is_monotone,default_group ,woe )
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'SERVICE_FEE' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE,
        IV
from
(
 select * from table(cu.f_sco_number_compress_dj('sco.zs_car_basetrain','SERVICE_FEE','','target',4,5,10,1,50)) 
)t2
where t2.type_name is not null
order by t2.woe desc
;

----4、VEHICLE_PRICE
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'VEHICLE_PRICE' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(
select * from table(cu.f_sco_number_compress_dj('sco.zs_car_basetrain','VEHICLE_PRICE','','target',3,500,300,1,100)) 
)t2
where t2.type_name is not null
order by t2.woe desc;
/*(-∞,84300]
(84300,240000]
(240000,+∞]*/

----5、PAYMENT_SUM
select  
        sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'PAYMENT_SUM' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE,iV
        
from
(
select * from table(cu.f_sco_number_compress_dj('sco.zs_car_basetrain','PAYMENT_SUM','','target',3,50,300,1,100)) 
)t2
where t2.type_name is not null
order by t2.woe desc;
/*(43800,+∞]
(19800,43800]
(-∞,19800]*/
;
--6、BUSINESSSUM
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'BUSINESSSUM' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(
select * from table(cu.f_sco_number_compress_dj('cu.zs_car_add_basetrain','BUSINESSSUM','','target',3,100,300,1,200)) 
)t2
where t2.type_name is not null
order by t2.woe desc;
/*(-∞,52500]
(52500,77100]
(77100,+∞]*/ ;
--8、CAR_GUIDEPRICE
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'CAR_GUIDEPRICE' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(
select * from table(cu.f_sco_number_compress_dj('cu.zs_car_add_basetrain','CAR_GUIDEPRICE','','target',3,500,100,1,200)) 
)t2
where t2.type_name is not null
order by t2.woe desc;
/*(-∞,87100]
(87100,137300]
(137300,+∞]*/



---9、CAR_TOTAL
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'CAR_TOTAL' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(
select * from table(cu.f_sco_number_compress_dj('cu.zs_car_add_basetrain','CAR_TOTAL','','target',3,500,100,1,200)) 
)t2
where t2.type_name is not null
order by t2.woe desc;

--10、MONTH_TOTAL
select  sysdate CREATE_TIME,
        sysdate UPDATE_TIME,
        'MONTH_TOTAL' GROUP_TYPE,
        type_name TESTNAME,
        N,
        N1,
        row_number()over(order by woe desc) clus, 
        rate badrate,
        1 IS_NUM,
        1 IS_MONOTONE,
        '1' default_group,
        WOE
from
(
select * from table(cu.f_sco_number_compress_dj('cu.zs_car_add_basetrain','MONTH_TOTAL','','target',3,50,300,1,200)) 
)t2
where t2.type_name is not null
order by t2.woe desc;
/*(-∞,6300]
(6300,22500]
(22500,+∞]*/  --0.1176
--分成四组的IV值反而小
--
